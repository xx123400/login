package Shopping;

import java.util.HashMap;
import java.util.Map;

public class ShoppingCart {
    private Map<String, Integer> items;

    public ShoppingCart() {
        items = new HashMap<>();
    }

    public void addItem(String itemId, int quantity) {
        // 如果购物车中已经存在该商品，则将数量相加
        if (items.containsKey(itemId)) {
            quantity += items.get(itemId);
        }
        items.put(itemId, quantity);
    }

    public void removeItem(String itemId) {
        items.remove(itemId);
    }

    public void updateItemQuantity(String itemId, int quantity) {
        items.put(itemId, quantity);
    }

    public Map<String, Integer> getItems() {
        return items;
    }
}