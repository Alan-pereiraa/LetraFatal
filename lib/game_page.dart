import 'dart:math';

import 'package:flutter/material.dart';
import 'package:letrafatal/history_page.dart';
import 'package:letrafatal/widgets/button_widget.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class Partida {
  Partida({
    required this.id,
    required this.palavra,
    required this.letrasUsadas,
    required this.tentativasRestantes,
    required this.venceu,
    required this.data,
  });

  final String id;
  final String palavra;
  final List<String> letrasUsadas;
  final int tentativasRestantes;
  final bool venceu;
  final DateTime data;
}

class _GamePageState extends State<GamePage> {
  late String palavraSecreta;
  final List<String> palavras = [
    "FLUTTER",
    "DART",
    "PROGRAMACAO",
    "COMPUTADOR",
    "MOBILE",
    "DESENVOLVIMENTO",
    "APLICATIVO",
    "JOGO",
  ];

  int tentativasRestantes = 5;
   late String partidaAtualId;

  late List<String> letrasUsadas;
  List<Partida> historico = [];
  late List<String> letrasCorretas;
  late List<String> letrasIncorretas;

  @override
  void initState() {
    int index = Random().nextInt(palavras.length);
    palavraSecreta = palavras[index];
    letrasUsadas = [];
    letrasCorretas = [];
    letrasIncorretas = [];
    partidaAtualId = gerarId();
    super.initState();
  }

  String gerarId() => DateTime.now().microsecondsSinceEpoch.toString();

  Partida partidaAtual() {
    final venceu = palavraSecreta.split('').every((l) => letrasUsadas.contains(l));

    return Partida(
      id: partidaAtualId,
      palavra: palavraSecreta,
      letrasUsadas: List.of(letrasUsadas),
      tentativasRestantes: tentativasRestantes,
      venceu: venceu,
      data: DateTime.now(),
    );
  }


  void sincronizarPartida(Partida partidaAtual) {
    final index = historico.indexWhere((p) => p.id == partidaAtual.id);

    if (index == -1) {
      historico.add(partidaAtual);
    } else {
      historico[index] = partidaAtual;
    }
  }

  void iniciarNovoJogo() {
    final random = Random();

    setState(() {
      palavraSecreta = palavras[random.nextInt(palavras.length)];
      letrasUsadas.clear();
      tentativasRestantes = 5;
      partidaAtualId = gerarId();
    });
  }

  void tentarLetra(String letra) {
    if (letrasUsadas.contains(letra)) {
      return;
    }

    setState(() {
      letrasUsadas.add(letra);

      if (!palavraSecreta.split('').contains(letra)) {
        letrasIncorretas.add(letra);
        tentativasRestantes--;
      }

      letrasCorretas.add(letra);
      sincronizarPartida(partidaAtual());
    });
  }

  String exibirLetra() {
    return palavraSecreta.split('').map((letra) {
      if (letrasUsadas.contains(letra)) {
        return letra;
      } else {
        return "_";
      }
    }).join(' ');
  }

  String ganhouOuPerdeu() {
    if (tentativasRestantes <= 0) {
      return "Você perdeu! A palavra era: $palavraSecreta";
    } else if (palavraSecreta.split('').every((letra) => letrasUsadas.contains(letra))) {
      return "Parabéns! Você ganhou!";
    } else {
      return "";
    }
  }

