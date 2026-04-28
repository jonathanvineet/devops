# Login Application - Complete Documentation

A Spring Boot MVC application for user authentication with login and registration functionality. Stores user credentials in MySQL database.

---

## 📁 Project Structure

```
login/
├── src/
│   ├── main/
│   │   ├── java/com/example/login/
│   │   │   ├── LoginApplication.java          # Main Spring Boot entry point
│   │   │   ├── model/
│   │   │   │   └── User.java                  # User entity with username/password
│   │   │   ├── repository/
│   │   │   │   └── UserRepository.java        # JPA repository for User queries
│   │   │   ├── service/
│   │   │   │   └── AuthService.java           # Authentication & registration logic
│   │   │   └── controller/
│   │   │       └── AuthController.java        # HTTP endpoints
│   │   └── resources/
│   │       ├── application.properties         # MySQL configuration
│   │       └── templates/
│   │           ├── login.html                 # Login form page
│   │           ├── register.html              # Registration form page
│   │           └── dashboard.html             # Welcome page after login
│   └── test/
│       ├── java/com/example/login/
│       │   ├── LoginApplicationTests.java     # Base test class
│       │   └── service/
│       │       └── AuthServiceTest.java       # Unit tests for auth logic
│       └── resources/
│           └── application.properties         # H2 in-memory DB for tests
├── pom.xml                                    # Maven dependencies
├── mvnw / mvnw.cmd                           # Maven wrapper scripts
└── HELP.md                                    # Auto-generated help
```

---

## 🔧 Technology Stack

- **Framework**: Spring Boot 4.0.6
- **Language**: Java 21
- **Build**: Maven
- **Database**: MySQL (production), H2 (testing)
- **View Engine**: Thymeleaf
- **ORM**: JPA/Hibernate
- **Testing**: JUnit 5, AssertJ

---

## 🚀 How to Run

### Prerequisites
- Java 21+
- Maven 3.6+
- MySQL Server running (if running with real database)

### 1. Start the Application

**Option A: Using MySQL Database**
```bash
cd /workspaces/devops/login
mvn spring-boot:run
```

**Option B: Using Maven Wrapper**
```bash
./mvnw spring-boot:run
```

### 2. Access the Application
- Home/Login: http://localhost:8080 or http://localhost:8080/login
- Register: http://localhost:8080/register
- After login: http://localhost:8080/dashboard

### 3. Run Tests (H2 in-memory database)
```bash
mvn test
```

---

## ⚙️ Configuration Guide

### MySQL Database Setup

**File**: `src/main/resources/application.properties`

