import 'dart:convert';

import 'package:spamify/types/message.dart';

class MessagesModel {
  MessagesModel({
    this.context,
    this.id,
    this.type,
    this.hydraMember,
    required this.hydraTotalItems,
  });

  String? context;
  String? id;
  String? type;
  List<HydraMember>? hydraMember;
  int hydraTotalItems;

  factory MessagesModel.fromJson(Map<String, dynamic> json) => MessagesModel(
        context: json["@context"] == null ? null : json["@context"],
        id: json["id"] == null ? null : json["id"],
        type: json["@type"] == null ? null : json["@type"],
        hydraMember: json["hydra:member"] == null
            ? null
            : List<HydraMember>.from(
                json["hydra:member"].map((x) => HydraMember.fromJson(x))),
        hydraTotalItems:
            json["hydra:totalItems"] == null ? null : json["hydra:totalItems"],
      );

  Map<String, dynamic> toJson() => {
        "@context": context == null ? null : context,
        "@id": id == null ? null : id,
        "@type": type == null ? null : type,
        "hydra:member": hydraMember == null
            ? null
            : List<dynamic>.from(hydraMember!.map((x) => x.toJson())),
        "hydra:totalItems": hydraTotalItems == null ? null : hydraTotalItems,
      };
}

class HydraMember {
  HydraMember({
    this.id,
    this.type,
    this.hydraMemberId,
    this.accountId,
    this.msgid,
    this.from,
    this.to,
    this.subject,
    this.intro,
    this.seen = false,
    this.isDeleted,
    this.hasAttachments,
    this.size,
    this.downloadUrl,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? type;
  String? hydraMemberId;
  String? accountId;
  String? msgid;
  From? from;
  List<From>? to;
  String? subject;
  String? intro;
  bool seen;
  bool? isDeleted;
  bool? hasAttachments;
  int? size;
  String? downloadUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory HydraMember.fromJson(Map<String, dynamic> json) => HydraMember(
        id: json["id"] == null ? null : json["id"],
        type: json["@type"] == null ? null : json["@type"],
        hydraMemberId: json["id"] == null ? null : json["id"],
        accountId: json["accountId"] == null ? null : json["accountId"],
        msgid: json["msgid"] == null ? null : json["msgid"],
        from: json["from"] == null ? null : From.fromJson(json["from"]),
        to: json["to"] == null
            ? null
            : List<From>.from(json["to"].map((x) => From.fromJson(x))),
        subject: json["subject"] == null ? null : json["subject"],
        intro: json["intro"] == null ? null : json["intro"],
        seen: json["seen"] == null ? null : json["seen"],
        isDeleted: json["isDeleted"] == null ? null : json["isDeleted"],
        hasAttachments:
            json["hasAttachments"] == null ? null : json["hasAttachments"],
        size: json["size"] == null ? null : json["size"],
        downloadUrl: json["downloadUrl"] == null ? null : json["downloadUrl"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "@id": id == null ? null : id,
        "@type": type == null ? null : type,
        "id": hydraMemberId == null ? null : hydraMemberId,
        "accountId": accountId == null ? null : accountId,
        "msgid": msgid == null ? null : msgid,
        "from": from == null ? null : from?.toJson(),
        "to":
            to == null ? null : List<dynamic>.from(to!.map((x) => x.toJson())),
        "subject": subject == null ? null : subject,
        "intro": intro == null ? null : intro,
        "seen": seen == null ? null : seen,
        "isDeleted": isDeleted == null ? null : isDeleted,
        "hasAttachments": hasAttachments == null ? null : hasAttachments,
        "size": size == null ? null : size,
        "downloadUrl": downloadUrl == null ? null : downloadUrl,
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}
