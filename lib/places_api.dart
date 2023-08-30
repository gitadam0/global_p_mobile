/*
import 'package:http/http.dart' as http;
import 'dart:convert';
class Locationservice{
  final String key="AIzaSyAW7Uirfq-BEAI-RwG0phNquiBfOhzP9EM";

  Future <String>getPlaceId(String input) async {
      final String url="https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input &inputtype=textquery &key=$key";

      var response = await http.get(Uri.parse(url));

      var json=jsonDecode(response.body);

      var placeid=json['candidates'][0]['place_id'] as String;

      print(input);
      print(placeid);
      return placeid;
      
  }

}*/
