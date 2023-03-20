import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cryptastic_app/depositSite.dart';
import 'package:cryptastic_app/buySite.dart';
import 'package:cryptastic_app/sellSite.dart';

class tradeBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Trade'),
        ),
        body: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuySite()),
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white70),
              ),
              child: ListTile(
                leading: Icon(Icons.add_rounded),
                title: Text('Buy'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SellSite()),
                );
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white70)),
              child: ListTile(
                leading: Icon(Icons.attach_money_rounded),
                title: Text('Sell'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DepositSite()),
                );
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white70)),
              child: ListTile(
                leading: Icon(Icons.account_balance_outlined),
                title: Text('Deposit'),
              ),
            ),
          ],
        ));
  }
}
