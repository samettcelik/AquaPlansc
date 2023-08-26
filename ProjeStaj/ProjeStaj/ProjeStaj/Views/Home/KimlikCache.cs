using System.Collections.Generic;

public static class KimlikCache
{
    private static Dictionary<string, string> kimlik = new Dictionary<string, string>();

    public static void CacheKimlik(string email, string sifre)
    {
        // Geçerli email ve şifre değerleri olup olmadığını kontrol edin
        if (!string.IsNullOrEmpty(email) && !string.IsNullOrEmpty(sifre))
        {
            // Giriş kimlik bilgilerini ön bellekte sakla
            kimlik[email] = sifre;
        }
    }
    public static bool KimlikBilgileriGecerliMi(string email, string sifre)
    {
        // E-posta ön bellekte var mı? Şifre eşleşiyor mu? Kontrol edelim.
        return kimlik.TryGetValue(email, out string depoSifre) && depoSifre == sifre;
    }
}
s