# **PRAKTIKUM MCS BAB 6**

## _CARD BRIDGE_ (_BACKEND_ - GOLANG)
***
Pada praktikum MCS bab 6, praktikan akan belajar tentang bagaimana caranya membangun RESTFUL API sebuah aplikasi backend yang menjadi penghubung antara end user dengan Internet of Things (IoT). Server menjadi connector antara aplikasi android mobile dan IOT yang dibangun berbasis Uniform Resource Locator (URL). Pada praktikum kali ini, server akan berperan sebagai database untuk menyimpan nilai id yang dihasilkan dari RFID.


### **6.1 TUJUAN PRAKTIKUM**
| TUJUAN | PENJELASAN |
| ------ | ------------- |
| Memberikan penjelasan tentang bagaimana pengguna terhubung ke server. | Memberikan gambaran umum mengenai alur saat user melakukan koneksi ke dalam server |
| Membangun database dengan bahasa pemrograman Golang | Dalam bab ini, praktikan akan diajarkan cara membuat sebuah database dengan menggunakan bahasa pemrograman Golang |
| Melakukan migrasi database dengan Golang | Dalam bab ini, praktikan akan diajarkan bagaimana caranya melakukan migrasi ke Postgre SQL database menggunakan bahasa Golang |
***

### **6.2 PERSYARATAN PRAKTIKUM**
Disarankan praktikan menggunakan hardware dan software sesuai pada dokumentasi ini. Apabila terdapat versi yang lumayan lampau dari versi yang direkomendasikan atau hardware yang lawas maka sebaiknya bertanya kepada Asisten mengajar shift.

| HARDWARE YANG DIBUTUHKAN | JENIS |
| --------- | ------------- |
| PC / LAPTOP CPU | ≥ 4 CORES |
| PC / LAPTOP RAM | ≥ 8 GB |
| PC / LAPTOP STORAGE | ≥ 10 GB |
<br>

| SOFTWARE YANG DIBUTUHKAN | PENGGUNAAN |
| --------- | ------------- |
| Android Studio / Visual Studio Code | Code editor untuk pengembangan aplikasi menggunakan Flutter |
| Postgre SQL | Database untuk menyimpan data dari RFID dan servo |
| Postman | Software untuk pengujian dan pengelolaan data API |
***

### **6.3 MATERI PRAKTIKUM**
Pada bab ini aplikasi backend yang akan dibangun menggunakan bahasa pemrograman Go dengan framework yang bernama Gin. Adapun dari sisi IoT menggunakan microcontroller ESP32 dan sensor Radio Frequency Identification (RFID). Setiap kartu yang dibaca oleh RFID akan masuk ke server kemudian data kartu yang ada di server akan dibaca oleh aplikasi Android. Untuk berkomunikasi dengan backend berbasis URL (RESTFUL API) diperlukan beberapa method, beberapa method yang digunakan adalah GET, POST, PUT, DELETE.
<div align="center">
  <img width="590" height="157" alt="image" src="https://github.com/user-attachments/assets/1ae42d0a-536f-45f6-854c-f1c160d7a657" />
</div> <br>
User mengirim request dengan beberapa method yang digunakan untuk berkomunikasi dengan server kemudian server mengirim kembali data berupa response.

<div align="center">
  <img width="529" height="211" alt="image" src="https://github.com/user-attachments/assets/389afb31-37d1-46c5-a0fe-9bdcfe05df75" />
</div> <br>
Di praktikum ini hanya akan membangun dari sisi server saja dan praktikum akan berlanjut di bab 7 dan 8

***

### **6.4 PROSEDUR PRAKTIKUM**
Dalam membangun REST API pada praktikum ini, terdapat beberapa langkah yang harus dilalui terlebih dahulu, sebelum nantinya melakukan pembuatan kode untuk REST API. Berikut merupakan langkah-langkah yang harus dilalui:
1.	Memeriksa seluruh kebutuhan yang diperlukan
*	Bahasa pemrograman Golang (Version 1.23 atau di atasnya)
*	Visual studio code (Extension Golang dan code runner)
*	Postgre SQL
*	Postman

