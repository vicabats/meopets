import 'package:equatable/equatable.dart';

enum MyPetDetailsStatus {
  idle,
  loading,
  successfullyRemoved,
  error,
}

class MyPetDetailsState extends Equatable {
  final MyPetDetailsStatus status;

  const MyPetDetailsState({
    this.status = MyPetDetailsStatus.idle,
  });

  MyPetDetailsState copyWith({
    MyPetDetailsStatus? status,
  }) {
    return MyPetDetailsState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
