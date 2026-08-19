CREATE VIEW OrdersView AS SELECT OrderId, Quantity, TotalCost FROM Orders WHERE Quantity > 2;

SELECT
  customers.CustomerId,
  customers.Name,
  orders.OrderId,
  orders.TotalCost,
  menu.Name,
  menu_items.CourseName
FROM customers
INNER JOIN orders ON orders.CustomerId = customers.CustomerId
INNER JOIN menu ON menu.MenuId = orders.MenuId
INNER JOIN menu_items ON menu_items.MenuItemsId = menu.MenuItemsId
WHERE orders.TotalCost > 150;

SELECT Name
FROM menu
WHERE menu.MenuId = ANY (SELECT MenuId FROM Orders WHERE Quantity > 2)


CREATE PROCEDURE GetMaxQuantity()
SELECT MAX(Quantity) AS "Max Quantity in orders" FROM orders;

PREPARE GetOrderDetail FROM
'SELECT OrderId, Quantity, TotalCost
FROM orders
WHERE CustomerId = ?';

SET @id = 1;
EXECUTE GetOrderDetail USING @id;

DELIMITER //

CREATE PROCEDURE CancelOrder(IN p_OrderId INT)
BEGIN
    DELETE FROM orders 
    WHERE OrderId = p_OrderId;
END //

DELIMITER ;