import 'package:flutter/material.dart';
hexStringToColor(String hexColor){ //Fonksiyonun başladığı satır , string alıyor
  hexColor = hexColor.toUpperCase().replaceAll("#", ""); //Gelen hex renk kodunu büyük harfe çevirir (uppercase) ve içindeki "#" sembolünü çıkarır.
  if(hexColor.length ==6){
    hexColor = "FF" + hexColor;
  } /*Eğer hex renk kodunun uzunluğu 6 ise (yani hex kodu "RRGGBB" formatındaysa),
   başına "FF" ekleyerek "AARRGGBB" formatına dönüştürülür. Buradaki "AA" alfa kanalını temsil eder
   ve genellikle opaklık ayarları için kullanılır*/
  return Color(int.parse(hexColor,radix: 16)); //Oluşturulan hex renk kodunu onaltılı (hexadecimal) formatta ondalık bir sayıya çevirir ve Color nesnesi döndürür.
}