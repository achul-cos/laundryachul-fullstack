# 🚀 Mewing Laundry - Full Stack Application

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue)
![Go](https://img.shields.io/badge/Go-1.21+-blue)
![MySQL](https://img.shields.io/badge/MySQL-8.0+-blue)

**Complete laundry management system** dengan Flutter frontend & Golang backend.

> ⚠️ **TEST PROJECT:** Dikembangkan dalam 5 jam untuk keperluan technical assessment Intern Developer di PT. Piposmart Digital Indonesia.

---

## 📁 Project Structure

```
laundryachul-fullstack/
├── frontend/        # Flutter app (Provider state management)
├── backend/         # Golang API (Gin + MySQL + JWT)
└── README.md        # File ini
```

---

## 🎯 Features

✅ **Frontend (Flutter)**
- Login screen dengan form validation
- Dashboard dengan statistik & menu grid
- Customer CRUD (add/edit/delete/search)
- Account screen dengan logout
- Responsive Material Design 3
- Provider state management

✅ **Backend (Golang)**
- JWT authentication
- Customer CRUD REST API
- MySQL database
- Swagger documentation
- Password hashing (bcrypt)
- CORS support

✅ **Integration**
- Frontend login → call backend API
- JWT token management
- Error handling

---

## 🚀 Quick Start

### Frontend (Flutter)

```bash
cd frontend
flutter pub get
flutter run -d chrome
```

Buka: `http://localhost:5000`

### Backend (Golang)

```bash
cd backend
go run main.go
```

Server: `http://localhost:8080`  
Swagger Docs: `http://localhost:8080/swagger/index.html`

---

## 📚 Documentation

- **[Frontend README](./frontend/README.md)** - Flutter app docs
- **[Backend README](./backend/README.md)** - API & setup

---

## 🔐 Test Credentials

Email:    admin@laundry.com
Password: password

---

## 📋 Deliverables

✅ Source code (frontend & backend)  
✅ README documentation lengkap  
✅ Database schema  
✅ API Swagger documentation  
✅ Git repository terstruktur  
✅ Error handling & validation  
✅ Security: JWT + bcrypt  

---

## ⏱️ Development Timeline

- **Total:** ~5 jam one-day sprint
- **Frontend:** ~2.5 jam (Flutter setup + screens + state management)
- **Backend:** ~2.5 jam (Go setup + API + database + Swagger)
- **Integration:** ~0.5 jam (Backend-frontend connection)

---

## 🔄 Future Integration Steps

Untuk fully integrate customer CRUD dengan backend:

1. Buat `api_customer_service.dart` di frontend
2. Update `CustomerProvider` untuk call backend endpoints
3. Add pagination & search queries
4. Implement token refresh logic
5. Add offline sync capability

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | Flutter (Dart) + Provider |
| Backend | Go + Gin + GORM |
| Database | MySQL |
| API Docs | Swagger/OpenAPI |
| Auth | JWT + bcrypt |
| Version Control | Git |

---

## 📞 Project Info

**For:** PT. Piposmart Digital Indonesia  
**Position:** Intern Developer - Technical Assessment  
**Status:** ✅ Complete & Tested  
**Date:** July 6, 2026

---
