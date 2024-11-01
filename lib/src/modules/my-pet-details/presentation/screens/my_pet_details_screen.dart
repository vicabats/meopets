import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meopets/src/design-system/tokens/spacing.dart';
import 'package:meopets/src/modules/my-pet-details/cubit/my_pet_details_cubit.dart';
import 'package:meopets/src/modules/my-pet-details/presentation/widgets/my_pet_delete_button_widget.dart';
import 'package:meopets/src/modules/my-pet-details/presentation/widgets/my_pet_description_widget.dart';
import 'package:meopets/src/shared/entities/my_pet_entity.dart';
import 'package:meopets/src/shared/widgets/custom_app_bar.dart';

class MyPetDetailsScreen extends StatefulWidget {
  const MyPetDetailsScreen({super.key});

  @override
  State<MyPetDetailsScreen> createState() => _MyPetDetailsScreenState();
}

class _MyPetDetailsScreenState extends State<MyPetDetailsScreen> {
  MyPet get _pet => ModalRoute.of(context)!.settings.arguments as MyPet;
  MyPetDetailsCubit get _myPetDetailsCubit => context.read<MyPetDetailsCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(SpacingTokens.md),
        child: Column(
          children: [
            _buildPetImage(),
            const SizedBox(height: SpacingTokens.md),
            MyPetDescriptionWidget(
              pet: _pet,
            ),
            const SizedBox(height: SpacingTokens.md),
            MyPetDeleteButtonWidget(onPressed: onPetDelete),
          ],
        ),
      ),
    );
  }

  Widget _buildPetImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        _pet.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  void onPetDelete() async {
    await _myPetDetailsCubit.removePet(_pet.id!);
    if (mounted) {
      Navigator.pushNamed(context, '/');
    }
  }
}
