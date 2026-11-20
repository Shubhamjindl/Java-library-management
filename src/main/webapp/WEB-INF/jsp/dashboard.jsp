<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Dashboard — Library Management System" />
<c:set var="activeTab" value="dashboard" />
<jsp:include page="common/header.jsp" />

<div class="row mb-4 align-items-center">
    <div class="col-md-8">
        <h2 class="fw-bold mb-1"><i class="bi bi-speedometer2 text-primary me-2"></i>Dashboard Overview</h2>
        <p class="text-muted">Welcome to the Library Management System administration console.</p>
    </div>
    <div class="col-md-4 text-md-end">
        <a href="${pageContext.request.contextPath}/ui/borrow" class="btn btn-primary">
            <i class="bi bi-plus-circle me-1"></i> Issue a Book
        </a>
    </div>
</div>

<!-- Key Stat Cards -->
<div class="row g-3 mb-4">
    <div class="col-sm-6 col-lg-3">
        <div class="card stat-card p-3 shadow-sm h-100" style="border-left-color: #3498db;">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <span class="text-muted text-uppercase fw-semibold small">Total Books</span>
                    <h3 class="fw-bold my-1">${totalBooks}</h3>
                    <a href="${pageContext.request.contextPath}/ui/books" class="small text-decoration-none">View catalog &rarr;</a>
                </div>
                <div class="stat-icon text-primary"><i class="bi bi-journals"></i></div>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-lg-3">
        <div class="card stat-card p-3 shadow-sm h-100" style="border-left-color: #2ecc71;">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <span class="text-muted text-uppercase fw-semibold small">Registered Members</span>
                    <h3 class="fw-bold my-1">${totalMembers}</h3>
                    <a href="${pageContext.request.contextPath}/ui/members" class="small text-decoration-none text-success">Manage members &rarr;</a>
                </div>
                <div class="stat-icon text-success"><i class="bi bi-person-badge"></i></div>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-lg-3">
        <div class="card stat-card p-3 shadow-sm h-100" style="border-left-color: #f39c12;">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <span class="text-muted text-uppercase fw-semibold small">Active Loans</span>
                    <h3 class="fw-bold my-1 text-warning">${activeLoansCount}</h3>
                    <a href="${pageContext.request.contextPath}/ui/borrow" class="small text-decoration-none text-warning">Process returns &rarr;</a>
                </div>
                <div class="stat-icon text-warning"><i class="bi bi-hourglass-split"></i></div>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-lg-3">
        <div class="card stat-card p-3 shadow-sm h-100" style="border-left-color: #9b59b6;">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <span class="text-muted text-uppercase fw-semibold small">Total Transactions</span>
                    <h3 class="fw-bold my-1 text-purple">${totalTransactions}</h3>
                    <a href="${pageContext.request.contextPath}/ui/transactions" class="small text-decoration-none" style="color: #9b59b6;">Audit history &rarr;</a>
                </div>
                <div class="stat-icon" style="color: #9b59b6;"><i class="bi bi-receipt"></i></div>
            </div>
        </div>
    </div>
</div>

<!-- Quick Action Shortcuts & Active Loans -->
<div class="row g-4">
    <div class="col-lg-8">
        <div class="card shadow-sm p-4 h-100">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold mb-0"><i class="bi bi-bookmark-check text-warning me-2"></i>Currently Active Loans</h5>
                <span class="badge bg-warning text-dark">${activeLoansCount} Open</span>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Loan #</th>
                            <th>Book Title</th>
                            <th>Borrower</th>
                            <th>Borrowed</th>
                            <th>Due Date</th>
                            <th class="text-end">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty activeLoans}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-4">
                                        <i class="bi bi-check2-circle fs-3 d-block text-success mb-2"></i>
                                        All books are currently in the library inventory. No active loans!
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="loan" items="${activeLoans}">
                                    <tr>
                                        <td><strong>#${loan.id}</strong></td>
                                        <td>${loan.book.title}</td>
                                        <td>${loan.member.name}</td>
                                        <td>${loan.borrowDate}</td>
                                        <td><span class="badge bg-danger-subtle text-danger">${loan.dueDate}</span></td>
                                        <td class="text-end">
                                            <form action="${pageContext.request.contextPath}/ui/transactions/return/${loan.id}" method="post" style="display:inline;">
                                                <button type="submit" class="btn btn-sm btn-outline-success">
                                                    <i class="bi bi-box-arrow-in-left me-1"></i> Return
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Quick Actions Panel -->
    <div class="col-lg-4">
        <div class="card shadow-sm p-4 h-100">
            <h5 class="fw-bold mb-3"><i class="bi bi-lightning-charge text-primary me-2"></i>Quick Actions</h5>
            <div class="d-grid gap-2">
                <a href="${pageContext.request.contextPath}/ui/books" class="btn btn-outline-primary text-start py-2">
                    <i class="bi bi-journal-plus me-2 fs-5"></i> Add New Book
                </a>
                <a href="${pageContext.request.contextPath}/ui/members" class="btn btn-outline-success text-start py-2">
                    <i class="bi bi-person-plus me-2 fs-5"></i> Register Member
                </a>
                <a href="${pageContext.request.contextPath}/ui/borrow" class="btn btn-outline-warning text-dark text-start py-2">
                    <i class="bi bi-arrow-left-right me-2 fs-5"></i> Issue / Return Loan
                </a>
                <a href="${pageContext.request.contextPath}/servlet/summary" class="btn btn-outline-info text-start py-2">
                    <i class="bi bi-cpu me-2 fs-5"></i> Pure Servlet Demo
                </a>
            </div>

            <div class="mt-4 p-3 bg-light rounded border">
                <h6 class="fw-bold mb-1"><i class="bi bi-shield-check text-success me-1"></i> Architecture Note</h6>
                <small class="text-muted d-block">
                    This interface is rendered server-side via <strong>Spring MVC + JSP</strong>, sharing the same persistence layer and service rules as the 15 REST endpoints.
                </small>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
