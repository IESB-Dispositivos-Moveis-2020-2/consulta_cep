import 'package:consulta_cep/src/blocs/cep_bloc.dart';
import 'package:consulta_cep/src/models/cep_model.dart';
import 'package:flutter/material.dart';

class PesquisaEndereco extends StatelessWidget {

  final _bloc = CepBloc();
  final _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    _textFieldController.addListener(() {
      _bloc.obterEndereco(porCep: _textFieldController.text);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta CEP'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Digite o CEP para encontrar o endereço',
                  hintText: '00000000',
                  helperText: 'somente números',
                ),
                keyboardType: TextInputType.number,
                controller: _textFieldController,
              ),

              Container(
                child: StreamBuilder(
                  stream: _bloc.ultimoEnderecoObtido,
                  builder: (context, AsyncSnapshot<CepModel> snapshot) {
                    if (snapshot.hasData) {
                      final endereco = snapshot.data!;
                      return Column(
                        children: [
                          Text('CEP: ${endereco.cep}'),
                          Text('UF: ${endereco.uf}'),
                          Text('Cidade: ${endereco.localidade}'),
                          Text('Bairro: ${endereco.bairro}'),
                          Text('Logradouro: ${endereco.logradouro}'),
                        ],
                      );
                    }
                    if (snapshot.hasError) {
                      return Text('Ocorreu um erro!\n${snapshot.error}');
                    }

                    return StreamBuilder(
                      stream: _bloc.carregando,
                      builder: (context, AsyncSnapshot<bool> snapshot) {
                        final carregando = snapshot.data ?? false;
                        if (carregando) {
                          return CircularProgressIndicator();
                        }else {
                          return Container();
                        }
                      },
                    );

                  },
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
