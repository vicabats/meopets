import 'package:flutter/material.dart';
import 'package:meopets/src/core/app-network/app_network.dart';
import 'package:provider/provider.dart';
import 'package:meopets/src/core/app-network/app_network_http_client.dart';
import 'package:meopets/src/core/app-environment/environment.dart';
import 'package:http/http.dart' as http;

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<http.Client>(create: (_) => http.Client()),
        Provider<Environment>(create: (_) => Environment()),
        Provider<AppNetwork>(
          create: (context) => NetworkHttpClient(
            client: context.read<http.Client>(),
            environment: context.read<Environment>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
