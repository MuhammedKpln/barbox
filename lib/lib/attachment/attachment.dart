import 'package:json_annotation/json_annotation.dart';

part 'attachment.g.dart';

@JsonSerializable()
class Attachment {
  String? id;
  String? filename;
  String? contentType;
  String? disposition;
  String? transferEncoding;
  bool? related;
  int? size;
  String? downloadUrl;

  Attachment({
    this.id,
    this.filename,
    this.contentType,
    this.disposition,
    this.transferEncoding,
    this.related,
    this.size,
    this.downloadUrl,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return _$AttachmentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}
