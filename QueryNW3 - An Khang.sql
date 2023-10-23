USE Northwind
GO

SELECT C.CategoryID, CategoryName, count(*) as Quantity FROM dbo.Categories as C, dbo.Products
where C.CategoryID = Products.CategoryID
group by C.CategoryID, CategoryName
Having count(*) >= 10
Order by Quantity desc
select * from Categories
select * from dbo.Products
-- 1.
select * from dbo.Products

-- 2.
select ProductID, ProductName, UnitPrice from dbo.Products
where UnitPrice > 40

-- 3.
select S.SupplierID, CompanyName, ContactName from dbo.Suppliers as S, dbo.Products as P
where ProductName = 'Mishi Kobe Niku' and S.SupplierID = P.SupplierID 

-- 4.
select ProductName, UnitPrice from dbo.Products
where Discontinued = 1 and UnitPrice < 30 and UnitPrice > 10

-- 5.
select sum(UnitsOnOrder), ProductName from dbo.Products
where ProductName = 'Chef Anton''s Gumbo Mix' and UnitsOnOrder <> 0	
group by ProductName

-- 6.
select City, Country, count(SupplierID) from dbo.Suppliers
group by City, Country
order by count(SupplierID) desc

-- 7. 
/* select top(1)Country, count(SupplierID) from dbo.Suppliers
group by Country
order by count(SupplierID) desc */

select country, count(supplierID)
from Suppliers
group by country
having count(supplierID) = (select top 1 count(SupplierID) from Suppliers group by Country order by count(SupplierID) Desc)

-- 8. 
select SupplierID, CompanyName, ContactName from dbo.Suppliers
where City = 'London' or City = 'Tokyo' or City = 'Berlin' or City = 'Bend'

-- 9.
Select FirstName + ' ' + LastName as FullName, count(*) as Quantity from dbo.Employees as E, dbo.Orders as O
where E.EmployeeID = O.EmployeeID and LastName = 'Davolio' and FirstName = 'Nancy'
group by FirstName + ' ' + LastName

-- 11. 
select EmployeeID, FirstName + ' ' + LastName as Fullname from dbo.Employees
where Month(Birthdate) IN (1,2,3)

-- 12.
select count(*) from dbo.Employees
where MONTH(Birthdate) = 1

-- 13.
select EmployeeID, FirstName + ' ' + LastName as FullName from dbo.Employees
where Year(Birthdate) >= 1960 and Year(Birthdate) <= 1990

-- 14.
select avg(Year(getdate()) - Year(BirthDate)) from dbo.Employees

-- 15.
select EmployeeID, FirstName + ' ' + LastName as FullName, HireDate from dbo.Employees
where HireDate = (select Max(Hiredate) from dbo.Employees)

-- 16.
select ProductID, ProductName from dbo.Suppliers, dbo.Products
where Suppliers.SupplierID = Products.SupplierID and CompanyName = 'Exotic Liquids'

-- 17. 
select count(*) as Quantity from dbo.Orders
where CustomerID = 'ALFKI'

-- 18. 
select count(*) from dbo.Orders
where OrderDate = '1998-04-29'

-- 19. 
select top(10)Orders.OrderID, sum(UnitPrice*Quantity*(1-Discount)) as Total from dbo.[Order Details], dbo.Orders
where Orders.OrderID = [Order Details].OrderID
group by Orders.OrderID
order by Total desc

-- 20.
select EmployeeID, FirstName, LastName, Year(Getdate()) - Year(Hiredate) as EmployeeType from dbo.Employees
where Year(Getdate()) - Year(Hiredate)  >= 30

-- 21.
select ProductID, ProductName from dbo.Products
where UnitPrice > (select avg(UnitPrice) from dbo.Products)

select * from dbo.Suppliers
select * from dbo.Products
select * from dbo.Orders
select * from dbo.Employees
select * from dbo.EmployeeTerritories
select * from dbo.Customers
select * from dbo.[Order Details]

