import 'package:flutter/cupertino.dart';
import 'package:cryptastic_app/buySiteFinisher.dart' as buySiteFinisher;
import 'package:flutter/material.dart';
import 'package:cryptastic_app/depositSite.dart' as depositSite;
import 'package:hive/hive.dart';

class BuySite extends StatefulWidget {
  const BuySite({Key? key}) : super(key: key);

  @override
  _BuySiteState createState() => _BuySiteState();
}

class _BuySiteState extends State<BuySite> {
  var box = Hive.box('testBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buy"),
      ),
      body: ListView.builder(
          itemCount: box.length,
          itemBuilder: (BuildContext context, int index) {
            if (box.keyAt(index) == 'EUR') {
              return ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => depositSite.DepositSite(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white70),
                ),
                child: ListTile(
                  title: Text(
                    box.keyAt(index),
                  ),
                ),
              );
            }
            return ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => buySiteFinisher.BuySiteFinisher(index: index,),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white70),
              ),
              child: ListTile(
                title: Text(
                  box.keyAt(index),
                ),
                subtitle: Text(
                  box
                      .get(
                        box.keyAt(index),
                      )[0]
                      .toString(),
                ),
                trailing: Text(
                  "€ " +
                      box
                          .get(
                            box.keyAt(index),
                          )[1]
                          .toString(),
                ),
              ),
            );
          }),
    );
  }
}
