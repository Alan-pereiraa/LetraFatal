# Letra Fatal

Um jogo da forca simples feito em Flutter: descubra a palavra secreta antes de esgotar suas tentativas!

## Como jogar

1. Ao abrir o app, uma palavra secreta é sorteada automaticamente e exibida como um conjunto de traços (`_ _ _ _`), um para cada letra.
2. Você começa com **5 vidas** (❤️), mostradas no topo da tela.
3. Toque em uma letra do teclado exibido na tela para tentar adivinhar:
   - Se a letra existir na palavra, ela é revelada em todos os espaços correspondentes.
   - Se a letra não existir, você perde uma vida.
   - Letras já usadas ficam acinzentadas e não podem ser selecionadas novamente.
4. O jogo termina quando:
   - **Você vence** 🎉 — todas as letras da palavra são descobertas antes de zerar as vidas.
   - **Você perde** 💀 — as vidas chegam a zero; a palavra correta é revelada na tela.
5. Ao final de cada partida, use o botão **"Novo Jogo"** para sortear uma nova palavra e recomeçar.

## Histórico de partidas

Toque no ícone de histórico (🕒) no canto superior direito da tela para ver as partidas jogadas anteriormente, incluindo a palavra, as letras usadas, o resultado (vitória ou derrota) e a data.

## Executando o projeto

Pré-requisitos: [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado.

```bash
flutter pub get
flutter run
```

Escolha o dispositivo/emulador desejado (Android, iOS, web, desktop) quando solicitado pelo Flutter.
