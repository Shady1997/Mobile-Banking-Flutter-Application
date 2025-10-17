import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../services/api_service.dart';

class TransactionsTab extends StatefulWidget {
  final Function(String, bool) onMessage;

  const TransactionsTab({Key? key, required this.onMessage}) : super(key: key);

  @override
  State<TransactionsTab> createState() => _TransactionsTabState();
}

class _TransactionsTabState extends State<TransactionsTab> {
  List<Transaction> transactions = [];
  bool loading = false;

  final _referenceController = TextEditingController();
  final _fromAccountIdController = TextEditingController();
  final _toAccountIdController = TextEditingController();
  final _amountController = TextEditingController();
  final _feeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _searchReferenceController = TextEditingController();
  final _searchAccountIdController = TextEditingController();
  String _selectedTransactionType = 'DEPOSIT';

  Future<void> _createTransaction() async {
    setState(() => loading = true);
    try {
      final transaction = await ApiService.createTransaction({
        'transactionReference': _referenceController.text,
        'fromAccountId': int.parse(_fromAccountIdController.text),
        'toAccountId': _toAccountIdController.text.isNotEmpty
            ? int.parse(_toAccountIdController.text)
            : null,
        'transactionType': _selectedTransactionType,
        'amount': double.parse(_amountController.text),
        'description': _descriptionController.text,
        'fee': double.parse(_feeController.text),
      });
      setState(() => transactions.add(transaction));
      _clearForm();
      widget.onMessage('Transaction created successfully!', false);
    } catch (e) {
      widget.onMessage(e.toString(), true);
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> _getAllTransactions() async {
    setState(() => loading = true);
    try {
      final fetchedTransactions = await ApiService.getTransactions();
      setState(() => transactions = fetchedTransactions);
      widget.onMessage('Transactions loaded successfully!', false);
    } catch (e) {
      widget.onMessage(e.toString(), true);
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> _searchByReference() async {
    setState(() => loading = true);
    try {
      final transaction = await ApiService.getTransactionByReference(
          _searchReferenceController.text);
      setState(() => transactions = [transaction]);
      widget.onMessage('Transaction found!', false);
    } catch (e) {
      widget.onMessage(e.toString(), true);
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> _searchByAccountId() async {
    setState(() => loading = true);
    try {
      final fetchedTransactions = await ApiService.getTransactionsByAccountId(
          int.parse(_searchAccountIdController.text));
      setState(() => transactions = fetchedTransactions);
      widget.onMessage('Transactions found!', false);
    } catch (e) {
      widget.onMessage(e.toString(), true);
    } finally {
      setState(() => loading = false);
    }
  }

  void _clearForm() {
    _referenceController.clear();
    _fromAccountIdController.clear();
    _toAccountIdController.clear();
    _amountController.clear();
    _feeController.clear();
    _descriptionController.clear();
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
                child: _buildCreateTransactionForm(),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildSearchForm(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildTransactionsList(),
        ],
      ),
    );
  }

  Widget _buildCreateTransactionForm() {
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
                'Create Transaction',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _referenceController,
            decoration: const InputDecoration(
              hintText: 'Transaction Reference (unique)',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _fromAccountIdController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'From Account ID',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _toAccountIdController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'To Account ID (optional for DEPOSIT/WITHDRAWAL)',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedTransactionType,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
            items: ['DEPOSIT', 'WITHDRAWAL', 'TRANSFER', 'PAYMENT']
                .map((type) => DropdownMenuItem(
              value: type,
              child: Text(type),
            ))
                .toList(),
            onChanged: (value) {
              setState(() => _selectedTransactionType = value!);
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Amount',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _feeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Fee (optional)',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              hintText: 'Description',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: loading ? null : _createTransaction,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Create Transaction'),
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
                'Search Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchReferenceController,
                  decoration: const InputDecoration(
                    hintText: 'Reference Number',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: loading ? null : _searchByReference,
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
                  controller: _searchAccountIdController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Account ID',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: loading ? null : _searchByAccountId,
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
              onPressed: loading ? null : _getAllTransactions,
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Load All Transactions'),
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

  Widget _buildTransactionsList() {
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
            'Transactions List (${transactions.length})',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(Colors.indigo.shade100),
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Reference')),
                DataColumn(label: Text('Type')),
                DataColumn(label: Text('From Account')),
                DataColumn(label: Text('To Account')),
                DataColumn(label: Text('Amount')),
                DataColumn(label: Text('Fee')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Description')),
              ],
              rows: transactions
                  .map(
                    (transaction) => DataRow(
                  cells: [
                    DataCell(Text(transaction.id.toString())),
                    DataCell(Text(transaction.transactionReference)),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: transaction.transactionType == 'DEPOSIT'
                              ? Colors.green.shade200
                              : transaction.transactionType == 'WITHDRAWAL'
                              ? Colors.red.shade200
                              : transaction.transactionType == 'TRANSFER'
                              ? Colors.blue.shade200
                              : Colors.purple.shade200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          transaction.transactionType,
                          style: TextStyle(
                            fontSize: 12,
                            color: transaction.transactionType == 'DEPOSIT'
                                ? Colors.green.shade800
                                : transaction.transactionType == 'WITHDRAWAL'
                                ? Colors.red.shade800
                                : transaction.transactionType == 'TRANSFER'
                                ? Colors.blue.shade800
                                : Colors.purple.shade800,
                          ),
                        ),
                      ),
                    ),
                    DataCell(Text(
                        transaction.fromAccount?.accountNumber ?? 'N/A')),
                    DataCell(Text(
                        transaction.toAccount?.accountNumber ?? 'N/A')),
                    DataCell(Text('\${transaction.amount.toStringAsFixed(2)}')),
                    DataCell(Text('\${transaction.fee.toStringAsFixed(2)}')),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: transaction.status == 'COMPLETED'
                              ? Colors.green.shade200
                              : transaction.status == 'PENDING'
                              ? Colors.yellow.shade200
                              : transaction.status == 'FAILED'
                              ? Colors.red.shade200
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          transaction.status,
                          style: TextStyle(
                            fontSize: 12,
                            color: transaction.status == 'COMPLETED'
                                ? Colors.green.shade800
                                : transaction.status == 'PENDING'
                                ? Colors.yellow.shade800
                                : transaction.status == 'FAILED'
                                ? Colors.red.shade800
                                : Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ),
                    DataCell(Text(transaction.description)),
                  ],
                ),
              )
                  .toList(),
            ),
          ),
          if (transactions.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'No transactions found',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
        ],
      ),
    );
  }
}