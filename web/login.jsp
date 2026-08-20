<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Login</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <div class="container">
        <h2>Customer Login</h2>
        <%
            if ("registered".equals(request.getParameter("msg"))) {
                out.println("<p class='success-msg'>Registration successful! Please log in.</p>");
            }
            if ("invalid".equals(request.getParameter("error"))) {
                out.println("<p class='error-msg'>Invalid Email or Password!</p>");
            }
        %>

        <form action="LoginServlet" method="post">
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="t3" required>
            </div>
            
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="t2" required>
            </div>
            
            <button type="submit" class="btn">Login</button>
        </form>
        <br>
        <p class="link-text">
            <a href="index.jsp">Back to Home</a>
        </p>
    </div>

</body>
</html>