<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Borrow & Return — Library Management System" />
<c:set var="activeTab" value="borrow" />
<jsp:include page="common/header.jsp" />

<div class="row mb-4 align-items-center">
    <div class="col-md-7">
        <h2 class="fw-bold mb-1"><i class="bi bi-arrow-left-right text-primary me-2"></i>Borrow & Return</h2>
        <p class="text-muted mb-0">Issue books to registered members and process book returns.</p>
    </div>
</div>

<div class="row g-4">
    <!-- Issue Book Card -->
    <div class="col-lg-4">
        <div class="card shadow-sm h-100">
            <div class="card-header bg-white py-3 border-0">
                <h5 class="card-title fw-bold mb-0">
                    <i class="bi bi-box-arrow-right text-primary me-2"></i>Issue a Book
                </h5>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/ui/transactions/borrow" method="post">
                    <div class="mb-3">
                        <label for="bookId" class="form-label fw-semibold">Select Available Book <span class="text-danger">*</span></label>
                        <select class="form-select" id="bookId" name="bookId" required>
                            <option value="">-- Choose a Book --</option>
                            <c:forEach var="b" items="${availableBooks}">
                                <option value="${b.id}">#${b.id} - ${b.title} (${b.author})</option>
                            </c:forEach>
                        </select>
                        <c:if test="${empty availableBooks}">
                            <div class="form-text text-danger">No books are currently available to borrow.</div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label for="memberId" class="form-label fw-semibold">Select Member <span class="text-danger">*</span></label>
                        <select class="form-select" id="memberId" name="memberId" required>
                            <option value="">-- Choose a Member --</option>
                            <c:forEach var="m" items="${members}">
                                <option value="${m.id}">#${m.id} - ${m.name} (${m.email})</option>
                            </c:forEach>
                        </select>
                        <c:if test="${empty members}">
                            <div class="form-text text-danger">No members registered yet. Please register a member first.</div>
                        </c:if>
                    </div>

                    <div class="alert alert-info py-2 small mb-3">
                        <i class="bi bi-info-circle me-1"></i> Loan period is <strong>14 days</strong> from the date of issue.
                    </div>

                    <button type="submit" class="btn btn-primary w-100" <c:if test="${empty availableBooks || empty members}">disabled</c:if>>
                        <i class="bi bi-check-circle me-1"></i> Confirm Issue
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- Active Loans Table Card -->
    <div class="col-lg-8">
        <div class="card shadow-sm table-card h-100">
            <div class="card-header bg-white py-3 border-0 d-flex justify-content-between align-items-center">
                <h5 class="card-title fw-bold mb-0">
                    <i class="bi bi-clock-history text-warning me-2"></i>Active Loans (${activeRecords != null ? activeRecords.size() : 0})
                </h5>
                <span class="badge bg-warning-subtle text-warning border border-warning">Pending Return</span>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th scope="col" style="width: 70px;">ID</th>
                            <th scope="col">Book Title</th>
                            <th scope="col">Borrower</th>
                            <th scope="col">Borrowed</th>
                            <th scope="col">Due Date</th>
                            <th scope="col" class="text-end" style="width: 130px;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty activeRecords}">
                                <c:forEach var="rec" items="${activeRecords}">
                                    <tr>
                                        <td class="fw-bold text-muted">#${rec.id}</td>
                                        <td class="fw-semibold text-dark">
                                            <i class="bi bi-book me-1 text-primary"></i>${rec.book.title}
                                        </td>
                                        <td>
                                            <i class="bi bi-person me-1 text-secondary"></i>${rec.member.name}
                                        </td>
                                        <td><span class="small text-muted">${rec.borrowDate}</span></td>
                                        <td>
                                            <span class="badge bg-light text-dark border">
                                                <i class="bi bi-calendar-event me-1"></i>${rec.dueDate}
                                            </span>
                                        </td>
                                        <td class="text-end">
                                            <form action="${pageContext.request.contextPath}/ui/transactions/return/${rec.id}" method="post" style="display:inline;" onsubmit="return confirm('Confirm return of book #${rec.book.id} (${rec.book.title})?');">
                                                <button type="submit" class="btn btn-success btn-sm">
                                                    <i class="bi bi-arrow-return-left me-1"></i> Return
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="text-center py-5 text-muted">
                                        <i class="bi bi-check2-circle fs-1 d-block mb-2 text-success"></i>
                                        All books are currently in the library! No active loans.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
