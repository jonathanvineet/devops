# Store Application

A Spring Boot application to manage products with 3 input fields: **name**, **price**, and **quantity**.

## Features

- Add new products
- View all products in a list
- Edit existing products
- Delete products
- Persistent storage in MySQL database
- Unit tests with H2 in-memory database

## MVC Architecture

- **Model**: Product entity with name, price, quantity
- **View**: Thymeleaf templates (add-product.html, product-list.html, edit-product.html)
- **Controller**: ProductController with endpoints for CRUD operations
- **Service**: ProductService for business logic
- **Repository**: ProductRepository (JPA) for database access

## Setup

### Database Configuration

Update `src/main/resources/application.properties`:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/store_db
spring.datasource.username=root
spring.datasource.password=changeit
```

Create the MySQL database:

```sql
CREATE DATABASE store_db;
```

### Run the Application

```bash
mvn spring-boot:run
```

Access the application at: `http://localhost:8080`

### Run Tests

```bash
mvn test
```

## Endpoints

- `GET /` or `GET /products` - View all products
- `GET /add` - Show add product form
- `POST /add` - Add new product
- `GET /edit/{id}` - Show edit form for a product
- `POST /update/{id}` - Update existing product
- `GET /delete/{id}` - Delete a product
