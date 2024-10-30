import 'package:equatable/equatable.dart';

enum CreatePetStatus {
  loading,
  loaded,
  successfullyCreated,
  error,
}

class CreatePetState extends Equatable {
  final CreatePetStatus status;

  const CreatePetState({
    this.status = CreatePetStatus.loaded,
  });

  CreatePetState copyWith({
    CreatePetStatus? status,
  }) {
    return CreatePetState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
