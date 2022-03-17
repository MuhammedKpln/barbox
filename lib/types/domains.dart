import 'dart:convert';

class DomainsModel {
  DomainsModel({
    this.context,
    this.id,
    this.type,
    this.hydraMember,
    this.hydraTotalItems,
  });

  String? context;
  String? id;
  String? type;
  List<HydraMemberDomain>? hydraMember;
  int? hydraTotalItems;

  factory DomainsModel.fromJson(Map<String, dynamic> json) => DomainsModel(
        context: json["@context"] == null ? null : json["@context"],
        id: json["@id"] == null ? null : json["@id"],
        type: json["@type"] == null ? null : json["@type"],
        hydraMember: json["hydra:member"] == null
            ? null
            : List<HydraMemberDomain>.from(
                json["hydra:member"].map((x) => HydraMemberDomain.fromJson(x))),
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

class HydraMemberDomain {
  HydraMemberDomain({
    this.id,
    this.type,
    this.hydraMemberId,
    this.domain,
    this.isActive,
    this.isPrivate,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? type;
  String? hydraMemberId;
  String? domain;
  bool? isActive;
  bool? isPrivate;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory HydraMemberDomain.fromJson(Map<String, dynamic> json) =>
      HydraMemberDomain(
        id: json["@id"] == null ? null : json["@id"],
        type: json["@type"] == null ? null : json["@type"],
        hydraMemberId: json["id"] == null ? null : json["id"],
        domain: json["domain"] == null ? null : json["domain"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        isPrivate: json["isPrivate"] == null ? null : json["isPrivate"],
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
        "domain": domain == null ? null : domain,
        "isActive": isActive == null ? null : isActive,
        "isPrivate": isPrivate == null ? null : isPrivate,
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}
