import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'sellSiteFinisher.dart' as sellSiteFinisher;
import 'package:cryptastic_app/depositSite.dart' as depositSite;
import 'package:hive/hive.dart';

class SellSite extends StatefulWidget {
  const SellSite({Key? key}) : super(key: key);

  @override
  _SellSiteState createState() => _SellSiteState();
}

class _SellSiteState extends State<SellSite> {
  var box = Hive.box('testBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sell"),
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
                    builder: (context) => sellSiteFinisher.SellSiteFinisher(
                      index: index,
                    ),
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
