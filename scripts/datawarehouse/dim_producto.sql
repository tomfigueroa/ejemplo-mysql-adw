


insert into adw_datawh.dim_producto (producto_id,
                                     producto_nombre,
                                     producto_categoria,
                                     producto_subcategoria,
                                     producto_color,
                                     producto_tamanio,
                                     producto_peso)
select Production_Product.ProductID as producto_id,
       Production_Product.Name as producto_nombre,
       MAX(
               Production_ProductCategory.Name
       )                            as producto_categoria,
       MAX(
               Production_ProductSubcategory.Name
       )                            as producto_subcategoria,
       IFNULL(
               MAX(Production_Product.Color),
               'Desconocido'
       )                            as producto_color,
       IFNULL(
               MAX(Production_Product.Size),
               'Desconocido'
       )                            as producto_tamanio,
        CASE
            WHEN MAX(Production_Product.Weight) BETWEEN 0 AND 10 THEN 'de 0 a 10 libras'
            WHEN MAX(Production_Product.Weight) BETWEEN 11 AND 20 THEN 'de 11 a 20 libras'
            WHEN MAX(Production_Product.Weight) BETWEEN 21 AND 30 THEN 'de 21 a 30 libras'
            WHEN MAX(Production_Product.Weight) BETWEEN 31 AND 200 THEN 'de 31 a 200 gramos'
            WHEN MAX(Production_Product.Weight) BETWEEN 201 AND 400 THEN 'de 201 a 400 gramos'
            WHEN MAX(Production_Product.Weight) BETWEEN 401 AND 600 THEN 'de 401 a 600 gramos'
            WHEN MAX(Production_Product.Weight) BETWEEN 601 AND 800 THEN 'de 601 a 800 gramos'
            WHEN MAX(Production_Product.Weight) BETWEEN 801 AND 1000 then 'de 801 a 1000 gramos'
            WHEN MAX(Production_Product.Weight) IS NULL THEN 'Desconocido'
            ELSE 'más de 1000 gramos'
        END as producto_peso
from adw.Production_Product
         inner join adw.Production_ProductSubcategory
                    on Production_Product.ProductSubcategoryID = Production_ProductSubcategory.ProductSubcategoryID
         inner join adw.Production_ProductCategory
                    on Production_ProductSubcategory.ProductCategoryID = Production_ProductCategory.ProductCategoryID
group by ProductID;