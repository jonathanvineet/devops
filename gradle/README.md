# Gradle Project - Complete Documentation

A Spring Boot application demonstrating Gradle build system with Thymeleaf templates. Includes authentication pages with hardcoded credentials and a custom JAR creation task.

---

## 📁 Project Structure

```
gradle/
├── src/
│   ├── main/
│   │   ├── java/com/example/gradle/
│   │   │   ├── GradleApplication.java         # Main Spring Boot entry point
│   │   │   ├── model/
│   │   │   │   └── User.java                  # User model (username, password)
│   │   │   └── controller/
│   │   │       └── AuthController.java        # HTTP endpoints
│   │   └── resources/
│   │       ├── application.properties         # Spring Boot config
│   │       └── templates/
│   │           ├── index.html                 # Home page
│   │           ├── login.html                 # Login form
│   │           ├── register.html              # Registration form
│   │           ├── dashboard.html             # After login
│   │           └── success.html               # After register
│   └── test/
│       └── java/com/example/gradle/
│           └── GradleApplicationTests.java    # Unit tests
├── gradle/
│   └── wrapper/
│       ├── gradle-wrapper.jar                 # Gradle distribution
│       └── gradle-wrapper.properties          # Gradle version config
├── build.gradle                               # Gradle build config
├── gradlew / gradlew.bat                     # Gradle wrapper scripts
├── settings.gradle                            # Gradle project settings
├── SETUP.md                                   # Setup guide
└── gradle-wrapper.jar                         # Wrapper JAR

```

---

## 🔧 Technology Stack

- **Framework**: Spring Boot 4.0.5
- **Build System**: Gradle 8.x
- **Language**: Java 21
- **View Engine**: Thymeleaf
- **No Database**: Uses in-memory session (no persistence)
- **Testing**: JUnit 5

---

## 🚀 How to Run

### Prerequisites
- Java 21+
- Gradle 8.x (or use wrapper provided)

### 1. Start the Application

**Option A: Using Gradle wrapper (recommended)**
```bash
cd /workspaces/devops/gradle
./gradlew bootRun
```

**Option B: Direct gradle command**
```bash
gradle bootRun
```

**Option C: Build & run JAR**
```bash
./gradlew build
java -jar build/libs/gradle-*.jar
```

### 2. Access the Application
- Home: http://localhost:8080
- Login: http://localhost:8080/login
- Register: http://localhost:8080/register

### 3. Run Tests
```bash
./gradlew test
```

### 4. Create JAR (using custom task)
```bash
./gradlew createjar
```

---

## 📋 Hardcoded Test Credentials

⚠️ **Note**: This project uses hardcoded credentials for demo purposes.

**Valid Login Credentials**:
- Username: `user`
- Password: `pass`

Located in: `src/main/java/com/example/gradle/controller/AuthController.java`

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
| POST | `/register` | Process registration (no storage) |

---

## 🎨 Pages & Templates

### 1. Home (`index.html`)
- Welcome page
- Navigation links to login and register
- Project introduction

### 2. Login (`login.html`)
- Username input field
- Password input field
- **Test credentials**: `user` / `pass`
- Link to registration
- Form POSTs to `/login`

### 3. Register (`register.html`)
- Username input field
- Password input field
- Submit button POSTs to `/register`
- Data not persisted (demo only)

### 4. Dashboard (`dashboard.html`)
- Shown after successful login
- Displays username parameter
- Welcome message

### 5. Success (`success.html`)
- Shown after registration attempt
- Confirmation message
- Navigation links

---

## ⚙️ Build Configuration

### build.gradle File

**Location**: `/workspaces/devops/gradle/build.gradle`

Key sections:
```gradle
plugins {
    id 'java'
    id 'org.springframework.boot' version '4.0.5'
    id 'io.spring.dependency-management' version '1.1.7'
}

group = 'com.example'
version = '0.0.1-SNAPSHOT'

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(21)
    }
}

// Custom task to create JAR
task createjar {
    dependsOn bootJar
    doLast {
        println "JAR file created: build/libs/gradle-${version}.jar"
        println "File size: " + file("build/libs/gradle-${version}.jar").size() + " bytes"
    }
}
```

