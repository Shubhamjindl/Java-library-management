package com.library.management.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.library.management.entity.BorrowRecord;

public interface BorrowRecordRepository extends JpaRepository<BorrowRecord, Long> {

    boolean existsByBook_IdAndReturnDateIsNull(int bookId);

    boolean existsByBook_Id(int bookId);

    boolean existsByMember_Id(Long memberId);

    List<BorrowRecord> findByMember_Id(Long memberId);

    List<BorrowRecord> findByReturnDateIsNull();
}
