abstract class StringFormatter {
  StringFormatter._();

  static String camelCaseToKebab(String baseName) {
    final beforeCapitalLetter = RegExp(r"(?=[A-Z])");
    final parts = baseName.split(beforeCapitalLetter);
    final newPath = parts.length == 1
        ? parts.first.toLowerCase()
        : parts.map((e) => e.toLowerCase()).join('-');
    return newPath;
  }
}
