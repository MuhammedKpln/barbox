import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

import 'from.dart';
import 'to.dart';

part 'message.g.dart';

@Collection(inheritance: false)
class Message extends Equatable {
  final Id isarId = Isar.autoIncrement;
  final String privateId;
  final String privateType;
  @Index(unique: true)
  final String id;
  final String accountId;
  final String msgid;
  final From from;
  final List<To> to;
  final String subject;
  final String? intro;
  final bool seen;
  final bool isDeleted;
  final bool hasAttachments;
  final int size;
  final String downloadUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Message({
    required this.id,
    required this.privateType,
    required this.privateId,
    required this.accountId,
    required this.msgid,
    required this.from,
    required this.to,
    required this.subject,
    this.intro,
    required this.seen,
    required this.isDeleted,
    required this.hasAttachments,
    required this.size,
    required this.downloadUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Message.fromMap(Map<String, dynamic> data) => Message(
        privateId: data['@id'] as String,
        privateType: data['@type'] as String,
        id: data['id'] as String,
        accountId: data['accountId'] as String,
        msgid: data['msgid'] as String,
        from: From.fromMap(data['from'] as Map<String, dynamic>),
        to: (data['to'] as List<dynamic>)
            .map((e) => To.fromMap(e as Map<String, dynamic>))
            .toList(),
        subject: data['subject'] as String,
        intro: data['intro'] as String?,
        seen: data['seen'] as bool,
        isDeleted: data['isDeleted'] as bool,
        hasAttachments: data['hasAttachments'] as bool,
        size: data['size'] as int,
        downloadUrl: data['downloadUrl'] as String,
        createdAt: DateTime.parse(data['createdAt']),
        updatedAt: DateTime.parse(data['updatedAt']),
      );

  Map<String, dynamic> toMap() => {
        '@id': privateId,
        '@type': privateType,
        'id': id,
        'accountId': accountId,
        'msgid': msgid,
        'from': from.toMap(),
        'to': to.map((e) => e.toMap()).toList(),
        'subject': subject,
        'intro': intro,
        'seen': seen,
        'isDeleted': isDeleted,
        'hasAttachments': hasAttachments,
        'size': size,
        'downloadUrl': downloadUrl,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [HydraMember].
  factory Message.fromJson(String data) {
    return Message.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [HydraMember] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @ignore
  @override
  List<Object?> get props {
    return [
      privateId,
      privateType,
      id,
      accountId,
      msgid,
      from,
      to,
      subject,
      intro,
      seen,
      isDeleted,
      hasAttachments,
      size,
      downloadUrl,
      createdAt,
      updatedAt,
    ];
  }
}
