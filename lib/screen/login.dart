import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginreg/screen/home.dart';
import 'package:loginreg/screen/sign.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN "),
        backgroundColor: Colors.blue,
      ),
      body: LoginBody(),
    );
  }

  Widget LoginBody() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              NameInput(),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 16,
              ),
              PasswordInput(),
              SizedBox(
                height: 16,
              ),
              SigninButton(),
              SizedBox(
                height: 16,
              ),
              SubmitButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget NameInput() {
    return TextFormField(
      focusNode: _usernameFocusNode,
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Username",
        hintText: "e.g Morgan",
        labelStyle: TextStyle(
          color: Colors.blue, // <-- Change this
          fontSize: 18,
          fontWeight: FontWeight.w300,
          fontFamily: 'ZillaSlab',
        ),
      ),
      textInputAction: TextInputAction.next,
      validator: (name) {
        if (name != "admin" || name.isEmpty)
          return 'Invalid Username !';
        else
          return null;
      },
    );
  }

  Widget PasswordInput() {
    return TextFormField(
      focusNode: _passwordFocusNode,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        suffixIcon: Icon(Icons.lock),
        labelStyle: TextStyle(
          color: Colors.blue, // <-- Change this
          fontSize: 18,
          fontWeight: FontWeight.w300,
          fontFamily: 'ZillaSlab',
        ),
      ),
      textInputAction: TextInputAction.done,
      validator: (password) {
        if (password != "admin@123" || password.isEmpty)
          return 'Invalid Password !';
        else
          return null;
      },
    );
  }

  RaisedButton SigninButton() {
    return RaisedButton(
      color: Colors.blue,
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Sign()));
      },
      child: Text(
        "SignIn",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  RaisedButton SubmitButton() {
    return RaisedButton(
      color: Colors.blue,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          toastMessage("Login Successfull");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      },
      child: Text(
        "LOGIN",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

void toastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      fontSize: 16.0);
}

void fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
