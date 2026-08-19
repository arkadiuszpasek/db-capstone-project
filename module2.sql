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