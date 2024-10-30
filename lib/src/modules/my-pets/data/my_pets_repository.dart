import 'dart:convert';
import 'package:meopets/src/core/network/network.dart';
import 'package:meopets/src/shared/models/my_pet_model.dart';

abstract class MyPetsRepository {
  Future<List<MyPetModel>> getPets();
}

class MyPetsRepositoryImpl implements MyPetsRepository {
  final AppNetwork appNetwork;

  MyPetsRepositoryImpl({
    required this.appNetwork,
  });

  @override
  Future<List<MyPetModel>> getPets() async {
    const myPetsUrl = '/pets';

    final response = await appNetwork.get(myPetsUrl);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((item) => MyPetModel.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar pets: ${response.statusCode}');
    }
  }
}
