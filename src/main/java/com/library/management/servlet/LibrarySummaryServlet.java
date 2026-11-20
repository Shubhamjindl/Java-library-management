package com.library.management.servlet;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

import com.library.management.entity.Book;
import com.library.management.entity.BorrowRecord;
import com.library.management.entity.Member;
import com.library.management.service.BookService;
import com.library.management.service.BorrowService;
import com.library.management.service.MemberService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Pure Java HttpServlet demonstration.
 * Handles GET /servlet/summary requests and forwards to /WEB-INF/jsp/summary.jsp
 * using the standard Jakarta Servlet RequestDispatcher.
 */
@Component
public class LibrarySummaryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Autowired
    private BookService bookService;

    @Autowired
    private MemberService memberService;

    @Autowired
    private BorrowService borrowService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Fetch data from business services
        List<Book> books = bookService.getAllBooks();
        List<Member> members = memberService.getAllMembers();
        List<BorrowRecord> activeRecords = borrowService.getActiveRecords();
        List<BorrowRecord> allRecords = borrowService.getAllRecords();

        // 2. Set request attributes for the JSP view
        request.setAttribute("totalBooks", books.size());
        request.setAttribute("totalMembers", members.size());
        request.setAttribute("activeLoansCount", activeRecords.size());
        request.setAttribute("returnedLoansCount", allRecords.size() - activeRecords.size());

        // 3. Forward request to JSP presentation layer
        request.getRequestDispatcher("/WEB-INF/jsp/summary.jsp").forward(request, response);
    }

    /**
     * Configuration bean to register this pure HttpServlet in embedded Tomcat.
     */
    @Configuration
    public static class ServletConfig {
        @Bean
        public ServletRegistrationBean<LibrarySummaryServlet> registerSummaryServlet(LibrarySummaryServlet servlet) {
            ServletRegistrationBean<LibrarySummaryServlet> bean =
                    new ServletRegistrationBean<>(servlet, "/servlet/summary");
            bean.setLoadOnStartup(1);
            return bean;
        }
    }
}
