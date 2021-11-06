import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function deleteTx; // a pointer to "_deleteTransaction" function

  TransactionList(this.transactions, this.deleteTx) {
    print('Constructor TransactionList StatelessWidget');
  }

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {

  @override
  void didUpdateWidget(covariant TransactionList oldWidget) {
    print('didUpdateWidget() TransactionList Widget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print('build() TransactionList StatelessWidget');
    return widget.transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.custom(
            childrenDelegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return TransactionItem(
                  transaction: widget.transactions[index],
                  key: ValueKey<Transaction>(widget.transactions[index]),
                  deleteTx: widget.deleteTx,
                );
              },
              childCount: widget.transactions.length,
              findChildIndexCallback: (Key key) {
                final ValueKey<Transaction> valueKey =
                    key as ValueKey<Transaction>;
                final Transaction data = valueKey.value;
                return widget.transactions.indexOf(data);
              },
            ),
          );
    // : ListView.builder(
    //     itemBuilder: (ctx, index) {
    //       return TransactionItem(
    //         key: ValueKey(transactions[index].id),
    //         transaction: transactions[index],
    //         deleteTx: deleteTx,
    //       );
    //     },
    //     itemCount: transactions
    //         .length, // if we have 2 transactions, we're gonna build 2 items
    // );
  }
}
