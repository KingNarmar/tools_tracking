String cleanInput(String input) {
  return input.trim().replaceAll(RegExp(r'\s+'), ' ').toLowerCase();
}
