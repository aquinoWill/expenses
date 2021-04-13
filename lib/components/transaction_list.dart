import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../modules/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionsList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return (Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.05),
                Container(
                  height: constraints.maxHeight * 0.3,
                  child: Text(
                    'Nenhuma Transação cadastrada!',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                Container(
                  height: constraints.maxHeight *
                      0.6, // constrainsts tem acesso as dimenssões que do local que o component será exibido
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ));
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final trans = transactions[index];

              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(child: Text('R\$${trans.value}')))),
                  title: Text(
                    trans.title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(DateFormat('d MMM y').format(trans.date)),
                  trailing: MediaQuery.of(context).size.width > 480
                    ? FlatButton.icon(
                        onPressed: () => onRemove(trans.id),
                        icon: Icon(Icons.delete),
                        label: Text('Excluir'),
                        textColor: Theme.of(context).errorColor,
                      )
                    : IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => onRemove(trans.id),
                      ),
                ),
              );
            },
          );
  }
}
