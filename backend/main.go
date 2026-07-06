// @title Mewing Laundry API
// @version 1.0
// @description API untuk manajemen laundry - Flutter Test Project
// @host localhost:8080
// @basePath /api

package main

import (
	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"time"
	"github.com/golang-jwt/jwt/v5"
	// "net/http"
	"strings"
	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
	_ "laundryachul-backend/docs"	
)

// ============= MODELS =============
type User struct {
	ID       int    `gorm:"primaryKey"`
	Email    string `gorm:"unique"`
	Password string
	Name     string
	Role     string
}

type Customer struct {
	ID        int       `gorm:"primaryKey"`
	Name      string
	Phone     string
	Address   string
	Email     string
	CreatedAt time.Time
}

// ============= GLOBAL DB =============
var DB *gorm.DB

// ============= JWT SECRET =============
const JWT_SECRET = "mewing_laundry_secret_key_12345"

// ============= UTILS =============
func GenerateToken(userID int, email string) string {
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"user_id": userID,
		"email":   email,
		"exp":     time.Now().Add(24 * time.Hour).Unix(),
	})
	tokenString, _ := token.SignedString([]byte(JWT_SECRET))
	return tokenString
}

func ValidateToken(tokenString string) (int, string, bool) {
	token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
		return []byte(JWT_SECRET), nil
	})

	if err != nil || !token.Valid {
		return 0, "", false
	}

	claims := token.Claims.(jwt.MapClaims)
	userID := int(claims["user_id"].(float64))
	email := claims["email"].(string)
	return userID, email, true
}

func RespondJSON(c *gin.Context, success bool, statusCode int, message string, data interface{}) {
	if data == nil {
		data = gin.H{}
	}
	c.JSON(statusCode, gin.H{
		"success": success,
		"message": message,
		"data":    data,
	})
}

// ============= HANDLERS =============
// LOGIN

// @Summary Login pengguna
// @Description Login dengan email dan password, return JWT token
// @Tags Auth
// @Accept json
// @Produce json
// @Param request body object true "Login request"
// @Success 200 {object} object "Login berhasil"
// @Failure 401 {object} object "Email atau password salah"
// @Router /login [post]
func Login(c *gin.Context) {
	var req struct {
		Email    string `json:"email" binding:"required,email"`
		Password string `json:"password" binding:"required"`
	}

	if err := c.ShouldBindJSON(&req); err != nil {
		RespondJSON(c, false, 400, "Email dan password harus diisi", nil)
		return
	}

	var user User
	if err := DB.Where("email = ?", req.Email).First(&user).Error; err != nil {
		RespondJSON(c, false, 401, "Email atau password salah", nil)
		return
	}

	if err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(req.Password)); err != nil {
		RespondJSON(c, false, 401, "Email atau password salah", nil)
		return
	}

	token := GenerateToken(user.ID, user.Email)
	RespondJSON(c, true, 200, "Login berhasil", gin.H{
		"token": token,
		"user": gin.H{
			"id":    user.ID,
			"name":  user.Name,
			"email": user.Email,
			"role":  user.Role,
		},
	})
}

// LOGOUT (dummy, just return success)
func Logout(c *gin.Context) {
	RespondJSON(c, true, 200, "Logout berhasil", nil)
}

// GET CUSTOMERS

// @Summary Dapatkan daftar pelanggan
// @Security ApiKeyAuth
// @Tags Customers
// @Accept json
// @Produce json
// @Success 200 {object} object "Berhasil mengambil data"
// @Failure 401 {object} object "Token tidak valid"
// @Router /customers [get]
func GetCustomers(c *gin.Context) {
	var customers []Customer
	DB.Find(&customers)
	RespondJSON(c, true, 200, "Berhasil mengambil data", gin.H{
		"customers": customers,
		"total":     len(customers),
	})
}

// GET CUSTOMER DETAIL
func GetCustomerDetail(c *gin.Context) {
	id := c.Param("id")
	var customer Customer
	if err := DB.First(&customer, id).Error; err != nil {
		RespondJSON(c, false, 404, "Pelanggan tidak ditemukan", nil)
		return
	}
	RespondJSON(c, true, 200, "Berhasil mengambil detail", customer)
}

// ADD CUSTOMER

// @Summary Tambah pelanggan baru
// @Security ApiKeyAuth
// @Tags Customers
// @Accept json
// @Produce json
// @Param request body object true "Customer data"
// @Success 201 {object} object "Pelanggan berhasil ditambahkan"
// @Failure 400 {object} object "Data tidak valid"
// @Router /customers [post]
func AddCustomer(c *gin.Context) {
	var req struct {
		Name    string `json:"name" binding:"required"`
		Phone   string `json:"phone" binding:"required"`
		Address string `json:"address" binding:"required"`
		Email   string `json:"email" binding:"required,email"`
	}

	if err := c.ShouldBindJSON(&req); err != nil {
		RespondJSON(c, false, 400, "Data tidak valid", nil)
		return
	}

	customer := Customer{
		Name:      req.Name,
		Phone:     req.Phone,
		Address:   req.Address,
		Email:     req.Email,
		CreatedAt: time.Now(),
	}

	if err := DB.Create(&customer).Error; err != nil {
		RespondJSON(c, false, 500, "Gagal menambah pelanggan", nil)
		return
	}

	RespondJSON(c, true, 201, "Pelanggan berhasil ditambahkan", customer)
}

