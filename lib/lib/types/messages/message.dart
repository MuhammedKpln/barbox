import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

import 'from.dart';
import 'to.dart';

part 'message.g.dart';

@Collection(inheritance: false)
class Message extends Equatable {
  @Id()
  late int isarId;
  final String privateId;
  final String privateType;
  @Index(unique: true)
  final String id;
  @Index()
  final String accountId;
  final String msgid;
  final From from;
  final List<To> to;
  final String? subject;
  final String? intro;
  final bool seen;
  final bool isDeleted;
  final bool hasAttachments;
  final int size;
  final String downloadUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Message({
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
        'createdAt': createdAt.toString(),
        'updatedAt': createdAt.toString(),
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

  Message copyWith({
    String? id,
    String? privateType,
    String? privateId,
    String? accountId,
    String? msgid,
    From? from,
    List<To>? to,
    String? subject,
    String? intro,
    bool? seen,
    bool? isDeleted,
    bool? hasAttachments,
    int? size,
    String? downloadUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Message(
      id: id ?? this.id,
      privateType: privateType ?? this.privateType,
      privateId: privateId ?? this.privateId,
      accountId: accountId ?? this.accountId,
      msgid: msgid ?? this.msgid,
      from: from ?? this.from,
      to: to ?? this.to,
      subject: subject ?? this.subject,
      intro: intro ?? this.intro,
      seen: seen ?? this.seen,
      isDeleted: isDeleted ?? this.isDeleted,
      hasAttachments: hasAttachments ?? this.hasAttachments,
      size: size ?? this.size,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  @ignore
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
