import 'package:freezed_annotation/freezed_annotation.dart';

part 'single_message.model.freezed.dart';
part 'single_message.model.g.dart';

@freezed
class SingleMessage with _$SingleMessage {
  const factory SingleMessage({
    @JsonKey(name: "@id") String? id,
    @JsonKey(name: "@type") String? type,
    @JsonKey(name: "@context") String? context,
    @JsonKey(name: "id") required String singleMessageId,
    required String accountId,
    required String msgid,
    required From from,
    required List<From> to,
    required List<String> cc,
    required List<String> bcc,
    required String subject,
    required bool seen,
    required bool flagged,
    required bool isDeleted,
    required List<String> verifications,
    required bool retention,
    required DateTime retentionDate,
    required String text,
    required List<String> html,
    required bool hasAttachments,
    required List<Attachment> attachments,
    required int size,
    required String downloadUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SingleMessage;

  factory SingleMessage.fromJson(Map<String, dynamic> json) =>
      _$SingleMessageFromJson(json);
}

@freezed
class Attachment with _$Attachment {
  const factory Attachment({
    required String id,
    required String filename,
    required String contentType,
    required String disposition,
    required String transferEncoding,
    required bool related,
    required int size,
    required String downloadUrl,
  }) = _Attachment;

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);
}

@freezed
class From with _$From {
  const factory From({
    required String name,
    required String address,
  }) = _From;

  factory From.fromJson(Map<String, dynamic> json) => _$FromFromJson(json);
}
