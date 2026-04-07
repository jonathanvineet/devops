# Spring Boot Authentication App (Gradle)

A minimal MVC-based user authentication application built with Spring Boot using Gradle.

## Project Structure

```
src/main/java/com/example/gradle/
├── GradleApplication.java      # Spring Boot main application
├── controller/
│   └── AuthController.java     # Routes for login/register
├── model/
│   └── User.java               # User data model
└── src/main/resources/templates/
    ├── index.html              # Home page
    ├── login.html              # Login form
    ├── register.html           # Registration form
    ├── dashboard.html          # Dashboard after login
    └── success.html            # Registration success page
```

## Features

- **Login** - Demo credentials: username: `user`, password: `pass`
- **Register** - Register new users
- **Dashboard** - Welcome page after successful login
- **Simple MVC Architecture** - Model, View, Controller separation

## Prerequisites

- Java 21+
- Gradle 8.0+ (or use included Gradle wrapper)

## Build

### macOS/Linux
```bash
cd gradle
./gradlew clean build -x test
```

### Windows
```cmd
cd gradle
gradlew.bat clean build -x test
```

## Run

### macOS/Linux
```bash
./gradlew bootRun
```

Or run the JAR directly:
```bash
java -jar build/libs/gradle-0.0.1-SNAPSHOT.jar
```

### Windows
```cmd
gradlew.bat bootRun
```

Or run the JAR directly:
```cmd
java -jar build\libs\gradle-0.0.1-SNAPSHOT.jar
```

## Access the Application

Open your browser and go to:
- **Home**: http://localhost:8080/
- **Login**: http://localhost:8080/login (use: user/pass)
- **Register**: http://localhost:8080/register

## Credentials

**Test Login:**
- Username: `user`
- Password: `pass`

## Technologies

- Spring Boot 4.0.5
- Spring Web
- Thymeleaf (Template Engine)
- Java 21
- Gradle
