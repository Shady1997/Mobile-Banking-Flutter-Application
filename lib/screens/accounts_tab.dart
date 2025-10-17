import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/account.dart';
import '../services/api_service.dart';

class AccountsTab extends StatefulWidget {
  final Function(String, bool) onMessage;

  const AccountsTab({Key? key, required this.onMessage}) : super(key: key);

  @override
  State<AccountsTab> createState() => _AccountsTabState();
}

class _AccountsTabState extends State<AccountsTab> {
  List<Account> accounts = [];
  bool loading = false;

  final _accountNumberController = TextEditingController();
  final _balanceController = TextEditingController();
  final _creditLimitController = TextEditingController();
  final _userIdController = TextEditingController();
  final _searchAccountNumberController = TextEditingController();
  final _searchUserIdController = TextEditingController();
  String _selectedAccountType = 'SAVINGS';

  Future<void> _createAccount() async {
    setState(() => loading = true);
    try {
      final account = await ApiService.createAccount({
        'accountNumber': _accountNumberController.text,
        'accountType': _selectedAccountType,
        'balance': double.parse(_balanceController.text),
        'userId': int.parse(_userIdController.text),
        'creditLimit': double.parse(_creditLimitController.text),
      });
      setState(() => accounts.add(account));
      _clearForm();
      widget.onMessage('Account created successfully!', false);
    } catch (e) {
      widget.onMessage(e.toString(), true);
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> _getAllAccounts() async {
    setState(() => loading = true);
    try {
      final fetchedAccounts = await ApiService.getAccounts();
      setState(() => accounts = fetchedAccounts);
      widget.onMessage('Accounts loaded successfully!', false);
    } catch (e) {
      widget.onMessage(e.toString(), true);
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> _searchByAccountNumber() async {
    setState(() => loading = true);
    try {
      final account = await ApiService.getAccountByNumber(
          _searchAccountNumberController.text);
      setState(() => accounts = [account]);
      widget.onMessage('Account found!', false);
    } catch (e) {
      widget.onMessage(e.toString(), true);
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> _searchByUserId() async {
    setState(() => loading = true);
    try {
      final fetchedAccounts = await ApiService.getAccountsByUserId(
          int.parse(_searchUserIdController.text));
      setState(() => accounts = fetchedAccounts);
      widget.onMessage('Accounts found!', false);
    } catch (e) {
      widget.onMessage(e.toString(), true);
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> _deleteAccount(int id) async {
    setState(() => loading = true);
    try {
      await ApiService.deleteAccount(id);
      setState(() => accounts.removeWhere((a) => a.id == id));
      widget.onMessage('Account deleted successfully!', false);
    } catch (e) {
      widget.onMessage(e.toString(), true);
    } finally {
      setState(() => loading = false);
    }
  }

  void _clearForm() {
    _accountNumberController.clear();
    _balanceController.clear();
    _creditLimitController.clear();
    _userIdController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildCreateAccountForm(),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildSearchForm(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildAccountsList(),
        ],
      ),
    );
  }

  Widget _buildCreateAccountForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.add_circle, size: 20),
              SizedBox(width: 8),
              Text(
                'Create Account',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _accountNumberController,
            decoration: const InputDecoration(
              hintText: 'Account Number',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedAccountType,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
            items: ['SAVINGS', 'CHECKING', 'CREDIT']
                .map((type) => DropdownMenuItem(
              value: type,
              child: Text(type),
            ))
                .toList(),
            onChanged: (value) {
              setState(() => _selectedAccountType = value!);
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _balanceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Initial Balance',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _creditLimitController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Credit Limit (optional)',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _userIdController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'User ID',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: loading ? null : _createAccount,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Create Account'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.search, size: 20),
              SizedBox(width: 8),
              Text(
                'Search Accounts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchAccountNumberController,
                  decoration: const InputDecoration(
                    hintText: 'Account Number',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: loading ? null : _searchByAccountNumber,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(12),
                ),
                child: const Text('Search'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchUserIdController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'User ID',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: loading ? null : _searchByUserId,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(12),
                ),
                child: const Text('Search'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: loading ? null : _getAllAccounts,
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Load All Accounts'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountsList() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Accounts List (${accounts.length})',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(Colors.indigo.shade100),
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Account Number')),
                DataColumn(label: Text('Type')),
                DataColumn(label: Text('Balance')),
                DataColumn(label: Text('Credit Limit')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('User')),
                DataColumn(label: Text('Actions')),
              ],
              rows: accounts
                  .map(
                    (account) => DataRow(
                  cells: [
                    DataCell(Text(account.id.toString())),
                    DataCell(Text(account.accountNumber)),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          account.accountType,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ),
                    ),
                    DataCell(Text('\${account.balance.toStringAsFixed(2)}')),
                    DataCell(Text('\${account.creditLimit.toStringAsFixed(2)}')),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: account.status == 'ACTIVE'
                              ? Colors.green.shade200
                              : account.status == 'FROZEN'
                              ? Colors.yellow.shade200
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          account.status,
                          style: TextStyle(
                            fontSize: 12,
                            color: account.status == 'ACTIVE'
                                ? Colors.green.shade800
                                : account.status == 'FROZEN'
                                ? Colors.yellow.shade800
                                : Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ),
                    DataCell(Text(account.user?.username ?? 'N/A')),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteAccount(account.id),
                      ),
                    ),
                  ],
                ),
              )
                  .toList(),
            ),
          ),
          if (accounts.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'No accounts found',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
        ],
      ),
    );
  }
}