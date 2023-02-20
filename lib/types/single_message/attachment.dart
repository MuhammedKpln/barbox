import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'attachment.g.dart';

@Embedded(inheritance: false)
class Attachment extends Equatable {
  final String? id;
  final String? filename;
  final String? contentType;
  final String? disposition;
  final String? transferEncoding;
  final bool? related;
  final int? size;
  final String? downloadUrl;

  const Attachment({
    this.id,
    this.filename,
    this.contentType,
    this.disposition,
    this.transferEncoding,
    this.related,
    this.size,
    this.downloadUrl,
  });

  factory Attachment.fromMap(Map<String, dynamic> data) => Attachment(
        id: data['id'] as String?,
        filename: data['filename'] as String?,
        contentType: data['contentType'] as String?,
        disposition: data['disposition'] as String?,
        transferEncoding: data['transferEncoding'] as String?,
        related: data['related'] as bool?,
        size: data['size'] as int?,
        downloadUrl: data['downloadUrl'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'filename': filename,
        'contentType': contentType,
        'disposition': disposition,
        'transferEncoding': transferEncoding,
        'related': related,
        'size': size,
        'downloadUrl': downloadUrl,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Attachment].
  factory Attachment.fromJson(String data) {
    return Attachment.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Attachment] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  @ignore
  List<Object?> get props {
    return [
      id,
      filename,
      contentType,
      disposition,
      transferEncoding,
      related,
      size,
      downloadUrl,
    ];
  }
}
