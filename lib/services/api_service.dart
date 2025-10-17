import 'dart:convert';

import '../models/account.dart';
import '../models/transaction.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8083/api';

  // Users
  static Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    }
    throw Exception('Failed to load users');
  }

  static Future<User> getUserByUsername(String username) async {
    final response =
    await http.get(Uri.parse('$baseUrl/users/username/$username'));
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    }
    throw Exception('User not found');
  }

  static Future<User> createUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userData),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    }
    throw Exception(response.body);
  }

  static Future<void> deleteUser(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$id'));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete user');
    }
  }

  // Accounts
  static Future<List<Account>> getAccounts() async {
    final response = await http.get(Uri.parse('$baseUrl/accounts'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Account.fromJson(json)).toList();
    }
    throw Exception('Failed to load accounts');
  }

  static Future<List<Account>> getAccountsByUserId(int userId) async {
    final response =
    await http.get(Uri.parse('$baseUrl/accounts/user/$userId'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Account.fromJson(json)).toList();
    }
    throw Exception('Accounts not found');
  }

  static Future<Account> getAccountByNumber(String accountNumber) async {
    final response =
    await http.get(Uri.parse('$baseUrl/accounts/number/$accountNumber'));
    if (response.statusCode == 200) {
      return Account.fromJson(json.decode(response.body));
    }
    throw Exception('Account not found');
  }

  static Future<Account> createAccount(Map<String, dynamic> accountData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/accounts'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(accountData),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Account.fromJson(json.decode(response.body));
    }
    throw Exception(response.body);
  }

  static Future<void> deleteAccount(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/accounts/$id'));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete account');
    }
  }

  // Transactions
  static Future<List<Transaction>> getTransactions() async {
    final response = await http.get(Uri.parse('$baseUrl/transactions'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Transaction.fromJson(json)).toList();
    }
    throw Exception('Failed to load transactions');
  }

  static Future<List<Transaction>> getTransactionsByAccountId(
      int accountId) async {
    final response =
    await http.get(Uri.parse('$baseUrl/transactions/account/$accountId'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Transaction.fromJson(json)).toList();
    }
    throw Exception('Transactions not found');
  }

  static Future<Transaction> getTransactionByReference(String reference) async {
    final response = await http
        .get(Uri.parse('$baseUrl/transactions/reference/$reference'));
    if (response.statusCode == 200) {
      return Transaction.fromJson(json.decode(response.body));
    }
    throw Exception('Transaction not found');
  }

  static Future<Transaction> createTransaction(
      Map<String, dynamic> transactionData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/transactions'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(transactionData),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Transaction.fromJson(json.decode(response.body));
    }
    throw Exception(response.body);
  }
}