// UPDATE CUSTOMER

// @Summary Update pelanggan
// @Security ApiKeyAuth
// @Tags Customers
// @Accept json
// @Produce json
// @Param id path int true "Customer ID"
// @Param request body object true "Updated customer data"
// @Success 200 {object} object "Pelanggan berhasil diperbarui"
// @Failure 404 {object} object "Pelanggan tidak ditemukan"
// @Router /customers/{id} [put]
func UpdateCustomer(c *gin.Context) {
	id := c.Param("id")
	var req struct {
		Name    string `json:"name"`
		Phone   string `json:"phone"`
		Address string `json:"address"`
		Email   string `json:"email"`
	}

	if err := c.ShouldBindJSON(&req); err != nil {
		RespondJSON(c, false, 400, "Data tidak valid", nil)
		return
	}

	var customer Customer
	if err := DB.First(&customer, id).Error; err != nil {
		RespondJSON(c, false, 404, "Pelanggan tidak ditemukan", nil)
		return
	}

	DB.Model(&customer).Updates(req)
	RespondJSON(c, true, 200, "Pelanggan berhasil diperbarui", customer)
}

// DELETE CUSTOMER

// @Summary Delete pelanggan
// @Security ApiKeyAuth
// @Tags Customers
// @Accept json
// @Produce json
// @Param id path int true "Customer ID"
// @Success 200 {object} object "Pelanggan berhasil dihapus"
// @Failure 404 {object} object "Pelanggan tidak ditemukan"
// @Router /customers/{id} [delete]
func DeleteCustomer(c *gin.Context) {
	id := c.Param("id")
	var customer Customer
	if err := DB.First(&customer, id).Error; err != nil {
		RespondJSON(c, false, 404, "Pelanggan tidak ditemukan", nil)
		return
	}

	DB.Delete(&customer)
	RespondJSON(c, true, 200, "Pelanggan berhasil dihapus", nil)
}

// ============= MIDDLEWARE =============
func AuthMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		authHeader := c.GetHeader("Authorization")
		if authHeader == "" {
			RespondJSON(c, false, 401, "Token tidak ditemukan", nil)
			c.Abort()
			return
		}

		tokenString := strings.TrimPrefix(authHeader, "Bearer ")
		userID, email, valid := ValidateToken(tokenString)

		if !valid {
			RespondJSON(c, false, 401, "Token tidak valid", nil)
			c.Abort()
			return
		}

		c.Set("user_id", userID)
		c.Set("email", email)
		c.Next()
	}
}

// ============= INIT DATABASE =============
func InitDB() {
	dsn := "root:root@tcp(127.0.0.1:3306)/laundry_db?charset=utf8mb4&parseTime=True&loc=Local"
	var err error
	DB, err = gorm.Open(mysql.Open(dsn), &gorm.Config{})
	if err != nil {
		panic("Gagal connect ke database: " + err.Error())
	}

	// Auto migrate
	DB.AutoMigrate(&User{}, &Customer{})

	// Seed admin user jika belum ada
	var userCount int64
	DB.Model(&User{}).Count(&userCount)
	if userCount == 0 {
		hashedPassword, _ := bcrypt.GenerateFromPassword([]byte("password"), bcrypt.DefaultCost)
		adminUser := User{
			Email:    "admin@laundry.com",
			Password: string(hashedPassword),
			Name:     "Mario Wicaksono",
			Role:     "Owner",
		}
		DB.Create(&adminUser)

		// Seed 3 customers
		customers := []Customer{
			{Name: "Budi Santoso", Phone: "081234567890", Address: "Jl. Merdeka No. 10", Email: "budi@email.com", CreatedAt: time.Now()},
			{Name: "Siti Nurhaliza", Phone: "082345678901", Address: "Jl. Ahmad Yani No. 25", Email: "siti@email.com", CreatedAt: time.Now()},
			{Name: "Ahmad Suryanto", Phone: "083456789012", Address: "Jl. Gatot Subroto No. 5", Email: "ahmad@email.com", CreatedAt: time.Now()},
		}
		for _, c := range customers {
			DB.Create(&c)
		}
	}
}

// ============= MAIN =============
func main() {
	InitDB()

	router := gin.Default()

	// CORS
	router.Use(func(c *gin.Context) {
		c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
		c.Writer.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
		c.Writer.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")
		if c.Request.Method == "OPTIONS" {
			c.AbortWithStatus(204)
			return
		}
		c.Next()
	})

	// Public routes
	router.POST("/api/login", Login)
	router.POST("/api/logout", Logout)

	// Protected routes (require JWT)
	protected := router.Group("/api")
	protected.Use(AuthMiddleware())
	{
		protected.GET("/customers", GetCustomers)
		protected.GET("/customers/:id", GetCustomerDetail)
		protected.POST("/customers", AddCustomer)
		protected.PUT("/customers/:id", UpdateCustomer)
		protected.DELETE("/customers/:id", DeleteCustomer)
	}

	// Swagger route
	router.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))

	// Run
	router.Run(":8080")
}