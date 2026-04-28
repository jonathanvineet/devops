# DevOps Repository - Complete Project Overview

A comprehensive collection of Spring Boot demonstration projects showcasing different build systems, architectures, and best practices.

---

## 📁 Repository Structure

```
devops/
├── login/            # Maven + MVC Login with Database ⭐
├── store/            # Maven + Product Store (3 inputs) ⭐
├── maven/            # Maven + Thymeleaf (in-memory auth)
├── gradle/           # Gradle + Thymeleaf (custom tasks)
├── README.md         # This file - overview of all projects
├── GIT_COMMANDS.md   # Git commands reference
├── ansible.md        # Ansible configuration guide
├── setup-ansible.sh  # Ansible setup script
└── COMMANDS.md       # Quick reference commands
```

---

## 🎯 Project Summary

### 1️⃣ **LOGIN** - User Authentication with Database
**Path**: `/workspaces/devops/login`

📌 **What it does**: 
- User login & registration system
- Stores credentials in **MySQL database**
- Full MVC architecture with Service layer
- 6 unit tests using H2 in-memory DB

🔧 **Tech**: Maven, Spring Boot, JPA, Thymeleaf, MySQL, H2

✨ **Key Features**:
- User entity with persistence
- AuthService & AuthRepository
- Login form validation
- Dashboard after successful login

🚀 **Quick Start**:
```bash
cd login
mvn spring-boot:run
# Access: http://localhost:8080/login
```

👉 **Full Documentation**: [login/README.md](login/README.md)

---

### 2️⃣ **STORE** - Product Management System
**Path**: `/workspaces/devops/store`

📌 **What it does**:
- Accept **3 inputs**: product name, price, quantity
- Complete CRUD operations (Create, Read, Update, Delete)
- **MySQL storage** with JPA
- 6 comprehensive unit tests

🔧 **Tech**: Maven, Spring Boot, JPA, Thymeleaf, MySQL, H2

✨ **Key Features**:
- Product listing with table display
- Add new products form
- Edit products inline
- Delete with confirmation
- Formatted currency display

🚀 **Quick Start**:
```bash
cd store
mvn spring-boot:run
# Access: http://localhost:8080/products
```

👉 **Full Documentation**: [store/README.md](store/README.md)

---

### 3️⃣ **MAVEN** - Maven Build System Demo
**Path**: `/workspaces/devops/maven`

📌 **What it does**:
- Demonstrates Maven as build system
- Authentication pages (no database)
- **Hardcoded credentials** for demo: `user` / `pass`
- Standard Maven project structure

🔧 **Tech**: Maven, Spring Boot, Thymeleaf (in-memory)

✨ **Key Features**:
- Maven wrapper support (`./mvnw`)
- Standard POM configuration
- Simple Thymeleaf templating
- Web MVC without persistence

🚀 **Quick Start**:
```bash
cd maven
mvn spring-boot:run
# Access: http://localhost:8080
# Login: user / pass
```

👉 **Full Documentation**: [maven/README.md](maven/README.md)

---

### 4️⃣ **GRADLE** - Gradle Build System Demo
**Path**: `/workspaces/devops/gradle`

📌 **What it does**:
- Demonstrates Gradle as build system
- Authentication pages (no database)
- **Hardcoded credentials** for demo: `user` / `pass`
- Custom Gradle tasks

🔧 **Tech**: Gradle 8.x, Spring Boot, Thymeleaf (in-memory)

✨ **Key Features**:
- Gradle wrapper scripts
- Custom task: `createjar` with build info
- Modern Gradle build configuration
- Java 21 toolchain specification

🚀 **Quick Start**:
```bash
cd gradle
./gradlew bootRun
# Access: http://localhost:8080
# Login: user / pass
# Create JAR: ./gradlew createjar
```

👉 **Full Documentation**: [gradle/README.md](gradle/README.md)

---

## 🔄 Quick Comparison Table

