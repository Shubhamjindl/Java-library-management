package com.library.management.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.library.management.entity.Book;
import com.library.management.repository.BookRepository;
import com.library.management.repository.BorrowRecordRepository;

@Service
public class BookService {

    @Autowired
    private BookRepository repository;

    @Autowired
    private BorrowRecordRepository borrowRecordRepository;

    public Book saveBook(Book book) {
        book.setId(null); // let the database generate the auto-increment id
        return repository.save(book);
    }

    public List<Book> getAllBooks() {
        return repository.findAll();
    }

    public Book getBookById(int id) {
        return repository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found with id: " + id));
    }

    public Book updateBook(int id, Book book) {
        getBookById(id); // verify existence, throws 404 if missing
        book.setId(id);
        return repository.save(book);
    }

    public String deleteBook(int id) {
        if (!repository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found with id: " + id);
        }
        if (borrowRecordRepository.existsByBook_Id(id)) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Cannot delete book: borrowing records exist for this book");
        }
        repository.deleteById(id);
        return "Book Deleted Successfully";
    }
}