```properties
# Default configuration (change as needed):
spring.datasource.url=jdbc:mysql://localhost:3306/login_db
spring.datasource.username=root
spring.datasource.password=changeit

# Auto-create tables
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

**Before running the app, create the database:**
```bash
mysql -u root -p
```

```sql
CREATE DATABASE login_db;
USE login_db;
-- Tables will be auto-created by Hibernate
```

---

## 📋 API Endpoints

| Method | URL | Description |
|--------|-----|-------------|
| GET | `/` or `/login` | Show login form |
| POST | `/login` | Submit login credentials |
| GET | `/register` | Show registration form |
| POST | `/register` | Submit registration |

---

## 🧑‍💼 User Model

### Entity: User
Located in: `src/main/java/com/example/login/model/User.java`

**Table**: `users`

| Column | Type | Constraints |
|--------|------|-------------|
| id | BIGINT | Primary Key, Auto-increment |
| username | VARCHAR(255) | Unique, Not Null |
| password | VARCHAR(255) | Not Null |

**Example SQL**:
```sql
SELECT * FROM users;
INSERT INTO users (username, password) VALUES ('alice', 'password123');
```

---

## 🔐 Service Layer

### AuthService
Located in: `src/main/java/com/example/login/service/AuthService.java`

**Methods**:
- `authenticate(String username, String password)` - Returns true if credentials match
- `register(String username, String password)` - Creates new user in database

---

## 🎨 UI Templates

### 1. Login Form (`login.html`)
- Username input field
- Password input field
- Error messages (red) if login fails
- Link to registration page
- POST to `/login`

### 2. Register Form (`register.html`)
- Username input field
- Password input field
- POST to `/register`

### 3. Dashboard (`dashboard.html`)
- Welcome message with username
- Simple confirmation after successful login

---

## 🧪 Testing

### Test File
Located in: `src/test/java/com/example/login/service/AuthServiceTest.java`

**Tests Included**:
1. ✅ `authenticateWithValidCredentials()` - Test correct login
2. ✅ `authenticateWithInvalidCredentials()` - Test wrong password

**Run tests**:
```bash
mvn test
# Or specific test:
mvn test -Dtest=AuthServiceTest
```

**Test Configuration** (`src/test/resources/application.properties`):
```properties
# Uses H2 in-memory database (no MySQL needed)
spring.datasource.url=jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1
spring.datasource.driverClassName=org.h2.Driver
spring.jpa.hibernate.ddl-auto=create-drop
```

---

## 🔄 Customizable Elements

### 1. **Database Credentials**
Edit `src/main/resources/application.properties`:
```properties
spring.datasource.username=newuser
spring.datasource.password=newpassword
spring.datasource.url=jdbc:mysql://host:3306/dbname
```

### 2. **Port**
Add to `src/main/resources/application.properties`:
```properties
server.port=8081  # Default is 8080
```

### 3. **User Model Fields**
To add more fields (email, phone, etc.):
1. Edit `src/main/java/com/example/login/model/User.java` - Add fields with @Column
2. Edit `src/main/resources/templates/register.html` - Add input fields
3. Edit `src/main/java/com/example/login/controller/AuthController.java` - Update handle methods
4. Restart app (Hibernate updates schema)

### 4. **Styling**
Edit HTML templates in `src/main/resources/templates/`:
- Add CSS classes
- Use Thymeleaf attributes: `th:if`, `th:each`, `th:class`
- Link external CSS in template head

### 5. **Password Encryption**
Currently stores passwords as plain text (for demo). To add encryption:
1. Add Spring Security dependency to pom.xml
2. Use `BCryptPasswordEncoder` in service layer
3. Update authentication logic

---

## 🛠️ Build & Package

### Create JAR file
```bash
mvn clean package
# JAR will be at: target/login-0.0.1-SNAPSHOT.jar
```

### Run packaged JAR
```bash
java -jar target/login-0.0.1-SNAPSHOT.jar
```

---

## 📦 Dependency Overview

| Dependency | Purpose |
|------------|---------|
| spring-boot-starter-data-jpa | Database ORM/persistence |
| spring-boot-starter-thymeleaf | Template rendering |
| spring-boot-starter-webmvc | MVC framework |
| mysql-connector-j | MySQL JDBC driver |
| h2 | In-memory test database |

---

## ❌ Troubleshooting

### "Connection refused" to MySQL
- Ensure MySQL is running: `mysql -u root -p`
- Check host/port in application.properties
- Verify database exists: `CREATE DATABASE login_db;`

### Port 8080 already in use
- Change port in `application.properties`: `server.port=8081`
- OR kill process: `lsof -ti:8080 | xargs kill -9`

### Tests fail
- Clear .m2 cache: `rm -rf ~/.m2/repository`
- Run: `mvn clean test`

###H2 tests can't find tables
- Delete H2 files: `rm -rf ~/.h2.server`
- ddl-auto should be `create-drop` in test properties

---

## 📚 Next Steps

1. **Add Spring Security**: Proper password hashing and session management
2. **Add email verification**: Send confirmation emails on registration
3. **Add profile page**: Let users view/edit their account
4. **Add logout**: Clear session when user logs out
5. **Database migration**: Use Liquibase/Flyway for schema versioning

---

## 📞 File References

- **Main class**: `src/main/java/com/example/login/LoginApplication.java`
- **Configuration**: `src/main/resources/application.properties`
- **Dependencies**: `pom.xml`
- **Tests run**: `mvn test`

