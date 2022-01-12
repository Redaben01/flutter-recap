import 'package:flutter/material.dart';
import 'package:sum/UI/auth/SignIn.dart';
import 'package:sum/UI/expenses/transaction.dart';
import 'package:sum/providers/AppLanguage.dart';
import 'package:sum/providers/Settings.dart';
import 'package:sum/providers/TransactionProvider.dart';
import 'package:sum/providers/users.dart';
import 'package:sum/utils/AppLocalizations.dart';
import 'package:provider/provider.dart';
import 'package:sum/utils/common.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ),
  );
  final UserProvider _userProvider = UserProvider();
  await _userProvider.initMyApp();

  runApp(MyApp(
    userProvider: _userProvider,
  ));
}

class MyApp extends StatelessWidget {
  final UserProvider userProvider;

  MyApp({this.userProvider});

  final routes = <String, WidgetBuilder>{
    MyHomePage.tag: (context) => MyHomePage(),
    SignIn.tag: (context) => SignIn(),
  };

  final UserProvider _userProvider = UserProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => userProvider,
        ),
        ChangeNotifierProvider(
          create: (_) => AppLanguage(),
        ),
        ChangeNotifierProvider(
          create: (_) => Settings(),
        ),
      ],
      child: MaterialApp(
        title: 'Personal Expenses',
        theme: lightTheme,
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', ''),
          Locale('fr', '')
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          FallbackLocalizationDelegate()
        ],
        locale: Locale('en'),
        home: Consumer<UserProvider>(
          builder: (context, user, child) {
            return (user.authenticatedUser == null) ? SignIn() : MyHomePage();
          },
        ),
        routes: routes,
      ),
    );
  }
}
