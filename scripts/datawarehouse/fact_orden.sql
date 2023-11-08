


insert into adw_datawh.fact_orden(
        orden_id,
        orden_ingresos,
        orden_costos ,
        orden_utilidad,  
        orden_cantidad ,
        orden_descuento,
        fecha_key ,     
        vendedor_key  ,  
        producto_key ,   
        tienda_key      
)
with datos as (
    select 
Sales_SalesOrderHeader.SalesOrderID as orden_id ,
SalesOrderDetailID,
SalesPersonID,
CustomerID,
OrderDate,
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
),
datos_transformados as (
    select
        
        orden_id,
        OrderQty as orden_cantidad ,
        orden_costos,
        utilidad_producto as orden_utilidad,
        total_orden as orden_ingresos,
        monto_descuento as orden_descuento,
        dim_vendedor.vendedor_key as vendedor_key,
        dim_producto.producto_key as producto_key,
        dim_tienda.tienda_key as tienda_key,
        to_days(OrderDate) as fecha_key
        
    from
        datos
        join adw_datawh.dim_vendedor on datos.SalesPersonID = dim_vendedor.vendedor_id
        join adw_datawh.dim_producto on datos.ProductID = dim_producto.producto_id
        join adw_datawh.dim_tienda on datos.CustomerID = dim_tienda.tienda_id
        
)
select *
from datos_transformados
;