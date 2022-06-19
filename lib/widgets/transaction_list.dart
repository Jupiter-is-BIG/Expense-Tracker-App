import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 589,
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover),
                    height: 200,
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                      child: ListTile(
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () => deleteTx(transactions[index].id),
                        ),
                        subtitle: Text(DateFormat.yMMMd()
                            .format(transactions[index].date as DateTime)),
                        title: Text(transactions[index].title as String,
                            style: Theme.of(context).textTheme.headline6),
                        leading: CircleAvatar(
                            radius: 30,
                            child: Padding(
                                padding: EdgeInsets.all(6),
                                child: FittedBox(
                                    child: Text(
                                  '\$${transactions[index].amount}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )))),
                      ));
                  // return Card(
                  //   child: Row(
                  //     children: <Widget>[
                  //       Container(
                  //         padding: EdgeInsets.all(10),
                  //         margin: EdgeInsets.symmetric(
                  //             vertical: 10, horizontal: 15),
                  //         decoration: BoxDecoration(
                  //             border: Border.all(
                  //                 color: Theme.of(context).primaryColor,
                  //                 width: 2)),
                  //         child: Text(
                  //           '\$${(transactions[index].amount)!.toStringAsFixed(2)}',
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 20,
                  //               color: Theme.of(context).primaryColor),
                  //         ),
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: <Widget>[
                  //           Text(
                  //             transactions[index].title as String,
                  //             // style: TextStyle(
                  //             //     fontWeight: FontWeight.bold, fontSize: 18),
                  //             style: Theme.of(context).textTheme.headline6,
                  //           ),
                  //           Text(
                  //             DateFormat.yMMMMd()
                  //                 .format(transactions[index].date as DateTime),
                  //             style: TextStyle(
                  //               color: Colors.grey,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // );
                },
                itemCount: transactions.length,
              ));
  }
}
