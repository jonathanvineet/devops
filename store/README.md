# Store Application - Complete Documentation

A Spring Boot MVC application for managing products. Accepts 3 inputs: **product name**, **price**, and **quantity**, storing them persistently in a MySQL database.

---

## 📁 Project Structure

```
store/
├── src/
│   ├── main/
│   │   ├── java/com/example/store/
│   │   │   ├── StoreApplication.java          # Main Spring Boot entry point
│   │   │   ├── model/
│   │   │   │   └── Product.java               # Product entity (name, price, qty)
│   │   │   ├── repository/
│   │   │   │   └── ProductRepository.java     # JPA repository for Product CRUD
│   │   │   ├── service/
│   │   │   │   └── ProductService.java        # Business logic
│   │   │   └── controller/
│   │   │       └── ProductController.java     # HTTP endpoints
│   │   └── resources/
│   │       ├── application.properties         # MySQL configuration
│   │       └── templates/
│   │           ├── product-list.html          # View all products + edit/delete
│   │           ├── add-product.html           # Form to add new product
│   │           └── edit-product.html          # Form to edit existing product
│   └── test/
│       ├── java/com/example/store/
│       │   ├── StoreApplicationTests.java     # Base test class
│       │   └── service/
│       │       └── ProductServiceTest.java    # Unit tests (6 tests)
│       └── resources/
│           └── application.properties         # H2 in-memory DB for tests
├── pom.xml                                    # Maven dependencies
├── mvnw / mvnw.cmd                           # Maven wrapper scripts
├── README_STORE.md                            # Quick start guide
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
- MySQL Server running (for real database)

### 1. Start the Application

**Option A: Using MySQL Database**
```bash
cd /workspaces/devops/store
mvn spring-boot:run
```

**Option B: Using Maven Wrapper**
```bash
./mvnw spring-boot:run
```

### 2. Access the Application
- Product List: http://localhost:8080 or http://localhost:8080/products
- Add Product: http://localhost:8080/add
- Edit Product: http://localhost:8080/edit/{id}
- Delete Product: http://localhost:8080/delete/{id}

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
spring.datasource.url=jdbc:mysql://localhost:3306/store_db
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
CREATE DATABASE store_db;
USE store_db;
-- Tables will be auto-created by Hibernate
```

---

## 📋 API Endpoints

| Method | URL | Description |
|--------|-----|-------------|
| GET | `/` or `/products` | List all products |
| GET | `/add` | Show add product form |
| POST | `/add` | Add new product (name, price, quantity) |
| GET | `/edit/{id}` | Show edit form for product |
| POST | `/update/{id}` | Update product |
| GET | `/delete/{id}` | Delete product |

---

## 🛍️ Product Model

### Entity: Product
Located in: `src/main/java/com/example/store/model/Product.java`

**Table**: `products`

| Column | Type | Constraints |
|--------|------|-------------|
| id | BIGINT | Primary Key, Auto-increment |
| name | VARCHAR(255) | Not Null |
| price | DOUBLE | Not Null |
| quantity | INT | Not Null |

**Example SQL**:
```sql
SELECT * FROM products;
INSERT INTO products (name, price, quantity) VALUES ('Laptop', 999.99, 5);
UPDATE products SET quantity = 3 WHERE id = 1;
DELETE FROM products WHERE id = 1;
```

---

## 🎯 Service Layer

### ProductService
Located in: `src/main/java/com/example/store/service/ProductService.java`

**Methods**:
- `addProduct(String name, Double price, Integer quantity)` - Create new product
- `getAllProducts()` - Fetch all products (List<Product>)
- `getProductById(Long id)` - Find single product by ID
- `updateProduct(Long id, String name, Double price, Integer quantity)` - Modify product
- `deleteProduct(Long id)` - Remove product from database

---

## 🎨 UI Templates

### 1. Product List (`product-list.html`)
- Displays all products in an HTML table
- Columns: ID, Name, Price, Quantity, Actions
- Edit button (yellow) - goes to `/edit/{id}`
- Delete button (red) - deletes with confirmation
- "Add New Product" button (green) - goes to `/add`
- Price formatted as currency ($USD)
- Empty state message if no products exist

### 2. Add Product Form (`add-product.html`)
- Text input: Product Name (required)
- Number input: Price (decimal, required)
- Number input: Quantity (integer, required)
- Submit button to POST to `/add`
- Link back to product list
- Styled form with padding and border

### 3. Edit Product Form (`edit-product.html`)
- Pre-filled fields with current product values
- Same inputs as add form (name, price, quantity)
- Submit button to POST to `/update/{id}`
- Link back to product list
- Updates existing product in database

---

## 🧪 Testing

### Test File
Located in: `src/test/java/com/example/store/service/ProductServiceTest.java`

