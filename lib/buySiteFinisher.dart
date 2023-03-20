import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BuySiteFinisher extends StatefulWidget {
  final int index;

  BuySiteFinisher({Key? key, required this.index}) : super(key: key);

  @override
  _BuySiteFinisherState createState() => _BuySiteFinisherState();
}

class _BuySiteFinisherState extends State<BuySiteFinisher> {
  var box = Hive.box('testBox');

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buy " + "(1 " + box.keyAt(widget.index) + " = € " + box.getAt(widget.index)[1].toString() + ")"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: myController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Your credit: € " + box.get('EUR')[1].toString(),
          labelText: "How much " + box.keyAt(widget.index) + "'s do you want to buy?",
        ),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          double currentCoinAmount = box.getAt(widget.index)[0];
          double inputCoinAmount = double.parse(myController.text);
          double newCoinAmount = currentCoinAmount + inputCoinAmount;
          double lastPrice = box.getAt(widget.index)[1];
          double priceCost = inputCoinAmount * lastPrice;
          double currentEur = box.get('EUR')[1];
          double newEur = currentEur - priceCost;

          if(currentEur < priceCost){
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text("You don't have enough money. (€ " + currentEur.toString() + ")"),
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
                  content: Text("Successfully added " + inputCoinAmount.toString() + " " + box.keyAt(widget.index) + "s to your wallet."),
                );
              },
            );
          }
        },
        tooltip: 'Buy',
        child: Icon(Icons.add),
      ),
    );
  }
}
