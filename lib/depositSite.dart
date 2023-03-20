import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter/widgets.dart';

class DepositSite extends StatefulWidget {
  const DepositSite({Key? key}) : super(key: key);

  @override
  _DepositSiteState createState() => _DepositSiteState();
}

class _DepositSiteState extends State<DepositSite> {
  var box = Hive.box('testBox');
  final myController = TextEditingController();

  @override
  String inputText = "";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deposit"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
          // keyboardType: TextInputType.number,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Amount of euros you want to deposit'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          double currentEur = box.get('EUR')[1];
          double inputEur = double.parse(myController.text);
          double newEur = inputEur + currentEur;
          box.put('EUR', [0, newEur]);

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(" € " +
                    myController.text +
                    " successfully added to your wallet!"),
              );
            },
          );
        },
        tooltip: 'Submit',
        child: Icon(Icons.add),
      ),
    );
  }
}