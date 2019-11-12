import 'package:first_app/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignupPage extends StatefulWidget{
  final String title;
  SignupPage({Key key, this.title}) : super(key: key);
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage>{
  
  final _formKey = GlobalKey<FormState>();
  final double _margin = 30;
  bool _pressed = true;
  User user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _createForm()
      ),
    );
  }
  
  void _setPwd(){
    setState(() {   
      _pressed = !_pressed;
    });
  }

  Widget _createForm(){
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget> [ 
            //this is a cacata
            Center(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Image.asset('lib/Resources/Img/flutter-logo.png', width: 100, height: 100,) 
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: _margin, left: _margin),
              child: TextFormField(
                validator: (value) {
                  if(value.isEmpty){
                    return "Please enter Firstname!";
                  }
                  return null;
                },
                onSaved: (value) => user.firstname = value,
                decoration: InputDecoration(
                  labelText: 'Firstname',
                  prefixIcon: Icon(Icons. account_circle),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: _margin, left: _margin, top: _margin),
              child: TextFormField(
                validator: (value) {
                  if(value.isEmpty){
                    return "Please enter Lastname!";
                  }
                  return null;
                },
                onSaved: (value) => user.lastname = value,
                decoration: InputDecoration(
                  labelText: 'Lastname',
                  prefixIcon: Icon(Icons. account_circle),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: _margin, left: _margin, top: _margin),
              child: TextFormField(
                validator: (value) {
                  if(value.isEmpty){
                    return "Please enter Email!";
                  }
                  return null;
                },
                onSaved: (value) => user.email = value,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.mail),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: _margin, left: _margin, top: _margin),
              child: TextFormField(
                validator: (value) {
                  if(value.isEmpty){
                    return "Please enter Username!";
                  }
                  return null;
                },
                onSaved: (value) => user.username = value,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons. account_circle),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: _margin, left: _margin, top: _margin),
              child: TextFormField(
                validator: (value) {
                  if(value.isEmpty) return "Please enter Password!";
                  if(value.length < 8) return "Password at least 8 character";
                  return null;
                },
                onSaved: (value) => user.password=value,
                obscureText: _pressed,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: _pressed ? Icon(Icons.visibility_off): Icon(Icons.visibility),
                    onPressed:_setPwd,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                )
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(left: _margin, right: _margin, top: _margin),
                child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)
                  ),
                  onPressed: () {
                    if(_formKey.currentState.validate()){
                      _formKey.currentState.save();
                    }
                    //post to login
                    //print(_username + ":" + _password);
                    Navigator.pushNamed(context, "/");
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 2/3,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20)
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10),
                    child: Text("Do you have already an account?"),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, top: 10),
                  child: InkWell(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.blue, 
                      ),
                    ),
                    onTap: () => Navigator.pushNamed(context, "/login"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      
    );
  }
}