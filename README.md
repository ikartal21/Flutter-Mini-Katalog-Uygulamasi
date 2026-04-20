<img width="313" height="690" alt="Ekran görüntüsü 2026-04-20 225943" src="https://github.com/user-attachments/assets/8a540840-03c7-48e8-aeff-6fc2bc883d67" />


# Mini Katalog Uygulamasi

## Proje Adi
Mini Katalog Uygulamasi

## Kisa Aciklama
Bu proje, Flutter ile gelistirilmis basit bir mini e-ticaret/katalog uygulamasidir.
Uygulamada urunler JSON verisinden okunur, liste halinde gosterilir, urun detaylari
incelenir ve urun sepete eklenebilir.

## Kullanilan Flutter Surumu
- Flutter: 3.41.7 (stable)
- Dart: 3.11.5

## Calistirma Adimlari
1. Proje klasorune girin:
	```bash
	cd mini_katalog_uygulamasi
	```
2. Bagimliliklari yukleyin:
	```bash
	flutter pub get
	```
3. Mevcut cihazlari/emulatorleri kontrol edin:
	```bash
	flutter devices
	```
4. Android emulatoru baslatin (gerekirse):
	```bash
	flutter emulators --launch Pixel_9_Pro
	```
5. Uygulamayi emulator/cihazda calistirin:
	```bash
	flutter run -d emulator-5554
	```

Not: Windows'ta proje yolu Turkce karakter iceriyorsa Android build araclari hata verebilir.
Bu durumda projeyi ASCII bir yol uzerinden (or. `C:\dev\mini_katalog_uygulamasi`) calistirmak daha sagliklidir.
