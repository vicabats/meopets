import 'package:meopets/src/shared/entities/my_pet_entity.dart';

class MyPetModel extends MyPet {
  const MyPetModel({
    super.id,
    required super.name,
    required super.type,
    required super.birthDate,
    required super.description,
    required super.imageUrl,
  });

  factory MyPetModel.fromJson(Map<String, dynamic> json) {
    return MyPetModel(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      birthDate: DateTime.parse(json['birthDate']).toLocal(),
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'birthDate': birthDate.toString(),
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
