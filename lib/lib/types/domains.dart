import 'package:freezed_annotation/freezed_annotation.dart';

part 'domains.freezed.dart';
part 'domains.g.dart';

@freezed
class DomainsModel with _$DomainsModel {
  factory DomainsModel({
    @JsonKey(name: "hydra:member") required List<HydraMember> hydraMember,
    @JsonKey(name: "hydra:totalItems") required int hydraTotalItems,
    @JsonKey(name: "hydra:view") HydraView? hydraView,
    @JsonKey(name: "hydra:search") HydraSearch? hydraSearch,
  }) = _DomainsModel;

  factory DomainsModel.fromJson(Map<String, dynamic> json) =>
      _$DomainsModelFromJson(json);
}

@freezed
class HydraMember with _$HydraMember {
  factory HydraMember({
    @JsonKey(name: "@id") String? id,
    @JsonKey(name: "@type") String? type,
    @JsonKey(name: "@context") String? context,
    @JsonKey(name: "id") required String hydraMemberId,
    required String domain,
    required bool isActive,
    required bool isPrivate,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _HydraMember;

  factory HydraMember.fromJson(Map<String, dynamic> json) =>
      _$HydraMemberFromJson(json);
}

@freezed
class HydraSearch with _$HydraSearch {
  factory HydraSearch({
    @JsonKey(name: "@type") String? type,
    @JsonKey(name: "hydra:template") required String hydraTemplate,
    @JsonKey(name: "hydra:variableRepresentation")
    required String hydraVariableRepresentation,
    @JsonKey(name: "hydra:mapping") required List<HydraMapping> hydraMapping,
  }) = _HydraSearch;

  factory HydraSearch.fromJson(Map<String, dynamic> json) =>
      _$HydraSearchFromJson(json);
}

@freezed
class HydraMapping with _$HydraMapping {
  factory HydraMapping({
    @JsonKey(name: "@type") String? type,
    required String variable,
    required String property,
    required bool required,
  }) = _HydraMapping;

  factory HydraMapping.fromJson(Map<String, dynamic> json) =>
      _$HydraMappingFromJson(json);
}

@freezed
class HydraView with _$HydraView {
  factory HydraView({
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