### Application Properties

**File**: `src/main/resources/application.properties`

```properties
spring.application.name=gradle
# Add custom properties as needed
```

### Change Port

Add to `src/main/resources/application.properties`:
```properties
server.port=8081  # Default is 8080
```

---

## 🔄 Gradle Tasks

### Display available tasks
```bash
./gradlew tasks
```

### Common Gradle tasks

| Task | Purpose |
|------|---------|
| `./gradlew build` | Build project (compile, test, package) |
| `./gradlew clean` | Remove build directory |
| `./gradlew compile` | Compile source code only |
| `./gradlew test` | Run all tests |
| `./gradlew bootRun` | Run Spring Boot app |
| `./gradlew jar` | Create JAR file |
| `./gradlew bootJar` | Create executable Spring Boot JAR |
| `./gradlew createjar` | **Custom task** - create JAR with info |

---

## 📦 Custom Gradle Task: createjar

Found in: `build.gradle`

```gradle
task createjar {
    dependsOn bootJar
    doLast {
        println "JAR file created: build/libs/gradle-${version}.jar"
        println "File size: " + file("build/libs/gradle-${version}.jar").size() + " bytes"
    }
}
```

**Run custom task**:
```bash
./gradlew createjar
```

**Output example**:
```
JAR file created: build/libs/gradle-0.0.1-SNAPSHOT.jar
File size: 45678901 bytes
```

---

## 📦 Build & Package

### Build all (compile + test + package)
```bash
./gradlew build
# Output: build/libs/gradle-0.0.1-SNAPSHOT.jar
```

### Build without tests
```bash
./gradlew build -x test
```

### Build info
```bash
./gradlew build --info  # Verbose output
```

### Run packaged JAR
```bash
java -jar build/libs/gradle-0.0.1-SNAPSHOT.jar
```

### Run on different port
```bash
java -jar build/libs/gradle-0.0.1-SNAPSHOT.jar --server.port=9090
```

---

## 🔄 Customizable Elements

### 1. **Change Login Credentials**
Edit `src/main/java/com/example/gradle/controller/AuthController.java`:

```java
// Current (hardcoded)
if ("user".equals(user.getUsername()) && "pass".equals(user.getPassword())) {

// Change to:
if ("admin".equals(user.getUsername()) && "secret123".equals(user.getPassword())) {
```

Rebuild and restart:
```bash
./gradlew clean bootRun
```

### 2. **Add More Pages**
1. Create HTML: `src/main/resources/templates/newpage.html`
2. Add to controller:
```java
@GetMapping("/newpage")
public String newPage() {
    return "newpage";  // Returns templates/newpage.html
}
```

### 3. **Modify Styling**
Edit HTML templates and add CSS:
```html
<style>
    body { font-family: Arial; margin: 20px; }
    input { padding: 8px; }
</style>
```

Or link external CSS:
```html
<link rel="stylesheet" href="/css/style.css">
```

### 4. **Add Static Resources**
Create directories:
- `src/main/resources/static/css/` - CSS files
- `src/main/resources/static/js/` - JavaScript files
- `src/main/resources/static/images/` - Images

Reference in templates:
```html
<link rel="stylesheet" href="/css/style.css">
<script src="/js/app.js"></script>
<img src="/images/logo.png">
```

### 5. **Add Dependencies**
Edit `build.gradle` dependencies section:

```gradle
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-thymeleaf'
    implementation 'org.mysql:mysql-connector-java:8.0.33'  // Add MySQL
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}
```

Then rebuild:
```bash
./gradlew clean build
```

### 6. **Add Custom Gradle Tasks**
Examples in `build.gradle`:

