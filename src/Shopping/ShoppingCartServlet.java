package Shopping;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/shopp ing-cart")

public class ShoppingCartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 获取当前购物车对象，如果不存在则创建新的购物车
        HttpSession session = request.getSession(true);
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

        // 将购物车对象存入request作用域，并转发到显示购物车的JSP页面
        request.setAttribute("cart", cart);
        request.getRequestDispatcher("/shopping-cart.jsp").forward(request, response);
    }
}

