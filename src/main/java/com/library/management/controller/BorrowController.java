package com.library.management.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.library.management.entity.BorrowRecord;
import com.library.management.service.BorrowService;

@RestController
@RequestMapping("/transactions")
public class BorrowController {

    @Autowired
    private BorrowService service;

    @PostMapping("/borrow")
    public BorrowRecord borrowBook(@RequestParam int bookId, @RequestParam Long memberId) {
        return service.borrowBook(bookId, memberId);
    }

    @PutMapping("/return/{recordId}")
    public BorrowRecord returnBook(@PathVariable Long recordId) {
        return service.returnBook(recordId);
    }

    @GetMapping
    public List<BorrowRecord> getAllRecords() {
        return service.getAllRecords();
    }

    @GetMapping("/active")
    public List<BorrowRecord> getActiveRecords() {
        return service.getActiveRecords();
    }

    @GetMapping("/member/{memberId}")
    public List<BorrowRecord> getRecordsByMember(@PathVariable Long memberId) {
        return service.getRecordsByMember(memberId);
    }
}
