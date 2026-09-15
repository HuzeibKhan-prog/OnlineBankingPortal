<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Login - Online Banking Portal</title>
    <link rel="stylesheet" type="text/css" href="style.css?v=2">
</head>
<body>

    <div class="page-container">
        <div class="card">
            <div class="section-heading">
                <span>PORTAL ACCESS</span>
                <h1>Customer Login</h1>
                <p>Enter your credentials to manage your banking account.</p>
            </div>

            <%
                String error = request.getParameter("error");
                if ("invalid".equals(error)) {
            %>
                <div class="alert-error">Invalid Email or Password. Please try again.</div>
            <%
                } else if ("exception".equals(error)) {
            %>
                <div class="alert-error">A server error occurred. Please try again later.</div>
            <%
                }
            %>

            <form action="LoginServlet" method="post">
                <div class="form-group">
                    <label for="email">Email Address:</label>
                    <input type="email" id="email" name="t3" class="form-control" placeholder="name@example.com" required>
                </div>

                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="t2" class="form-control" placeholder="Enter your password" required>
                </div>

                <button type="submit" class="btn-primary">Login</button>
            </form>

            <a href="index.jsp" class="link-secondary">Back to Home</a>
        </div>
    </div>

</body>
</html>