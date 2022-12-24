import 'package:bitcointickerapp/network.dart';



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
  'PKR',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];
const apikey = 'YOUR API_KEY';

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getcoinrate(String currencyname ) async{
    Map<String, String> cryptoPrices = {};
     for (String crypto in cryptoList) {
    String link = "https://rest.coinapi.io/v1/exchangerate/$crypto/$currencyname?apikey=$apikey";
   Network networkhepler = Network(link);
   var coinrate = await networkhepler.getdata();
    cryptoPrices[crypto] = coinrate.toString();   
     }
     return cryptoPrices;
  }
}