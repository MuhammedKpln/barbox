import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'to.g.dart';

@Embedded(inheritance: false)
class To extends Equatable {
  final String? address;
  final String? name;

  const To({this.address, this.name});

  factory To.fromMap(Map<String, dynamic> data) => To(
        address: data['address'] as String?,
        name: data['name'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'address': address,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [To].
  factory To.fromJson(String data) {
    return To.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [To] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  @ignore
  List<Object?> get props => [address, name];
}
