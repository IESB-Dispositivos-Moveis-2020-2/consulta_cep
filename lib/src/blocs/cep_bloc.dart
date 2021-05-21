import 'dart:developer';

import 'package:consulta_cep/src/models/cep_model.dart';
import 'package:consulta_cep/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CepBloc {
  final _repository = Repository();
  final _cepFetcher = PublishSubject<CepModel>();
  final _carregando = PublishSubject<bool>();

  Stream<CepModel> get ultimoEnderecoObtido => _cepFetcher.stream;
  Stream<bool> get carregando => _carregando.stream;


  obterEndereco({required String porCep}) async {
    if (porCep != null && porCep.length == 8) {
      _carregando.sink.add(true);
      log('Recebi um cep: $porCep');
      final enderecoObtido = await _repository.obterEndereco(porCep);
      _carregando.sink.add(false);
      _cepFetcher.sink.add(enderecoObtido);
    }
    await _cepFetcher.drain();
  }

  dispose() {
    _cepFetcher.close();
    _carregando.close();
  }



}
