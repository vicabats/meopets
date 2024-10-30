import 'package:equatable/equatable.dart';
import 'package:meopets/src/shared/entities/my_pet_entity.dart';

enum MyPetsStatus {
  loading,
  loaded,
  error,
}

class MyPetsState extends Equatable {
  final MyPetsStatus status;
  final List<MyPet>? myPets;

  const MyPetsState({
    this.myPets,
    this.status = MyPetsStatus.loading,
  });

  MyPetsState copyWith({
    MyPetsStatus? status,
    List<MyPet>? myPets,
  }) {
    return MyPetsState(
      status: status ?? this.status,
      myPets: myPets ?? this.myPets,
    );
  }

  @override
  List<Object?> get props => [status, myPets];
}
