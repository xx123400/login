<%@ page  contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Register</title>
</head>
<body>
	<form method="post" action="register.jsp">
		<label for="username">用户名</label>
		<input type="text" id="username" name="username"><br><br>
		<label for="password">密码</label>
		<input type="password" id="password" name="password"><br><br>
		<label for="confirmPassword">输入密码再次确认</label>
		<input type="password" id="confirmPassword" name="confirmPassword"><br><br>
		<input type="submit" value="注册">
	</form>
	<%
	    // 检查密码是否匹配
	    String username = request.getParameter("username");
	    String password = request.getParameter("password");
	    String confirmPassword = request.getParameter("confirmPassword");
	    if (password != null && password.equals(confirmPassword)) {
	        try {
	            // 连接数据库
	            Class.forName("com.mysql.jdbc.Driver");
				try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "123456")) {
					String sql = "INSERT INTO user (username, password) VALUES (?, ?)";
					PreparedStatement pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, username);
					pstmt.setString(2, password);
					pstmt.executeUpdate();
					out.println("注册成功,3秒后将自动跳转至登录页面");
					response.setHeader("refresh", "3;URL=login.jsp");

				}
			} catch (Exception e) {
	            out.println("注册失败: " + e.getMessage());
	        }
	    } else if (confirmPassword != null) {
	        out.println("两次输入的密码不对");
	    }
	%>
</body>
</html>
