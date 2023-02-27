import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
class AccountModel with _$AccountModel {
  const factory AccountModel({
    @JsonKey(name: "@context") required String context,
    @JsonKey(name: "@id") required String id,
    @JsonKey(name: "@type") required String type,
    @JsonKey(name: "id") required String accountModelId,
    required String address,
    required int quota,
    required int used,
    required bool isDisabled,
    required bool isDeleted,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
}
