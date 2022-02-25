import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trabcon_flutter/application/auth/auth_controller.dart';
import 'package:trabcon_flutter/domain/auth/custom_exception.dart';
import 'package:trabcon_flutter/domain/candidatos/candidato.dart';
import 'package:trabcon_flutter/providers.dart';

final myDataExceptionProvider = StateProvider<CustomException?>((_) => null);

final myDataControllerProvider =
    StateNotifierProvider<MyDataController, AsyncValue<Candidato>>((ref) {
  final user = ref.watch(authControllerProvider);

  return MyDataController(ref.read, user);
});

class MyDataController extends StateNotifier<AsyncValue<Candidato>> {
  final Reader _read;
  final User? _user;

  MyDataController(this._read, this._user) : super(const AsyncValue.loading()) {
    if (_user?.uid != null) {
      fetchCandidato();
    }
  }

  Future<void> fetchCandidato({bool isRefreshing = false}) async {
    if (isRefreshing) state = const AsyncValue.loading();
    try {
      final failureOrCandidato =
          await _read(candidatoRepositoryProvider).fetchCandidato(_user!.uid);
      if (mounted) {
        state = await failureOrCandidato.fold(
          (failure) => AsyncValue.error(failure.toString()),
          (optionCandidato) => optionCandidato.fold(
            () => AsyncValue.data(Candidato.empty()),
            (candidato) async {
              if (candidato.photoUrl == null) {
                final photoUrl = await fetchPhotoUrl();
                if (photoUrl != null) {
                  candidato = candidato.copyWith(photoUrl: photoUrl);
                }
              }
              return AsyncValue.data(candidato);
            },
          ),
        );
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, stackTrace: st);
    }
  }

  Future<void> createOrUpdateCandidato(
      {required Candidato updatedCandidato}) async {
    try {
      await _read(candidatoRepositoryProvider)
          .createOrUpdate(userId: _user!.uid, candidato: updatedCandidato);
    } on CustomException catch (e) {
      _read(myDataExceptionProvider.state).state = e;
    }
  }

  Future<String?> fetchPhotoUrl() async {
    try {
      return await firebase_storage.FirebaseStorage.instance
          .ref('candidato_photos/${_user!.uid}')
          .getDownloadURL();
    } on firebase_storage.FirebaseException catch (e) {
      if (e.code == 'object-not-found') {
        return null;
      }
    }
    return null;
  }

  Future<void> uploadPhoto(XFile imageFile) async {
    // final ext = extension(imageFile.path);
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final fileName = uid; //basename(imageFile.path);

    try {
      final firebase_storage.UploadTask uploadTask;
      firebase_storage.Reference firebaseStorageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('candidato_photos')
          .child(fileName);

      // if (kIsWeb) {
      uploadTask = firebaseStorageRef.putData(await imageFile.readAsBytes(),
          firebase_storage.SettableMetadata(contentType: imageFile.mimeType));
      // } else {
      //   uploadTask = firebaseStorageRef.putFile(File(imageFile.path));
      // }

      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
      final photoUrl = await taskSnapshot.ref.getDownloadURL();
      state =
          state.whenData((candidato) => candidato.copyWith(photoUrl: photoUrl));
      print(state);
    } on firebase_storage.FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        _read(myDataExceptionProvider.state).state = const CustomException(
            message:
                'O usuário não tem permissão para fazer upload para esta referência.');
      }
    }
  }
}
