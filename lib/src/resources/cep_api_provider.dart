import 'dart:convert';

import 'package:consulta_cep/src/models/cep_model.dart';
import 'package:http/http.dart';

class CepApiProvider {
 final client = Client();
 final baseUrl = 'https://viacep.com.br/ws/';

 Future<CepModel> obterEndereco(String cep) async {
   final response = await client.get(Uri.parse('$baseUrl$cep/json'));
   if (response.statusCode >= 200 && response.statusCode < 300) {
      return CepModel.fromJson(json.decode(response.body));
   }else {
     throw Exception('Erro ao recuperar endereço. Status: ${response.statusCode}');
   }
 }

}
