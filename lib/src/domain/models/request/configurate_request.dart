class ConfigurateRequest {
  final String name;
  final String apiName;
  final String logo;
  final bool needScan;
  final String? colorPrimary;
  final String? colorSecondary;

  ConfigurateRequest({
    required this.name,
    required this.apiName,
    required this.logo,
    required this.needScan,
    this.colorPrimary,
    this.colorSecondary,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "apiName": apiName,
      "logo": logo,
      "needScan": needScan,
      "colorPrimary": colorPrimary,
      "colorSecondary": colorSecondary,
    };
  }
}
