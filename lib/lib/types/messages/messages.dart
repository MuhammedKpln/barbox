import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'message.dart';

class Messages extends Equatable {
  final String? context;
  final String? id;
  final String? type;
  final List<Message> hydraMember;
  final int hydraTotalItems;

  const Messages({
    this.context,
    this.id,
    this.type,
    required this.hydraMember,
    required this.hydraTotalItems,
  });

  factory Messages.fromMap(Map<String, dynamic> data) => Messages(
        context: data['@context'] as String?,
        id: data['@id'] as String?,
        type: data['@type'] as String?,
        hydraMember: (data['hydra:member'] as List<dynamic>)
            .map((e) => Message.fromMap(e as Map<String, dynamic>))
            .toList(),
        hydraTotalItems: data['hydra:totalItems'] as int,
      );

  Map<String, dynamic> toMap() => {
        '@context': context,
        '@id': id,
        '@type': type,
        'hydra:member': hydraMember.map((e) => e.toMap()).toList(),
        'hydra:totalItems': hydraTotalItems,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Messages].
  factory Messages.fromJson(String data) {
    return Messages.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Messages] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  @ignore
  bool get stringify => true;

  @override
  @ignore
  List<Object?> get props {
    return [
      context,
      id,
      type,
      hydraMember,
      hydraTotalItems,
    ];
  }
}
