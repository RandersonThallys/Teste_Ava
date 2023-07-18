import 'dart:convert';

class CepResitory {
  String? cep;
  String? street;
  String? complement;
  String? neighborhood;
  String? locality;
  String? state;
  bool? erro;

  CepResitory({
    this.cep,
    this.street,
    this.complement,
    this.neighborhood,
    this.locality,
    this.state,
    this.erro,
  });

  factory CepResitory.fromJson(String str) =>
      CepResitory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CepResitory.fromMap(Map<String, dynamic> json) => CepResitory(
      cep: json["cep"],
      street: json["logradouro"],
      complement: json["complemento"],
      neighborhood: json["bairro"],
      locality: json["localidade"],
      state: json["uf"],
      erro: json["erro"]);

  Map<String, dynamic> toMap() => {
        "cep": cep,
        "logradouro": street,
        "complemento": complement,
        "bairro": neighborhood,
        "localidade": state,
        "uf": state,
        "erro": erro
      };
}
