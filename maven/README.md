# Maven Project - Complete Documentation

A Spring Boot application demonstrating Maven build system with Thymeleaf templates. Includes authentication pages with hardcoded credentials for demo purposes.

---

## 📁 Project Structure

```
maven/
├── maven/                                     # Nested maven module
│   ├── pom.xml                                # Module POM file
│   └── src/
│       ├── main/
│       │   └── java/com/example/maven/
│       │       ├── MavenApplication.java
│       └── test/
│           └── java/com/example/maven/
│               └── MavenApplicationTests.java
├── src/
│   ├── main/
│   │   ├── java/com/example/maven/
│   │   │   ├── MavenApplication.java          # Main Spring Boot entry point
│   │   │   ├── model/
│   │   │   │   └── User.java                  # User model (username, password)
│   │   │   └── controller/
│   │   │       └── AuthController.java        # HTTP endpoints
│   │   └── resources/
│   │       ├── application.properties         # Spring Boot config
│   │       └── templates/
│   │           ├── index.html                 # Home page
│   │           ├── login.html                 # Login form (HARDCODED: user/pass)
│   │           ├── register.html              # Registration form
│   │           ├── dashboard.html             # Welcome after login
│   │           └── success.html               # Registration success
│   └── test/
│       └── java/com/example/maven/
│           └── MavenApplicationTests.java     # Unit test file
├── pom.xml                                    # Maven configuration (parent)
├── mvnw / mvnw.cmd                           # Maven wrapper
├── SETUP.md                                   # Setup instructions
└── HELP.md                                    # Auto-generated help
```

---

## 🔧 Technology Stack

- **Framework**: Spring Boot 4.0.5
- **Build System**: Maven 3.6+
- **Language**: Java 21
- **View Engine**: Thymeleaf
- **No Database**: Uses in-memory session (no persistence)
- **Testing**: JUnit 5

---

## 🚀 How to Run

### Prerequisites
- Java 21+
- Maven 3.6+

### 1. Start the Application

**Option A: Direct command**
```bash
cd /workspaces/devops/maven
mvn spring-boot:run
```

**Option B: Using Maven wrapper**
```bash
./mvnw spring-boot:run
```

### 2. Access the Application
- Home: http://localhost:8080
- Login: http://localhost:8080/login
- Register: http://localhost:8080/register

### 3. Run Tests
```bash
mvn test
```

---

## 📋 Hardcoded Test Credentials

⚠️ **Note**: This project uses hardcoded credentials for demo purposes only.

**Valid Login Credentials**:
- Username: `user`
- Password: `pass`

Located in: `src/main/java/com/example/maven/controller/AuthController.java`

```java
if ("user".equals(user.getUsername()) && "pass".equals(user.getPassword())) {
    // Login successful
    return "dashboard";
}
```

---

## 📋 API Endpoints

| Method | URL | Description |
|--------|-----|-------------|
| GET | `/` | Home page |
| GET | `/login` | Show login form |
| POST | `/login` | Process login (hardcoded: user/pass) |
| GET | `/register` | Show registration form |
| POST | `/register` | Process registration (no persistence) |

---

## 🎨 Pages & Templates

### 1. Home (`index.html`)
- Welcome page
- Links to login and register
- Simple introduction

### 2. Login (`login.html`)
- Username input field
- Password input field
- **Hardcoded test**: Use `user` / `pass`
- Link to registration page
- POST to `/login`

### 3. Register (`register.html`)
- Username input field
- Password input field
- Submit button POSTs to `/register`
- Data not saved anywhere (demo only)

### 4. Dashboard (`dashboard.html`)
- Shows after successful login with `user`/`pass`
- Displays username
- Welcome message

### 5. Success (`success.html`)
- Shown after registration
- Confirmation message
- Link back to login

---

## ⚙️ Configuration

### Application Properties

**File**: `src/main/resources/application.properties`

```properties
spring.application.name=maven
# Add custom properties as needed
```

### Change Port

Add to `src/main/resources/application.properties`:
```properties
server.port=8081  # Default is 8080
```

### Change Application Name

Edit both:
1. `pom.xml`: Update `<artifactId>` and `<name>`
2. `src/main/resources/application.properties`: Update `spring.application.name`

---

## 🔄 Customizable Elements

### 1. **Change Login Credentials**
Edit `src/main/java/com/example/maven/controller/AuthController.java`:

```java
// Current (hardcoded)
if ("user".equals(user.getUsername()) && "pass".equals(user.getPassword())) {

// Change to:
if ("admin".equals(user.getUsername()) && "secret123".equals(user.getPassword())) {
```

Then rebuild and restart.

### 2. **Add More Pages**
1. Create HTML file: `src/main/resources/templates/newpage.html`
2. Add mapping in controller:
```java
@GetMapping("/newpage")
public String newPage() {
    return "newpage";  // Returns templates/newpage.html
}
```

### 3. **Modify Styling**
Edit HTML templates: Add CSS in `<style>` tags or link CSS files:
```html
<link rel="stylesheet" href="/css/style.css">
```

