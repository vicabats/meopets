import 'package:flutter/material.dart';
import 'package:meopets/src/modules/my-pets/presentation/widgets/my_pet_card_widget.dart';
import 'package:meopets/src/shared/entities/my_pet_entity.dart';

class MyPetsGridWidget extends StatelessWidget {
  final List<MyPet> myPets;
  final void Function(MyPet) onCardPressed;

  const MyPetsGridWidget({
    super.key,
    required this.myPets,
    required this.onCardPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: myPets.length,
      itemBuilder: (context, index) {
        final pet = myPets[index];
        return MyPetCardWidget(
          pet: pet,
          onPressed: () => onCardPressed(pet),
        );
      },
    );
  }
}
