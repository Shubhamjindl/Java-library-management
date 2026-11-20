<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Transaction History — Library Management System" />
<c:set var="activeTab" value="transactions" />
<jsp:include page="common/header.jsp" />

<div class="row mb-4 align-items-center">
    <div class="col-md-7">
        <h2 class="fw-bold mb-1"><i class="bi bi-clock-history text-info me-2"></i>Borrowing Audit History</h2>
        <p class="text-muted mb-0">Complete historical audit trail of all library borrow and return operations.</p>
    </div>
    <div class="col-md-5 text-md-end mt-3 mt-md-0">
        <!-- Search filter by Member ID -->
        <form action="${pageContext.request.contextPath}/ui/transactions" method="get" class="d-flex justify-content-md-end gap-2">
            <div class="input-group" style="max-width: 280px;">
                <span class="input-group-text"><i class="bi bi-person-search"></i></span>
                <input type="number" name="memberId" class="form-control" placeholder="Filter by Member ID" value="${selectedMemberId != null ? selectedMemberId : ''}">
                <button type="submit" class="btn btn-outline-primary">Filter</button>
            </div>
            <c:if test="${not empty selectedMemberId}">
                <a href="${pageContext.request.contextPath}/ui/transactions" class="btn btn-outline-secondary">Reset</a>
            </c:if>
        </form>
    </div>
</div>

<div class="row g-4">
    <div class="col-12">
        <div class="card shadow-sm table-card">
            <div class="card-header bg-white py-3 border-0 d-flex justify-content-between align-items-center">
                <h5 class="card-title fw-bold mb-0">
                    <i class="bi bi-receipt me-2 text-info"></i>Records (${records != null ? records.size() : 0})
                    <c:if test="${not empty selectedMemberId}">
                        <span class="badge bg-primary-subtle text-primary ms-2">Member #${selectedMemberId}</span>
                    </c:if>
                </h5>
                <span class="badge bg-light text-dark border">Immutable Audit Trail</span>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th scope="col" style="width: 80px;">ID</th>
                            <th scope="col">Book Title</th>
                            <th scope="col">Member Name</th>
                            <th scope="col">Borrow Date</th>
                            <th scope="col">Due Date</th>
                            <th scope="col">Return Date</th>
                            <th scope="col" class="text-center" style="width: 130px;">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty records}">
                                <c:forEach var="r" items="${records}">
                                    <tr>
                                        <td class="fw-bold text-muted">#${r.id}</td>
                                        <td class="fw-semibold text-dark">
                                            <i class="bi bi-book me-1 text-primary"></i>${r.book.title}
                                            <small class="text-muted d-block">ID: #${r.book.id} &middot; Author: ${r.book.author}</small>
                                        </td>
                                        <td>
                                            <i class="bi bi-person me-1 text-secondary"></i>${r.member.name}
                                            <small class="text-muted d-block">ID: #${r.member.id} &middot; ${r.member.email}</small>
                                        </td>
                                        <td><span class="text-secondary">${r.borrowDate}</span></td>
                                        <td><span class="text-secondary">${r.dueDate}</span></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty r.returnDate}">
                                                    <span class="text-success fw-semibold">
                                                        <i class="bi bi-check2 me-1"></i>${r.returnDate}
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted italic">&mdash;</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${empty r.returnDate}">
                                                    <span class="badge bg-warning text-dark badge-status">
                                                        <i class="bi bi-hourglass-split me-1"></i> Active
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-success-subtle text-success border border-success badge-status">
                                                        <i class="bi bi-check-circle me-1"></i> Returned
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" class="text-center py-5 text-muted">
                                        <i class="bi bi-clock-history fs-1 d-block mb-2 text-secondary"></i>
                                        No borrow transactions found.
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
