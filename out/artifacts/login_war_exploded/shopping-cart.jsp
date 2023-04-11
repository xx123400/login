<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="Shopping.ShoppingCart" %>
<%
    // 获取当前购物车对象，如果不存在则创建新的购物车
    ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
    if (cart == null) {
        cart = new ShoppingCart();
        session.setAttribute("cart", cart);
    }

    // 根据不同的请求参数执行不同的操作
    String action = request.getParameter("action");
    if ("add".equals(action)) {
        String itemId = request.getParameter("itemId");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        cart.addItem(itemId, quantity);
    } else if ("remove".equals(action)) {
        String itemId = request.getParameter("itemId");
        cart.removeItem(itemId);
    } else if ("update".equals(action)) {
        String itemId = request.getParameter("itemId");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        cart.updateItemQuantity(itemId, quantity);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>购物车</title>
</head>
<body>
<h1>购物车</h1>
<table border="1">
    <tr>
        <td>商品编号</td>
        <td>商品名称</td>
        <td>商品单价</td>
        <td>数量</td>
        <td>小计</td>
        <td>操作</td>
    </tr>
    <% for (Map.Entry<String, Integer> entry : cart.getItems().entrySet()) { %>
    <tr>
        <td><%= entry.getKey() %></td>
        <td>商品<%= entry.getKey() %></td>
        <td>10.00</td>
        <td><input type="text" size="2" name="quantity" value="<%= entry.getValue() %>"></td>
        <td><%= entry.getValue() * 10.00 %></td>
        <td><a href="?action=remove&itemId=<%= entry.getKey() %>">删除</a></td>
    </tr>
    <% } %>
    <tr>
        <td colspan="4">总计：</td>
        <td><%
            double total = 0;
            for (int quantity : cart.getItems().values()) {
                total += quantity * 10.00;
            }
            out.print(total);
        %></td>
        <td>&nbsp;</td>
    </tr>
</table>
<hr>
<form action="?action=add" method="post">
    商品编号：<input type="text" name="itemId"><br>
    数量：<input type="text" name="quantity"><br>
    <input type="submit" value="添加到购物车">
</form>
</body>
</html>