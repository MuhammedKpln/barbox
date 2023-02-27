import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'package:barbox/types/single_message/attachment.dart';

import 'from.dart';
import 'to.dart';

part 'single_message.g.dart';

@Collection(inheritance: false)
class SingleMessage extends Equatable {
  final Id isarId = Isar.autoIncrement;
  final String? privateContext;
  final String? privateId;
  final String? privateType;
  final String id;
  final String accountId;
  final String msgid;
  final From from;
  final List<To> to;
  final List<String?> cc;
  final List<String?> bcc;
  final String? subject;
  final bool seen;
  final bool flagged;
  final bool isDeleted;
  final List<String?> verifications;
  final bool retention;
  final DateTime retentionDate;
  final String text;
  final List<String?> html;
  final bool hasAttachments;
  final List<Attachment?> attachments;
  final int size;
  final String downloadUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SingleMessage({
    this.privateContext,
    this.privateType,
    this.privateId,
    required this.id,
    required this.accountId,
    required this.msgid,
    required this.from,
    required this.to,
    required this.cc,
    required this.bcc,
    this.subject,
    required this.seen,
    required this.flagged,
    required this.isDeleted,
    required this.verifications,
    required this.retention,
    required this.retentionDate,
    required this.text,
    required this.html,
    required this.hasAttachments,
    required this.attachments,
    required this.size,
    required this.downloadUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SingleMessage.fromMap(Map<String, dynamic> data) => SingleMessage(
        privateContext: data['@context'] as String?,
        privateId: data['@id'] as String?,
        privateType: data['@type'] as String?,
        id: data['id'] as String,
        accountId: data['accountId'] as String,
        msgid: data['msgid'] as String,
        from: From.fromMap(data['from'] as Map<String, dynamic>),
        to: (data['to'] as List<dynamic>)
            .map((e) => To.fromMap(e as Map<String, dynamic>))
            .toList(),
        cc: List<String>.from(data["cc"] as List<dynamic>)
            .toList(growable: false),
        bcc: List<String>.from(data["bcc"] as List<dynamic>)
            .toList(growable: false),
        subject: data['subject'] as String?,
        seen: data['seen'] as bool,
        flagged: data['flagged'] as bool,
        isDeleted: data['isDeleted'] as bool,
        verifications:
            List<String>.from(data['verifications'] as List<dynamic>),
        retention: data['retention'] as bool,
        retentionDate: DateTime.parse(data['retentionDate']),
        text: data['text'] as String,
        html: List<String>.from(data["html"]),
        hasAttachments: data['hasAttachments'] as bool,
        attachments: List<Attachment>.from(
            (data['attachments'] as List<dynamic>)
                .map((e) => Attachment.fromMap(e.toMap()))),
        size: data['size'] as int,
        downloadUrl: data['downloadUrl'] as String,
        createdAt: DateTime.parse(data['createdAt']),
        updatedAt: DateTime.parse(data['updatedAt']),
      );

  Map<String, dynamic> toMap() => {
        '@context': privateContext,
        '@id': privateId,
        '@type': privateType,
        'id': id,
        'accountId': accountId,
        'msgid': msgid,
        'from': from.toMap(),
        'to': to.map((e) => e.toMap()).toList(),
        'cc': cc,
        'bcc': bcc,
        'subject': subject,
        'seen': seen,
        'flagged': flagged,
        'isDeleted': isDeleted,
        'verifications': verifications,
        'retention': retention,
        'retentionDate': retentionDate,
        'text': text,
        'html': html,
        'hasAttachments': hasAttachments,
        'attachments': attachments,
        'size': size,
        'downloadUrl': downloadUrl,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SingleMessage].
  factory SingleMessage.fromJson(String data) {
    return SingleMessage.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SingleMessage] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  @ignore
  bool get stringify => true;

  @override
  @ignore
  List<Object?> get props {
    return [
      privateContext,
      privateId,
      privateType,
      id,
      accountId,
      msgid,
      from,
      to,
      cc,
      bcc,
      subject,
      seen,
      flagged,
      isDeleted,
      verifications,
      retention,
      retentionDate,
      text,
      html,
      hasAttachments,
      attachments,
      size,
      downloadUrl,
      createdAt,
      updatedAt,
    ];
  }
}
