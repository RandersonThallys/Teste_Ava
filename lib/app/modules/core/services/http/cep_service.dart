// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:teste_ava/app/modules/core/repositories/cep_repository.dart';
import 'package:http/http.dart' as http;

class ViaCepService {
  static Future<CepResitory> fetchCep({String? cep}) async {
    try {
      var response =
          await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
      if (response.statusCode == 200) {
        print("endereço: ${response.body}");
        return CepResitory.fromJson(response.body);
      } else {
        throw Exception('Requisição inválida!');
      }
    } catch (e) {
      rethrow;
    }
  }
}
