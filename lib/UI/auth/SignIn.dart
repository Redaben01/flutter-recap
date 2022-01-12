import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:sum/UI/expenses/transaction.dart';
import 'package:sum/UI/widgets/PopUp.dart';
import 'package:sum/providers/users.dart';
import 'package:sum/utils/AppLocalizations.dart';
import 'package:sum/utils/input_validator.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  static String tag = 'SignIn';
  @override
  _SignIn createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).initFirebase();
    });
  }

  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _email = FocusNode(); //use focus node
  final _password = FocusNode();

  final Map<String, dynamic> _userLogin = {
    'email': null,
    'password': null,
  };

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  bool passwordVisible = true;
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    Size size = MediaQuery.of(context).size;

    
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/signin.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Container(
                child: Image.asset(
                  'assets/images/wordsBattle.png',
                  height: MediaQuery.of(context).size.height * 0.3,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 80),
                      child: TextFormField(
                        onSaved: (email) {
                          _userLogin['email'] = email;
                        },
                        style: TextStyle(color: Colors.black),
                        autofocus: false, // focus textfiels
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_password); // next focus textfiels
                        },
                        validator: InputValidator.email,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          contentPadding: EdgeInsets.all(size.width * 0.03),
                          hintText:
                              AppLocalizations.of(context).translate('Email'),
                          hintStyle: TextStyle(
                              fontSize: 17.0 * curScaleFactor,
                              color: Colors.black),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 80),
                      child: TextFormField(
                        onSaved: (input) {
                          _userLogin['password'] = input;
                        },
                        style: TextStyle(color: Colors.black),
                        focusNode: _password,
                        textInputAction: TextInputAction.send,
                        validator: InputValidator.password,
                        obscureText: passwordVisible,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          focusColor: Colors.black,
                          hintText: AppLocalizations.of(context)
                              .translate('Password'),
                          hintStyle: TextStyle(
                              fontSize: 17.0 * curScaleFactor,
                              color: Colors.black),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Row(children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          (AppLocalizations.of(context)
                              .translate("forgetPass")),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ]),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Container(
                              height: size.height * 0.065,
                              width: size.width * 0.38,
                              child: RaisedButton(
                                  textColor: Colors.white,
                                  color: Color.fromARGB(255, 59, 89, 152),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(0.0),
                                      side: BorderSide(
                                          color: Color.fromARGB(
                                              255, 59, 89, 152))),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('login'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18 * curScaleFactor),
                                  ),
                                  onPressed: () =>
                                      _submitForm(userProvider.signIn)),
                            ),
                    ),
                    Center(
                      child: Text(
                        AppLocalizations.of(context).translate("OrSignUpWith"),
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Center(
                      child: GoogleSignInButton(
                            text: AppLocalizations.of(context)
                                .translate("Google"),
                            onPressed: () async {
                             await  userProvider.signInWithGoogle(context);
                              // await model.signUpWithGoogle();
                              /*Navigator.of(context).pushNamedAndRemoveUntil(
                                  MyHomePage.tag, (Route<dynamic> route) => false);*/
                            }),
                    ),
                    Center(
                      child: FacebookSignInButton(
                            text: AppLocalizations.of(context)
                                .translate("Facebook"),
                            onPressed: () async {
                              // await model.signUpWithFB();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  MyHomePage.tag, (Route<dynamic> route) => false);
                            }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm(Function login) async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) return;
    setState(() {
      isLoading = true;
    });
    _formKey.currentState.save();

    final Map<String, dynamic> successInformation = await login(_userLogin);
    
    if (successInformation['success']) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          MyHomePage.tag, (Route<dynamic> route) => false);
    } else {
      setState(() {
        isLoading = false;
      });
      showDialog(
        builder: (BuildContext context) {
          return PopUpWidget(
            AppLocalizations.of(context).translate("Error"),
            AppLocalizations.of(context)
                .translate(successInformation['message']),
            icon: "error1",
          );
        },
        context: context,
      );
    }
  }
}
