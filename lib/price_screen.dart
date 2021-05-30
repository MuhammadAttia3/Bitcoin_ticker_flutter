import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList.first;

  CupertinoPicker iOSPicker() {
    List<Text> pickerList = [];
    for (String currency in currenciesList) {
      pickerList.add(Text('$currency'));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 30.0,
      onSelectedItemChanged: (selectedIndex){
        print(selectedIndex);
      },
      children: pickerList,
    );
  }

  DropdownButton androidDropdown() {
    List<DropdownMenuItem<String>> menuItems = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem<String>(child: Text(currency), value: currency,);
      menuItems.add(item);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: menuItems,
      onChanged: ((value) {
        setState(() {
          selectedCurrency = value;
        });
      }),
    );
  }


  List<Text> getPickerItem() {
    List<Text> cupertinoStyleCurrenciesList = [];
    for (String currency in currenciesList) {
      cupertinoStyleCurrenciesList.add(Text('$currency'));
    }
    return cupertinoStyleCurrenciesList;
  }

  List<DropdownMenuItem<String>> createItem()  {
    List<DropdownMenuItem<String>> menuItems = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem<String>(child: Text(currency), value: currency,);
      menuItems.add(item);
    }
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
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
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:  Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}



// DropdownButton<String>(
// value: selectedCurrency,
// items: createItem(),
// onChanged: ((value) {
// setState(() {
// selectedCurrency = value;
// });
// }),
// )
//
//
// CupertinoPicker(
// backgroundColor: Colors.lightBlue,
// itemExtent: 30.0,
// onSelectedItemChanged: (selectedIndex){
// print(selectedIndex);
// },
// children: getPickerItem(),
// )