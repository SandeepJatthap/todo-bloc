class AppValidations {
  static String? validateTitle(String? value) {
    return value == null || value.length < 6 ? 'Enter a valid title' : null;
  }

  static String? validateContent(String? value) {
    return value == null || value.length < 6 ? 'Enter a valid content' : null;
  }
}