Untuk memastikan apakah bahasa pemrograman golang telah terinstall pada perangkat, bukalah command prompt dan ketikan perintah go version. Jika perangkat telah terinstall dengan bahasa golang, maka tampilan dari command prompt akan terlihat, seperti pada Gambar
<div align="center">
  <img width="827" height="326" alt="image" src="https://github.com/user-attachments/assets/956630e6-b728-447a-ba5e-13d6286f275c" />
</div> <br>

<div align="center">
  <img width="586" height="145" alt="image" src="https://github.com/user-attachments/assets/8214420e-32e2-4695-ad50-7e90dafb50cb" />
</div> <br>

2.	Buatlah sebuah folder baru dengan nama bebas. Jika nama folder lebih dari 1 suku kata, pisahkan dengan menggunakan underscore (_).
<div align="center">
  <img width="827" height="466" alt="image" src="https://github.com/user-attachments/assets/80976d03-a928-4585-9e59-c27c4e458e51" />
</div> <br>

3.	Masuklah ke dalam folder tersebut dan ketiklah perintah cmd pada bagian path folder agar langsung masuk ke dalam command prompt untuk melakukan konfigurasi lebih lanjut
<div align="center">
  <img width="827" height="466" alt="image" src="https://github.com/user-attachments/assets/e8b56048-783c-4439-84f0-294b75680d81" />
</div> <br>

4.	Setelah masuk ke dalam command prompt, masukkan seluruh konfigurasi berikut secara satu per satu.
```go
go mod init [nama_project]

go get -u "github.com/gin-gonic/gin"
go get -u "github.com/lib/pq"
go get -u "github.com/rubenv/sql-migrate"
go get -u "github.com/joho/godotenv"
```

Berikut merupakan penjelasan singkat terkait kode konfigurasi yang telah dimasukkan:
1.	Perintah go mod init [nama_project] digunakan untuk menginisialisasi golang pada folder project. Hasil dari proses ini akan menghasilkan sebuah file bernama go.mod yang berisikan konfigurasi.
2.	Perintah go get -u "github.com/gin-gonic/gin" digunakan untuk instalasi package Gin framework. Gin framework memudahkan pengembangan API, karena package ini menyediakan berbagai fitur seperti routing, middleware dan handling JSON.
3.	Perintah go get -u "github.com/lib/pq" digunakan untuk mengunduh / instalasi driver untuk PostgreSQL. Package tersebut digunakan agar bahasa pemrograman Go berkomunikasi dengan PostgreSQL dan mengirim query.
4.	Perintah go get -u "github.com/rubenv/sql-migrate" digunakan untuk mengunduh / instalasi migrasi sql. Dengan adanya package ini pengembang dapat mengelola konfigurasi database.
5.	Perintah go get -u "github.com/joho/godotenv" digunakan untuk mengunduh / instalasi godotenv yang digunakan untuk membaca file .env yang berisikan berbagai konfiurasi.

Setelah melakukan konfigurasi pada project golang, bukalah folder tersebut pada software visual studio code dan bentuklah tree project, seperti yang terlihat pada Gambar
<div align="center">
  <img width="352" height="552" alt="image" src="https://github.com/user-attachments/assets/434d85ef-e3f7-48c5-8975-2e772776931d" />
</div> <br>

Setelah membentuk struktur tree project, bukalah file **card_bridge_entity.go** dan masukkanlah kode program berikut:
```go
package entities

type Card struct {
	ID string `json:"id"`
}
```

Kode program tersebut berperan sebagai model yang mendefinisikan variabel serta tipe data yang digunakannya. Karena pada praktikum kali ini hanya digunakan untuk menyimpan data id dari RFID, maka variabel yang didefinisikan hanyalah 1 variabel saja dengan tipe string. Ketika data tersebut akan dikonversi ke dalam bentuk JSON, maka field tersebut akan tersimpan ke dalam key id.

