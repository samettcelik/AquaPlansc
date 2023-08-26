using System;
using System.Web.Mvc;
public class YController : Controller
{
    // Kontrol Hareketleri

    [HttpPost]
    public ActionResult Giris(string email, string sifre)
    {
        if (KimlikCache.KimlikBilgileriGecerliMi(email, sifre))
        {
            // Başarılı Giriş Durumu
            // Ana sayfaya yönlendir
            return RedirectToAction("Index", "Home");
        }
        else
        {
            // Hatalı giriş durumu, hata mesajı göster
            ViewBag.ErrorMessage = "Geçersiz e-posta veya şifre. Lütfen tekrar deneyin.";
            return View();
        }
    }

}