import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.model.freezed.dart';
part 'message.model.g.dart';

@freezed
class Messages with _$Messages {
  const factory Messages({
    @JsonKey(name: "hydra:member") required List<Message> hydraMember,
    @JsonKey(name: "hydra:totalItems") required int hydraTotalItems,
    @JsonKey(name: "hydra:view") HydraView? hydraView,
    @JsonKey(name: "hydra:search") HydraSearch? hydraSearch,
  }) = _Messages;

  factory Messages.fromJson(Map<String, dynamic> json) =>
      _$MessagesFromJson(json);
}

@freezed
class Message with _$Message {
  const factory Message({
    @JsonKey(name: "@id") String? typeId,
    @JsonKey(name: "@type") String? type,
    @JsonKey(name: "@context") String? context,
    @JsonKey(name: "id") required String primaryId,
    required String accountId,
    required String msgid,
    required MessageFrom from,
    required List<MessageFrom>? to,
    required String subject,
    String? intro,
    required bool seen,
    required bool isDeleted,
    required bool hasAttachments,
    required int size,
    required String downloadUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}

@freezed
class MessageFrom with _$MessageFrom {
  const factory MessageFrom({
    required String name,
    required String address,
  }) = _MessageFrom;

  factory MessageFrom.fromJson(Map<String, dynamic> json) =>
      _$MessageFromFromJson(json);
}

@freezed
class HydraSearch with _$HydraSearch {
  const factory HydraSearch({
    @JsonKey(name: "@type") String? type,
    @JsonKey(name: "hydra:template") String? hydraTemplate,
    @JsonKey(name: "hydra:variableRepresentation")
        String? hydraVariableRepresentation,
    List<HydraMapping>? hydraMapping,
  }) = _HydraSearch;

  factory HydraSearch.fromJson(Map<String, dynamic> json) =>
      _$HydraSearchFromJson(json);
}

@freezed
class HydraMapping with _$HydraMapping {
  const factory HydraMapping({
    @JsonKey(name: "@type") String? type,
    String? variable,
    String? property,
    bool? required,
  }) = _HydraMapping;

  factory HydraMapping.fromJson(Map<String, dynamic> json) =>
      _$HydraMappingFromJson(json);
}

@freezed
class HydraView with _$HydraView {
  const factory HydraView({
    @JsonKey(name: "@id") String? id,
    @JsonKey(name: "@type") String? type,
    @JsonKey(name: "hydra:first") required String hydraFirst,
    @JsonKey(name: "hydra:last") required String hydraLast,
    @JsonKey(name: "hydra:previous") required String hydraPrevious,
    @JsonKey(name: "hydra:next") required String hydraNext,
  }) = _HydraView;

  factory HydraView.fromJson(Map<String, dynamic> json) =>
      _$HydraViewFromJson(json);
}