### 4. **Add Static Files**
Create directories:
- CSS: `src/main/resources/static/css/`
- JavaScript: `src/main/resources/static/js/`
- Images: `src/main/resources/static/images/`

Reference in templates:
```html
<link rel="stylesheet" href="/css/style.css">
<script src="/js/app.js"></script>
<img src="/images/logo.png">
```

### 5. **Add Database Storage**
To convert from in-memory to persistent storage:

1. Add JPA dependency to `pom.xml`:
```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
</dependency>
```

2. Add to `application.properties`:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/maven_db
spring.datasource.username=root
spring.datasource.password=changeit
spring.jpa.hibernate.ddl-auto=update
```

3. Make User an @Entity and use repository pattern (similar to login project)

4. Update controller to save users

---

## 🛠️ Maven Build Lifecycle

### Clean (remove build artifacts)
```bash
mvn clean
```

### Compile (compile source code)
```bash
mvn compile
```

### Test (run tests)
```bash
mvn test
```

### Package (create JAR)
```bash
mvn package
```

### Install (install to local repository)
```bash
mvn install
```

### Run (as one command)
```bash
mvn spring-boot:run
```

### Full cycle (clean → test → package)
```bash
mvn clean package
```

---

## 📦 Create Executable JAR

### Build JAR
```bash
mvn clean package
# JAR created at: target/maven-0.0.1-SNAPSHOT.jar
```

### Run JAR
```bash
java -jar target/maven-0.0.1-SNAPSHOT.jar
```

### Run on different port
```bash
java -jar target/maven-0.0.1-SNAPSHOT.jar --server.port=9090
```

---

## 📚 User Model

Located in: `src/main/java/com/example/maven/model/User.java`

```java
public class User {
    private String username;
    private String password;
    // Constructor, getters, setters
}
```

**Note**: This is NOT a database entity (no @Entity). It's just a POJO for request/response handling.

---

## 📦 Dependency Overview

| Dependency | Purpose |
|------------|---------|
| spring-boot-starter-web | Web MVC framework |
| spring-boot-starter-thymeleaf | Template rendering |
| spring-boot-starter-test | Testing framework |

---

## 🔍 Maven Wrapper

### What is mvnw?
Maven wrapper allows running Maven without having Maven installed globally.

### Use wrapper instead of mvn:
```bash
./mvnw spring-boot:run     # On Linux/Mac
mvnw.cmd spring-boot:run   # On Windows
```

### Update wrapper version
```bash
mvn -N io.takari:maven:wrapper -Dmaven=3.9.0
```

---

## ❌ Troubleshooting

### Port 8080 already in use
```bash
# Kill process on port 8080
lsof -ti:8080 | xargs kill -9
# Or use different port
java -jar target/maven-0.0.1-SNAPSHOT.jar --server.port=9090
```

### "mvn: command not found"
```bash
# Use Maven wrapper instead
./mvnw spring-boot:run
```

### 404 on templates
- Check template files exist: `src/main/resources/templates/`
- Verify controller method returns correct template name
- Restart app

### Build fails
```bash
# Clean and try again
mvn clean install
# If still fails, clear Maven cache
rm -rf ~/.m2/repository
mvn clean install
```

---

## 📊 Project Statistics

- **Language**: Java 21
- **Framework**: Spring Boot 4.0.5
- **Build Files**: 2 (parent pom.xml + maven/pom.xml)
- **Source Files**: 3 (MavenApplication, AuthController, User)
- **Templates**: 5 (index, login, register, dashboard, success)

---

## 🧪 Minimal Test Example

**Existing test**: `src/test/java/com/example/maven/MavenApplicationTests.java`

To add a new test:
```java
@SpringBootTest
public class AuthControllerTest {
    @Test
    void contextLoads() {
        assertTrue(true);
    }
}
```

Run tests:
```bash
mvn test
```

---

## 📚 Maven Plugin Configuration

### Spring Boot Plugin (in pom.xml)
```xml
<plugin>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-maven-plugin</artifactId>
</plugin>
```

Enables:
- `mvn spring-boot:run` - Start app
- `mvn spring-boot:build-image` - Docker image

### Add custom plugins

Example - Shade plugin (to create fat JAR with dependencies):
```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-shade-plugin</artifactId>
    <executions>
        <execution>
            <phase>package</phase>
            <goals><goal>shade</goal></goals>
        </execution>
    </executions>
</plugin>
```

---

## 🚀 Next Steps

1. **Add database**: Convert to JPA + MySQL (see Store project for reference)
2. **Add validation**: Email verification, password policies
3. **Add API endpoints**: REST endpoints instead of just web pages
4. **Add authentication**: Spring Security for real security
5. **Add logging**: SLF4J + Logback configuration
6. **Add error handling**: Custom error pages and exception handling

---

## 📞 File References

- **Main class**: `src/main/java/com/example/maven/MavenApplication.java`
- **Configuration**: `src/main/resources/application.properties` + `pom.xml`
- **Build file**: `pom.xml`
- **Run app**: `mvn spring-boot:run`
- **Run tests**: `mvn test`
- **Package**: `mvn clean package`

