import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(String format, DateTime date) {
  if (date == null) return '';
  var formatter = new DateFormat(format);
  return formatter.format(date);
}

String numberFormat(number) {
  if (number == null) return '';
  return NumberFormat.compact().format(number);
}

Widget loadingView(context, {label = 'loading...'}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 20),
        child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation(Theme.of(context).primaryColorLight),
        ),
      ),
      Text(
        label,
        style: Theme.of(context).textTheme.subtitle2,
      ),
    ],
  );
}

String postDate(DateTime postdate) {
  var days = DateTime.now().difference(postdate).inDays;
  var seconds = DateTime.now().difference(postdate).inSeconds;
  var hours = DateTime.now().difference(postdate).inHours;
  var minutes = DateTime.now().difference(postdate).inMinutes;
  if (seconds < 60)
    return seconds.toString() + ' s';
  else if (minutes < 60)
    return minutes.toString() + ' m';
  else if (hours < 24)
    return hours.toString() + ' h';
  else if (days < 30)
    return days.toString() + ' d';
  else
    return formatDate('dd MMM y', postdate);
}

int minutesDifference(TimeOfDay time1, TimeOfDay time2) {
  int mainMinutes = time1.minute -time2.minute;
  int mainhour = time1.hour -time2.hour;

  return mainhour*60+mainMinutes;
}


  final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF2A2E43),
    primaryColor: Color(0xFF3ACCE1),
    accentColor: Color(0xFF5773FF),
    primaryColorDark: Color(0xFF000000),
    primaryColorLight: Color(0XFFFFFFFF),
    backgroundColor: Color(0XFFFFFFFF),
    bottomAppBarColor: Color(0XFF3F4255),
    canvasColor: Color(0xFFFFDF00),
    buttonColor: Color(0xFF2D85DF),
    secondaryHeaderColor: Color.fromRGBO(230, 126, 0, 1),
    indicatorColor: Color.fromRGBO(50, 137, 179, 1),
    iconTheme: IconThemeData(
      color: Color(0xFF2A2E43),
    ),
    appBarTheme: AppBarTheme(
      color: Color(0xFF2A2E43),
      iconTheme: IconThemeData(
        color: Color(0XFFFFFFFF),
        size: 28,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0XFFFFFFFF),
    ),
    fontFamily: 'Roboto',
    textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: Color(0XFFFFFFFF)),
      headline2: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: Color(0XFFFFFFFF)),
      headline3: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: Color(0XFFBABABA)),
      headline4: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: Color(0XFF000000)),
      headline5: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2A2E43)),
      headline6: TextStyle(fontSize: 15.0, color: Color(0XFFFFFFFF)),
      subtitle1: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color(0XFF000000)),
      subtitle2: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color(0XFFFFFFFF)),
      overline: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color(0XFFA9A9A9)),
      button: TextStyle(fontSize: 20.0, color: Color(0XFFFFFFFF)),
      bodyText1: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2D85DF)),
      bodyText2: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color(0XFF000000)),
      caption: TextStyle(
          fontSize: 10.0,
          fontStyle: FontStyle.italic,
          color: Color(0XFFFFFFFF)),
    ),
  );

  final ThemeData lightTheme = ThemeData(
    cardColor: Color(0xFF2A2E43),
    scaffoldBackgroundColor: Color(0XFFFFFFFF),
    primaryColor: Color(0xFF3ACCE1),
    accentColor: Color(0xFF5773FF),
    primaryColorDark: Color(0XFFFFFFFF),
    primaryColorLight: Color(0xFF000000),
    backgroundColor: Color(0xFF2A2E43),
    canvasColor: Color(0xFFFFDF00),
    bottomAppBarColor: Color(0XFFCCCCCC),
    buttonColor: Color(0xFF2D85DF),
    secondaryHeaderColor: Color.fromRGBO(230, 126, 0, 1),
    indicatorColor: Color.fromRGBO(50, 137, 179, 1),
    iconTheme: IconThemeData(
      color: Color(0XFFFFFFFF),
    ),
    appBarTheme: AppBarTheme(
      color: Color(0XFFFFFFFF),
      iconTheme: IconThemeData(
        color: Color(0xFF2A2E43),
        size: 28,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF2A2E43),
    ),
    fontFamily: 'Roboto',
    textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: Color(0XFF000000)),
      headline2: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: Color(0XFF000000)),
      headline3: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: Color(0XFFBABABA)),
      headline4: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: Color(0XFFFFFFFF)),
      headline5: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: Color(0XFFFFFFFF)),
      headline6: TextStyle(fontSize: 15.0, color: Color(0XFF000000)),
      subtitle1: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color(0XFFFFFFFF)),
      subtitle2: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color(0XFF000000)),
      overline: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color(0XFF505050)),
      button: TextStyle(fontSize: 20.0, color: Color(0XFFFFFFFF)),
      bodyText1: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2D85DF)),
      bodyText2: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color(0XFFFFFFFF)),
      caption: TextStyle(
          fontSize: 10.0,
          fontStyle: FontStyle.italic,
          color: Color(0XFF000000)),
    ),
  );
