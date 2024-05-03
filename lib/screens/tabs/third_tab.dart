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
        return 'Temos o jogo do Pac-Man na aba a esquerda.';
      case 'quais são os métodos de pagamento aceitos?':
        return 'Aceitamos PIX, cartão de débito e crédito.';
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
    return Row(
      mainAxisAlignment:
          isUser ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          child: Column(
            crossAxisAlignment:
                isUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  if (isUser)
                    CircleAvatar(
                      backgroundImage: AssetImage('asset/fototeste2.png'),
                    )
                  else
                    CircleAvatar(
                      backgroundImage: AssetImage('asset/fototeste.png'),
                    ),
                  SizedBox(width: 8.0), // Espaço entre o avatar e o texto
                  Text(name),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0),
                child: Text(text),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
