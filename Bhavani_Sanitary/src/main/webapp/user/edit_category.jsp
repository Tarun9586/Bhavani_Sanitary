<%@page import="com.entity.category"%>
<%@page import="com.dao.CategoryDao"%>
<%@page import="com.db.HibernateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Edit Category | Admin</title>

<%@include file="../components/all_css.jsp"%>

<style>

body{
    background-color:#f4f6f9;
    padding-top:90px;
    overflow-x:hidden;
}

/* MAIN CARD */

.edit-card{
    border:none;
    border-radius:22px;
    overflow:hidden;
    background:#fff;
    box-shadow:0 6px 20px rgba(0,0,0,0.08);
}

/* HEADER */

.edit-header{
    background:linear-gradient(135deg,#0d6efd,#3d8bfd);
    padding:22px;
    text-align:center;
    color:#fff;
}

.edit-header h2{
    margin:0;
    font-weight:700;
    font-size:2rem;
}

/* BODY */

.edit-body{
    padding:35px;
}

/* LABELS */

.form-label{
    font-weight:600;
    color:#333;
    margin-bottom:8px;
}

/* INPUT */

.form-control{
    border-radius:14px;
    padding:12px 15px;
    border:1px solid #dcdcdc;
    font-size:0.95rem;
    transition:0.3s;
}

.form-control:focus{
    box-shadow:0 0 0 0.2rem rgba(13,110,253,0.15);
    border-color:#0d6efd;
}

/* TEXTAREA */

textarea.form-control{
    resize:none;
}

/* BUTTONS */

.action-btn{
    border-radius:40px;
    padding:12px 28px;
    font-weight:600;
    transition:0.3s;
}

.action-btn:hover{
    transform:translateY(-2px);
}

/* RESPONSIVE */

@media(max-width:768px){

    body{
        padding-top:80px;
    }

    .container{
        padding-left:12px;
        padding-right:12px;
    }

    .edit-header{
        padding:18px;
    }

    .edit-header h2{
        font-size:1.5rem;
    }

    .edit-body{
        padding:22px;
    }

    .form-control{
        font-size:0.9rem;
        padding:11px 14px;
    }

    .btn-group-mobile{
        display:flex;
        flex-direction:column;
        gap:12px;
    }

    .action-btn{
        width:100%;
    }

}

@media(max-width:480px){

    .edit-header h2{
        font-size:1.3rem;
    }

    .edit-body{
        padding:18px;
    }

}

</style>

</head>

<body>

<%@include file="../components/navbar.jsp"%>

<%

    int cid = Integer.parseInt(request.getParameter("cid"));

    CategoryDao dao = new CategoryDao(HibernateUtil.getSessionFactory());

    category cat = dao.getCategoryById(cid);

%>

<div class="container">

    <div class="row justify-content-center">

        <div class="col-lg-6 col-md-8 col-12">

            <div class="card edit-card">

                <!-- HEADER -->

                <div class="edit-header">

                    <h2>
                        <i class="bi bi-pencil-square me-2"></i>
                        Edit Category
                    </h2>

                </div>

                <!-- BODY -->

                <div class="edit-body">

                    <form action="../UpdateCategoryServlet" method="post">

                        <!-- HIDDEN ID -->

                        <input type="hidden"
                               name="cid"
                               value="<%= cat.getCategoryID() %>">

                        <!-- CATEGORY TITLE -->

                        <div class="mb-4">

                            <label class="form-label">
                                Category Title
                            </label>

                            <input type="text"
                                   name="catTitle"
                                   value="<%= cat.getCategoryTitle() %>"
                                   class="form-control"
                                   placeholder="Enter category title"
                                   required>

                        </div>

                        <!-- CATEGORY DESCRIPTION -->

                        <div class="mb-4">

                            <label class="form-label">
                                Category Description
                            </label>

                            <textarea name="catDesc"
                                      class="form-control"
                                      rows="6"
                                      placeholder="Enter category description"
                                      required><%= cat.getCategoryDescription() %></textarea>

                        </div>

                        <!-- BUTTONS -->

                        <div class="btn-group-mobile d-flex justify-content-center gap-3 mt-4">

                            <button type="submit"
                                    class="btn btn-success action-btn">

                                <i class="bi bi-check-circle me-2"></i>
                                Update Category

                            </button>

                            <a href="admin.jsp"
                               class="btn btn-secondary action-btn">

                               <i class="bi bi-arrow-left me-2"></i>
                               Cancel

                            </a>

                        </div>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>