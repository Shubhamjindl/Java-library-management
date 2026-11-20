<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Manage Members — Library Management System" />
<c:set var="activeTab" value="members" />
<jsp:include page="common/header.jsp" />

<div class="row mb-4 align-items-center">
    <div class="col-md-7">
        <h2 class="fw-bold mb-1"><i class="bi bi-people text-success me-2"></i>Member Management</h2>
        <p class="text-muted mb-0">Register new library patrons and manage existing memberships.</p>
    </div>
    <div class="col-md-5 text-md-end mt-3 mt-md-0">
        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addMemberModal">
            <i class="bi bi-person-plus me-1"></i> Register Member
        </button>
    </div>
</div>

<div class="row g-4">
    <!-- Members List Table -->
    <div class="col-12">
        <div class="card shadow-sm table-card">
            <div class="card-header bg-white py-3 border-0 d-flex justify-content-between align-items-center">
                <h5 class="card-title fw-bold mb-0">
                    <i class="bi bi-person-lines-fill me-2 text-success"></i>Registered Members (${members != null ? members.size() : 0})
                </h5>
                <span class="badge bg-light text-dark border">Auto-synced with MySQL</span>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th scope="col" style="width: 80px;">ID</th>
                            <th scope="col">Full Name</th>
                            <th scope="col">Email Address</th>
                            <th scope="col">Phone Number</th>
                            <th scope="col" class="text-end" style="width: 130px;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty members}">
                                <c:forEach var="m" items="${members}">
                                    <tr>
                                        <td class="fw-bold text-muted">#${m.id}</td>
                                        <td class="fw-semibold text-dark">
                                            <div class="d-flex align-items-center">
                                                <div class="avatar-sm bg-success text-white rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 32px; height: 32px; font-size: 14px;">
                                                    ${m.name.substring(0, 1).toUpperCase()}
                                                </div>
                                                <span>${m.name}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <a href="mailto:${m.email}" class="text-decoration-none">
                                                <i class="bi bi-envelope me-1 text-secondary"></i>${m.email}
                                            </a>
                                        </td>
                                        <td>
                                            <span class="text-muted">
                                                <i class="bi bi-telephone me-1 text-secondary"></i>${m.phone}
                                            </span>
                                        </td>
                                        <td class="text-end">
                                            <form action="${pageContext.request.contextPath}/ui/members/delete/${m.id}" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete member #${m.id} (${m.name})?');">
                                                <button type="submit" class="btn btn-outline-danger btn-sm" title="Delete Member">
                                                    <i class="bi bi-trash"></i> Delete
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" class="text-center py-5 text-muted">
                                        <i class="bi bi-people fs-1 d-block mb-2 text-secondary"></i>
                                        No members registered yet. Click "Register Member" to add one!
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

<!-- Add Member Modal -->
<div class="modal fade" id="addMemberModal" tabindex="-1" aria-labelledby="addMemberModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/ui/members/add" method="post">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="addMemberModalLabel">
                        <i class="bi bi-person-plus text-success me-2"></i>Register New Member
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="memberName" class="form-label fw-semibold">Full Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="memberName" name="name" required placeholder="e.g. John Doe">
                    </div>
                    <div class="mb-3">
                        <label for="memberEmail" class="form-label fw-semibold">Email Address <span class="text-danger">*</span></label>
                        <input type="email" class="form-control" id="memberEmail" name="email" required placeholder="e.g. john.doe@example.com">
                    </div>
                    <div class="mb-3">
                        <label for="memberPhone" class="form-label fw-semibold">Phone Number <span class="text-danger">*</span></label>
                        <input type="tel" class="form-control" id="memberPhone" name="phone" required placeholder="e.g. 9876543210">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success">
                        <i class="bi bi-check2-circle me-1"></i> Register Member
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