Kemudian, bukalah file **1_initiate.sql** yang tersimpan di dalam folder sql_migrations dan masukkanlah kode program berikut:
```go
-- +migrate Up
-- +migrate StatementBegin

CREATE TABLE card(
    id varchar(20)
);

-- +migrate StatementEnd
```

Kode program di atas digunakan untuk membuat tabel database baru bernama card. Tabel yang dibuat pada praktikum kali ini hanya memiliki 1 field bernama id bertipe data varchar yang hanya dapat menampung karakter sepanjang 20 karakter. Migrate up merupakan instruksi yang akan menerapkan semua query SQL ke yang lebih baru. Statement begin merupakan instruksi yang menandakan awal dari proses pembuatan database, sedangkan statement end merupakan instruksi yang menandakan akhir dari pembuatan databse.

Berikutnya bukalah file **database.go** yang tersimpan pada folder database dan ketiklah kode program berikut:
```go
package database

import (
	"database/sql"
	"embed"
	"fmt"
	migrate "github.com/rubenv/sql-migrate"
)

//go:embed sql_migrations/*.sql
var dbMigrations embed.FS
var DbConnection *sql.DB

func DBMigrate(dbParam *sql.DB) {
	migrations := &migrate.EmbedFileSystemMigrationSource{
		FileSystem: dbMigrations,
		Root:       "sql_migrations",
	}

	n, errs := migrate.Exec(dbParam, "postgres", migrations, migrate.Up)

	if errs != nil {
		panic(errs)
	}

	DbConnection = dbParam

	fmt.Println("Migrations success applied", n, migrations)
}
```

Kode program di atas digunakan untuk proses migrasi golang ke database. Baris kode program //go:embed sql_migrations/*.sql bukanlah sebuah komentar, melainkan baris tersebut berfungsi sebagai kode yang akan menyematkan seluruh file yang berekstensi .sql yang ada pada folder sql_migrations ke dalam variabel dbMigrations. Oleh karena itu, perintah ini wajib dituliskan sebelum nantinya membangun fungsi migrasi database. Pada bagian awal kode program, terdapat 2 pendefinisian variabel, yakni dbMigrations yang akan menyimpan hasil embed yang telah dilakukan pada folder sql_migrations dan dbConnection yang akan menyimpan koneksi ke database.

Berikutnya terdapat function DBMigrate() yang di dalamnya terdapat parameter dbParam yang berfungsi dalam menerima status koneksi golang ke database. Ketika function tersebut dipanggil, maka sistem akan menjalankan proses migrasi database dengan root yang diambil dari folder sql_migrations. Berikutnya sistem akan menjalankan proses migrasi dengan pemanggilan terhadap fungsi Exec(). Proses tersebut akan menyimpan jumlah migrasi yang berhasil dilakukan dan mengembalikan kondisi error jika proses migrasi mengalami permasalahan. Jika terjadi error, maka sistem akan memanggil fungsi panic() yang akan langsung menghentikan jalannya program. Jika tidak terdeteksi error, maka sistem akan menampilkan pesan bahwa proses migrasi berhasil dilakukan.

Kemudian bukalah file **card_bridge_repo.go** dan masukkanlah kode program berikut:
```go
package repositories

import (
	"database/sql"
	"mcs_bab_6/entities"
)

func GetCards(db *sql.DB) (result []entities.Card, err error) {
	sql := "SELECT * FROM card"
	rows, err := db.Query(sql)

	if err != nil {
		return
	}

	defer rows.Close()

	for rows.Next() {
		var data entities.Card
		err = rows.Scan(&data.ID)
		if err != nil {
			return
		}
		result = append(result, data)
	}
	return
}

func InsertCard(db *sql.DB, card entities.Card) (err error) {
	sql := "INSERT INTO card(id) values($1)"
	_, err = db.Exec(sql, card.ID)
	return err
}

func DeleteCard(db *sql.DB, card entities.Card) (err error) {
	sql := "DELETE FROM card WHERE id = $1"
	_, err = db.Exec(sql, card.ID)
	return err
}
```

