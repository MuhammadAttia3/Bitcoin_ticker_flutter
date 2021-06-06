import 'package:http/http.dart' as http;
import 'dart:convert';


const String coinApi = 'https://rest.coinapi.io/v1/exchangerate';
const String apiKey = 'F5825A27-FD95-4B49-A1CB-33415F08B55D';
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

Map<String, String> cryptoListRate = {
  'BTC': '',
  'ETH': '',
  'LTC': '',
};

class CoinData {

  CoinData({this.coin, this.selectedCurrency});
  String coin;
  String selectedCurrency;
  String rate;

  Future<String> getExchangeRate() async {
    var url = Uri.parse('$coinApi/$coin/$selectedCurrency?apikey=$apiKey');
    print(url);
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      var exchangeRate = jsonDecode(response.body);
      double rateRaw = await exchangeRate['rate'];
      rate = rateRaw.toInt().toString();
      print(rate);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return rate;
  }
}
