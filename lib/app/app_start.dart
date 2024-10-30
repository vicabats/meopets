import 'package:flutter/material.dart';
import 'package:meopets/app/app_providers.dart';
import 'package:meopets/src/modules/create-pet/presentation/screens/create_pet_screen.dart';
import 'package:meopets/src/modules/my-pet-details/presentation/screens/my_pet_details_screen.dart';
import 'package:meopets/src/modules/my-pets/presentation/screens/my_pets_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final _routes = <String, WidgetBuilder>{
  '/pet-details': (BuildContext context) => const MyPetDetailsScreen(),
  '/create-pet': (BuildContext context) => const CreatePetScreen(),
};

class AppStart {
  Future<void> startApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    return runApp(
      AppProviders(
        child: MaterialApp(
          locale: const Locale('pt', 'BR'),
          supportedLocales: const [
            Locale('pt', 'BR'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            fontFamily: 'OpenSans',
            colorScheme: const ColorScheme.light(
              primary: Colors.orangeAccent,
            ),
          ),
          home: const MyPetsScreen(),
          routes: _routes,
          title: "Meopets",
        ),
      ),
    );
  }
}
