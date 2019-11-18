import 'package:first_app/Models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



//dovrebbe essere un singleton in dart
class Connector{
  static var url = "http://192.168.1.31:5000/api";

  static Future<List<User>> listAllUsers() async {
    List<User> users;
    await http.get(url + "/user").then((response){
      Iterable list = json.decode(response.body)["data"];
      users = list.map((model) => User.fromJson(model)).toList();
    });
    return users;
  }

  //pass
  static Future<http.Response> signupUser(var user) async{
    http.Response response = await http.post(url + "/user",
      headers: {"content-type": "application/json"}, 
      body: json.encode(user));
    
    return response;
  }

  static Future<http.Response> getUserBy(String type, String userAttribute) async {
    var uri=url;
    if(type == "username")
      uri += "/user/username=" + userAttribute;
    else if(type == "email")
      uri+= "/user/email=" + userAttribute;
    
    http.Response response = await http.get(uri);
    return response;
  }

  static void login(){

  }
}