import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double)? onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueDoubleController = TextEditingController();

  _submitform() {
    final title = titleController.text;
    final value = double.tryParse(valueDoubleController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit!(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: valueDoubleController,
              onSubmitted: (_) => _submitform(),
              decoration: InputDecoration(labelText: 'Valor R\$'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // primary: Colors.blue,
                      primary: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      _submitform();
                    },
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
