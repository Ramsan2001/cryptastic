import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SellSiteFinisher extends StatefulWidget {
  final int index;

  SellSiteFinisher({Key? key, required this.index}) : super(key: key);

  @override
  _SellSiteFinisherState createState() => _SellSiteFinisherState();
}

class _SellSiteFinisherState extends State<SellSiteFinisher> {
  var box = Hive.box('testBox');

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sell " + "(1 " + box.keyAt(widget.index) + " = € " + box.getAt(widget.index)[1].toString() + ")"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Your amount: " + box.getAt(widget.index)[0].toString(),
            labelText: "How much " + box.keyAt(widget.index) + "'s do you want to sell?"
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          double currentCoinAmount = box.getAt(widget.index)[0];
          double inputCoinAmount = double.parse(myController.text);
          double newCoinAmount = currentCoinAmount - inputCoinAmount;
          double lastPrice = box.getAt(widget.index)[1];
          double getPrice = inputCoinAmount * lastPrice;
          double currentEur = box.get('EUR')[1];
          double newEur = currentEur + getPrice;

          if(inputCoinAmount > currentCoinAmount){
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text("You don't have enough coins: " + (currentCoinAmount.toString())),
                );
              },
            );
          }else{
            box.put('EUR', 0);
            box.put(box.keyAt(widget.index), 0);
            box.put('EUR', [0, newEur]);
            box.put(box.keyAt(widget.index), [newCoinAmount, lastPrice]);

            Navigator.pop(context);
            Navigator.pop(context);

            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text("Successfully sold " + inputCoinAmount.toString() + " coins. You received " + getPrice.toString()),
                );
              },
            );
          }
        },
        tooltip: 'Sell',
        child: Icon(Icons.attach_money_rounded),
      ),
    );
  }
}
