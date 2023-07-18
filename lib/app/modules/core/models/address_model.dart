// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddressModel {
  final String cep;
  final String street;
  final String complement;
  final String neighborhood;
  final String locality;
  final String state;
  final int userId;
  final int? id;
  AddressModel({
    required this.cep,
    required this.street,
    required this.complement,
    required this.neighborhood,
    required this.locality,
    required this.state,
    required this.userId,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cep': cep,
      'street': street,
      'complement': complement,
      'neighborhood': neighborhood,
      'locality': locality,
      'state': state,
      'user_id': userId,
      'id': id
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      cep: map['cep'] as String,
      street: map['street'] as String,
      complement: map['complement'] as String,
      neighborhood: map['neighborhood'] as String,
      locality: map['locality'] as String,
      state: map['state'] as String,
      userId: map['user_id'] as int,
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  AddressModel copyWith({
    String? cep,
    String? street,
    String? complement,
    String? neighborhood,
    String? locality,
    String? state,
    int? userId,
    int? id,
  }) {
    return AddressModel(
      cep: cep ?? this.cep,
      street: street ?? this.street,
      complement: complement ?? this.complement,
      neighborhood: neighborhood ?? this.neighborhood,
      locality: locality ?? this.locality,
      state: state ?? this.state,
      userId: userId ?? this.userId,
      id: id ?? this.id,
    );
  }
}
