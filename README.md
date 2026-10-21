# Library Management System

A RESTful backend for managing a library's books, members and borrowing transactions, built with **Java 17, Spring Boot, Spring Data JPA (Hibernate) and Oracle SQL**.

## Features
- Full CRUD for **books** and **members**
- **Borrowing transactions**: borrow a book (14-day loan), return it, and view all / active / per-member records
- Business rules: a book already on loan cannot be borrowed again; unknown book/member/record IDs return `404`; a double return returns `409`
- Layered architecture: Controller → Service → Repository → Entity

## Tech Stack
Java 17 · Spring Boot 3 · Spring Data JPA · Hibernate · Oracle SQL · Maven · Postman

## Project Structure
```
src/main/java/com/library/management
├── controller   # REST endpoints (Book, Member, Borrow)
├── service      # business logic
├── repository   # Spring Data JPA repositories
└── entity       # Book, Member, BorrowRecord
```

## Getting Started
**Prerequisites:** JDK 17+, Oracle Database (e.g. XE on `localhost:1521`).

1. Clone the repo.
2. Create your local credentials file:
   ```bash
   cp src/main/resources/application-local.properties.example src/main/resources/application-local.properties
   ```
   Then edit it with your Oracle username and password (this file is git-ignored).
3. If your DB URL differs, change `spring.datasource.url` in `application.properties`.
4. Run:
   ```bash
   ./mvnw spring-boot:run        # Windows: mvnw.cmd spring-boot:run
   ```
The app starts on **http://localhost:8082**. Tables are created automatically (`ddl-auto=update`).

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/books` | Add a book |
| GET | `/books` | List all books |
| GET | `/books/{id}` | Get a book |
| PUT | `/books` | Update a book |
| DELETE | `/books/{id}` | Delete a book |
| POST | `/members` | Add a member |
| GET | `/members` | List all members |
| GET | `/members/{id}` | Get a member |
| PUT | `/members/{id}` | Update a member |
| DELETE | `/members/{id}` | Delete a member |
| POST | `/transactions/borrow?bookId=&memberId=` | Borrow a book |
| PUT | `/transactions/return/{recordId}` | Return a book |
| GET | `/transactions` | All borrow records |
| GET | `/transactions/active` | Books currently on loan |
| GET | `/transactions/member/{memberId}` | A member's history |

## Example Requests
```bash
# add a book
curl -X POST localhost:8082/books -H "Content-Type: application/json" \
  -d '{"id":1,"title":"Clean Code","author":"Robert C. Martin","price":450,"category":"Programming"}'

# add a member
curl -X POST localhost:8082/members -H "Content-Type: application/json" \
  -d '{"name":"Amit","email":"amit@example.com","phone":"9999999999"}'

# borrow book 1 as member 1, then return it (use the record id from the response)
curl -X POST "localhost:8082/transactions/borrow?bookId=1&memberId=1"
curl -X PUT localhost:8082/transactions/return/1
```

## Author
Shubham Jindal — [GitHub](https://github.com/Shubhamjindl) · [LinkedIn](https://linkedin.com/in/shubham-jindal)
