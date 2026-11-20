<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Servlet Demonstration — Library Management System" />
<c:set var="activeTab" value="servlet" />
<jsp:include page="common/header.jsp" />

<div class="row mb-4 align-items-center">
    <div class="col-md-8">
        <h2 class="fw-bold mb-1"><i class="bi bi-cpu text-info me-2"></i>Pure Java Servlet MVC Demonstration</h2>
        <p class="text-muted mb-0">Dispatched via <code>HttpServlet</code> forwarding directly to JSP without Spring Web MVC controllers.</p>
    </div>
    <div class="col-md-4 text-md-end mt-3 mt-md-0">
        <span class="badge bg-primary px-3 py-2 fs-6">
            <i class="bi bi-diagram-3 me-1"></i> jakarta.servlet.http.HttpServlet
        </span>
    </div>
</div>

<!-- Servlet Architecture Note Alert -->
<div class="alert alert-info shadow-sm mb-4">
    <div class="d-flex">
        <div class="me-3 fs-3 text-info">
            <i class="bi bi-info-circle-fill"></i>
        </div>
        <div>
            <h5 class="alert-heading fw-bold mb-1">How This Page Works (Academic / Viva Explanation)</h5>
            <p class="mb-1">
                This page is handled by <code>com.library.management.servlet.LibrarySummaryServlet</code> which extends standard <code>jakarta.servlet.http.HttpServlet</code>.
            </p>
            <p class="mb-0 small text-dark">
                The servlet intercepts the <code>GET /servlet/summary</code> request, queries the database services for system totals, attaches the data as request attributes via <code>request.setAttribute("totalBooks", ...)</code>, and transfers control to this JSP file using <code>request.getRequestDispatcher("/WEB-INF/jsp/summary.jsp").forward(request, response)</code>.
            </p>
        </div>
    </div>
</div>

<!-- Stat Cards -->
<div class="row g-3 mb-4">
    <div class="col-sm-6 col-lg-3">
        <div class="card stat-card p-3 shadow-sm h-100" style="border-left-color: #3498db;">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <span class="text-muted text-uppercase fw-semibold small">Catalog Books</span>
                    <h3 class="fw-bold my-1">${totalBooks}</h3>
                    <small class="text-muted">Managed via BookService</small>
                </div>
                <div class="stat-icon text-primary"><i class="bi bi-journal-check"></i></div>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-lg-3">
        <div class="card stat-card p-3 shadow-sm h-100" style="border-left-color: #2ecc71;">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <span class="text-muted text-uppercase fw-semibold small">Registered Members</span>
                    <h3 class="fw-bold my-1">${totalMembers}</h3>
                    <small class="text-muted">Managed via MemberService</small>
                </div>
                <div class="stat-icon text-success"><i class="bi bi-person-check"></i></div>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-lg-3">
        <div class="card stat-card p-3 shadow-sm h-100" style="border-left-color: #f39c12;">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <span class="text-muted text-uppercase fw-semibold small">Active Borrowings</span>
                    <h3 class="fw-bold my-1 text-warning">${activeLoansCount}</h3>
                    <small class="text-muted">Currently in loan</small>
                </div>
                <div class="stat-icon text-warning"><i class="bi bi-clock-history"></i></div>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-lg-3">
        <div class="card stat-card p-3 shadow-sm h-100" style="border-left-color: #9b59b6;">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <span class="text-muted text-uppercase fw-semibold small">Completed Returns</span>
                    <h3 class="fw-bold my-1 text-purple">${returnedLoansCount}</h3>
                    <small class="text-muted">Historical returns</small>
                </div>
                <div class="stat-icon text-secondary"><i class="bi bi-arrow-return-left"></i></div>
            </div>
        </div>
    </div>
</div>

<!-- Architecture comparison table -->
<div class="card shadow-sm table-card">
    <div class="card-header bg-white py-3 border-0">
        <h5 class="card-title fw-bold mb-0">
            <i class="bi bi-layers text-primary me-2"></i>Multi-Paradigm Architecture In This Project
        </h5>
    </div>
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-bordered align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th style="width: 25%;">Layer / Technology</th>
                        <th style="width: 25%;">Route / Prefix</th>
                        <th style="width: 25%;">Purpose</th>
                        <th style="width: 25%;">Output Format</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="fw-semibold">
                            <span class="badge bg-success me-2">15 REST APIs</span>
                            <code>@RestController</code>
                        </td>
                        <td><code>/books</code>, <code>/members</code>, <code>/borrow</code></td>
                        <td>Machine-to-machine APIs (Postman, Mobile Apps, Single Page Apps)</td>
                        <td><span class="badge bg-secondary">JSON</span></td>
                    </tr>
                    <tr>
                        <td class="fw-semibold">
                            <span class="badge bg-primary me-2">JSP MVC UI</span>
                            <code>@Controller</code>
                        </td>
                        <td><code>/ui/*</code></td>
                        <td>Human-facing interactive web portal with Bootstrap 5</td>
                        <td><span class="badge bg-secondary">HTML / JSP</span></td>
                    </tr>
                    <tr>
                        <td class="fw-semibold">
                            <span class="badge bg-info me-2">Pure Servlet</span>
                            <code>HttpServlet</code>
                        </td>
                        <td><code>/servlet/summary</code></td>
                        <td>Native Java Servlet standard demonstrating RequestDispatcher forwarding</td>
                        <td><span class="badge bg-secondary">JSP Forward</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
