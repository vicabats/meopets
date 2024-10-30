import 'package:equatable/equatable.dart';

class MyPet extends Equatable {
  final int? id;
  final String name;
  final DateTime birthDate;
  final String type;
  final String description;
  final String imageUrl;

  const MyPet({
    this.id,
    required this.name,
    required this.birthDate,
    required this.type,
    required this.description,
    required this.imageUrl,
  });

  factory MyPet.generate() => MyPet(
        id: null,
        name: '',
        birthDate: DateTime.now(),
        type: '',
        description: '',
        imageUrl: '',
      );

  @override
  List<Object?> get props => [
        id,
        name,
        birthDate,
        type,
        description,
        imageUrl,
      ];
}
