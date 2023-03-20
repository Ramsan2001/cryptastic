import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';

class priceList extends StatefulWidget {
  @override
  _priceListState createState() => _priceListState();
}

class _priceListState extends State<priceList> {
  var box = Hive.box('testBox');

  final Uri apiUrl =
      Uri.parse('https://api.exchange.bitpanda.com/public/v1/market-ticker');

  Future<List<dynamic>?> fetchPrices() async {
    var result = await http.get(apiUrl);
    return jsonDecode(result.body);
  }

  Text _name(dynamic crypto) {
    if (crypto['instrument_code'].toString().contains('EUR') &&
        crypto['last_price'] != null) {
      if (!box.containsKey(crypto['instrument_code'].split('_')[0])) {
        // double amount = box.get(crypto['instrument_code'].toString().split('_')[0])[0];
        double lastPrice = double.parse(crypto['last_price']);
        box.put(crypto['instrument_code'].split('_')[0], [0, lastPrice]);
        // double value = amount * lastPrice;
        // box.put(crypto['instrument_code'].split('_')[0], [0, value]);
      }
    }
    return Text(crypto['instrument_code'].split('_')[0]);
  }

  Text _priceChangeNew(dynamic crypto) {
    if (crypto['price_change_percentage'].toString().contains('-'))
      return Text("24h: "+
        crypto['price_change_percentage'].toString() +
            '% (' +
            crypto['price_change'].toString() +
            '€)',
        style: TextStyle(color: Colors.red),
      );

    return Text("24h: "+
      crypto['price_change_percentage'].toString() +
          '% (' +
          crypto['price_change'].toString() +
          '€)',
      style: TextStyle(color: Colors.green),
    );
  }

  Text _lastPrice(Map<String, dynamic> crypto) {
    if (crypto['last_price'] != null) {
      var a = double.parse(crypto['last_price']);
      return Text('€ ' + a.toString());
    }

    return Text('null');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prices'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>?>(
          future: fetchPrices(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (!snapshot.data[index]['instrument_code']
                            .toString()
                            .contains('EUR') ||
                        snapshot.data[index]['last_price'] == null)
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              title:
                                  Text(snapshot.data[index]['instrument_code']),
                              subtitle: Text('Currency not available'),
                            ),
                          ],
                        ),
                      );
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            title: _name(snapshot.data[index])!,
                            subtitle: _priceChangeNew(snapshot.data[index]),
                            trailing: _lastPrice(snapshot.data[index]),
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
