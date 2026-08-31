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
                String error = request.getParameter("error");
                if ("invalid".equals(error)) {
            %>
            <script type="text/javascript">
                alert("Invalid Email or Password!");
            </script>
            <%
            } else if ("exception".equals(error)) {
            %>
            <script type="text/javascript">
                alert("A server error occurred. Please try again.");
            </script>
            <%
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