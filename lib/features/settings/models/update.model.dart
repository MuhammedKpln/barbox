import 'package:freezed_annotation/freezed_annotation.dart';

part 'update.model.freezed.dart';
part 'update.model.g.dart';

@freezed
class Updates with _$Updates {
  factory Updates({
    required String version,
    required String changelog,
    required String downloadUrl,
  }) = _Updates;

  factory Updates.fromJson(Map<String, dynamic> json) =>
      _$UpdatesFromJson(json);
}