Kode di atas digunakan agar golang dapat melakukan interaksi dengan database. Terdapat 3 fungsi yang dibentuk pada file ini, antara lain GetCards(), InsertCard() dan DeleteCard() yang masing-masing function memiliki tujuan penggunaannya sendiri. Fungsi GetCards() digunakan untuk membaca seluruh data yang tersimpan dalam tabel card. Data tersebut dibaca dengan menggunakan perintah query SELECT * FROM card. Pada fungsi tersebut, sistem akan melakukan looping untuk mengisikan data ke dalam variabek result.

Fungsi InsertCard() digunakan untuk menginput data ke dalam table card dengan menggunakan perintah query INSERT INTO card(id) values($1). Sedangkan, fungsi DeleteCard() merupakan fungsi untuk menghapus data dari tabel berdasarkan id yang terdeteksi. Perintah query yang digunakan untuk menghapus data tersebut adalah DELETE FROM card WHERE id = $1. Selanjutnya masuklah ke dalam file **card_bridge_controller.go** dan masukkanlah kode program berikut:
```go
package controllers

import (
	"mcs_bab_6/database"
	"mcs_bab_6/entities"
	"mcs_bab_6/repositories"
	"net/http"
	"github.com/gin-gonic/gin"
)

func GetCards(c *gin.Context) {
	var result gin.H

	card, err := repositories.GetCards(database.DbConnection)

	if err != nil {
		result = gin.H{
			"result": err.Error(),
		}
	} else {
		result = gin.H{
			"result": card,
		}
	}

	c.JSON(http.StatusOK, result)
}

func InsertCard(c *gin.Context) {
	var card entities.Card
	idCard := c.Param("id")
	card.ID = idCard

	err := repositories.InsertCard(database.DbConnection, card)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"errpr": err.Error()})
		return
	}

	c.JSON(http.StatusOK, card)
}

func DeleteCard(c *gin.Context) {
	var card entities.Card
	idCard := c.Param("id")
	card.ID = idCard

	err := repositories.DeleteCard(database.DbConnection, card)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
	}

	c.JSON(http.StatusOK, gin.H{"message": "Data berhasil dihapus", "id": idCard})
}
```
 
Kode program yang digunakan pada file controller bertujuan untuk mengontrol apa yang akan dilakukan oleh sistem. Pada file ini, terdapat 3 fungsi yang dibentuk berdasarkan fungsi yang terbentuk pada file card_bridge_repo.go. Fungsi GetCards() berfungsi untuk mengambil seluruh data yang tersimpan pada database. Data yang diambil akan ditampung ke dalam forat JSON dengan key bernama result. Jika terjadi error, maka sistem akan menampilkan pesan error pada key tersebut.

Fungsi InsertCard() digunakan untuk menginput data ke dalam database. Data kartu dimasukkan menggunakan parameter di akhir url bernama id. Variabel idCard memiliki nilai yang diambil dari parameter id, lalu card.ID diinisialisasi dengan nilai dari idCard. Setelah itu memanggil InsertCard() dari package repositories agar data masuk ke database. Jika error maka response yang akan diberikan adalah error dengan StatusInternalServerError. Fungsi DeleteCard() digunakan untuk meenghapus data kartu yang telah disimpan pada database dengan memanggil fungsi DeleteCard() yang telah dibentuk pada package repositories. Jika terjadi error maka response yang diberikan adalah StatusInternalServerError.

