package com.library.management.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.library.management.entity.Book;
import com.library.management.entity.BorrowRecord;
import com.library.management.entity.Member;
import com.library.management.repository.BookRepository;
import com.library.management.repository.BorrowRecordRepository;
import com.library.management.repository.MemberRepository;

@Service
public class BorrowService {

    private static final int LOAN_PERIOD_DAYS = 14;

    @Autowired
    private BorrowRecordRepository recordRepository;

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private MemberRepository memberRepository;

    public BorrowRecord borrowBook(int bookId, Long memberId) {
        Book book = bookRepository.findById(bookId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));
        Member member = memberRepository.findById(memberId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Member not found"));

        if (recordRepository.existsByBook_IdAndReturnDateIsNull(bookId)) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Book is already borrowed");
        }

        BorrowRecord record = new BorrowRecord();
        record.setBook(book);
        record.setMember(member);
        record.setBorrowDate(LocalDate.now());
        record.setDueDate(LocalDate.now().plusDays(LOAN_PERIOD_DAYS));
        return recordRepository.save(record);
    }

    public BorrowRecord returnBook(Long recordId) {
        BorrowRecord record = recordRepository.findById(recordId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Borrow record not found"));

        if (record.getReturnDate() != null) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Book already returned");
        }

        record.setReturnDate(LocalDate.now());
        return recordRepository.save(record);
    }

    public List<BorrowRecord> getAllRecords() {
        return recordRepository.findAll();
    }

    public List<BorrowRecord> getActiveRecords() {
        return recordRepository.findByReturnDateIsNull();
    }

    public List<BorrowRecord> getRecordsByMember(Long memberId) {
        return recordRepository.findByMember_Id(memberId);
    }
}
