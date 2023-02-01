// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Messages _$$_MessagesFromJson(Map<String, dynamic> json) => _$_Messages(
      hydraMember: (json['hydraMember'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      hydraTotalItems: json['hydraTotalItems'] as int?,
      hydraView: json['hydraView'] == null
          ? null
          : HydraView.fromJson(json['hydraView'] as Map<String, dynamic>),
      hydraSearch: json['hydraSearch'] == null
          ? null
          : HydraSearch.fromJson(json['hydraSearch'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_MessagesToJson(_$_Messages instance) =>
    <String, dynamic>{
      'hydraMember': instance.hydraMember,
      'hydraTotalItems': instance.hydraTotalItems,
      'hydraView': instance.hydraView,
      'hydraSearch': instance.hydraSearch,
    };

_$_Message _$$_MessageFromJson(Map<String, dynamic> json) => _$_Message(
      id: json['id'] as String?,
      type: json['type'] as String?,
      context: json['context'] as String?,
      hydraMemberId: json['hydraMemberId'] as String?,
      accountId: json['accountId'] as String?,
      msgid: json['msgid'] as String?,
      from: json['from'] == null
          ? null
          : MessageFrom.fromJson(json['from'] as Map<String, dynamic>),
      to: (json['to'] as List<dynamic>?)
          ?.map((e) => MessageFrom.fromJson(e as Map<String, dynamic>))
          .toList(),
      subject: json['subject'] as String?,
      intro: json['intro'] as String?,
      seen: json['seen'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      hasAttachments: json['hasAttachments'] as bool?,
      size: json['size'] as int?,
      downloadUrl: json['downloadUrl'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'context': instance.context,
      'hydraMemberId': instance.hydraMemberId,
      'accountId': instance.accountId,
      'msgid': instance.msgid,
      'from': instance.from,
      'to': instance.to,
      'subject': instance.subject,
      'intro': instance.intro,
      'seen': instance.seen,
      'isDeleted': instance.isDeleted,
      'hasAttachments': instance.hasAttachments,
      'size': instance.size,
      'downloadUrl': instance.downloadUrl,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$_MessageFrom _$$_MessageFromFromJson(Map<String, dynamic> json) =>
    _$_MessageFrom(
      name: json['name'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$$_MessageFromToJson(_$_MessageFrom instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
    };

_$_HydraSearch _$$_HydraSearchFromJson(Map<String, dynamic> json) =>
    _$_HydraSearch(
      type: json['type'] as String?,
      hydraTemplate: json['hydraTemplate'] as String?,
      hydraVariableRepresentation:
          json['hydraVariableRepresentation'] as String?,
      hydraMapping: (json['hydraMapping'] as List<dynamic>?)
          ?.map((e) => HydraMapping.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_HydraSearchToJson(_$_HydraSearch instance) =>
    <String, dynamic>{
      'type': instance.type,
      'hydraTemplate': instance.hydraTemplate,
      'hydraVariableRepresentation': instance.hydraVariableRepresentation,
      'hydraMapping': instance.hydraMapping,
    };

_$_HydraMapping _$$_HydraMappingFromJson(Map<String, dynamic> json) =>
    _$_HydraMapping(
      type: json['type'] as String?,
      variable: json['variable'] as String?,
      property: json['property'] as String?,
      required: json['required'] as bool?,
    );

Map<String, dynamic> _$$_HydraMappingToJson(_$_HydraMapping instance) =>
    <String, dynamic>{
      'type': instance.type,
      'variable': instance.variable,
      'property': instance.property,
      'required': instance.required,
    };

_$_HydraView _$$_HydraViewFromJson(Map<String, dynamic> json) => _$_HydraView(
      id: json['id'] as String?,
      type: json['type'] as String?,
      hydraFirst: json['hydraFirst'] as String?,
      hydraLast: json['hydraLast'] as String?,
      hydraPrevious: json['hydraPrevious'] as String?,
      hydraNext: json['hydraNext'] as String?,
    );

Map<String, dynamic> _$$_HydraViewToJson(_$_HydraView instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'hydraFirst': instance.hydraFirst,
      'hydraLast': instance.hydraLast,
      'hydraPrevious': instance.hydraPrevious,
      'hydraNext': instance.hydraNext,
    };
