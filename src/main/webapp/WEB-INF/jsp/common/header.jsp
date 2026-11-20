<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : "Library Management System"}</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2c3e50;
            --accent-color: #3498db;
        }
        body {
            background-color: #f8f9fa;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .navbar-brand {
            font-weight: 700;
            letter-spacing: 0.5px;
        }
        .nav-link {
            font-weight: 500;
            transition: color 0.2s ease-in-out;
        }
        .nav-link:hover {
            color: #3498db !important;
        }
        .nav-link.active {
            color: #3498db !important;
            border-bottom: 2px solid #3498db;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            transition: transform 0.2s ease;
        }
        .stat-card {
            border-left: 4px solid var(--accent-color);
        }
        .stat-icon {
            font-size: 2.2rem;
            opacity: 0.85;
        }
        .table-card {
            border-radius: 10px;
            overflow: hidden;
        }
        .badge-status {
            padding: 6px 12px;
            font-weight: 600;
            border-radius: 20px;
        }
        footer {
            margin-top: auto;
            background-color: #2c3e50;
            color: #ecf0f1;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark py-3 shadow-sm sticky-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/ui">
                <i class="bi bi-book-half me-2 text-primary fs-4"></i>
                <span>Library Management</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-search"></span>
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link ${activeTab == 'dashboard' ? 'active' : ''}" href="${pageContext.request.contextPath}/ui">
                            <i class="bi bi-speedometer2 me-1"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${activeTab == 'books' ? 'active' : ''}" href="${pageContext.request.contextPath}/ui/books">
                            <i class="bi bi-journal-bookmark me-1"></i> Books
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${activeTab == 'members' ? 'active' : ''}" href="${pageContext.request.contextPath}/ui/members">
                            <i class="bi bi-people me-1"></i> Members
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${activeTab == 'borrow' ? 'active' : ''}" href="${pageContext.request.contextPath}/ui/borrow">
                            <i class="bi bi-arrow-left-right me-1"></i> Borrow / Return
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${activeTab == 'transactions' ? 'active' : ''}" href="${pageContext.request.contextPath}/ui/transactions">
                            <i class="bi bi-clock-history me-1"></i> Transactions
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container my-4">
        <!-- Flash Alert Messages -->
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
