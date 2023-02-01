import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.model.freezed.dart';
part 'message.model.g.dart';

@freezed
class Messages with _$Messages {
  const factory Messages({
    List<Message>? hydraMember,
    int? hydraTotalItems,
    HydraView? hydraView,
    HydraSearch? hydraSearch,
  }) = _Messages;

  factory Messages.fromJson(Map<String, dynamic> json) =>
      _$MessagesFromJson(json);
}

@freezed
class Message with _$Message {
  const factory Message({
    String? id,
    String? type,
    String? context,
    String? hydraMemberId,
    String? accountId,
    String? msgid,
    MessageFrom? from,
    List<MessageFrom>? to,
    String? subject,
    String? intro,
    bool? seen,
    bool? isDeleted,
    bool? hasAttachments,
    int? size,
    String? downloadUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}

@freezed
class MessageFrom with _$MessageFrom {
  const factory MessageFrom({
    String? name,
    String? address,
  }) = _MessageFrom;

  factory MessageFrom.fromJson(Map<String, dynamic> json) =>
      _$MessageFromFromJson(json);
}

@freezed
class HydraSearch with _$HydraSearch {
  const factory HydraSearch({
    String? type,
    String? hydraTemplate,
    String? hydraVariableRepresentation,
    List<HydraMapping>? hydraMapping,
  }) = _HydraSearch;

  factory HydraSearch.fromJson(Map<String, dynamic> json) =>
      _$HydraSearchFromJson(json);
}

@freezed
class HydraMapping with _$HydraMapping {
  const factory HydraMapping({
    String? type,
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
    String? id,
    String? type,
    String? hydraFirst,
    String? hydraLast,
    String? hydraPrevious,
    String? hydraNext,
  }) = _HydraView;

  factory HydraView.fromJson(Map<String, dynamic> json) =>
      _$HydraViewFromJson(json);
}
