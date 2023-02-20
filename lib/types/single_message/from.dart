import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'from.g.dart';

@Embedded(inheritance: false)
class From extends Equatable {
  final String? address;
  final String? name;

  const From({this.address, this.name});

  factory From.fromMap(Map<String, dynamic> data) => From(
        address: data['address'] as String?,
        name: data['name'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'address': address,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [From].
  factory From.fromJson(String data) {
    return From.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [From] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  @ignore
  List<Object?> get props => [address, name];
}
