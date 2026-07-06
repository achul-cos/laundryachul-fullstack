# Mewing Laundry - Aplikasi Manajemen Laundry

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue)
![Dart](https://img.shields.io/badge/Dart-3.x-blue)
![License](https://img.shields.io/badge/License-MIT-green)

## 📋 Deskripsi Proyek

**Mewing Laundry** adalah aplikasi mobile untuk manajemen bisnis laundry yang dikembangkan menggunakan **Flutter** dengan state management **Provider**. Aplikasi ini menampilkan fitur autentikasi, dashboard, dan sistem CRUD data pelanggan yang terintegrasi dengan state lokal.

Ini adalah Branch "Intergration-With-Backend"

> ⚠️ **CATATAN PENTING:** Proyek ini adalah hasil pengerjaan singkat (5 jam) untuk keperluan **Tes Magang** pada posisi **Intern Developer** di **PT. Piposmart Digital Indonesia**. Proyek dirancang untuk mendemonstrasikan pemahaman dasar tentang Flutter development, state management, dan UI/UX design yang responsif.

---

## 🎯 Fitur Utama

✅ **Autentikasi Pengguna**
- Login dengan email dan password
- Validasi form input
- Session management dengan state lokal
- Logout dengan konfirmasi

✅ **Dashboard**
- Greeting pengguna dengan nama dan role
- 4 kartu statistik (Pendapatan Bersih, Penjualan, Pengeluaran, Pendapatan Kotor)
- Grid menu navigasi 8 item
- Responsive layout dengan material design

✅ **Manajemen Pelanggan (CRUD)**
- **Create:** Tambah pelanggan baru via modal form
- **Read:** List view pelanggan dengan data dummy
- **Update:** Edit informasi pelanggan
- **Delete:** Hapus pelanggan dengan konfirmasi
- **Search:** Cari pelanggan berdasarkan nama
- **Filter:** Filter status pelanggan (dummy)

✅ **Halaman Akun**
- Informasi profil pengguna
- Menu settings (Profil, Ganti Password, Tentang, Privacy, Contact)
- Tombol logout

---

## 🛠️ Tech Stack

| Aspek | Teknologi |
|-------|-----------|
| **Frontend** | Flutter 3.x (Dart) |
| **State Management** | Provider |
| **Data Storage** | Local (In-Memory) |
| **UI Framework** | Material Design 3 |
| **Testing** | Flutter Web (Chrome) |

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0          # State management
  intl: ^0.19.0             # Internationalization & formatting
  uuid: ^4.0.0              # Generate unique IDs
```

---

## 🚀 Cara Instalasi & Setup

### Prerequisites
- **Flutter SDK** versi 3.x ke atas
- **Dart SDK** (included dengan Flutter)
- **Chrome** browser (untuk testing Flutter Web)
- **VS Code** atau editor lainnya (recommended)
- **Git** (untuk version control)

### Langkah 1: Clone / Download Proyek

```bash
# Via Git
git clone <repository-url>
cd laundry_app

# Atau jika download ZIP
# Extract file, buka folder di terminal
cd laundry_app
```

### Langkah 2: Install Dependencies

```bash
# Get all pub packages
flutter pub get
```

### Langkah 3: Jalankan Aplikasi (Flutter Web)

```bash
# Run di Chrome browser
flutter run -d chrome

# Atau run di web secara umum
flutter run -d web
```

> 💡 **Tip:** Aplikasi akan auto-reload saat kamu edit kode (Hot Reload). Tekan `r` di terminal untuk manual reload.

### Langkah 4: Build untuk Production (Opsional)

```bash
# Build untuk web
flutter build web

# Output berada di: build/web/
# Bisa di-deploy ke hosting (Firebase Hosting, Netlify, dll)
```

---

## 📂 Struktur Project

```
laundry_app/
├── lib/
│   ├── main.dart                          # Entry point aplikasi
│   ├── models/
│   │   ├── user_model.dart               # Model User
│   │   └── customer_model.dart           # Model Customer
│   ├── providers/
│   │   ├── auth_provider.dart            # Auth state management
│   │   ├── user_provider.dart            # User data state
│   │   └── customer_provider.dart        # Customer CRUD state
│   └── screens/
│       ├── login_screen.dart             # Login page
│       ├── dashboard_screen.dart         # Dashboard & home
│       ├── customer_list_screen.dart     # Customer list view
│       ├── customer_form_screen.dart     # Add/Edit customer
│       └── account_screen.dart           # User account settings
├── pubspec.yaml                           # Dependencies config
├── pubspec.lock                           # Lock file
├── README.md                              # File ini
└── build/                                 # Build output (auto-generated)
```

---

## 🔐 Default Credentials

Gunakan data dummy berikut untuk test login:

Email:    admin@laundry.com
Password: password

> ℹ️ Credentials ini hardcoded untuk keperluan demo/testing. Pada production, gunakan backend authentication yang proper.

---

## 🧪 Cara Testing Aplikasi

### Test di Browser (Flutter Web)

1. Jalankan: `flutter run -d chrome`
2. Aplikasi terbuka di `localhost:5000`
3. **Test Login:**
   - Masukkan email: `admin@laundry.com`
   - Masukkan password: `password`
   - Klik "Login"
   - Harusnya masuk ke Dashboard

4. **Test Dashboard:**
   - Lihat header merah dengan greeting
   - Lihat 4 kartu statistik dummy
   - Lihat grid menu 8 item
   - Bottom navigation: Beranda, Pelanggan, Akun

5. **Test CRUD Pelanggan:**
   - Klik tab "Pelanggan"
   - **Add:** Klik tombol `+` → isi form → Klik "Tambah"
   - **List:** Lihat customer muncul di list
   - **Edit:** Klik icon edit (pensil) → ubah data → Klik "Perbarui"
   - **Delete:** Klik icon delete (tempat sampah) → confirm → Klik "Hapus"
   - **Search:** Ketik nama di search box → list filter

6. **Test Akun:**
   - Klik tab "Akun"
   - Lihat profil user
   - Klik menu items (optional, beberapa menampilkan dummy message)
   - Klik "Keluar" → confirm logout → balik ke Login

7. **Test Validasi Form:**
   - Login: Coba kosongkan field atau email tanpa `@` → error validation muncul
   - Customer form: Coba submit tanpa nama → error validation muncul

---

## 📱 Responsive Design

Aplikasi dioptimalkan untuk berbagai ukuran layar:

| Device | Support |
|--------|---------|
| 📱 Mobile (360px - 600px) | ✅ Full |
| 📱 Tablet (600px - 900px) | ✅ Full |
| 💻 Desktop (900px+) | ✅ Optimized |
| 🌐 Flutter Web | ✅ Full |

---

## 🎨 Design & UI

- **Color Theme:** Red (#C8102E) primary, White background, Gray accents
- **Typography:** Bold titles, readable body text
- **Icons:** Material Design Icons
- **Components:** Forms, Cards, BottomNavigationBar, AlertDialogs, FloatingActionButton

---

## 🔄 State Management Flow

```
┌─────────────────────────────────────────────┐
│           MultiProvider Setup               │
├─────────────────────────────────────────────┤
│                                             │
│  AuthProvider (Login/Logout)                │
│  ├─ user: User?                             │
│  └─ isLoggedIn: bool                        │
│                                             │
│  UserProvider (Business Data)               │
│  ├─ businessName: String                    │
│  ├─ revenue, sales, expense: double         │
│  └─ formatRupiah(): String                  │
│                                             │
│  CustomerProvider (CRUD Local)              │
│  ├─ customers: List<Customer>               │
│  ├─ addCustomer()                           │
│  ├─ updateCustomer()                        │
│  ├─ deleteCustomer()                        │
│  ├─ setSearchQuery()                        │
│  └─ setFilterStatus()                       │
│                                             │
└─────────────────────────────────────────────┘
```

---

## 💾 Data Persistence

> **Catatan:** Aplikasi ini menggunakan **in-memory storage** (state lokal). Data customer akan **hilang** saat aplikasi ditutup atau di-refresh.

Untuk production dengan persistence, implementasikan:
- SQLite / Hive (local database)
- Backend API (Golang, Node.js, etc)
- Cloud Firestore / Supabase

---

## 🐛 Known Limitations & Future Improvements

### Current Limitations
- ❌ Data tidak persist (hilang saat refresh)
- ❌ Tidak ada backend API integration
- ❌ Fitur menu (Pesanan, Layanan, dll) belum fully implemented
- ❌ Tidak ada dark mode
- ❌ Tidak ada push notification
- ❌ Tidak ada unit/integration testing

### Future Improvements (Jika Lanjut)
- ✨ Integrasi backend Golang + REST API
- ✨ Database MySQL/PostgreSQL dengan migration
- ✨ Role-Based Access Control (RBAC)
- ✨ Refresh token & JWT expiry handling
- ✨ Dark mode theme
- ✨ Push notification
- ✨ Unit & integration testing
- ✨ Docker containerization
- ✨ CI/CD pipeline

---

## 📸 Screenshot Aplikasi

### Login Screen

(coming soon)

### Dashboard

(coming soon)

### Customer List

(coming soon)

---

## 🔗 Git Repository

Pastikan push project ke repository:

```bash
# Initialize git (jika belum)
git init

# Add all files
git add .

# First commit
git commit -m "Initial commit: Mewing Laundry app - Flutter test project"

# Add remote & push
git remote add origin <your-repo-url>
git branch -M main
git push -u origin main
```

---

## 📝 Catatan Pengembang

### Mengapa Choice Ini?

1. **Provider untuk State Management:**
   - Simple, mudah dipelajari pemula
   - Less boilerplate vs Bloc/GetX
   - Perfect untuk proyek kecil

2. **Flutter Web untuk Testing:**
   - Nggak perlu setup emulator Android (hemat waktu)
   - Chrome browser universally available
   - Hot reload bekerja dengan baik

3. **In-Memory Storage:**
   - Fokus pada UI/UX & logic
   - Hemat waktu setup database
   - Cukup untuk demo/test project

4. **Material Design 3:**
   - Modern, konsisten, accessible
   - Built-in di Flutter

### Performance Considerations

- App ringan (~5 screens)
- No network calls = instant UI response
- In-memory state = fast CRUD operations
- Responsive design work well di berbagai screen sizes

---

## 📞 Kontak & Info Tambahan

**Proyek untuk:** PT. Piposmart Digital Indonesia  
**Posisi:** Intern Developer  
**Tujuan:** Technical Assessment - Flutter & State Management  
**Durasi Pengerjaan:** ~5 jam (one-day sprint)  
**Developer:** [Your Name]  
**Tanggal:** [Date]

---

## 📄 License

MIT License - Free to use for educational & commercial purposes.

---

## ✅ Checklist Development

- [x] Setup Flutter project & dependencies
- [x] Create models (User, Customer)
- [x] Implement providers (Auth, User, Customer)
- [x] Build login screen dengan validasi
- [x] Build dashboard dengan stats & menu grid
- [x] Build customer CRUD (list, add, edit, delete)
- [x] Build search & filter functionality
- [x] Build account screen dengan logout
- [x] Responsive layout untuk multiple screen sizes
- [x] Error handling & loading states
- [x] Testing di Flutter Web (Chrome)
- [x] README documentation

---

**Last Updated:** 2026-07-06  
**Status:** ✅ Complete & Tested
