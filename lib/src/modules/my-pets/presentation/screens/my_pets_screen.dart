import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meopets/src/design-system/tokens/colors.dart';
import 'package:meopets/src/design-system/tokens/spacing.dart';
import 'package:meopets/src/modules/my-pets/cubit/my_pets_cubit.dart';
import 'package:meopets/src/modules/my-pets/cubit/my_pets_state.dart';
import 'package:meopets/src/modules/my-pets/presentation/widgets/my_pets_grid.dart';
import 'package:meopets/src/modules/my-pets/presentation/widgets/my_pets_screen_bloc_listeners.dart';
import 'package:meopets/src/shared/widgets/custom_app_bar.dart';
import 'package:meopets/src/shared/widgets/loading_component.dart';
import 'package:meopets/src/shared/entities/my_pet_entity.dart';
import 'package:meopets/src/shared/widgets/custom_toaster.dart';

class MyPetsScreen extends StatefulWidget {
  const MyPetsScreen({super.key});

  @override
  State<MyPetsScreen> createState() => _MyPetsScreenState();
}

class _MyPetsScreenState extends State<MyPetsScreen> {
  MyPetsCubit get _myPetsCubit => context.read<MyPetsCubit>();
  MyPetsState get _myPetsState => _myPetsCubit.state;

  @override
  Widget build(BuildContext context) {
    return MyPetsScreenBlocListeners(
      builder: (BuildContext context) {
        return BlocConsumer<MyPetsCubit, MyPetsState>(
          listener: (context, myPetsState) {
            if (myPetsState.status == MyPetsStatus.error) {
              _showError();
            }
          },
          builder: (context, myPetsState) {
            if (myPetsState.status == MyPetsStatus.loading) {
              return const LoadingComponent();
            } else {
              return _buildLoadedScaffold(context);
            }
          },
        );
      },
    );
  }

  Widget _buildLoadedScaffold(BuildContext context) {
    if (_myPetsState.myPets!.isEmpty) {
      return Container();
    }
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildAddNewPetButton(context),
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: SpacingTokens.lg,
          right: SpacingTokens.lg,
          top: SpacingTokens.xl,
        ),
        child: MyPetsGridComponent(
          myPets: _myPetsState.myPets!,
          onCardPressed: _onCardPressed,
        ),
      ),
    );
  }

  void _onCardPressed(MyPet pet) {
    _navigateToPetDetails(pet);
  }

  FloatingActionButton _buildAddNewPetButton(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text('Cadastrar novo pet'),
      icon: const Icon(Icons.add),
      backgroundColor: ColorsTokens.brandPrimary,
      onPressed: () {
        Navigator.of(context).pushNamed('/create-pet');
      },
    );
  }

  void _navigateToPetDetails(MyPet pet) {
    Navigator.of(context).pushNamed('/pet-details', arguments: pet);
  }

  void _showError() {
    CustomToaster.showErrorToast('Erro ao carregar pets');
  }
}
