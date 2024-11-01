import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:meopets/src/core/network/network.dart';
import 'package:meopets/src/modules/my-pets/data/my_pets_repository.dart';
import 'package:meopets/src/shared/models/my_pet_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

void main() {
  late MyPetsRepository myPetsRepository;
  late AppNetwork appNetwork;

  setUp(() {
    appNetwork = _MockAppNetwork();
    myPetsRepository = MyPetsRepositoryImpl(appNetwork: appNetwork);
  });

  group("MyPetsRepository /", () {
    group("getMyPets /", () {
      const String urlPath = "/pets";

      test(
        "when called, "
        "then expect to perform a GET request to urlPath and return the correct response",
        () async {
          final mockResponse = File(
            'test/modules/my-pets/fixtures/get_pets_response_mock.json',
          ).readAsStringSync();

          when(
            () => appNetwork.get(
              urlPath,
              headers: any(named: 'headers'),
            ),
          ).thenAnswer(
            (_) async => http.Response(mockResponse, 200),
          );

          await myPetsRepository.getPets();

          verify(
            () => appNetwork.get(
              urlPath,
              headers: any(named: 'headers'),
            ),
          ).called(1);
        },
      );

      test(
        "given a successful response, "
        "when called, "
        "then expect to return a List<MyPetModel> object",
        () async {
          final mockResponse = File(
            'test/modules/my-pets/fixtures/get_pets_response_mock.json',
          ).readAsStringSync();

          when(
            () => appNetwork.get(
              urlPath,
              headers: any(named: 'headers'),
            ),
          ).thenAnswer(
            (_) async => http.Response(mockResponse, 200),
          );

          final result = await myPetsRepository.getPets();

          expect(result, isA<List<MyPetModel>>());
        },
      );

      test(
        "given a failed response, "
        "when called, "
        "then expect to throw a ServerException",
        () async {
          when(
            () => appNetwork.get(
              urlPath,
              headers: any(named: 'headers'),
            ),
          ).thenAnswer(
            (_) async => http.Response("", 400),
          );

          expect(
            () async => await myPetsRepository.getPets(),
            throwsException,
          );
        },
      );
    });
  });
}

class _MockAppNetwork extends Mock implements AppNetwork {}
