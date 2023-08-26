import 'package:flutter/material.dart';
import 'package:mobil_projesi/Comm/comHelper.dart';
import 'package:mobil_projesi/KayitEkrani.dart';
import 'package:mobil_projesi/auth.dart';
import 'package:mobil_projesi/color_utils.dart';
import 'package:mobil_projesi/Comm/getTextFormField.dart';
import 'package:mobil_projesi/UrunEkle.dart';


class GirisEkrani extends StatefulWidget {
  const GirisEkrani({Key? key}) : super(key: key);

  @override
  _GirisEkraniState createState() => _GirisEkraniState();
}
class _GirisEkraniState extends State<GirisEkrani> {
  final _formKey = new GlobalKey<FormState>();
  final _conmail = TextEditingController();
  final _conpassword = TextEditingController();
  AuthService _authService = AuthService();



  void girisYap() async {
    String em = _conmail.text;
    String pass = _conpassword.text;

    if (em.isEmpty || pass.isEmpty) {
      alertDialog(context, 'E-Posta ve Şifre alanları zorunludur.');
      return;
    }

    _authService.girisYap(em, pass).then((user) {
      if (user != null) {
        // Giriş başarılı, ana sayfaya yönlendir
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => UrunEkle()),
          // Değiştirilecek sayfa
              (Route<dynamic> route) => false,
        );
      }
    }).catchError((error) {
      print(error);
      alertDialog(context, "Hata : Giriş Hatası");
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("#F5F5F5"),
              hexStringToColor("#F5FEFD"),
              hexStringToColor("#FAEBD7"),
            ],
            begin: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, MediaQuery.of(context).size.height * 0.1, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assests/images/botasslogo.png"),
                SizedBox(height: 5.0,),
                getTextFormField(
                  controller: _conmail,
                  hintName: 'E-posta',
                  icon: Icons.person,
                  isObscureText: false,
                ),
                SizedBox(height: 5.0,),
                getTextFormField(
                  controller: _conpassword,
                  hintName: 'Şifre',
                  icon: Icons.lock,
                  isObscureText: true,
                ),
                SizedBox(height: 5.0,),
                InkWell(
                  onTap: girisYap, // Düzeltildi, metodun çağrısını burada yapın
                  child: Container(
                    margin: EdgeInsets.all(20.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[700],
                        onPrimary: Colors.grey,
                        elevation: 0.0,
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text('Giriş Yap'),
                      onPressed: null, // null olarak bırakın, butonun aktif olmasını sağlamak için onTap kullanıyoruz
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hesabınız yok mu ?    ",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                          onPrimary: Colors.white,
                          elevation: 0.0,
                        ),
                        child: Text('Kayıt Ol'),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => KayitEkrani()));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 120,
    height: 150,
    color: Colors.red,
  );
}
