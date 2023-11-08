

use adw;


 select 
Sales_SalesOrderHeader.SalesOrderID as orden_id ,
SalesOrderDetailID,
SalesPersonID,
CustomerID,
TO_DAYS(OrderDate),
OrderQty,
ProductID,
UnitPrice,
StandardCost,
LineTotal as total_orden,
(UnitPrice*OrderQty)as precio_por_unidades,
(StandardCost*OrderQty) as orden_costos,
((UnitPrice  - StandardCost )*OrderQty - UnitPrice*OrderQty*UnitPriceDiscount) as utilidad_producto,
(UnitPrice*OrderQty - LineTotal)as monto_descuento,
TotalDue
FROM adw.Sales_SalesOrderHeader
join adw.Sales_SalesOrderDetail USING (SalesOrderID)
join adw.Production_Product USING (ProductID)
limit 100;


select 
Sales_SalesOrderHeader.SalesOrderID as orderid ,
SalesOrderDetailID,
OrderQty,
ProductID,
UnitPrice,
LineTotal,
(UnitPrice*OrderQty)as precio_por_unidades,
(UnitPrice*OrderQty - LineTotal)as monto_descuento,
TotalDue
FROM adw.Sales_SalesOrderHeader
join adw.Sales_SalesOrderDetail USING (SalesOrderID)
limit 100;