import 'package:mobile_banking_flutter/models/user.dart';

class Account {
  final int id;
  final String accountNumber;
  final String accountType;
  final double balance;
  final double creditLimit;
  final String status;
  final User? user;

  Account({
    required this.id,
    required this.accountNumber,
    required this.accountType,
    required this.balance,
    required this.creditLimit,
    required this.status,
    this.user,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      accountNumber: json['accountNumber'],
      accountType: json['accountType'],
      balance: json['balance']?.toDouble() ?? 0.0,
      creditLimit: json['creditLimit']?.toDouble() ?? 0.0,
      status: json['status'] ?? 'ACTIVE',
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}