| Feature | Login | Store | Maven | Gradle |
|---------|-------|-------|-------|--------|
| **Build System** | Maven | Maven | Maven | Gradle |
| **Database** | ✅ MySQL | ✅ MySQL | ❌ None | ❌ None |
| **Persistence** | ✅ Yes | ✅ Yes | ❌ No | ❌ No |
| **Inputs** | 2 (user, pass) | 3 (name, price, qty) | 2 | 2 |
| **MVC Layers** | ✅ Full | ✅ Full | ⚠️ Partial | ⚠️ Partial |
| **Service Layer** | ✅ Yes | ✅ Yes | ❌ No | ❌ No |
| **Unit Tests** | 2 tests | 6 tests | ❌ None | ❌ None |
| **Port** | 8080 | 8080 | 8080 | 8080 |

---

## 🚀 Running All Projects

### Start MySQL (if not running)
```bash
# Start MySQL service
mysql -u root -p

# Or create databases (once connected)
CREATE DATABASE login_db;
CREATE DATABASE store_db;
```

### Run Projects in Parallel (from devops root)

**Terminal 1 - Login**:
```bash
cd login && mvn spring-boot:run
```

**Terminal 2 - Store**:
```bash
cd store && mvn spring-boot:run -Dserver.port=8081
```

**Terminal 3 - Maven**:
```bash
cd maven && mvn spring-boot:run -Dserver.port=8082
```

**Terminal 4 - Gradle**:
```bash
cd gradle && ./gradlew bootRun --args='--server.port=8083'
```

Then access:
- Login: http://localhost:8080
- Store: http://localhost:8081
- Maven: http://localhost:8082
- Gradle: http://localhost:8083

---

## 🎓 Learning Path

### Beginner
1. **Start with Maven** → Learn Maven build system
2. **Then Login** → Learn MVC + database

### Intermediate
3. **Store Project** → CRUD operations
4. **Gradle** → Compare build systems

### Advanced
- Add Spring Security to Login
- Add search/filtering to Store
- Integrate CI/CD & Docker

---

## 🔧 Configuration Changes

### Change Ports (all projects use 8080 by default)

**For Maven/Gradle projects** (temporary):
```bash
mvn spring-boot:run -Dspring-boot.run.arguments="--server.port=9090"
./gradlew bootRun --args='--server.port=9090'
```

**Permanent** (in `src/main/resources/application.properties`):
```properties
server.port=9090
```

### Change Database Credentials

All projects with databases (login, store):

Edit `src/main/resources/application.properties`:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/db_name
spring.datasource.username=your_user
spring.datasource.password=your_password
spring.jpa.hibernate.ddl-auto=update  # auto | create | create-drop | validate
```

### Disable SQL Logging

Edit `src/main/resources/application.properties`:
```properties
spring.jpa.show-sql=false
```

---

## 📦 Build & Package All Projects

### Build All (from root devops folder)
```bash
# Build login
cd login && mvn clean package -DskipTests

# Build store
cd ../store && mvn clean package -DskipTests

# Build maven
cd ../maven && mvn clean package -DskipTests

# Build gradle
cd ../gradle && ./gradlew clean build -x test
```

### Create JARs
```bash
# Login
java -jar login/target/login-0.0.1-SNAPSHOT.jar

# Store
java -jar store/target/store-0.0.1-SNAPSHOT.jar --server.port=8081

# Maven
java -jar maven/target/maven-0.0.1-SNAPSHOT.jar --server.port=8082

# Gradle
java -jar gradle/build/libs/gradle-0.0.1-SNAPSHOT.jar --server.port=8083
```

---

## 🧪 Run Tests All Projects

```bash
# Login tests
cd login && mvn test

# Store tests
cd ../store && mvn test

# Maven tests (no database tests)
cd ../maven && mvn test

# Gradle tests (no database tests)
cd ../gradle && ./gradlew test
```

---

## 🔍 File Structure by Project

### All Projects have:
```
src/
├── main/
│   ├── java/com/example/{project}/
│   │   ├── {Project}Application.java
│   │   ├── model/
│   │   ├── controller/
│   │   └── [service/]          # Only for Login & Store
│   │   └── [repository/]       # Only for Login & Store
│   └── resources/
│       ├── application.properties
│       └── templates/
│           └── *.html
└── test/
    └── java/com/example/{project}/
        └── [*Tests.java]
