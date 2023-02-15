class UpdateModel {
  UpdateModel({
    required this.version,
    required this.changelog,
    required this.downloadUrl,
  });

  String version;
  String changelog;
  String downloadUrl;

  factory UpdateModel.fromJson(Map<String, dynamic> json) => UpdateModel(
        version: json["version"],
        changelog: json["changelog"],
        downloadUrl: json["downloadUrl"],
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "changelog": changelog,
        "downloadUrl": downloadUrl,
      };
}
