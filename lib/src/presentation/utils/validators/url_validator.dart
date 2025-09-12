class UrlValidator {
  static String? validateApiUrl(String value) {
    final trimmed = value.trim();

    if (trimmed.isEmpty) {
      return 'El campo API es obligatorio';
    }

    final urlPattern = RegExp(r'^(https?:\/\/)[\w.-]+(\.[\w.-]+)+.*$');
    if (!urlPattern.hasMatch(trimmed)) {
      return 'Debe tener un formato válido (ej: https://api.ejemplo.com)';
    }

    return null;
  }
}
