import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/home.dart';


class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginState();
  }

}

class _LoginState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Sign In"),),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Column(

            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    /*Scaffold.of(context).showSnackBar(
                        new SnackBar(
                          content: new Text("Please Enter Required Fields"),
                          duration: new Duration(seconds: 3),)
                    );*/
                    return "Please Enter Email ID";
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(labelText: "Email ID"),
              ),
              TextFormField(
                validator: (input) {
                  if (input.length < 6) {
                    return "Please provide a password";
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              MaterialButton(onPressed: () => signIn(),
                  color: Colors.red,

                  child: Text("Sign In")

              )
            ],
          ),)
        ,
      )
      ,
    );
  }


  Future<void>  signIn() async{
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()));
        print(user);
        //Navigator.of(context).pushNamed("/a");
      } catch (e) {
        print(e.message);
      }
    }
  }
}