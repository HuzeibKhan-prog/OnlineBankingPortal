# 🏦 Online Banking Portal

## 📌 Overview
The **Online Banking Portal** is a Java web application built using **HTML, JSP, Servlets, and JDBC**.  
It allows customers to register, log in, check balances, and perform transactions (money transfers between accounts).  
All data is stored in a MySQL database with two core tables: `rega` and `transactions`.

---

## 🚀 Features
- **Customer Registration** → Create new accounts with username, password, email, country, and initial balance.
- **Login & Authentication** → Secure login using email and password.
- **Dashboard** → View account balance and profile details.
- **Transactions** → Transfer money between accounts.
- **Transaction History** → View all past transfers with timestamps.
- **Logout** → End session securely.

---

## 🛠️ Tech Stack
- **Frontend:** HTML, JSP  
- **Backend:** Java Servlets  
- **Database:** MySQL (via JDBC)  
- **Server:** GlassFish 4.1.1 / Apache Tomcat  
- **IDE:** NetBeans  

---

## 🗄️ Database Schema (MySQL)

### Table: `rega`
```sql
CREATE TABLE rega (
    username VARCHAR(100),
    password VARCHAR(50),
    email VARCHAR(100) PRIMARY KEY,
    country VARCHAR(50),
    balance DECIMAL(10,2)
);
```

### Table: `transactions`
```sql
CREATE TABLE transactions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    transaction_id VARCHAR(50),
    sender_email VARCHAR(100),
    receiver_email VARCHAR(100),
    amount DECIMAL(10,2),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

⚙️ Setup Instructions
```text
1.Clone the repository: git clone https://github.com/HuzeibKhan-prog/OnlineBankingPortal.git
2.Import the project into NetBeans.
3.Configure GlassFish Server 4.1.1 (default) or Apache Tomcat.
4.Create the database onlinebanking in MySQL and run the schema above.
5.Update JDBC connection string in DBConnection.java:
String url = "jdbc:mysql://localhost:3306/onlinebanking?useSSL=false&allowPublicKeyRetrieval=true";
Connection con = DriverManager.getConnection(url, "root", "");
6.Deploy the project and access via:
http://localhost:8080/OnlineBankingPortal
```

📂 Project Structure
```text
OnlineBankingPortal/
│
├── Web Pages/
│   ├── WEB-INF/                # Config files (web.xml, etc.)
│   ├── dashboard.jsp           # Customer dashboard after login
│   ├── history.jsp             # Transaction history page
│   ├── index.jsp               # Home page
│   ├── login.jsp               # Login form
│   ├── register.jsp            # Registration form
│   ├── transaction.jsp         # Transaction form (transfer money)
│   └── style.css               # Stylesheet for UI
│
├── Source Packages/
│   ├── com.bank.servlet/
│   │   ├── LoginServlet.java       # Handles login authentication
│   │   ├── LogoutServlet.java      # Handles logout
│   │   ├── RegistrationServlet.java# Handles new customer registration
│   │   └── TransactionServlet.java # Handles money transfers
│   │
│   └── com.bank.util/
│       └── DBConnection.java       # Utility class for JDBC connection
│
├── Libraries/
│   ├── mysql-connector-java-5.1.23-bin.jar # MySQL JDBC driver
│   ├── JDK 1.8 (Default)                   # Java runtime
│   └── GlassFish Server 4.1.1 / Tomcat     # Application server
│
└── README.md
```

###🎯 Future Enhancements
```text
1.Add deposit/withdraw functionality.
2.Implement email notifications for transactions.
3.Enhance UI with Bootstrap/Material Design.
4.Add admin panel for monitoring all users and transactions.

```
