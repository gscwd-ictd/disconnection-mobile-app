String textLengthChecker(String text, int length) {
  var res = "";
  if (text.length > length) {
    res = text.substring(0, length - 1) + "...";
    return res;
  } else {
    return text;
  }
}
