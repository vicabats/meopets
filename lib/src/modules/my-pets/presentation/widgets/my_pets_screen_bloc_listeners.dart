import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meopets/src/modules/create-pet/cubit/create_pet_cubit.dart';
import 'package:meopets/src/modules/create-pet/cubit/create_pet_state.dart';
import 'package:meopets/src/modules/my-pet-details/cubit/my_pet_details_cubit.dart';
import 'package:meopets/src/modules/my-pet-details/cubit/my_pet_details_state.dart';
import 'package:meopets/src/modules/my-pets/cubit/my_pets_cubit.dart';

class MyPetsScreenBlocListeners extends StatefulWidget {
  final Widget child;

  const MyPetsScreenBlocListeners({
    super.key,
    required this.child,
  });

  @override
  State<MyPetsScreenBlocListeners> createState() =>
      _MyPetsScreenBlocListenersState();
}

class _MyPetsScreenBlocListenersState extends State<MyPetsScreenBlocListeners> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        _updateMyPetsListener,
        _updateDeletedPetsListener,
      ],
      child: widget.child,
    );
  }

  BlocListener<CreatePetCubit, CreatePetState> get _updateMyPetsListener {
    return BlocListener<CreatePetCubit, CreatePetState>(
      listenWhen: (CreatePetState previous, CreatePetState current) {
        return current.status == CreatePetStatus.successfullyCreated;
      },
      listener: (BuildContext context, CreatePetState createPetState) {
        final myPetsCubit = context.read<MyPetsCubit>();
        myPetsCubit.getMyPets();
      },
    );
  }

  BlocListener<MyPetDetailsCubit, MyPetDetailsState>
      get _updateDeletedPetsListener {
    return BlocListener<MyPetDetailsCubit, MyPetDetailsState>(
      listenWhen: (MyPetDetailsState previous, MyPetDetailsState current) {
        return current.status == MyPetDetailsStatus.successfullyRemoved;
      },
      listener: (BuildContext context, MyPetDetailsState myPetDetailsState) {
        final myPetsCubit = context.read<MyPetsCubit>();
        myPetsCubit.getMyPets();
      },
    );
  }
}
