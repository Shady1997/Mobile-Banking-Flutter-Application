import 'account.dart';

class Transaction {
  final int id;
  final String transactionReference;
  final String transactionType;
  final double amount;
  final double fee;
  final String status;
  final String description;
  final Account? fromAccount;
  final Account? toAccount;

  Transaction({
    required this.id,
    required this.transactionReference,
    required this.transactionType,
    required this.amount,
    required this.fee,
    required this.status,
    required this.description,
    this.fromAccount,
    this.toAccount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      transactionReference: json['transactionReference'],
      transactionType: json['transactionType'],
      amount: json['amount']?.toDouble() ?? 0.0,
      fee: json['fee']?.toDouble() ?? 0.0,
      status: json['status'] ?? 'PENDING',
      description: json['description'] ?? '',
      fromAccount: json['fromAccount'] != null
          ? Account.fromJson(json['fromAccount'])
          : null,
      toAccount: json['toAccount'] != null
          ? Account.fromJson(json['toAccount'])
          : null,
    );
  }
}