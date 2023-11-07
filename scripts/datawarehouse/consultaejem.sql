use adw;


select 
Sales_SalesOrderHeader.SalesOrderID as orderid ,
SalesOrderDetailID,
OrderQty,
ProductID,
UnitPrice,
LineTotal,
(UnitPrice*OrderQty)as ingreso_producto,
(UnitPrice*OrderQty - LineTotal)as monto_descuento,
UnitPriceDiscount,
Sales_SalesOrderDetail.rowguid,
TotalDue
FROM adw.Sales_SalesOrderHeader
join adw.Sales_SalesOrderDetail USING (SalesOrderID)
limit 100;