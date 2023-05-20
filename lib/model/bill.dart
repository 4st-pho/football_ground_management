import 'package:cloud_firestore/cloud_firestore.dart';

class Bill {
  final String id;
  final String emailOrPhoneNumber;
  final DateTime startTimePlay;
  Bill({
    required this.id,
    required this.emailOrPhoneNumber,
    required this.startTimePlay,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'emailOrPhoneNumber': emailOrPhoneNumber,
      'startTimePlay': Timestamp.fromDate(startTimePlay),
    };
  }

  factory Bill.fromJson(Map<String, dynamic> json, String? id) {
    return Bill(
      id: id ?? '',
      emailOrPhoneNumber: json['emailOrPhoneNumber'] ?? '',
      startTimePlay: (json['startTimePlay'] as Timestamp).toDate(),
    );
  }
}
