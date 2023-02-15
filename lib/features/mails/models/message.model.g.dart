// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Messages _$$_MessagesFromJson(Map<String, dynamic> json) => _$_Messages(
      hydraMember: (json['hydra:member'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      hydraTotalItems: json['hydra:totalItems'] as int,
      hydraView: json['hydra:view'] == null
          ? null
          : HydraView.fromJson(json['hydra:view'] as Map<String, dynamic>),
      hydraSearch: json['hydra:search'] == null
          ? null
          : HydraSearch.fromJson(json['hydra:search'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_MessagesToJson(_$_Messages instance) =>
    <String, dynamic>{
      'hydra:member': instance.hydraMember,
      'hydra:totalItems': instance.hydraTotalItems,
      'hydra:view': instance.hydraView,
      'hydra:search': instance.hydraSearch,
    };

_$_Message _$$_MessageFromJson(Map<String, dynamic> json) => _$_Message(
      id: json['@id'] as String?,
      type: json['@type'] as String?,
      context: json['@context'] as String?,
      hydraMemberId: json['id'] as String,
      accountId: json['accountId'] as String,
      msgid: json['msgid'] as String,
      from: MessageFrom.fromJson(json['from'] as Map<String, dynamic>),
      to: (json['to'] as List<dynamic>?)
          ?.map((e) => MessageFrom.fromJson(e as Map<String, dynamic>))
          .toList(),
      subject: json['subject'] as String,
      intro: json['intro'] as String?,
      seen: json['seen'] as bool,
      isDeleted: json['isDeleted'] as bool,
      hasAttachments: json['hasAttachments'] as bool,
      size: json['size'] as int,
      downloadUrl: json['downloadUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      '@id': instance.id,
      '@type': instance.type,
      '@context': instance.context,
      'id': instance.hydraMemberId,
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
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$_MessageFrom _$$_MessageFromFromJson(Map<String, dynamic> json) =>
    _$_MessageFrom(
      name: json['name'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$$_MessageFromToJson(_$_MessageFrom instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
    };

_$_HydraSearch _$$_HydraSearchFromJson(Map<String, dynamic> json) =>
    _$_HydraSearch(
      type: json['@type'] as String?,
      hydraTemplate: json['hydra:template'] as String?,
      hydraVariableRepresentation:
          json['hydra:variableRepresentation'] as String?,
      hydraMapping: (json['hydraMapping'] as List<dynamic>?)
          ?.map((e) => HydraMapping.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_HydraSearchToJson(_$_HydraSearch instance) =>
    <String, dynamic>{
      '@type': instance.type,
      'hydra:template': instance.hydraTemplate,
      'hydra:variableRepresentation': instance.hydraVariableRepresentation,
      'hydraMapping': instance.hydraMapping,
    };

_$_HydraMapping _$$_HydraMappingFromJson(Map<String, dynamic> json) =>
    _$_HydraMapping(
      type: json['@type'] as String?,
      variable: json['variable'] as String?,
      property: json['property'] as String?,
      required: json['required'] as bool?,
    );

Map<String, dynamic> _$$_HydraMappingToJson(_$_HydraMapping instance) =>
    <String, dynamic>{
      '@type': instance.type,
      'variable': instance.variable,
      'property': instance.property,
      'required': instance.required,
    };

_$_HydraView _$$_HydraViewFromJson(Map<String, dynamic> json) => _$_HydraView(
      id: json['@id'] as String?,
      type: json['@type'] as String?,
      hydraFirst: json['hydra:first'] as String,
      hydraLast: json['hydra:last'] as String,
      hydraPrevious: json['hydra:previous'] as String,
      hydraNext: json['hydra:next'] as String,
    );

Map<String, dynamic> _$$_HydraViewToJson(_$_HydraView instance) =>
    <String, dynamic>{
      '@id': instance.id,
      '@type': instance.type,
      'hydra:first': instance.hydraFirst,
      'hydra:last': instance.hydraLast,
      'hydra:previous': instance.hydraPrevious,
      'hydra:next': instance.hydraNext,
    };
