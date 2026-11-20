<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Manage Books — Library Management System" />
<c:set var="activeTab" value="books" />
<jsp:include page="common/header.jsp" />

<div class="row mb-4 align-items-center">
    <div class="col-md-7">
        <h2 class="fw-bold mb-1"><i class="bi bi-journal-bookmark text-primary me-2"></i>Book Management</h2>
        <p class="text-muted mb-0">Add new books to the catalog and review existing inventory.</p>
    </div>
    <div class="col-md-5 text-md-end mt-3 mt-md-0">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBookModal">
            <i class="bi bi-plus-circle me-1"></i> Add New Book
        </button>
    </div>
</div>

<div class="row g-4">
    <!-- Books List Table -->
    <div class="col-12">
        <div class="card shadow-sm table-card">
            <div class="card-header bg-white py-3 border-0 d-flex justify-content-between align-items-center">
                <h5 class="card-title fw-bold mb-0">
                    <i class="bi bi-bookshelf me-2 text-primary"></i>Book Catalog (${books != null ? books.size() : 0})
                </h5>
                <span class="badge bg-light text-dark border">Auto-synced with MySQL</span>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th scope="col" style="width: 80px;">ID</th>
                            <th scope="col">Title</th>
                            <th scope="col">Author</th>
                            <th scope="col">Category</th>
                            <th scope="col">Price</th>
                            <th scope="col">Status</th>
                            <th scope="col" class="text-end" style="width: 130px;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty books}">
                                <c:forEach var="book" items="${books}">
                                    <tr>
                                        <td class="fw-bold text-muted">#${book.id}</td>
                                        <td class="fw-semibold text-dark">
                                            <i class="bi bi-book me-2 text-secondary"></i>${book.title}
                                        </td>
                                        <td>${book.author}</td>
                                        <td>
                                            <span class="badge bg-secondary-subtle text-secondary border">
                                                ${book.category != null ? book.category : "General"}
                                            </span>
                                        </td>
                                        <td class="fw-semibold text-success">&#8377; ${book.price}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${borrowedBookIds.contains(book.id)}">
                                                    <span class="badge bg-warning text-dark badge-status">
                                                        <i class="bi bi-clock-history me-1"></i> Borrowed
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-success-subtle text-success border border-success badge-status">
                                                        <i class="bi bi-check-circle me-1"></i> Available
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end">
                                            <form action="${pageContext.request.contextPath}/ui/books/delete/${book.id}" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete book #${book.id} (${book.title})?');">
                                                <button type="submit" class="btn btn-outline-danger btn-sm" title="Delete Book">
                                                    <i class="bi bi-trash"></i> Delete
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" class="text-center py-5 text-muted">
                                        <i class="bi bi-journal-x fs-1 d-block mb-2 text-secondary"></i>
                                        No books found in the catalog. Click "Add New Book" to get started!
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

<!-- Add Book Modal -->
<div class="modal fade" id="addBookModal" tabindex="-1" aria-labelledby="addBookModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/ui/books/add" method="post">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="addBookModalLabel">
                        <i class="bi bi-plus-circle text-primary me-2"></i>Add New Book
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="title" class="form-label fw-semibold">Book Title <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="title" name="title" required placeholder="e.g. Clean Code">
                    </div>
                    <div class="mb-3">
                        <label for="author" class="form-label fw-semibold">Author <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="author" name="author" required placeholder="e.g. Robert C. Martin">
                    </div>
                    <div class="mb-3">
                        <label for="category" class="form-label fw-semibold">Category</label>
                        <input type="text" class="form-control" id="category" name="category" placeholder="e.g. Software Engineering">
                    </div>
                    <div class="mb-3">
                        <label for="price" class="form-label fw-semibold">Price (&#8377;) <span class="text-danger">*</span></label>
                        <input type="number" step="0.01" class="form-control" id="price" name="price" required placeholder="e.g. 599.00">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-check2-circle me-1"></i> Save Book
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
