extension StringExtension on String {
  DateTime toDateTime() {
    return DateTime.parse(this);
  }
}
