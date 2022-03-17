class MessageSingle {
  MessageSingle({
    this.context,
    this.id,
    this.type,
    this.messageSingleId,
    this.accountId,
    this.msgid,
    this.from,
    this.to,
    this.cc,
    this.bcc,
    this.subject,
    this.seen,
    this.flagged,
    this.isDeleted,
    this.verifications,
    this.retention,
    this.retentionDate,
    this.text,
    this.html,
    this.hasAttachments,
    this.attachments,
    this.size,
    this.downloadUrl,
    this.createdAt,
    this.updatedAt,
  });

  String? context;
  String? id;
  String? type;
  String? messageSingleId;
  String? accountId;
  String? msgid;
  From? from;
  List<From>? to;
  List<dynamic>? cc;
  List<dynamic>? bcc;
  String? subject;
  bool? seen;
  bool? flagged;
  bool? isDeleted;
  List<dynamic>? verifications;
  bool? retention;
  DateTime? retentionDate;
  String? text;
  List<String?>? html;
  bool? hasAttachments;
  List<dynamic>? attachments;
  int? size;
  String? downloadUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory MessageSingle.fromJson(Map<String?, dynamic> json) => MessageSingle(
        context: json["@context"],
        id: json["@id"],
        type: json["@type"],
        messageSingleId: json["id"],
        accountId: json["accountId"],
        msgid: json["msgid"],
        from: From.fromJson(json["from"]),
        to: List<From>.from(json["to"].map((x) => From.fromJson(x))),
        cc: List<dynamic>.from(json["cc"].map((x) => x)),
        bcc: List<dynamic>.from(json["bcc"].map((x) => x)),
        subject: json["subject"],
        seen: json["seen"],
        flagged: json["flagged"],
        isDeleted: json["isDeleted"],
        verifications: List<dynamic>.from(json["verifications"].map((x) => x)),
        retention: json["retention"],
        retentionDate: DateTime.parse(json["retentionDate"]),
        text: json["text"],
        html: List<String?>.from(json["html"].map((x) => x)),
        hasAttachments: json["hasAttachments"],
        attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
        size: json["size"],
        downloadUrl: json["downloadUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String?, dynamic> toJson() => {
        "@context": context,
        "@id": id,
        "@type": type,
        "id": messageSingleId,
        "accountId": accountId,
        "msgid": msgid,
        "from": from?.toJson(),
        "to": List<dynamic>.from(to!.map((x) => x.toJson())),
        "cc": List<dynamic>.from(cc!.map((x) => x)),
        "bcc": List<dynamic>.from(bcc!.map((x) => x)),
        "subject": subject,
        "seen": seen,
        "flagged": flagged,
        "isDeleted": isDeleted,
        "verifications": List<dynamic>.from(verifications!.map((x) => x)),
        "retention": retention,
        "retentionDate": retentionDate?.toIso8601String(),
        "text": text,
        "html": List<dynamic>.from(html!.map((x) => x)),
        "hasAttachments": hasAttachments,
        "attachments": List<dynamic>.from(attachments!.map((x) => x)),
        "size": size,
        "downloadUrl": downloadUrl,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class From {
  From({
    this.address,
    this.name,
  });

  String? address;
  String? name;

  factory From.fromJson(Map<String?, dynamic> json) => From(
        address: json["address"],
        name: json["name"],
      );

  Map<String?, dynamic> toJson() => {
        "address": address,
        "name": name,
      };
}