  ({Color color, Color textColor, Color borderColor}) corDaLetra(String letra) {
    if(letrasUsadas.contains(letra)) {
      if(palavraSecreta.contains(letra)) {
        return (borderColor: Colors.green, color: Colors.green, textColor: Colors.white);
      } else {
        return (borderColor: Colors.red, color: Colors.red, textColor: Colors.white);
      }
    }
    return (borderColor: Colors.grey, color: Colors.white, textColor: Colors.black);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Letra Fatal'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder:(_)=>HistoryPage(historico: historico)));
            },
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.indigo[100],
            child: SizedBox(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          for (int i = 0; i < tentativasRestantes; i++)
                            Icon(Icons.favorite, color: Colors.red, size: 32),
                        ],
                      ),
                    ),
                    if (ganhouOuPerdeu().isNotEmpty)
                      SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Column(children: [
                            Text(
                              ganhouOuPerdeu(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Center(child: ElevatedButton(
                              onPressed: iniciarNovoJogo,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.refresh),
                                  SizedBox(width: 8),
                                  Text("Novo Jogo"),
                              ],),
                            ))
                          ],)
                        ),
                      )
                    else
                      SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            exibirLetra(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ]
                )
              )
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(child: 
                    Row(
                      children: [
                        ButtonWidget(
                          text: "A", 
                          onPressed: () { tentarLetra("A"); }, 
                          color: corDaLetra("A").color, 
                          textColor: corDaLetra("A").textColor, 
                          borderColor: corDaLetra("A").borderColor),
                        ButtonWidget(
                          text: "B", 
                          onPressed: () { tentarLetra("B"); }, 
                          color: corDaLetra("B").color, 
                          textColor: corDaLetra("B").textColor, 
                          borderColor: corDaLetra("B").borderColor),
                        ButtonWidget(
                          text: "C", 
                          onPressed: () { tentarLetra("C"); }, 
                          color: corDaLetra("C").color, 
                          textColor: corDaLetra("C").textColor, 
                          borderColor: corDaLetra("C").borderColor),
                        ButtonWidget(
                          text: "D", 
                          onPressed: () { tentarLetra("D"); }, 
                          color: corDaLetra("D").color, 
                          textColor: corDaLetra("D").textColor, 
                          borderColor: corDaLetra("D").borderColor),
                        ButtonWidget(
                          text: "E", 
                          onPressed: () { tentarLetra("E"); }, 
                          color: corDaLetra("E").color, 
                          textColor: corDaLetra("E").textColor, 
                          borderColor: corDaLetra("E").borderColor),
                        ButtonWidget(
                          text: "F", 
                          onPressed: () { tentarLetra("F"); }, 
                          color: corDaLetra("F").color, 
                          textColor: corDaLetra("F").textColor, 
                          borderColor: corDaLetra("F").borderColor),
                      ]
                    )
                  ),
                  Expanded(child: 
                    Row(
                      children: [
                        ButtonWidget(
                          text: "G", 
                          onPressed: () { tentarLetra("G"); }, 
                          color: corDaLetra("G").color, 
                          textColor: corDaLetra("G").textColor, 
                          borderColor: corDaLetra("G").borderColor),
                        ButtonWidget(
                          text: "H", 
                          onPressed: () { tentarLetra("H"); }, 
                          color: corDaLetra("H").color, 
                          textColor: corDaLetra("H").textColor, 
                          borderColor: corDaLetra("H").borderColor),
                        ButtonWidget(
                          text: "I", 
                          onPressed: () { tentarLetra("I"); }, 
                          color: corDaLetra("I").color, 
                          textColor: corDaLetra("I").textColor, 
                          borderColor: corDaLetra("I").borderColor),
                        ButtonWidget(
                          text: "J", 
                          onPressed: () { tentarLetra("J"); }, 
                          color: corDaLetra("J").color, 
                          textColor: corDaLetra("J").textColor, 
                          borderColor: corDaLetra("J").borderColor),
                        ButtonWidget(
                          text: "K", 
                          onPressed: () { tentarLetra("K"); }, 
                          color: corDaLetra("K").color, 
                          textColor: corDaLetra("K").textColor, 
                          borderColor: corDaLetra("K").borderColor),
                        ButtonWidget(
                          text: "L", 
                          onPressed: () { tentarLetra("L"); }, 
                          color: corDaLetra("L").color, 
                          textColor: corDaLetra("L").textColor, 
                          borderColor: corDaLetra("L").borderColor),
                      ]
                    )
                  ),
                  Expanded(child: 
                    Row(
                      children: [
                        ButtonWidget(
                          text: "M", 
                          onPressed: () { tentarLetra("M"); }, 
                          color: corDaLetra("M").color, 
                          textColor: corDaLetra("M").textColor, 
                          borderColor: corDaLetra("M").borderColor),
                        ButtonWidget(
                          text: "N", 
                          onPressed: () { tentarLetra("N"); }, 
                          color: corDaLetra("N").color, 
                          textColor: corDaLetra("N").textColor, 
                          borderColor: corDaLetra("N").borderColor),
                        ButtonWidget(
                          text: "O", 
                          onPressed: () { tentarLetra("O"); }, 
                          color: corDaLetra("O").color, 
                          textColor: corDaLetra("O").textColor, 
                          borderColor: corDaLetra("O").borderColor),
                        ButtonWidget(
                          text: "P", 
                          onPressed: () { tentarLetra("P"); }, 
                          color: corDaLetra("P").color, 
                          textColor: corDaLetra("P").textColor, 
                          borderColor: corDaLetra("P").borderColor),
                        ButtonWidget(
                          text: "Q", 
                          onPressed: () { tentarLetra("Q"); }, 
                          color: corDaLetra("Q").color, 
                          textColor: corDaLetra("Q").textColor, 
                          borderColor: corDaLetra("Q").borderColor),
                        ButtonWidget(text: "R", onPressed: () { tentarLetra("R"); }, color: corDaLetra("R").color, textColor: corDaLetra("R").textColor, borderColor: corDaLetra("R").borderColor),
                      ]
                    )
                  ),
                  Expanded(child: 
                    Row(
                      children: [
                        ButtonWidget(
                          text: "S", 
                          onPressed: () { tentarLetra("S"); }, 
                          color: corDaLetra("S").color, 
                          textColor: corDaLetra("S").textColor, 
                          borderColor: corDaLetra("S").borderColor),
                        ButtonWidget(
                          text: "T", 
                          onPressed: () { tentarLetra("T"); }, 
                          color: corDaLetra("T").color, 
                          textColor: corDaLetra("T").textColor, 
                          borderColor: corDaLetra("T").borderColor),
                        ButtonWidget(
                          text: "U", 
                          onPressed: () { tentarLetra("U"); }, 
                          color: corDaLetra("U").color, 
                          textColor: corDaLetra("U").textColor, 
                          borderColor: corDaLetra("U").borderColor),
                        ButtonWidget(
                          text: "V", 
                          onPressed: () { tentarLetra("V"); }, 
                          color: corDaLetra("V").color, 
                          textColor: corDaLetra("V").textColor, 
                          borderColor: corDaLetra("V").borderColor),
                        ButtonWidget(
                          text: "W", 
                          onPressed: () { tentarLetra("W"); }, 
                          color: corDaLetra("W").color, 
                          textColor: corDaLetra("W").textColor, 
                          borderColor: corDaLetra("W").borderColor),
                        ButtonWidget(
                          text: "X", 
                          onPressed: () { tentarLetra("X"); }, 
                          color: corDaLetra("X").color, 
                          textColor: corDaLetra("X").textColor, 
                          borderColor: corDaLetra("X").borderColor),
                      ]
                    )
                  ),
                  Expanded(child: 
                    Row(
                      children: [
                        ButtonWidget(
                          text: "Y", 
                          onPressed: () { tentarLetra("Y"); }, 
                          color: corDaLetra("Y").color, 
                          textColor: corDaLetra("Y").textColor, 
                          borderColor: corDaLetra("Y").borderColor),
                        ButtonWidget(
                          text: "Z", 
                          onPressed: () { tentarLetra("Z"); }, 
                          color: corDaLetra("Z").color, 
                          textColor: corDaLetra("Z").textColor, 
                          borderColor: corDaLetra("Z").borderColor),
                      ]
                    )
                  ),
                ],
              )
            )
          )
        ]
      )
    );
  }
}