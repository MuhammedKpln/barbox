import 'dart:convert';

import 'package:isar/isar.dart';

part 'messages.db.g.dart';

@embedded
class MessageFromDb {
  String? name;
  String? address;
  MessageFromDb({
    this.name,
    this.address,
  });

  MessageFromDb copyWith({
    String? name,
    String? address,
  }) {
    return MessageFromDb(
      name: name ?? this.name,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'address': address,
    };
  }

  factory MessageFromDb.fromMap(Map<String, dynamic> map) {
    return MessageFromDb(
      name: map['name'] != null ? map['name'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageFromDb.fromJson(String source) =>
      MessageFromDb.fromMap(json.decode(source) as Map<String, dynamic>);
}

@collection
class MessagesDatabase {
  Id isarId = Isar.autoIncrement;

  String? accountId;

  String? context;

  DateTime? createdAt;

  String? downloadUrl;

  MessageFromDb? from;

  bool? hasAttachments;

  String? hydraMemberId;

  String? intro;

  bool? isDeleted;

  @Index(unique: true)
  String? msgid;

  bool? seen;

  int? size;

  String? subject;

  List<MessageFromDb>? to;

  String? type;

  DateTime? updatedAt;
  @Index(unique: true)
  String? id;
  MessagesDatabase({
    this.accountId,
    this.context,
    this.createdAt,
    this.downloadUrl,
    this.from,
    this.hasAttachments,
    this.hydraMemberId,
    this.intro,
    this.isDeleted,
    this.msgid,
    this.seen,
    this.size,
    this.subject,
    this.to,
    this.type,
    this.updatedAt,
    this.id,
  });
  MessagesDatabase copyWith({
    Id? isarId,
    String? accountId,
    String? context,
    DateTime? createdAt,
    String? downloadUrl,
    MessageFromDb? from,
    bool? hasAttachments,
    String? hydraMemberId,
    String? intro,
    bool? isDeleted,
    String? msgid,
    bool? seen,
    int? size,
    String? subject,
    List<MessageFromDb>? to,
    String? type,
    DateTime? updatedAt,
    String? id,
  }) {
    return MessagesDatabase(
      accountId: accountId ?? this.accountId,
      context: context ?? this.context,
      createdAt: createdAt ?? this.createdAt,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      from: from ?? this.from,
      hasAttachments: hasAttachments ?? this.hasAttachments,
      hydraMemberId: hydraMemberId ?? this.hydraMemberId,
      intro: intro ?? this.intro,
      isDeleted: isDeleted ?? this.isDeleted,
      msgid: msgid ?? this.msgid,
      seen: seen ?? this.seen,
      size: size ?? this.size,
      subject: subject ?? this.subject,
      to: to ?? this.to,
      type: type ?? this.type,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accountId': accountId,
      'context': context,
      'createdAt': createdAt.toString(),
      'downloadUrl': downloadUrl,
      'from': from?.toMap(),
      'hasAttachments': hasAttachments,
      'hydraMemberId': hydraMemberId,
      'intro': intro,
      'isDeleted': isDeleted,
      'msgid': msgid,
      'seen': seen,
      'size': size,
      'subject': subject,
      'to': to?.map((x) => x.toMap()).toList(),
      'type': type,
      'updatedAt': updatedAt?.toString(),
      'id': id,
    };
  }

  factory MessagesDatabase.fromMap(Map<String, dynamic> map) {
    return MessagesDatabase(
      accountId: map['accountId'] != null ? map['accountId'] as String : null,
      context: map['context'] != null ? map['context'] as String : null,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      downloadUrl:
          map['downloadUrl'] != null ? map['downloadUrl'] as String : null,
      from: map['from'] != null ? MessageFromDb.fromMap(map['from']) : null,
      hasAttachments:
          map['hasAttachments'] != null ? map['hasAttachments'] as bool : null,
      hydraMemberId:
          map['hydraMemberId'] != null ? map['hydraMemberId'] as String : null,
      intro: map['intro'] != null ? map['intro'] as String : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
      msgid: map['msgid'] != null ? map['msgid'] as String : null,
      seen: map['seen'] != null ? map['seen'] as bool : null,
      size: map['size'] != null ? map['size'] as int : null,
      subject: map['subject'] != null ? map['subject'] as String : null,
      to: map['to'] != null
          ? List<MessageFromDb>.from(
              (map['to']).map<MessageFromDb?>(
                (x) => MessageFromDb.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      type: map['type'] != null ? map['type'] as String : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessagesDatabase.fromJson(String source) =>
      MessagesDatabase.fromMap(json.decode(source) as Map<String, dynamic>);
}
