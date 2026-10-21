package com.library.management.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.library.management.entity.Book;
import com.library.management.repository.BookRepository;

@Service
public class BookService {

    @Autowired
    private BookRepository respository;

    public Book saveBook(Book book) {
        return respository.save(book);
    }

    public List<Book> getAllBooks() {
        return respository.findAll();
    }

    public Book getBookById(int id) {
        return respository.findById(id).orElse(null);
    }

    public Book updateBook(Book book) {
        return respository.save(book);
    }

    public String deleteBook(int id) {
    	if (respository.existsById(id)) {
    		respository.deleteById(id);
    	    return "Book Deleted Successfully";
    	}
    	return "Book Not Found";
    }
}