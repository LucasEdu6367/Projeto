import 'package:flutter/material.dart';

class FirstTab extends StatelessWidget {
  const FirstTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red, // Cor da borda
              width: 2.0, // Largura da borda
            ),
            borderRadius: BorderRadius.circular(8.0), // Raio da borda
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("asset/playvault.jpeg"),
                const SizedBox(height: 20),
                const Text(
                  "Tudo sobre o seu jogo favorito PacMan em um só lugar. Desfrute desta plataforma e se divirta no jogo",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Converse na sala de chat por texto e tire suas dúvidas sobre o jogo",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
