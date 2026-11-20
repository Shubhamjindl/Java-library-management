package com.library.management.controller;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.management.entity.Book;
import com.library.management.entity.BorrowRecord;
import com.library.management.entity.Member;
import com.library.management.service.BookService;
import com.library.management.service.BorrowService;
import com.library.management.service.MemberService;

@Controller
public class WebViewController {

    @Autowired
    private BookService bookService;

    @Autowired
    private MemberService memberService;

    @Autowired
    private BorrowService borrowService;

    // --- Dashboard ---
    @GetMapping({"/", "/ui"})
    public String dashboard(Model model) {
        List<Book> books = bookService.getAllBooks();
        List<Member> members = memberService.getAllMembers();
        List<BorrowRecord> activeLoans = borrowService.getActiveRecords();
        List<BorrowRecord> allRecords = borrowService.getAllRecords();

        model.addAttribute("totalBooks", books.size());
        model.addAttribute("totalMembers", members.size());
        model.addAttribute("activeLoansCount", activeLoans.size());
        model.addAttribute("returnedLoansCount", allRecords.size() - activeLoans.size());
        model.addAttribute("activeLoans", activeLoans);
        return "dashboard";
    }

    // --- Books View & Actions ---
    @GetMapping("/ui/books")
    public String listBooks(Model model) {
        List<Book> books = bookService.getAllBooks();
        Set<Integer> borrowedBookIds = borrowService.getActiveRecords().stream()
                .map(r -> r.getBook().getId())
                .collect(Collectors.toSet());

        model.addAttribute("books", books);
        model.addAttribute("borrowedBookIds", borrowedBookIds);
        return "books";
    }

    @PostMapping("/ui/books/add")
    public String addBook(@RequestParam String title,
                          @RequestParam String author,
                          @RequestParam(required = false) String category,
                          @RequestParam Double price,
                          RedirectAttributes redirectAttributes) {
        try {
            Book book = new Book();
            book.setTitle(title.trim());
            book.setAuthor(author.trim());
            book.setCategory(category != null ? category.trim() : null);
            book.setPrice(price);
            bookService.saveBook(book);
            redirectAttributes.addFlashAttribute("message", "Book '" + title + "' added successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to add book: " + e.getMessage());
        }
        return "redirect:/ui/books";
    }

    @PostMapping("/ui/books/delete/{id}")
    public String deleteBook(@PathVariable int id, RedirectAttributes redirectAttributes) {
        try {
            bookService.deleteBook(id);
            redirectAttributes.addFlashAttribute("message", "Book #" + id + " deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Cannot delete book #" + id + ": " + e.getMessage());
        }
        return "redirect:/ui/books";
    }

    // --- Members View & Actions ---
    @GetMapping("/ui/members")
    public String listMembers(Model model) {
        model.addAttribute("members", memberService.getAllMembers());
        return "members";
    }

    @PostMapping("/ui/members/add")
    public String addMember(@RequestParam String name,
                            @RequestParam String email,
                            @RequestParam String phone,
                            RedirectAttributes redirectAttributes) {
        try {
            Member member = new Member();
            member.setName(name.trim());
            member.setEmail(email.trim());
            member.setPhone(phone.trim());
            memberService.saveMember(member);
            redirectAttributes.addFlashAttribute("message", "Member '" + name + "' registered successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to register member: " + e.getMessage());
        }
        return "redirect:/ui/members";
    }

    @PostMapping("/ui/members/delete/{id}")
    public String deleteMember(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            memberService.deleteMember(id);
            redirectAttributes.addFlashAttribute("message", "Member #" + id + " deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Cannot delete member #" + id + ": " + e.getMessage());
        }
        return "redirect:/ui/members";
    }

    // --- Borrow & Return View & Actions ---
    @GetMapping("/ui/borrow")
    public String borrowPage(Model model) {
        List<Book> allBooks = bookService.getAllBooks();
        Set<Integer> borrowedBookIds = borrowService.getActiveRecords().stream()
                .map(r -> r.getBook().getId())
                .collect(Collectors.toSet());

        List<Book> availableBooks = allBooks.stream()
                .filter(b -> !borrowedBookIds.contains(b.getId()))
                .collect(Collectors.toList());

        model.addAttribute("availableBooks", availableBooks);
        model.addAttribute("members", memberService.getAllMembers());
        model.addAttribute("activeRecords", borrowService.getActiveRecords());
        return "borrow";
    }

    @PostMapping("/ui/transactions/borrow")
    public String issueBook(@RequestParam int bookId,
                            @RequestParam Long memberId,
                            RedirectAttributes redirectAttributes) {
        try {
            BorrowRecord record = borrowService.borrowBook(bookId, memberId);
            redirectAttributes.addFlashAttribute("message", "Book '" + record.getBook().getTitle() + "' successfully issued to " + record.getMember().getName() + " (Due: " + record.getDueDate() + ")");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to issue book: " + e.getMessage());
        }
        return "redirect:/ui/borrow";
    }

    @PostMapping("/ui/transactions/return/{id}")
    public String returnBook(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            BorrowRecord record = borrowService.returnBook(id);
            redirectAttributes.addFlashAttribute("message", "Book '" + record.getBook().getTitle() + "' returned successfully on " + record.getReturnDate() + "!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to return book: " + e.getMessage());
        }
        return "redirect:/ui/borrow";
    }

    // --- Transactions Audit Log ---
    @GetMapping("/ui/transactions")
    public String transactions(@RequestParam(required = false) Long memberId, Model model) {
        List<BorrowRecord> records;
        if (memberId != null) {
            records = borrowService.getRecordsByMember(memberId);
            model.addAttribute("selectedMemberId", memberId);
        } else {
            records = borrowService.getAllRecords();
        }
        model.addAttribute("records", records);
        return "transactions";
    }
}
