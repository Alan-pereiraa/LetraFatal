import 'package:flutter/material.dart';
import 'package:letrafatal/game_page.dart';

class HistoryPage extends StatelessWidget {
  final List<Partida> historico;
  const HistoryPage({super.key, required this.historico});

  bool emAndamento(Partida partida) {
    return !partida.venceu && partida.tentativasRestantes > 0;
  }

  IconData iconeDaPartida(Partida partida) {
    if (emAndamento(partida)) {
      return Icons.hourglass_empty;
    } else if (partida.venceu) {
      return Icons.check_circle;
    } else {
      return Icons.cancel;
    }
  }

  Color corDaPartida(Partida partida) {
    if (emAndamento(partida)) {
      return Colors.orange;
    } else if (partida.venceu) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  String exibirPalavra(Partida partida) {
    if (!emAndamento(partida)) {
      return partida.palavra;
    }

    return partida.palavra.split('').map((letra) {
      return partida.letrasUsadas.contains(letra) ? letra : "_";
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Histórico"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (historico.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Nenhuma partida realizada.",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            else
              ...historico.map(
                (partida) => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        iconeDaPartida(partida),
                        color: corDaPartida(partida),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exibirPalavra(partida),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Letras: ${partida.letrasUsadas.join(', ')}",
                            ),
                            Text(
                              "Tentativas restantes: ${partida.tentativasRestantes}",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
