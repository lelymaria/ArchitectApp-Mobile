class Validations {
  static String emptyValidation(String value) {
    if (value.isEmpty || value == null) {
      return "Tidak boleh kosong";
    }
    return null;
  }
}