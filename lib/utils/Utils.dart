class Utils {
  
  static List<String> extractUrl(String text) {
    RegExp regExp = new RegExp(
      r"(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-&?=%.]+",
      caseSensitive: false,
      multiLine: false,
    );
    return regExp.allMatches(text).toList().map((e) => e.group(0) ?? "").toList();
  }
}