import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meopets/src/core/network/network.dart';
import 'package:meopets/src/modules/create-pet/data/create_pet_repository.dart';
import 'package:meopets/src/modules/create-pet/cubit/create_pet_cubit.dart';
import 'package:meopets/src/modules/my-pets/data/my_pets_repository.dart';
import 'package:meopets/src/modules/my-pets/cubit/my_pets_cubit.dart';
import 'package:meopets/src/core/network/network_http_client.dart';
import 'package:meopets/config/environment.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<http.Client>.value(value: http.Client()),
        Provider<Environment>.value(value: Environment()),
        Provider<AppNetwork>(
          create: (context) => NetworkHttpClient(
            client: context.read<http.Client>(),
            environment: context.read<Environment>(),
          ),
        ),
        Provider<MyPetsRepository>(
          create: (context) => MyPetsRepositoryImpl(
            appNetwork: context.read<AppNetwork>(),
          ),
        ),
        Provider<CreatePetRepository>(
          create: (context) => CreatePetRepositoryImpl(
            appNetwork: context.read<AppNetwork>(),
          ),
        ),
        BlocProvider<MyPetsCubit>(
          create: (context) => MyPetsCubit(
            myPetsRepository: context.read<MyPetsRepository>(),
          ),
        ),
        BlocProvider<CreatePetCubit>(
          create: (context) => CreatePetCubit(
            createPetRepository: context.read<CreatePetRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
