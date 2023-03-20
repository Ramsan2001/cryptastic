import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyDashboardState();
  }
}

class _MyDashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('testBox');
    double currentEur = box.get('EUR')[1];

    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Card(
                child: ListTile(
                  title: Text("Your Fiat: "),
                  trailing: Text("€ " + currentEur.toString()),
                ),
              ),
            ],
          ),
        ));
  }
}
