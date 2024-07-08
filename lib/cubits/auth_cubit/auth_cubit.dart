import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:my_chat_app/models/user_model.dart';
import '../../services/firebase_storage_service.dart';
import '../../services/firestore_service.dart';
import '../../services/sharedpreference_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseStorageService _firebaseStorageService =
      FirebaseStorageService();
  bool isLoading = false;
  String? photoUrl;

  Future<void> registerUser(String email, String password, String username, XFile? xfile) async {
    isLoading = true;
    emit(AuthLoading());

    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await SharedPreferencesService.saveUsername(username);
      photoUrl = await _firebaseStorageService.uploadProfileImage(xfile, username);
      if (photoUrl != null) {
        await SharedPreferencesService.savePhotoUrl(photoUrl!);
      }
      await _firestoreService.addUser(username, email, photoUrl);

      isLoading = false;
      emit(AuthSuccess(
          UserModel(id: email, username: username, photoUrl: photoUrl)));
    } on FirebaseAuthException catch (ex) {
      String errorMessage;
      switch (ex.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'This email is already in use.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is invalid.';
          break;
        default:
          errorMessage = 'An error occurred: ${ex.message}';
      }
      isLoading = false;
      emit(AuthFailure(errorMessage));
    } catch (ex) {
      isLoading = false;
      emit(AuthFailure('An error occurred: $ex'));
    }
  }

  Future<void> loginUser(String email, String password) async {
    isLoading = true;
    emit(AuthLoading());

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      UserModel user = await _firestoreService.getUserInfo(email);
      print(user.photoUrl ?? 'photo is null');
      await SharedPreferencesService.saveUsername(user.username);
      if (user.photoUrl != null) {
        await SharedPreferencesService.savePhotoUrl(user.photoUrl!);
      }
      isLoading = false;
      emit(AuthSuccess(user));
    } on FirebaseAuthException catch (ex) {
      String errorMessage;
      switch (ex.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        case 'user-disabled':
          errorMessage = 'User with this email has been disabled.';
          break;
        case 'invalid-credential':
          errorMessage = 'The email or password is incorrect';
          break;
        default:
          errorMessage = 'An error occurred: ${ex.message}';
      }
      print(errorMessage);
      isLoading = false;
      emit(AuthFailure(errorMessage));
    } catch (ex) {
      print(ex.toString());
      isLoading = false;
      emit(AuthFailure('An error occurred: $ex'));
    }
  }
}
