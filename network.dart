import 'package:http/http.dart' as http;
import 'dart:convert';

class Network{
  final String  url;
  Network(this.url);

  Future getdata() async{
    http.Response response= await http.get(Uri.parse(url));

    if (response.statusCode==200){
      String data = response.body;
      var decodeddata=  jsonDecode(data);
      var price= decodeddata["rate"].toInt();
      return price;
      
  }else{
    // ignore: avoid_print
    print(response.statusCode);
   }
   //return response;
}}