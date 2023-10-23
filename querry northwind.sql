use Northwind
go


-- select distinct p.productID as [Ma Hang] from dbo.products
/* select productname from dbo.products
where discontinued = 0 */
 select * from dbo.products
where SupplierID = 1 or SupplierID = 3

select * from dbo.products
where Discontinued = 0 and (SupplierID = 1 or SupplierId = 2)

select * from dbo.products 
where Unitprice between 2 and 10

select * from dbo.products
where Unitprice <= 10 and Unitprice >=2

select * from dbo.products
where not SupplierID = 1 and Unitprice > 10 

select * from dbo.products
where SupplierID <> 1 and Unitprice > 10

select * from dbo.products
where SupplierID != 1 and Unitprice > 10

select * from dbo.products
where SupplierID IN (1,2,5,9,13,17,20,25,35)

select ProductID, UnitsInStock, UnitsInStock * UnitPrice as hihi from dbo.Products
where Discontinued = 1
order by hihi desc

select ProductID, ProductName, UnitsInStock * UnitPrice as hihi from dbo.products
where UnitsInStock * UnitPrice > 100 and UnitsInStock > 10

select UnitPrice * 0.9 as 'gia goc' from dbo.products

select * from dbo.products
where ProductName like '%Tofu%'

select * from dbo.products
where ProductName like '%Coffee%'

select * from dbo.employees
where Region is null

select * from dbo.employees
where year(BirthDate) = '1948'

select * from dbo.employees
where month(Birthdate) = '10'

select LastName + ' ' + FirstName as FullName from dbo.Employees

select count(ProductID) from dbo.Products
where UnitPrice > 10

select count(ProductID), SupplierID from dbo.Products
group by SupplierID

select count(ProductID) as 'SoLuongHang', SupplierID from dbo.Products
where UnitPrice > 10 and ReorderLevel > 5
Group by SupplierID
Order by SoLuongHang desc

select * from dbo.Products

select * from dbo.Products
where Unitprice = (select max(Unitprice) from dbo.Products)


select SupplierID, count(ProductID) as 'SoLuongHangHoa', avg(Unitprice) as 'Average Price', max(UnitPrice) as 'Max Price', min(UnitPrice) as 'Min Price' 
from dbo.Products
group by SupplierID
order by SoLuongHangHoa desc



