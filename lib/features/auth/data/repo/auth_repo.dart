import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iti_training/features/auth/data/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<UserCredential> registerWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await credential.user?.updateDisplayName(name);

    if (credential.user != null) {
      await saveUser(credential.user!);
    }

    return credential;
  }

  Future<UserCredential> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user != null) {
      await saveUser(credential.user!);
    }

    return credential;
  }

  Future<UserCredential?> signInWithGoogle() async {
    await _googleSignIn.initialize();

    if (!_googleSignIn.supportsAuthenticate()) {
      throw Exception(
        'Google Sign-In is not supported on this platform.',
      );
    }

    final GoogleSignInAccount googleUser =
        await _googleSignIn.authenticate();

    final GoogleSignInAuthentication googleAuth =
        googleUser.authentication;

    final idToken = googleAuth.idToken;

    if (idToken == null) {
      throw Exception('Google authentication failed.');
    }

    final credential = GoogleAuthProvider.credential(
      idToken: idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(
      credential,
    );

    if (userCredential.user != null) {
      await saveUser(userCredential.user!);
    }

    return userCredential;
  }

  Future<void> saveUser(User user) async {
    final userModel = UserModel.fromFirebaseUser(
      uid: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      photoUrl: user.photoURL ?? '',
      provider: user.providerData.isNotEmpty
          ? user.providerData.first.providerId
          : 'password',
    );

    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(
          userModel.toJson(),
          SetOptions(merge: true),
        );
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