```

---

## 📝 Common Changes You Might Make

### 1. Add New User Field (Login project)
1. Edit `login/src/main/java/com/example/login/model/User.java` - Add field
2. Edit templates - Add input form
3. Restart - Hibernate creates column automatically

### 2. Add New Product Field (Store project)
1. Edit `store/src/main/java/com/example/store/model/Product.java` - Add field
2. Edit `add-product.html` and `edit-product.html` - Add inputs
3. Edit `ProductController.java` - Update @RequestParam
4. Restart - Database schema updates

### 3. Change Hardcoded Credentials (Maven/Gradle)
Edit `src/main/java/com/example/{project}/controller/AuthController.java`
```java
// Change from:
if ("user".equals(...) && "pass".equals(...))
// To:
if ("admin".equals(...) && "secret123".equals(...))
```

### 4. Add Custom Port
Add to `src/main/resources/application.properties`:
```properties
server.port=9090
```

### 5. Add Logging
Edit `src/main/resources/application.properties`:
```properties
logging.level.root=INFO
logging.level.com.example=DEBUG
logging.file.name=app.log
```

---

## 🆘 Troubleshooting

### MySQL Connection Errors
```bash
# Check if MySQL is running
mysql -u root -p

# Or start MySQL service
sudo service mysql start  # Linux
brew services start mysql # Mac
```

### Port Already in Use
```bash
# Find and kill process
lsof -ti:8080 | xargs kill -9

# Or use different port
java -jar target/*.jar --server.port=9090
```

### Build/Test Failures
```bash
# Clean everything
cd project_folder
mvn clean install    # Maven projects
./gradlew clean build # Gradle project

# Clear cache
rm -rf ~/.m2/repository
```

### Access Denied to Database
Check `application.properties`:
```properties
spring.datasource.username=root       # Correct user
spring.datasource.password=changeit   # Correct password
```

---

## 📚 Reference Files

| File | Purpose |
|------|---------|
| `login/README.md` | Login project complete guide |
| `store/README.md` | Store project complete guide |
| `maven/README.md` | Maven project complete guide |
| `gradle/README.md` | Gradle project complete guide |
| `GIT_COMMANDS.md` | Git commands reference |
| `ansible.md` | Ansible configuration |
| `setup-ansible.sh` | Ansible setup script |

---

## 🎯 Project Purpose Summary

| Project | Purpose | Best For |
|---------|---------|----------|
| **Login** | Learn MVC + Database | Beginners learning Spring Data JPA |
| **Store** | CRUD Operations | E-commerce concepts |
| **Maven** | Build System Demo | Understanding Maven |
| **Gradle** | Build System Demo | Understanding Gradle |

---

## 🚀 Next Steps

1. **Pick a project** and read its README.md
2. **Run it locally** using provided commands
3. **Make changes** to understand how code works
4. **Run tests** to ensure everything works
5. **Deploy** as JAR file

---

## 💡 Tips & Best Practices

### Database
- Always backup before schema changes
- Use `ddl-auto=validate` in production
- Check logs for SQL errors: `spring.jpa.show-sql=true`

### Testing
- Run tests before committing: `mvn test` / `./gradlew test`
- Use in-memory H2 for faster tests
- Add more test cases for edge cases

### Build
- Use `-DskipTests` flag for faster builds: `mvn clean package -DskipTests`
- Clear `.m2` cache if issues persist
- Always clean before packaging: `mvn clean package`

### Performance
- Set JVM heap size for large projects: `export GRADLE_OPTS="-Xmx2048m"`
- Use `spring.jpa.show-sql=false` in production
- Enable caching for static resources

---

## 📞 Quick Commands Reference

### Maven Projects
```bash
mvn clean install              # Full build
mvn spring-boot:run            # Run app
mvn test                        # Run tests
mvn clean package -DskipTests  # Package JAR
java -jar target/*.jar         # Run JAR
```

### Gradle Project
```bash
./gradlew clean build          # Full build
./gradlew bootRun              # Run app
./gradlew test                 # Run tests
./gradlew build -x test        # Build without tests
./gradlew createjar            # Custom task
java -jar build/libs/*.jar     # Run JAR
```

---

## 📞 Contact & Support

For questions about specific projects, see:
- **Login issues**: [login/README.md](login/README.md#-troubleshooting)
- **Store issues**: [store/README.md](store/README.md#-troubleshooting)
- **Maven issues**: [maven/README.md](maven/README.md#-troubleshooting)
- **Gradle issues**: [gradle/README.md](gradle/README.md#-troubleshooting)

---

**Happy coding!** 🚀