import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'network.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var bitcoinData;
  void getBitcoinData() async {
    NetworkHelper netHelp = NetworkHelper();
    bitcoinData = await netHelp.getBitcoinData();
  }

  String selectedCurrency = 'USD';
  double bitcoinPrice = 0.0;

  void updateUi(var bitcoinData, String symbol) {
    setState(() {
      if (bitcoinData == null || symbol == '-') {
        bitcoinPrice = 0.0;
        selectedCurrency = 'Select a currency';
      } else {
        bitcoinPrice = bitcoinData[symbol]['last'];
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getBitcoinData();
    updateUi(bitcoinData, selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.blueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $bitcoinPrice $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 120.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.blueAccent,
            child: CupertinoPicker(
              itemExtent: 32.0,
              onSelectedItemChanged: (selectedIndex) {
                setState(() {
                  selectedCurrency = currenciesList[selectedIndex];
                  updateUi(bitcoinData, selectedCurrency);
                });
              },
              children: [for (var item in currenciesList) Text(item)],
            ),
          ),
        ],
      ),
    );
  }
}

// DropdownButton<String>(
// value: selectedCurrency,
// items: [
// for (var item in currenciesList)
// DropdownMenuItem(
// child: Text(item),
// value: item,
// ),
// ],
// onChanged: (value) {
// setState(() {
// selectedCurrency = value.toString();
// });
// },
// ),
