


insert into adw_datawh.fact_orden(
        orden_id
        orden_ingresos
        orden_costos ,
        orden_utilidad,  
        orden_cantidad ,
        orden_descuento 


)

with datos as (
    SELECT

    SalesOrderDetailID,
    OrderQty,
    ProductID

        



        FROM adw.Sales_SalesOrderDetail
)