//Form widget for login screen
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {

  AuthForm(this.submitFn,this.isLoading);


  //VVIMP: LEARN HOW TO ACCEPT FUNCTION AS PARAMETER
  //we set parameters below
  final bool isLoading;
  final void Function(
      String email,
      String password,
      String username,
      bool isLogin,
      BuildContext context
      ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

  final _formKey = GlobalKey<FormState>();
  // to retrieve data from the form
  //when u use the Form() widget give it a key so that u can manage data
  // is entered in it

  var _isLogin = true; // to toggle between Login and Sign up

  //variables to store values of mail username password
  String _userEmail='' ;
  String _userPassword='';
  String _userName='';

  void _trySubmit(){
    //needed to validate(check conditions) and submit the form
    final isValid= _formKey.currentState!.validate();

    //print("ENTERED _TRYSUBMIT");

    FocusScope.of(context).unfocus();
    //closes keyboard


    //if all values are accepted then save the values
    if(isValid){
      //print("VALID");
      //print(_userEmail);
      //print(_userPassword);
      //print(_userName);

      _formKey.currentState!.save(); //saves current state of form field

      //widget. is used in stateful widgets to use constructor variables
      //in state

      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName,
        _isLogin,
        context
      );

      //use values to send auth state
    }

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(


              //check up
              key: _formKey,

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 40,
                  ),
                  FlatButton.icon(
                      onPressed: (){},
                      icon: Icon(Icons.image),
                      label: Text('Add Image')
                  ),
                  TextFormField(
                    key: ValueKey('email'),

                    //validator
                    validator: (value){
                      if(value!.isEmpty || !value!.contains('@')){
                        return 'Please enter a valid email';
                      }
                      else{
                        return null;
                      }
                    },

                    onSaved: (value){
                      //print("ENTERED ON SAVE");
                      _userEmail = value!;
                      //print(_userEmail);
                    },

                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email address'
                    ),
                  ),

                  //dynamically typed DART ALLOWS
                  if(!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),

                    validator: (value){
                      if(value!.isEmpty || value!.length<4){
                        return 'Please enter atleast 4 characters';
                      }
                      else{
                        return null;
                      }

                    },
                    onSaved: (value){
                        //print("ENTERED ON SAVED");
                        _userName=value!;
                        //print(_userEmail);
                    },
                    decoration: InputDecoration(
                        labelText: 'Username'
                    ),
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value){
                      if(value!.isEmpty || value!.length < 7){
                        return 'Password must be atleast 7 characters';
                      }
                      else{
                        return null;
                      }
                    },
                    onSaved: (value1){
                      //print("ENTERED ON SAVED");
                      _userPassword=value1!;
                      //print(_userPassword);
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password'
                    ),
                  ),
                  SizedBox(height: 12,),

                  if(widget.isLoading)
                    CircularProgressIndicator(),
                  if(!widget.isLoading)
                  RaisedButton(
                    child: Text(_isLogin?
                    "Login" :
                       'Signup'
                    ),
                      onPressed: _trySubmit
                      ),
                  if(!widget.isLoading)
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                      onPressed: (){

                      setState(() {
                        _isLogin= !_isLogin; //switch between login and signup
                      });

                      },
                      child: Text(
                          _isLogin?'Create new account':
                          'I already have an account'
                      )
                  )

                ],
              ),
            ),
          ),
        ) ,
      ),
    );
  }
}
