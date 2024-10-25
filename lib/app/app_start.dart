import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meopets/app/app_providers.dart';
import 'package:meopets/src/modules/home/view/home_view.dart';

class AppStart {
  Future<void> startApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return runApp(
      AppProviders(
        child: MaterialApp(
          routes: <String, WidgetBuilder>{
            '/': (BuildContext context) => const HomeView(),
          },
          title: "Meopets",
        ),
      ),
    );
  }
}
