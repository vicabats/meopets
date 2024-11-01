import 'package:flutter/material.dart';
import 'package:meopets/src/design-system/tokens/spacing.dart';
import 'package:meopets/src/design-system/tokens/typography.dart';
import 'package:meopets/src/modules/my-pet-details/presentation/widgets/my_pet_description_info_widget.dart';
import 'package:meopets/src/shared/entities/my_pet_entity.dart';

class MyPetDescriptionWidget extends StatelessWidget {
  final MyPet pet;

  const MyPetDescriptionWidget({
    super.key,
    required this.pet,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(SpacingTokens.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPetName(),
              const SizedBox(height: SpacingTokens.sm),
              ..._buildPetInfos(),
            ],
          ),
        ),
      ),
    );
  }

  Text _buildPetName() {
    return Text(
      pet.name,
      style: TypographyTokens.titleBoldLg,
    );
  }

  List _buildPetInfos() {
    return [
      MyPetDescriptionInfoWidget(
        infoLabel: 'Tipo',
        infoValue: pet.type,
      ),
      const SizedBox(height: SpacingTokens.xs),
      MyPetDescriptionInfoWidget(
        infoLabel: 'Idade',
        infoValue: _calculateAge(pet.birthDate),
      ),
      const SizedBox(height: SpacingTokens.xs),
      MyPetDescriptionInfoWidget(
        infoLabel: 'Descrição',
        infoValue: pet.description,
      ),
    ];
  }

  String _calculateAge(DateTime birthDate) {
    final today = DateTime.now();

    int age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    final String years = age <= 1 ? 'ano' : 'anos';

    return "$age $years";
  }
}
