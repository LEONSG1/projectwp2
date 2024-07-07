class Flight {
  final String airline;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final double price;
  final int passengerCount; // Ubah nama variabel untuk lebih representatif

  Flight({
    required this.airline,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    required this.passengerCount,
  });

  // Buat method copyWith untuk mengembalikan instance baru dengan perubahan yang diinginkan
  Flight copyWith({
    String? airline,
    DateTime? departureTime,
    DateTime? arrivalTime,
    double? price,
    int? passengerCount,
  }) {
    return Flight(
      airline: airline ?? this.airline,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      price: price ?? this.price,
      passengerCount: passengerCount ?? this.passengerCount,
    );
  }
}