Selanjutnya, bukalah file **card_bridge_router.go** dan masukkanlah kode program berikut:
```go
package routers

import (
	"mcs_bab_6/controllers"
	"github.com/gin-gonic/gin"
)

func StartServer() *gin.Engine {
	router := gin.Default()

	router.GET("/cards", controllers.GetCards)
	router.POST("/card/input/:id", controllers.InsertCard)
	router.DELETE("/card/delete/:id", controllers.DeleteCard)

	return router
}
```

Kode program yang dituliskan pada file tersebut merupakan kode yang akan mengatur endpoint dari masing-masing fungsi yang telah dibangun. Seluruh fungsi tersebut akan dijalankan dengan url yang sama. Namun, endpoint yang ingin digunakan akan disesuaikan berdasarkan kebutuhan. Endpoint yang dapat digunakan pada praktikum ini, antara lain:
| Endpoint | Penggunaan |
| -------- | ---------- |
| /cards | Digunakan untuk menampilkan seluruh data yang ada dengan method API yang digunakan adalah method GET. |
| /card/input/:id | Digunakan untuk menginput data baru ke dalam database dengan method API yang digunakan adalah method POST. Untuk menginput data, variabel id pada endpoint diganti dengan data yang diinginkan. |
| /card/delete/:id | Digunakan untuk menghapus data yang telah tersimpan dalam database dengan menggunakan method API DELETE. Sama halnya dengan pada saat input data, variabel id pada endpoint tersebut juga diganti dengan data yang ingin dihapus. |

Setelah mendefinisikan router yang akan digunakan pada praktikum kali ini, langkah berikutnya sebelum membangun kode utama adalah membuat database terlebih dahulu. Database yang digunakan pada praktikum kali ini adalah postgre SQL yang dapat diakses dengan membuka software pgAdmin yang telah terinstall
<div align="center">
  <img width="827" height="304" alt="image" src="https://github.com/user-attachments/assets/7665c22b-73a7-411a-acee-0b26c466ac4a" />
</div> <br>

Setelah pgAdmin terbuka pada perangkat, tekanlah menu server yang berada pada bagian sebelah kiri dan pilihlah server PostgreSQL yang tersedia (Note: Versi server dapat berbeda-beda). Selanjutnya masukkanlah password yang telah dibuat ke dalam field yang telah disediakan dan tekanlah tombol OK untuk masuk ke dalam server tersebut.
<div align="center">
  <img width="827" height="171" alt="image" src="https://github.com/user-attachments/assets/3a839c80-832f-444d-b59d-12b96746d656" />
</div> <br>

Setelah berhasil masuk ke dalam server, klik kanan pada menu **Databases > Create > Database…**
<div align="center">
  <img width="587" height="168" alt="image" src="https://github.com/user-attachments/assets/e70fdbf3-2106-4e47-ba47-753992bf1950" />
</div> <br>

PostgreSQL akan menampilkan halaman baru yang berisikan konfigurasi untuk pembuatan database. Pada menu tersebut, isilah kolom database dengan nama bebas. Jika nama folder lebih dari 1 suku kata, pisahkan dengan menggunakan underscore (_). Kemudian tekanlah tombol save untuk membuat database. Jika berhasil terbentuk, maka pada menu Databases yang ada di sebelah kiri, akan muncul file database dengan nama yang telah dibuat.
<div align="center">
  <img width="532" height="420" alt="image" src="https://github.com/user-attachments/assets/de7a323c-0a5e-47b0-a814-fa96ed30f3b8" />
</div> <br>