**Tests Included**:
1. ✅ `addProductTest()` - Test creating new product
2. ✅ `getAllProductsTest()` - Test fetching all products
3. ✅ `getProductByIdTest()` - Test finding product by ID
4. ✅ `updateProductTest()` - Test modifying product
5. ✅ `deleteProductTest()` - Test deleting product
6. ✅ `T/test for size verification` - Verify all products stored

**Run tests**:
```bash
mvn test
# Or specific test:
mvn test -Dtest=ProductServiceTest
# Run with output:
mvn test -X
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
spring.datasource.url=jdbc:mysql://host:3306/store_db
```

### 2. **Port**
Add to `src/main/resources/application.properties`:
```properties
server.port=8081  # Default is 8080
```

### 3. **Add More Product Fields**
To add fields like description, category, supplier, etc:
1. Edit `src/main/java/com/example/store/model/Product.java` - Add @Column fields
2. Edit `src/main/resources/templates/add-product.html` - Add input fields
3. Edit `src/main/resources/templates/edit-product.html` - Add input fields with th:value
4. Edit `src/main/java/com/example/store/controller/ProductController.java` - Update @RequestParam and service calls
5. Restart app (Hibernate will auto-create new columns)

**Example: Add description field**
```java
// In Product.java
@Column(nullable = false)
private String description;

// In add-product.html
<label>Description: 
    <input type="text" name="description" required/>
</label>

// In ProductController
public String addProduct(@RequestParam String name,
                        @RequestParam Double price,
                        @RequestParam Integer quantity,
                        @RequestParam String description) {
    productService.addProduct(name, price, quantity, description);
    return "redirect:/products";
}
```

### 4. **Styling & Appearance**
Edit HTML templates in `src/main/resources/templates/`:
- Modify CSS in `<style>` tags
- Change colors: `#4CAF50` (green), `red`, `blue`, etc.
- Adjust layout, borders, spacing
- Add Thymeleaf attributes: `th:if`, `th:each`, `th:class`

### 5. **Table Sorting/Filtering**
Current: Simple list of all products
To add:
- Sort by name/price: Add `@Query` in ProductRepository
- Filter: Add filter parameters to ProductService
- Pagination: Use `Page<Product>` and `Pageable` parameter

### 6. **Data Validation**
Add validation annotations to Product model:
```java
import javax.validation.constraints.*;

@NotBlank(message = "Name required")
private String name;

@Positive(message = "Price must be positive")
private Double price;

@Positive(message = "Quantity must be positive")
private Integer quantity;
```

---

## 🛠️ Build & Package

### Create JAR file
```bash
mvn clean package
# JAR will be at: target/store-0.0.1-SNAPSHOT.jar
```

### Run packaged JAR
```bash
java -jar target/store-0.0.1-SNAPSHOT.jar
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
- Verify database exists: `CREATE DATABASE store_db;`

### Port 8080 already in use
- Change port in `application.properties`: `server.port=8081`
- OR kill process: `lsof -ti:8080 | xargs kill -9`

### 404 errors on templates
- Ensure HTML files are in: `src/main/resources/templates/`
- Correct names: `add-product.html`, `product-list.html`, `edit-product.html`
- Restart app

### Tests fail
- Clear Maven cache: `mvn clean test`
- Delete node_modules: `rm -rf ~/.m2/repository`

### "No products found" message shows
- Database is empty - add a product via UI
- OR insert via MySQL:
```sql
INSERT INTO products (name, price, quantity) VALUES ('Test', 99.99, 10);
```

---

## 📚 Sample Data

Insert test products for demo:
```sql
INSERT INTO products (name, price, quantity) VALUES
('Laptop', 999.99, 5),
('Mouse', 25.50, 100),
('Keyboard', 75.00, 50),
('Monitor', 350.00, 20),
('USB Cable', 10.00, 200);
```

---

## 🔍 Database Queries

### View all products
```sql
SELECT * FROM products;
```

### Find products by price range
```sql
SELECT * FROM products WHERE price BETWEEN 50 AND 500;
```

### Find low stock items (qty < 10)
```sql
SELECT * FROM products WHERE quantity < 10;
```

### Update product price
```sql
UPDATE products SET price = 899.99 WHERE name = 'Laptop';
```

### Delete all products (careful!)
```sql
DELETE FROM products;
```

---

## 📞 File References

- **Main class**: `src/main/java/com/example/store/StoreApplication.java`
- **Configuration**: `src/main/resources/application.properties`
- **Dependencies**: `pom.xml`
- **Run app**: `mvn spring-boot:run`
- **Run tests**: `mvn test`

---

## 🚀 Next Steps

1. **Add search functionality**: Filter products by name
2. **Add pagination**: Display 10 products per page
3. **Add stock alerts**: Warn when quantity is low
4. **Add image uploads**: Upload product images
5. **Add categories**: Organize products by type
6. **Export to CSV**: Download product list

