import 'dart:convert';
import 'package:meopets/src/core/network/network.dart';
import 'package:meopets/src/shared/models/my_pet_model.dart';

abstract class CreatePetRepository {
  Future<MyPetModel> createPet(Map<String, dynamic> pet);
}

class CreatePetRepositoryImpl implements CreatePetRepository {
  final AppNetwork appNetwork;

  CreatePetRepositoryImpl({
    required this.appNetwork,
  });

  @override
  Future<MyPetModel> createPet(Map<String, dynamic> petData) async {
    const createPetUrl = '/pets';

    final petModel = MyPetModel(
      name: petData['name']!,
      type: petData['type']!,
      description: petData['description']!,
      imageUrl: petData['imageUrl']!,
      birthDate: petData['birthDate']!,
    );

    final response = await appNetwork.post(
      createPetUrl,
      body: jsonEncode(petModel.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return MyPetModel.fromJson(jsonResponse);
    } else {
      throw Exception('Falha ao criar pet: ${response.statusCode}');
    }
  }
}
