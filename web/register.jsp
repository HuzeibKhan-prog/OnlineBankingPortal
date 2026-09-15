<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Registration - Online Banking Portal</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

    <div class="page-container">
        <div class="card">
            <div class="section-heading">
                <h1>Customer Registration</h1>
                <p>Create a new account to access our online banking services.</p>
            </div>

            <form action="RegistrationServlet" method="post">
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="t1" class="form-control" placeholder="Enter your username" required>
                </div>

                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="t2" class="form-control" placeholder="Enter your password" required>
                </div>

                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="t3" class="form-control" placeholder="name@example.com" required>
                </div>

                <div class="form-group">
                    <label for="country">Country:</label>
                    <select id="country" name="country" class="form-control" required>
                        <option value="" disabled selected>Select your country</option>
                        <option value="India">India</option>
                        <option value="United States">United States</option>
                        <option value="United Kingdom">United Kingdom</option>
                        <option value="Canada">Canada</option>
                        <option value="Australia">Australia</option>
                        <option value="United Arab Emirates">United Arab Emirates</option>
                        <option value="Germany">Germany</option>
                    </select>
                </div>

                <button type="submit" class="btn-primary">Register</button>
            </form>

            <a href="index.jsp" class="link-secondary">Back to Home</a>
        </div>
    </div>

</body>
</html>