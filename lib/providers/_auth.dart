import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../modals/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  //doubt

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {

    print('1111111111111111111111111111111111');


    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAkCjlEx_MOZexiDy-IKYLW7VNz6db1SDY';


    //try{
    final response = await http.post(Uri.parse(url),
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
    final responseData = json.decode(response.body);
    if (responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    }
  
  
    //}catch(error){
    //log('inside catch block');
    //log(error.toString());
    //rethrow;
    //}
    //print('22222222222222222222222222222222');
    //print(json.decode(response.body.toString()));
  }

  Future<void> signUp(String email, String password) async {
    await _authenticate(email, password, 'signUp');    
  }

  Future<void> signIn(String email, String password) async {
    await _authenticate(email, password, 'signInWithPassword');
  }
}
