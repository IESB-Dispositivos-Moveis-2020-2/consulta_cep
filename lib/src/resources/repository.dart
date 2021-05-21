import 'package:consulta_cep/src/models/cep_model.dart';
import 'package:consulta_cep/src/resources/cep_api_provider.dart';

class Repository {
  final cepApiProvider = CepApiProvider();

  Future<CepModel> obterEndereco(String cep) => cepApiProvider.obterEndereco(cep);

}
