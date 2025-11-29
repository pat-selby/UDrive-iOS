class Vehicle {
  final String id;
  final String make;
  final String model;
  final int year;
  final String color;
  final String licensePlate;
  final int capacity;
  final String? vehicleImageUrl;

  Vehicle({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.licensePlate,
    required this.capacity,
    this.vehicleImageUrl,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] as String,
      make: json['make'] as String,
      model: json['model'] as String,
      year: json['year'] as int,
      color: json['color'] as String,
      licensePlate: json['licensePlate'] as String,
      capacity: json['capacity'] as int,
      vehicleImageUrl: json['vehicleImageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'make': make,
      'model': model,
      'year': year,
      'color': color,
      'licensePlate': licensePlate,
      'capacity': capacity,
      'vehicleImageUrl': vehicleImageUrl,
    };
  }
}

