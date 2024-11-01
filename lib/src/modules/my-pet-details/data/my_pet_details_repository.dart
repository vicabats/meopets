import 'package:meopets/src/core/network/network.dart';

abstract class MyPetDetailsRepository {
  Future<bool> removePet(int petId);
}

class MyPetDetailsRepositoryImpl implements MyPetDetailsRepository {
  final AppNetwork appNetwork;

  MyPetDetailsRepositoryImpl({
    required this.appNetwork,
  });

  @override
  Future<bool> removePet(int petId) async {
    final removePetUrl = '/pets/$petId';

    final response = await appNetwork.delete(removePetUrl);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Falha ao remover pet: ${response.statusCode}');
    }
  }
}
