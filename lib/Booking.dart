class Booking {
  final String serviceTitle;
  final String providerName;
  final DateTime date;
  final double price;
  bool isRated;

  Booking({
    required this.serviceTitle,
    required this.providerName,
    required this.date,
    required this.price,
    this.isRated = false,
  });
}
