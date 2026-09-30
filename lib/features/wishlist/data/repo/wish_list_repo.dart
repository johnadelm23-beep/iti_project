import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iti_training/features/wishlist/data/models/wish_list_model.dart';

class WishlistRepo {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  WishlistRepo(
    this.firestore,
    this.auth,
  );

  CollectionReference<Map<String, dynamic>> get _wishlist {
    final uid = auth.currentUser!.uid;

    return firestore
        .collection('users')
        .doc(uid)
        .collection('wishlist');
  }

  Future<void> addToWishlist(
    WishlistMovieModel movie,
  ) async {
    await _wishlist.doc(movie.id.toString()).set(
          movie.toJson(),
        );
  }

  Future<void> removeFromWishlist(int movieId) async {
    await _wishlist.doc(movieId.toString()).delete();
  }

  Future<List<WishlistMovieModel>> getWishlist() async {
    final snapshot = await _wishlist.get();

    return snapshot.docs
        .map(
          (doc) => WishlistMovieModel.fromJson(
            doc.data(),
          ),
        )
        .toList();
  }

  Future<bool> isInWishlist(int movieId) async {
    final doc = await _wishlist
        .doc(movieId.toString())
        .get();

    return doc.exists;
  }
}