```gradle
// Display build info
task buildInfo {
    doLast {
        println "Project: " + project.name
        println "Version: " + version
        println "Java: " + java.toolchain.languageVersion.get()
    }
}

// Print all dependencies
task showDeps {
    doLast {
        project.configurations.compile.each { println it.name }
    }
}

// Delete all class files
task deleteClasses {
    doLast {
        delete fileTree(dir: 'build/classes', include: '**/*.class')
    }
}
```

Run custom tasks:
```bash
./gradlew buildInfo
./gradlew showDeps
./gradlew deleteClasses
```

---

## 🧰 Gradle Wrapper

The `gradlew` and `gradlew.bat` scripts allow using Gradle without installing it globally.

### Wrapper files:
- `gradle/wrapper/gradle-wrapper.jar` - Wrapper runtime
- `gradle/wrapper/gradle-wrapper.properties` - Version configuration

### Check wrapper version:
```bash
cat gradle/wrapper/gradle-wrapper.properties
```

### Update wrapper to new Gradle version:
```bash
./gradlew wrapper --gradle-version=8.5
```

### Use wrapper for all commands:
```bash
./gradlew tasks      # Show all tasks
./gradlew build      # Build project
./gradlew bootRun    # Run app
```

---

## 📚 User Model

Located in: `src/main/java/com/example/gradle/model/User.java`

```java
public class User {
    private String username;
    private String password;
    // Constructors, getters, setters
}
```

**Note**: This is a POJO (Plain Old Java Object), NOT a database entity.

---

## 📦 Dependency Management

Gradle automatically handles dependency versions using Spring Boot's dependency management plugin.

To check resolved dependencies:
```bash
./gradlew dependencies
# Shows: compile, runtime, test dependencies with versions
```

Details:
```bash
./gradlew dependencies --configuration compileClasspath
```

---

## ❌ Troubleshooting

### Port 8080 already in use
```bash
# Kill process on port 8080
lsof -ti:8080 | xargs kill -9

# Or use different port
java -jar build/libs/gradle-0.0.1-SNAPSHOT.jar --server.port=9090
```

### "gradlew: command not found" (on Windows)
```bash
# Use .bat version
gradlew.bat bootRun
```

### Build fails
```bash
# Clean and rebuild
./gradlew clean build

# With verbose output
./gradlew clean build --debug
```

### Out of memory during build
```bash
# Increase heap size
export GRADLE_OPTS="-Xmx2048m"
./gradlew build
```

### 404 on templates
- Ensure files in: `src/main/resources/templates/`
- Return correct name from controller
- Restart app: `./gradlew bootRun`

### Tests fail
```bash
./gradlew test --info
# Check logs for specific failures
```

---

## 📊 Gradle vs Maven Comparison

| Aspect | Gradle | Maven |
|--------|--------|-------|
| Config file | `build.gradle` (Groovy) | `pom.xml` (XML) |
| Task execution | Fast (caching) | Slower |
| Dependency mgmt | Flexible | Strict |
| Learning curve | Steeper | Gentler |
| Customization | Very flexible | Limited |
| Script format | Groovy | XML |

---

## 🚀 Next Steps

1. **Add database**: JPA + MySQL integration (see Store project)
2. **Add logging**: SLF4J + Logback, Gradle config
3. **Add API testing**: REST Assured in tests
4. **Docker support**: Add `gradle docker` plugin
5. **CI/CD integration**: GitHub Actions + Gradle
6. **Add authentication**: Spring Security integration

---

## 📞 File References

- **Main class**: `src/main/java/com/example/gradle/GradleApplication.java`
- **Build config**: `build.gradle`
- **Settings**: `settings.gradle`
- **Properties**: `src/main/resources/application.properties`
- **Run app**: `./gradlew bootRun`
- **Run tests**: `./gradlew test`
- **Package JAR**: `./gradlew build` or `./gradlew createjar`

---

## 📖 Gradle Documentation

- Official Gradle Docs: https://docs.gradle.org
- Spring Boot Gradle Plugin: https://docs.spring.io/spring-boot/docs/current/gradle-plugin/reference/html/

