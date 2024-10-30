import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meopets/src/modules/create-pet/cubit/create_pet_cubit.dart';
import 'package:meopets/src/modules/create-pet/cubit/create_pet_state.dart';
import 'package:meopets/src/modules/my-pets/cubit/my_pets_cubit.dart';

class MyPetsScreenBlocListeners extends StatelessWidget {
  final WidgetBuilder builder;

  const MyPetsScreenBlocListeners({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final myPetsCubit = context.read<MyPetsCubit>();
    return BlocListener<CreatePetCubit, CreatePetState>(
      listenWhen: (previous, current) =>
          current.status == CreatePetStatus.successfullyCreated,
      listener: (context, createPetState) {
        myPetsCubit.getMyPets();
      },
      child: builder(context),
    );
  }
}
