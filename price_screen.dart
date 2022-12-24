import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  late String selectedcurrency = 'USD';
  late String crypto = 'BTC';
  CoinData coinrates= CoinData();
  String? rate;

   // ** FOR ANDROID DROPDOWNBUTTON **
   DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
       
        value: currency,
        child: Text(currency,textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                        )),
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
       style: const TextStyle(
                  color: Color.fromARGB(255, 242, 255, 64),
                         ),
                         dropdownColor: Colors.yellow,
                        underline: Container(
                          height: 3,
                        color: Colors.black,
                         ),
                         icon: const Icon(
                           Icons.arrow_drop_down,
                           color: Colors.black,
                        ),
      value: selectedcurrency,
      
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          updateui(crypto,selectedcurrency);
          selectedcurrency = value.toString(); 
        });
      },
    );
  }
  
  // ** FOR IOS CUPERTINOPICKER **
    CupertinoPicker getIOSPicker() {
    // loop to get menu items
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency,textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                        )));
    }
    return CupertinoPicker(
      backgroundColor: Colors.yellow,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedcurrency = currenciesList[selectedIndex];
          updateui(crypto, selectedcurrency);
        });
      },
      children: pickerItems,
    );
  }
 
   @override
  void initState() {
    super.initState();
   
    updateui(crypto, selectedcurrency);
  }
   
  Map<String, String> coinValues = {};
   
  void updateui(String crypto,String selectedcurrency) async {
    var coinupdatedata =await coinrates.getcoinrate(selectedcurrency); 
    setState(() {
      coinValues = coinupdatedata;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    //makecard();
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Feild(crypto: 'BTC',rate: coinValues['BTC'], selectedcurrency: selectedcurrency),
          Feild(crypto: 'ETH',rate: coinValues['ETH'], selectedcurrency: selectedcurrency),
          Feild(crypto: 'LTC',rate: coinValues['LTC'], selectedcurrency: selectedcurrency),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: const Color.fromARGB(255, 242, 255, 64),
            //==== ** FOR IOS WE USE CUPERTINOPICKER **====
            
            //child: getIOSPicker(),
            child: Platform.isIOS ? getIOSPicker() : androidDropdown(),
           
          ),
        ],
      ),
    );
  }
}

class Feild extends StatelessWidget {
  const Feild({
    Key? key,
    required this.crypto,
    required this.rate,
    required this.selectedcurrency,
  }) : super(key: key);

  final String crypto;
  final String? rate;
  final String selectedcurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: const Color.fromARGB(255, 242, 255, 64),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = $rate $selectedcurrency',
            textAlign: TextAlign.center,
            style:const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
