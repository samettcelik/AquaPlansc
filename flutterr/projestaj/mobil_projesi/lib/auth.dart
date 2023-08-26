import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//giris yap fonksiyonu

  Future<User?> girisYap(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  //kayıt ol fonksiyonu

  Future<User?> kayitOl(String username, String email, String password) async {
    try {
      // Kullanıcıyı Firebase Authentication'da oluşturmadan önce, e-posta adresiyle kayıtlı bir kullanıcı olup olmadığını kontrol edin
      var existingUser = await _auth.fetchSignInMethodsForEmail(email);
      if (existingUser.isNotEmpty) {
        print("Hata: Bu e-posta adresi zaten kullanılıyor.");
        return null;
      }

      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestore.collection("Person").doc(user.user?.uid).set({
        'username': username,
        'email': email,
      });
      return user.user;
    } catch (e) {
      print("Hata: Kayıt işlemi başarısız oldu: $e");
      return null;
    }
  }
}