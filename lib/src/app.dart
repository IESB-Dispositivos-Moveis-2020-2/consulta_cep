import 'package:consulta_cep/src/ui/pesquisa_endereco.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: PesquisaEndereco(),
    );
  }


}
