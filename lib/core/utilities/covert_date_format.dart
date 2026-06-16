String convertToRepoKey(DateTime date) {
  final String year = date.year.toString();

  final String month = date.month.toString().padLeft(2, '0');

  return "$year-$month";
}
