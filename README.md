# Harry Potter App

Aplikasi Flutter untuk menjelajahi karakter Harry Potter dan sihir-sihir dari API Potter.

## Fitur

### 1. **Login View** (20 pts)

- Login menggunakan username dan password (hardcoded)
- Session disimpan dengan Shared Preferences
- Snackbar notifikasi untuk login berhasil/gagal
- Demo credentials:
  - Username: `harrypotter`
  - Password: `password123`

### 2. **Character View & Detail** (20 pts)

- Menampilkan list karakter dari API
- API: https://potterapi-fedeperin.vercel.app/en/characters
- Klik item untuk melihat detail lengkap karakter
- Menampilkan semua property karakter (nama, house, patronus, aktor, dll)

### 3. **Spells View** (20 pts)

- Menampilkan list spell dari API
- API: https://potterapi-fedeperin.vercel.app/en/spells
- Tombol favorite untuk toggle ke Hive storage
- Snackbar notifikasi saat toggle favorite

### 4. **Favorite Spells View** (20 pts)

- Menampilkan spell yang telah difavoritkan
- Dapat menghapus favorite dari halaman ini
- Immediate Notifications saat menghapus spell

### 5. **Logout** (20 pts)

- Tombol logout di AppBar halaman Character dan Spells
- Kembali ke halaman login dengan snackbar notifikasi

### 6. **State Management**

- Menggunakan **GetX** untuk state management
- Clean architecture dengan folder separation

## Teknologi & Package

- **Flutter** - Framework UI
- **GetX** - State management dan routing
- **http** - HTTP requests untuk API calls
- **shared_preferences** - Session storage
- **hive** & **hive_flutter** - Local database untuk favorites
- **flutter_local_notifications** - Immediate notifications

## Project Structure

```
lib/
├── main.dart                          # Entry point
├── controllers/                       # GetX Controllers
│   ├── auth_controller.dart
│   ├── character_controller.dart
│   └── spell_controller.dart
├── models/                            # Data models
│   ├── character_model.dart
│   └── spell_model.dart
├── services/                          # Services
│   ├── api_service.dart
│   ├── local_storage_service.dart
│   └── notification_service.dart
├── views/                             # UI Screens
│   ├── login_view.dart
│   ├── character_view.dart
│   ├── character_detail_view.dart
│   ├── spell_view.dart
│   └── favorite_spell_view.dart
├── routes/                            # Navigation
│   ├── app_routes.dart
│   └── app_pages.dart
└── widgets/                           # Reusable widgets
    ├── custom_button.dart
    └── custom_text_field.dart
```

## Setup & Running

1. **Clone atau buka project**

   ```bash
   cd latres
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run project**
   ```bash
   flutter run
   ```

## Authentication

Gunakan credentials demo untuk testing:

- **Username**: `harrypotter`
- **Password**: `password123`

## API Integration

### Characters

```
GET https://potterapi-fedeperin.vercel.app/en/characters
```

### Spells

```
GET https://potterapi-fedeperin.vercel.app/en/spells
```

## Local Storage

- **Shared Preferences**: Menyimpan login session
- **Hive**: Menyimpan spell favorit dengan database lokal

## Notifications

Menggunakan Flutter Local Notifications untuk immediate notifications saat menghapus favorite spell.

## Requirements

- Flutter SDK >= 3.11.5
- Dart >= 3.11.5
- Android SDK (untuk Android)
- Xcode (untuk iOS)

## Notes

- Aplikasi menggunakan GetX untuk state management
- Semua komunikasi API dilakukan asynchronously
- Data favorit persisten menggunakan Hive database
- Session login tersimpan dalam Shared Preferences
