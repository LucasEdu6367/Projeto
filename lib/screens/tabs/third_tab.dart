import 'package:flutter/material.dart';

class ThirdTab extends StatefulWidget {
  @override
  _ThirdTabState createState() => _ThirdTabState();
}

class _ThirdTabState extends State<ThirdTab> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      name: 'você',
      isUser: true, // Define que a mensagem é do usuário
    );

    setState(() {
      _messages.insert(0, message);

      String response = getAutoResponse(text);
      if (response != '') {
        ChatMessage botMessage = ChatMessage(
          text: response,
          name: 'Suporte',
          isUser: false, // Define que a mensagem é do suporte
        );
        _messages.insert(0, botMessage);
      }
    });
  }

  String getAutoResponse(String question) {
    switch (question.toLowerCase()) {
      case 'preciso de ajuda':
        return 'Olá! Como posso ajudar você hoje?';
      case 'como posso acessar a aba do jogo?':
        return 'Pode acessar na aba superior a esquerda.';
      case 'qual nome do jogo que tem em sua loja?':
        return 'Temos o jogo da cobra na aba a esquerda.';
      case 'quais são os métodos de pagamento aceitos?':
        return 'Aceitamos PIX, cartão de débito e crédito.';
      case 'o que acontece quando a cobra colide com a parede?':
        return 'Quando a cobra colide com a parede, o jogo termina.';
      case 'como faço para controlar a cobra?':
        return 'Você pode controlar a cobra deslizando o dedo na tela na direção desejada.';
      case 'quais são os objetivos do jogo?':
        return 'O objetivo principal do jogo é fazer com que a cobra cresça o máximo possível, evitando colisões.';
      case 'há alguma maneira de aumentar a velocidade da cobra?':
        return 'Não, a velocidade da cobra é constante.';
      case 'existe algum recurso de reiniciar o jogo?':
        return 'Sim, você pode reiniciar o jogo tocando no botão de reinício na tela.';
      case 'posso ajustar a dificuldade do jogo?':
        return 'Não, a dificuldade do jogo é fixa.';
      case 'o que acontece quando a cobra se enrosca em si mesma?':
        return 'Quando a cobra se enrosca em si mesma, o jogo termina.';
      case 'como são geradas as posições da comida?':
        return 'As posições da comida são geradas aleatoriamente na tela.';
      case 'há alguma forma de visualizar a pontuação durante o jogo?':
        return 'Sim, a pontuação é exibida na tela durante o jogo.';
      case 'qual é a cor da cobra?':
        return 'A cor da cobra é azul.';
      case 'é possível personalizar a aparência do jogo?':
        return 'Não, a aparência do jogo é fixa.';
      case 'existe alguma maneira de pausar o jogo durante uma partida?':
        return 'Não, o jogo não pode ser pausado durante uma partida.';
      case 'como posso começar a jogar?':
        return 'Para começar a jogar, toque na tela para iniciar o jogo.';
      case 'qual é a mecânica do jogo?':
        return 'A mecânica do jogo consiste em controlar uma cobra para coletar alimentos e evitar colisões.';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: Container(
          color: Colors.blue, // Cor da faixa azul
          child: Center(
            child: Text(
              'Suporte Chat',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration:
                  InputDecoration.collapsed(hintText: 'Como posso ajudar?'),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: Icon(Icons.send),
              color: Colors.red, // Cor do ícone
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String name;
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.name, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                if (isUser)
                  CircleAvatar(
                    backgroundImage: AssetImage('asset/fototeste2.png'),
                  ),
                if (!isUser) Spacer(), // Espaço para alinhar com a direita
                Text(name),
                SizedBox(width: 8.0), // Espaço entre o avatar e o texto
                if (isUser) Spacer(), // Espaço para alinhar com a esquerda
                if (!isUser)
                  CircleAvatar(
                    backgroundImage: AssetImage('asset/fototeste.png'),
                  ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
