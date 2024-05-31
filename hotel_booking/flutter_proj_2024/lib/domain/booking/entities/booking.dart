// booking.dart

import 'dart:convert';

class Booking {
  final String id;
  final String userId;
  final String roomId;
  final DateTime startDate;
  final DateTime endDate;

  Booking({
    required this.id,
    required this.userId,
    required this.roomId,
    required this.startDate,
    required this.endDate,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['_id'],
      userId: json['userId'],
      roomId: json['roomId'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'roomId': roomId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }
}
