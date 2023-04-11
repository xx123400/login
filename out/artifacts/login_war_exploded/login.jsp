<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>主页</title>
</head>
<body>
<h1>欢迎登录</h1>
<form method="post">
    <label for="username">用户名:</label>
    <input type="text" id="username" name="用户名"><br><br>
    <label for="password">密码:</label>
    <input type="password" id="password" name="密码"><br><br>
    <input type="submit" value="登录">
    <input type="button" onclick="javascript:window.location.href='register.jsp';" value="注册"  >
</form>

<%
    if ("POST".equals(request.getMethod())) {
        String username = request.getParameter("用户名");
        String password = request.getParameter("密码");
        String url = "jdbc:mysql://localhost:3306/test";
        String user = "root";
        String dbPassword = "123456";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, dbPassword);
            String sql = "SELECT * FROM user WHERE username=? AND password=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
if (rs.next()) {
    response.sendRedirect("shopping-cart.jsp");
    out.print("登录成功");
} else {
    // Check if username exists in database
    String sql2 = "SELECT * FROM user WHERE username=?";
    PreparedStatement pstmt2 = conn.prepareStatement(sql2);
    pstmt2.setString(1, username);
    ResultSet rs2 = pstmt2.executeQuery();
    if (rs2.next()) {
        out.print("密码错误");
    } else {
        out.print("用户名不存在");
    }
}
            conn.close();
        } catch (Exception e) {
            out.print(e);
        }
    }
%>
</body>
</html>
