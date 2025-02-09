import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'loan_backend.dart';

class LoanScreen extends StatefulWidget {
  const LoanScreen({super.key});

  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Loan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Loan Amount'),
            ),
            ElevatedButton(
              onPressed: _requestLoan,
              child: const Text('Submit Request'),
            ),
            const SizedBox(height: 20),
            const Text('Loan History'),
            // Expanded(
            //   child: StreamBuilder(
            //     stream: context.read<LoanService>().getLoanHistory(),
            //     builder: (context, snapshot) {
            //       // Build loan history list
            //       if (snapshot.hasError) {
            //         return Center(child: Text('Error: ${snapshot.error}'));
            //       }

            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const Center(child: CircularProgressIndicator());
            //       }

            //       final loans = snapshot.data!.docs;

            //       if (loans.isEmpty) {
            //         return const Center(child: Text('No loan history found'));
            //       }

            //       return ListView.builder(
            //         itemCount: loans.length,
            //         itemBuilder: (context, index) {
            //           final loan = loans[index].data() as Map<String, dynamic>;
            //           return ListTile(
            //             title: Text('\$${loan['amount']}'),
            //             subtitle: Text('Status: ${loan['status']}'),
            //             trailing: Text(
            //               _formatDate(loan['createdAt']),
            //               style: const TextStyle(color: Colors.grey),
            //             ),
            //           );
            //         },
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> _requestLoan() async {
    try {
      final amount = double.parse(_amountController.text);
      await context.read<LoanBackend>().requestLoan(amount);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Loan requested successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}
