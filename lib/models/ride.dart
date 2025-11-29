import 'models/location.dart';

enum RideStatus {
  requested,
  accepted,
  inProgress,
  completed,
  cancelled,
  emergency,
}

class Ride {
  final String id;
  final String studentId;
  final String? driverId;
  final Location pickupLocation;
  final Location dropoffLocation;
  final RideStatus status;
  final DateTime requestedAt;
  final DateTime? estimatedArrival;
  final bool isEmergency;

  Ride({
    required this.id,
    required this.studentId,
    this.driverId,
    required this.pickupLocation,
    required this.dropoffLocation,
    this.status = RideStatus.requested,
    DateTime? requestedAt,
    this.estimatedArrival,
    this.isEmergency = false,
  }) : requestedAt = requestedAt ?? DateTime.now();

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      driverId: json['driverId'] as String?,
      pickupLocation: Location.fromJson(json['pickupLocation'] as Map<String, dynamic>),
      dropoffLocation: Location.fromJson(json['dropoffLocation'] as Map<String, dynamic>),
      status: RideStatus.values.firstWhere(
        (e) => e.toString() == 'RideStatus.${json['status']}',
      ),
      requestedAt: DateTime.parse(json['requestedAt'] as String),
      estimatedArrival: json['estimatedArrival'] != null
          ? DateTime.parse(json['estimatedArrival'] as String)
          : null,
      isEmergency: json['isEmergency'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'driverId': driverId,
      'pickupLocation': pickupLocation.toJson(),
      'dropoffLocation': dropoffLocation.toJson(),
      'status': status.toString().split('.').last,
      'requestedAt': requestedAt.toIso8601String(),
      'estimatedArrival': estimatedArrival?.toIso8601String(),
      'isEmergency': isEmergency,
    };
  }
}

