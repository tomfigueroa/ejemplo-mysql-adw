
with territorio_y_ventas as (
    select 
    distinct Person_CountryRegion.CountryRegionCode as Cod_ISO,
    Person_CountryRegion.Name as pais,
    Person_StateProvince.TerritoryID as TerritoryID,
    Sales_SalesTerritory.Name as Lugar_ventas,
    Person_StateProvince.Name as Provincia

    from Person_CountryRegion
        join Person_StateProvince using(CountryRegionCode)
        join Sales_SalesTerritory on Sales_SalesTerritory.TerritoryID =Person_StateProvince.TerritoryID

),

ventas_por_territorio as (
    select
        distinct SalesOrderID,
        TotalDue,
        SubTotal,
        OrderDate,
        City,
        AddressID,
        Person_StateProvince.Name as Provincia,
        Person_CountryRegion.Name as Pais

    from Sales_SalesOrderHeader
        join Person_Address on Person_Address.AddressID = Sales_SalesOrderHeader.BillToAddressID
        join Person_StateProvince using (StateProvinceID)
        join Person_CountryRegion using (CountryRegionCode)
),

ventas_y_monedas as (
    select 
        distinct SalesOrderID,
        TotalDue,
        SubTotal,
        OrderDate,
        FromCurrencyCode,
        ToCurrencyCode
    from Sales_SalesOrderHeader
    join Sales_CurrencyRate using (CurrencyRateID)
),

Ventas_por_producto as (
    select 
        distinct ProductID,
        Production_Product.Name as producto,
        sum(LineTotal) as Ingresos_prod,
        Production_ProductCategory.Name as categoria,
        Production_ProductSubcategory.Name as subcategoria
        from Sales_SalesOrderDetail
        join Production_Product using (ProductID)
        join Production_ProductSubcategory using (ProductSubcategoryID) 
        join Production_ProductCategory using (ProductCategoryID) 
        group by ProductID

)


select *
from
Ventas_por_producto

limit 30;