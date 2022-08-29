import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';

class FlutterRegulationTheme {
  static ThemeData get light {
    return ThemeData(
      dividerTheme: DividerThemeData(color: Color(0xFF303030)),
      indicatorColor: Color(0xFF969899),
      dividerColor: Colors.transparent,
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: Color(0xFFfcfcfc),
        indicatorColor: Color(0xFFfcedda),
        unselectedIconTheme: IconThemeData(color: Color(0xFFa2a4a5)),
        selectedIconTheme: IconThemeData(color: Color(0xFFe98c14)),
        unselectedLabelTextStyle: TextStyle(
            color: Color(0xFF828282),
            fontWeight: FontWeight.bold,
            fontSize: FontSize.large.size),
        selectedLabelTextStyle: TextStyle(color: Color(0xFFe98c14)),
      ),
      fontFamily: 'Yandex',
      focusColor: Colors.blueGrey[900],
      appBarTheme: const AppBarTheme(
        elevation: 74,
        backgroundColor: Colors.white,
        shadowColor: Color.fromRGBO(0, 0, 0, .06),
        foregroundColor: Color(0XFF747E8B),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
        toolbarTextStyle: TextStyle(
          color: Color(0XFF747E8B),
          fontSize: 16,
        ),
        iconTheme: IconThemeData(
          size: 27,
          color: Colors.black,
        ),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: Color(0xFFfcfcfc),
      ),
      scaffoldBackgroundColor: Colors.white,
      bottomAppBarColor: Color(0XFFf7f6fb),
      shadowColor: Color(0xFFe7e7e7),
      textTheme: const TextTheme(
          headline1: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17.0),
          headline2:
              TextStyle(color: Colors.black, backgroundColor: Colors.white),
          bodyText1: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          bodyText2: TextStyle(color: Colors.black, fontSize: 15)),
      iconTheme: IconThemeData(size: 20, color: Color(0XFF447FEB)),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      indicatorColor: Color(0xFF969899),
      dividerColor: Colors.transparent,
      fontFamily: 'Yandex',
      focusColor: Colors.blueGrey[900],
      shadowColor: Color(0xFF353535),
      appBarTheme: const AppBarTheme(
          elevation: 74,
          color: Colors.black,
          shadowColor: Color(0xFF242424),
          titleTextStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
          toolbarTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          iconTheme: IconThemeData(
            size: 27,
            color: Colors.white,
          ),
          foregroundColor: Color(0XFF747E8B)
          ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: Color(0xFF25292a),
        indicatorColor: Color(0xFF654a23),
        unselectedIconTheme: IconThemeData(color: Color(0xFF5f6262)),
        selectedIconTheme: IconThemeData(color: Color(0xFFf49315)),
        unselectedLabelTextStyle: TextStyle(color: Color(0xFFc6c7c7)),
        selectedLabelTextStyle: TextStyle(color: Color(0xFFf49315)),
        
      ),
      drawerTheme: DrawerThemeData(backgroundColor: Color(0xFF25292a)),
      scaffoldBackgroundColor: Color(0xFF0b0b0b),
      textTheme: const TextTheme(
          headline1: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17.0),
          headline2: TextStyle(
              color: Color(0xFFfdfdfd), 
              backgroundColor: Color(0xFF272727)),
          bodyText1: TextStyle(
            color: Color(0xFF999da5),
            fontWeight: FontWeight.w600,
          ),
          bodyText2: TextStyle(
            color: Color(0xFF999da5),
            fontSize: 15,
          )),
      iconTheme: IconThemeData(size: 20, color: Colors.white),
      
    );
  }
}
