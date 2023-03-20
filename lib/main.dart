import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cryptastic_app/price_list.dart' as priceList;
import 'package:cryptastic_app/tradeBar.dart' as tradeBar;
import 'package:cryptastic_app/portfolio.dart' as portfolio;
import 'package:cryptastic_app/dashboard.dart' as dashboard;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

void main() async {
  Hive.initFlutter();

  var box = await Hive.openBox('testBox',
      compactionStrategy: (entries, deletedEntries) {
    return deletedEntries > 1;
  });
  // priceList.priceList();
  // box.clear();
  if(!box.containsKey('EUR'))
      box.put('EUR', [0, 0]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.euro_rounded), text: "Prices"),
                  Tab(icon: Icon(Icons.dashboard_rounded), text: "Dashboard"),
                  Tab(icon: Icon(Icons.cases), text: "Portfolio"),
                  Tab(icon: Icon(Icons.swap_vert_rounded), text: "Trade"),
                ],
              ),
              title: Text('Cryptastic'),
            ),
            body: TabBarView(
              children: [
                priceList.priceList(),
                dashboard.Dashboard(),
                portfolio.Portfolio(),
                tradeBar.tradeBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
