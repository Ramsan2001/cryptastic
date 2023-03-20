import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

class Portfolio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyPortfolioState();
  }
}

class _MyPortfolioState extends State<Portfolio> {
  final Uri apiUrl =
      Uri.parse('https://api.exchange.bitpanda.com/public/v1/market-ticker');

  Future<List<dynamic>?> fetchPrices() async {
    var result = await http.get(apiUrl);
    return jsonDecode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('testBox');

    return Scaffold(
        appBar: AppBar(
          title: Text('Portfolio'),
        ),
        body: Container(
          child: FutureBuilder(
            future: fetchPrices(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.data[index]['instrument_code']
                              .toString()
                              .contains('EUR') &&
                          snapshot.data[index]['last_price'] != null &&
                          box.containsKey(snapshot.data[index]
                                  ['instrument_code']
                              .toString()
                              .split('_')[0])) {
                        double amount = box.get(snapshot.data[index]['instrument_code'].toString().split('_')[0])[0];
                        double lastPrice = double.parse(snapshot.data[index]['last_price']);
                        double value = amount * lastPrice;
                        if(value == null)
                          value = 0;
                        
                        return Card(
                          child: ListTile(
                            title: Text(snapshot.data[index]['instrument_code']
                                .toString()
                                .split('_')[0]),
                            subtitle: Text(box
                                .get(snapshot.data[index]['instrument_code']
                                    .toString()
                                    .split('_')[0])[0]
                                .toString()),
                            trailing: Text("€ " + value.toString()),
                          ),
                        );
                      }
                      return Card(
                        child: ListTile(
                          title: Text(snapshot.data[index]['instrument_code']),
                          subtitle: Text('Currency not available'),
                        ),
                      );
                    });
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
          ),
        )

        // ListView.builder(
        //     itemCount: box.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       if (box.keyAt(index) == 'EUR') {
        //         return Card(
        //           child: ListTile(
        //             title: Text(
        //               box.keyAt(index),
        //             ),
        //             trailing:
        //                 Text("€ " + box.get(box.keyAt(index))[1].toString()),
        //           ),
        //         );
        //       }
        //       return Card(
        //         child: ListTile(
        //           title: Text(
        //             box.keyAt(index),
        //           ),
        //           subtitle: Text(
        //             box
        //                 .get(
        //                   box.keyAt(index),
        //                 )[0]
        //                 .toString(),
        //           ),
        //           trailing: Text(
        //             "€ " +
        //                 box
        //                     .get(
        //                       box.keyAt(index),
        //                     )[1]
        //                     .toString(),
        //           ),
        //         ),
        //       );
        //     }),

        );
  }
}
