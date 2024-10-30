import 'package:flutter/material.dart';
import 'package:meopets/src/design-system/tokens/spacing.dart';
import 'package:meopets/src/modules/my-pet-details/presentation/widgets/my_pet_description_component.dart';
import 'package:meopets/src/shared/entities/my_pet_entity.dart';
import 'package:meopets/src/shared/widgets/custom_app_bar.dart';

class MyPetDetailsScreen extends StatefulWidget {
  const MyPetDetailsScreen({super.key});

  @override
  State<MyPetDetailsScreen> createState() => _MyPetDetailsScreenState();
}

class _MyPetDetailsScreenState extends State<MyPetDetailsScreen> {
  MyPet get _pet => ModalRoute.of(context)!.settings.arguments as MyPet;

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
            MyPetDescriptionComponent(
              pet: _pet,
            ),
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
}