Jika database telah terbentuk, kembalilah ke dalam software visual studio code dan masukkan kode berikut ke dalam file **main.go**
```go
package main

import (
	"database/sql"
	"fmt"
	"log"
	"mcs_bab_6/database"
	"mcs_bab_6/routers"
	_ "github.com/lib/pq"
)

const (
	host     = "localhost"
	port     = 5432
	user     = "postgres"
	password = ""           // SESUAIKAN DENGAN PASSWORD POSTGRE YANG TELAH DIDAFTARKAN
	dbName   = "" 			// SESUAIKAN DENGAN NAMA DATABASE YANG DIBUAT
)

var (
	DB  *sql.DB
	err error
)

func main() {
	var PORT = ":50000"		// ISI DENGAN PORT BEBAS (DAPAT DICARI DI GOOGLE DENGAN KEYWORD "UNUSED PORT RANGE")

	psqlInfo := fmt.Sprintf(
		`host=%s port=%d user=%s password=%s dbname=%s sslmode=disable`,
		host, port, user, password, dbName,
	)

	DB, err = sql.Open("postgres", psqlInfo)

	if err != nil {
		log.Fatal("Error Open DB: ", err)
	}

	database.DBMigrate(DB)

	defer DB.Close()

	routers.StartServer().Run(PORT)
	fmt.Printf("Success Connected")
}
```

Pada file tersebut, definisikan beberapa variabel yang bersifat konstanta, seperti host, port, user, password, dan dbName. Variabel tersebut ini nantinya akan digunakan untuk berkomunikasi dengan PostgreSQL. Selain itu, buatlah variabel global bernama DB dengan tipe *sql.DB dan err yang akan menangkap error. 

Pada file tersebut, buatlah satu fungsi bernama main() yang di dalamnya terdapat logika program utama yang akan dijalankan oleh sistem. Pada fungsi tersebut definisikanlah variabel PORT dengan nilai :8080. SQL akan dibuka dengan pemanggilan terhadap fungsi Open() yang di dalamnya terdapat parameter “postgres” dan psqlInfo. Jika terjadi error pada saat membuka database, maka aplikasi akan menampilkan pesan error pada terminal. Selanjutnya, untuk proses migrasi database, panggilah fungsi DBMigrate() yang telah didefinisikan pada file database untuk menjalankan migrasi konfigurasi SQL ke aplikasi PostgreSQL. Kemudian, koneksi ke database akan ditutup setelah fungsi main() dijalankan dengan pemanggilan terhadap fungsi Close() dengan menggunakan defer agar tidak terjai kebocoran koneksi. Kemudian, server akan mulai dijalankan dengan pemanggilan terhadap fungsi StartServer() yang telah didefinisikan pada file routers dan dijalankan pada port yang telah ditentukan.

Setelah kode pada main.go selesai dituliskan, bukalah terminal visual studio code dan ketikan perintah go run main.go untuk menjalankan kode yang telah dibangun. Jika kode berhasil dijalankan, maka tampilan dari terminal akan terlihat, seperti pada Gambar.
<div align="center">
  <img width="827" height="233" alt="image" src="https://github.com/user-attachments/assets/859985a9-a1d5-4fe4-b8da-d5f82c602674" />
</div> <br>

Bukalah aplikasi postman pada perangkat dan lakukanlah uji coba terhadap beberapa endpoint yang telah dibangun.
<div align="center">
  <img width="528" height="245" alt="image" src="https://github.com/user-attachments/assets/a7e716d4-cd6a-4175-8b18-b5442f029dcc" />
  <p style="text-align:center;">Hasil Uji Coba Terhadap Method POST</p>
</div> <br>

<div align="center">
  <img width="469" height="416" alt="image" src="https://github.com/user-attachments/assets/8c46902b-0481-4629-9d50-ae23ca65e2f8" />
  <p style="text-align:center;">Hasil Uji Coba Terhadap Method GET</p>
</div> <br>

<div align="center">
  <img width="531" height="268" alt="image" src="https://github.com/user-attachments/assets/e585f988-5b3f-48c0-85cc-738f1f6268b7" />
  <p style="text-align:center;">Hasil Uji Coba Terhadap Method DELETE</p>
</div> <br>

<div align="center">
  <img width="823" height="369" alt="image" src="https://github.com/user-attachments/assets/5a595270-9b27-44a3-95dc-c3d4b682a6d3" />
  <p style="text-align:center;">Tampilan Terminal Ketika Telah Menjalankan Beberapa Method</p>
</div> <br>
