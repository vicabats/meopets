import 'package:flutter/material.dart';
import 'package:meopets/src/design-system/tokens/colors.dart';
import 'package:meopets/src/design-system/tokens/spacing.dart';
import 'package:meopets/src/design-system/tokens/typography.dart';
import 'package:meopets/src/shared/entities/my_pet_entity.dart';

class MyPetCardWidget extends StatelessWidget {
  final MyPet pet;
  final VoidCallback onPressed;

  const MyPetCardWidget({
    super.key,
    required this.pet,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: ColorsTokens.softGray,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildPhoto(),
            _buildName(),
          ],
        ),
      ),
    );
  }

  ClipRRect _buildPhoto() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(70),
      child: Image.network(
        pet.imageUrl,
        width: 90,
        height: 90,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildName() {
    return Container(
      padding: const EdgeInsets.all(SpacingTokens.sm),
      child: Text(
        pet.name,
        style: TypographyTokens.titleRegularSm,
        textAlign: TextAlign.center,
      ),
    );
  }
}
