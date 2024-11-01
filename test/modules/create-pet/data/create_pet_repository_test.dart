import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:meopets/src/core/network/network.dart';
import 'package:meopets/src/modules/create-pet/data/create_pet_repository.dart';
import 'package:meopets/src/shared/models/my_pet_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

void main() {
  late CreatePetRepository createPetRepository;
  late AppNetwork appNetwork;

  setUp(() {
    appNetwork = _MockAppNetwork();
    createPetRepository = CreatePetRepositoryImpl(appNetwork: appNetwork);
  });

  group("CreatePetRepository /", () {
    group("createPet /", () {
      const String urlPath = "/pets";

      test(
        "when called, "
        "then expect to perform a POST request to urlPath and return the correct response",
        () async {
          final mockResponse = File(
            'test/modules/create-pet/fixtures/create_pet_response_mock.json',
          ).readAsStringSync();

          when(
            () => appNetwork.post(
              urlPath,
              headers: any(named: 'headers'),
              body: any(named: 'body'),
            ),
          ).thenAnswer(
            (_) async => http.Response(mockResponse, 200),
          );

          await createPetRepository.createPet({
            'name': 'name',
            'type': 'type',
            'description': 'description',
            'imageUrl': 'imageUrl',
            'birthDate': DateTime.parse("2023-10-31"),
          });

          verify(() => appNetwork.post(urlPath,
              headers: any(named: 'headers'),
              body: any(named: 'body'))).called(1);
        },
      );

      test(
        "given a successful response, "
        "when called, "
        "then expect to return a MyPetModel object",
        () async {
          final mockResponse = File(
            'test/modules/create-pet/fixtures/create_pet_response_mock.json',
          ).readAsStringSync();

          when(
            () => appNetwork.post(
              urlPath,
              headers: any(named: 'headers'),
              body: any(named: 'body'),
            ),
          ).thenAnswer(
            (_) async => http.Response(mockResponse, 200),
          );

          final result = await createPetRepository.createPet({
            'name': 'name',
            'type': 'type',
            'description': 'description',
            'imageUrl': 'imageUrl',
            'birthDate': DateTime.parse("2023-10-31"),
          });

          expect(result, isA<MyPetModel>());
          expect(result.id, 1);
          expect(result.name, "name");
          expect(result.type, "type");
          expect(result.description, "description");
          expect(result.imageUrl, "imageUrl");
          expect(result.birthDate, DateTime.parse("2023-10-31"));
        },
      );

      test(
        "given a failed response, "
        "when called, "
        "then expect to throw an Exception",
        () async {
          when(
            () => appNetwork.post(
              urlPath,
              headers: any(named: 'headers'),
              body: any(named: 'body'),
            ),
          ).thenAnswer(
            (_) async => http.Response("", 400),
          );

          expect(
            () => createPetRepository.createPet({
              'name': 'name',
              'type': 'type',
              'description': 'description',
              'imageUrl': 'imageUrl',
              'birthDate': DateTime.parse("2023-10-31"),
            }),
            throwsException,
          );
        },
      );
    });
  });
}

class _MockAppNetwork extends Mock implements AppNetwork {}
