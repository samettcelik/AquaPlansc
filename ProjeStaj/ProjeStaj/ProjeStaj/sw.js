const CACHE_NAME = 'botas-cache-v1';
const urlsToCache = [
    '/',
    '/Home/KayitOl',
    '/Home/Index',
    '/Home/UrunEkle',
    '/Images/Botaslogo.png',
    '/Images/kayitol.png',
    '/sw.js',
];

const MAX_CACHE_AGE = 7 * 24 * 60 * 60; // 7 gün saniye cinsinden

self.addEventListener('install', (event) => {
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then((cache) => cache.addAll(urlsToCache))
            .then(() => self.skipWaiting())
    );
});

self.addEventListener('activate', (event) => {
    event.waitUntil(
        caches.keys().then((cacheNames) => {
            return Promise.all(
                cacheNames.map((cacheName) => {
                    if (cacheName !== CACHE_NAME) {
                        return caches.delete(cacheName);
                    }
                })
            );
        })
    );
});

self.addEventListener('fetch', (event) => {
    event.respondWith(
        caches.match(event.request)
            .then((response) => {
                if (response) {
                    // Önbelleğe alınmış yanıtın 7 günden eski olup olmadığını kontrol edin
                    const cacheAge = Date.now() - new Date(response.headers.get('date')).getTime();
                    if (cacheAge > MAX_CACHE_AGE) {
                        // Eğer önbelleğe alınmış yanıt 7 günden eskiyse, ağından yeni bir kopyayı getirin ve önbelleğe alın
                        return fetchAndCache(event.request);
                    }
                    return response;
                }
                return fetchAndCache(event.request);
            })
            .catch((error) => {
                // Eğer ağda bağlantı sorunu varsa, önbellekte uygun bir yanıt arayın
                return caches.match(event.request)
                    .then((response) => {
                        if (response) {
                            return response;
                        }
                        // Ağda yanıt yoksa, '/' yani ana sayfaya yönlendir
                        return caches.match('/');
                    });
            })
    );
});

function fetchAndCache(request) {
    // Sadece GET isteklerini önbelleğe alın
    if (request.method !== 'GET') {
        return fetch(request);
    }

    return fetch(request)
        .then((response) => {
            if (!response || response.status !== 200 || response.type !== 'basic') {
                // Başarılı, temel bir yanıt değilse (örn. CSS, JS dosyaları değilse) yanıtı önbelleğe almayın
                return response;
            }

            const responseToCache = response.clone();

            caches.open(CACHE_NAME)
                .then((cache) => {
                    cache.put(request, responseToCache);
                });

            return response;
        });
}

            