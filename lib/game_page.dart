import 'dart:math';

import 'package:flutter/material.dart';
import 'package:letrafatal/widgets/button_widget.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final palavras = [
    "FLUTTER",
    "DART",
    "PROGRAMACAO",
    "COMPUTADOR",
    "MOBILE",
    "DESENVOLVIMENTO",
    "APLICATIVO",
    "JOGO",
  ];
  late String palavraSecreta;
  int tentativasRestantes = 5;
  late List<String> letrasUsadas;

  @override
  void initState() {
    super.initState();

    int index = Random().nextInt(palavras.length);
    palavraSecreta = palavras[index];
    letrasUsadas = [];
  }

  void iniciarNovoJogo() {
    final random = Random();

    setState(() {
      palavraSecreta = palavras[random.nextInt(palavras.length)];
      letrasUsadas.clear();
      tentativasRestantes = 5;
    });
  }

  void tentarLetra(String letra) {
    if (letrasUsadas.contains(letra)) {
      return;
    }

    setState(() {
      letrasUsadas.add(letra);
      tentativasRestantes--;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Letra Fatal'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
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
                        ButtonWidget(text: "A", onPressed: () { tentarLetra("A"); }, color: letrasUsadas.contains("A") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("A") ? Colors.grey : Colors.black),
                        ButtonWidget(text: "B", onPressed: () { tentarLetra("B"); }, color: letrasUsadas.contains("B") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("B") ? Colors.grey : Colors.black),
                        ButtonWidget(text: "C", onPressed: () { tentarLetra("C"); }, color: letrasUsadas.contains("C") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("C") ? Colors.grey : Colors.black),
                        ButtonWidget(text: "D", onPressed: () { tentarLetra("D"); }, color: letrasUsadas.contains("D") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("D") ? Colors.grey : Colors.black),
                        ButtonWidget(text: "E", onPressed: () { tentarLetra("E"); }, color: letrasUsadas.contains("E") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("E") ? Colors.grey : Colors.black),
                        ButtonWidget(text: "F", onPressed: () { tentarLetra("F"); }, color: letrasUsadas.contains("F") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("F") ? Colors.grey : Colors.black),
                      ]
                    )
                  ),
                  Expanded(child: 
                    Row(
                      children: [
                        ButtonWidget(text: "G", onPressed: () { tentarLetra("G"); }, color: letrasUsadas.contains("G") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("G") ? Colors.grey : Colors.black),
                        ButtonWidget(text: "H", onPressed: () { tentarLetra("H"); }, color: letrasUsadas.contains("H") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("H") ? Colors.grey : Colors.black),
                        ButtonWidget(text: "I", onPressed: () { tentarLetra("I"); }, color: letrasUsadas.contains("I") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("I") ? Colors.grey : Colors.black),
                        ButtonWidget(text: "J", onPressed: () { tentarLetra("J"); }, color: letrasUsadas.contains("J") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("J") ? Colors.grey : Colors.black),
                        ButtonWidget(text: "K", onPressed: () { tentarLetra("K"); }, color: letrasUsadas.contains("K") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("K") ? Colors.grey : Colors.black),
                        ButtonWidget(text: "L", onPressed: () { tentarLetra("L"); }, color: letrasUsadas.contains("L") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("L") ? Colors.grey : Colors.black),
                      ]
                    )
                  ),
                  Expanded(child: 
                    Row(
                      children: [
                        ButtonWidget(text: "M", onPressed: () { tentarLetra("M"); }, color: letrasUsadas.contains("M") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("M") ? Colors.grey : Colors.black),
                        ButtonWidget(text: "N", onPressed: () { tentarLetra("N"); }, color: letrasUsadas.contains("N") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("N") ? Colors.grey : Colors.black),
                        ButtonWidget(text: "O", onPressed: () { tentarLetra("O"); }, color: letrasUsadas.contains("O") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("O") ? Colors.grey : Colors.black),
                        ButtonWidget(text: "P", onPressed: () { tentarLetra("P"); }, color: letrasUsadas.contains("P") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("P") ? Colors.grey : Colors.black),
                        ButtonWidget(text: "Q", onPressed: () { tentarLetra("Q"); }, color: letrasUsadas.contains("Q") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("Q") ? Colors.grey : Colors.black),
                        ButtonWidget(text: "R", onPressed: () { tentarLetra("R"); }, color: letrasUsadas.contains("R") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("R") ? Colors.grey : Colors.black),
                      ]
                    )
                  ),
                  Expanded(child: 
                    Row(
                      children: [
                        ButtonWidget(text: "S", onPressed: () { tentarLetra("S"); }, color: letrasUsadas.contains("S") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("S") ? Colors.white10 : Colors.black),
                        ButtonWidget(text: "T", onPressed: () { tentarLetra("T"); }, color: letrasUsadas.contains("T") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("T") ? Colors.grey : Colors.black),
                        ButtonWidget(text: "U", onPressed: () { tentarLetra("U"); }, color: letrasUsadas.contains("U") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("U") ? Colors.grey : Colors.black),
                        ButtonWidget(text: "V", onPressed: () { tentarLetra("V"); }, color: letrasUsadas.contains("V") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("V") ? Colors.grey : Colors.black),
                        ButtonWidget(text: "W", onPressed: () { tentarLetra("W"); }, color: letrasUsadas.contains("W") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("W") ? Colors.grey : Colors.black),
                        ButtonWidget(text: "X", onPressed: () { tentarLetra("X"); }, color: letrasUsadas.contains("X") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("X") ? Colors.grey : Colors.black),
                      ]
                    )
                  ),
                  Expanded(child: 
                    Row(
                      children: [
                        ButtonWidget(text: "Y", onPressed: () { tentarLetra("Y"); }, color: letrasUsadas.contains("Y") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("Y") ? Colors.grey : Colors.black),
                        ButtonWidget(text: "Z", onPressed: () { tentarLetra("Z"); }, color: letrasUsadas.contains("Z") ? Colors.grey : Colors.white, textColor: letrasUsadas.contains("Z") ? Colors.grey : Colors.black),
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