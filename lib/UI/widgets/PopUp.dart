import 'package:flutter/material.dart';
import 'package:sum/utils/AppLocalizations.dart';
import 'package:flare_flutter/flare_actor.dart';

class PopUpWidget extends StatelessWidget {
  final String title;
  final String content;
  final String icon;
  PopUpWidget(this.title, this.content, {this.icon = "info1"});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      insetPadding: EdgeInsets.only(
        left: size.width * 0.04,
        right: size.width * 0.04,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.height * 0.1),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            width: size.width,
            padding: EdgeInsets.only(
              top: size.height * 0.14,
              bottom: size.height * 0.02,
              left: size.width * 0.04,
              right: size.width * 0.04,
            ),
            margin: EdgeInsets.only(top: size.height * 0.05),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(size.height * 0.03),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    content,
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  FlatButton(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                          AppLocalizations.of(context).translate("Close"),
                          style: Theme.of(context).textTheme.button),
                      onPressed: () => Navigator.of(context).pop())
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 16,
            right: 16,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: FlareActor(
                "assets/animation/" + icon + ".flr",
                animation: icon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
