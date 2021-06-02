import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;


const String coinApi = 'https://rest.coinapi.io/v1/exchangerate';
const String apiKey = 'F5825A27-FD95-4B49-A1CB-33415F08B55D';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  static String coin = 'BTC';
  var rate = '?';
  String selectedCurrency = currenciesList.elementAt(currenciesList.length -2);


  // IOS Picker
  CupertinoPicker iOSPicker() {
    List<Text> pickerList = [];
    for (String currency in currenciesList) {
      pickerList.add(Text('$currency'));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 30.0,
      onSelectedItemChanged: (selectedIndex){
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          updateRate();
        });
      },
      children: pickerList,
    );
  }

  // Android Dropdown menu
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
          updateRate();
        });
      }),
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateRate();
    // buildText();
  }

  // void updateUI (var exRate) {
  //   rate = exRate['rate'].toString();
  //   print(rate);
  // }

  Future<String> updateRate() async {
    CoinData coinData = CoinData(coin: coin, selectedCurrency: selectedCurrency);
    var rateData = await coinData.getExchangeRate();
    setState(() {
      rate = rateData;
    });
    return rate;
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text (
                      '1 $coin = $rate $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text (
                      '1 ETH = $rate $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text (
                      '1 LTC = $rate $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
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


// class NetworkHelper {
//   NetworkHelper({this.coin, this.currency});
//   String coin;
//   String currency ;
//   var exchangeUSDtoBTC;
//
//   Future<dynamic> getExchangeRate({String coin, String currency}) async {
//     var url = Uri.parse('$coinApi/$coin/$currency?apikey=$apiKey');
//     print(url);
//     var response = await http.get(url);
//     print('Response status: ${response.statusCode}');
//     if (response.statusCode == 200) {
//       exchangeUSDtoBTC = jsonDecode(response.body);
//       _PriceScreenState  priceScreen = _PriceScreenState();
//       priceScreen.updateUI(exchangeUSDtoBTC);
//     } else {
//       print('Request failed with status: ${response.statusCode}.');
//     }
//     return exchangeUSDtoBTC;
//   }
// }


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
