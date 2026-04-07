# Spring Boot Authentication App

A minimal MVC-based user authentication application built with Spring Boot.

## Project Structure

```
src/main/java/com/example/maven/
├── MavenApplication.java       # Spring Boot main application
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
- Maven 3.6+

## Build

### macOS/Linux
```bash
cd maven/maven
mvn clean install -DskipTests
```

### Windows
```cmd
cd maven\maven
mvn clean install -DskipTests
```

## Run

### macOS/Linux
```bash
export JAVA_HOME=/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home
java -jar target/maven-0.0.1-SNAPSHOT.jar
```

Or use Maven:
```bash
mvn spring-boot:run
```

### Windows
```cmd
set JAVA_HOME=C:\Program Files\Java\jdk-21
java -jar target\maven-0.0.1-SNAPSHOT.jar
```

Or use Maven:
```cmd
mvn spring-boot:run
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
