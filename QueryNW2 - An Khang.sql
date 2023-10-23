use Northwind
go

-- 1. Thống kê tất cả số lượng hàng tồn và số lượng hàng đang được đặt hàng và tất cả những mặt hàng đang được bán (discontinued = 0)

declare @Discontinued0 int
select @Discontinued0 = count(discontinued) from dbo.Products
where Discontinued = 0
select sum(UnitsInStock) as N'Số lượng hàng tồn', sum(UnitsOnOrder) as N'Số lượng đang được đặt hàng', @Discontinued0 as N'Những mặt hàng đang được bán' from dbo.Products

-- 2. Hiển thị loại hàng, mã hàng, tên hàng, số lượng hàng tồn do công ty Exotic Liquids cung cấp
select CategoryID, ProductID, UnitsInStock, ProductName from dbo.Products
inner join dbo.Suppliers on Suppliers.SupplierID = Products.SupplierID
where CompanyName = 'Exotic Liquids'

-- 3. TÌm mã, tên của tất cả các nhân viên đã từng làm việc với công ty khách hàng là công ty Ana Trujillo Emparedados y helados
select Employees.EmployeeID, FirstName + ' ' + LastName as FullName from dbo.Employees, dbo.Customers, dbo.Orders
where Employees.EmployeeID = Orders.EmployeeID and Orders.CustomerID = Customers.CustomerID and CompanyName = 'Ana Trujillo Emparedados y helados'

-- 4. Hiển thị tên của tất cả mã nv, tên nhân viên đã từng làm việc với những khách hàng ở Germany
select Employees.EmployeeID, FirstName + ' ' + LastName as FullName from dbo.Employees, dbo.Orders, dbo.Customers
where Employees.EmployeeID = Orders.EmployeeID and Orders.CustomerID = Customers.CustomerID and Customers.Country = 'Germany'

-- 5. Hiển thị chi tiết mã đơn hàng, mã sản phẩm, số lượng sản phẩm, giá, chiết khấu, thành tiền của những đơn hàng do trưởng phòng kinh doanh (Sale manager) trực tiếp đảm nhận
select Orders.OrderID, Products.ProductID, Quantity, Products.UnitPrice, Discount, Products.UnitPrice*Quantity*(1-Discount) as TotalPrice  from dbo.Products, dbo.[Order Details], dbo.Orders, dbo.Employees
where Products.ProductID = [Order Details].ProductID and [Order Details].OrderID = Orders.OrderID and Orders.EmployeeID = Employees.EmployeeID and Title = 'Sales Manager'

-- 6. Hãy sắp xếp tên những sản phẩm theo thứ tự a, b, c
select ProductName from dbo.Products order by ProductName asc

-- 7. Tìm mã đơn hàng, mã khách hàng thực hiện đơn hàng có giá trị lớn nhất
select Orders.OrderID, CustomerID from dbo.Orders
inner join dbo.[Order Details] on Orders.OrderID = [Order Details].OrderID
where Quantity*UnitPrice*(1-Discount) = (select max(Quantity*UnitPrice*(1-Discount)) from dbo.[Order Details])

/* SELECT s.OrderID, s.CustomerID, s.TotalPrice
FROM (select Orders.OrderID, Orders.CustomerID, sum(Quantity*UnitPrice*(1-Discount)) as TotalPrice from dbo.[Order Details]
inner join dbo.Orders on Orders.OrderID = [Order Details].OrderID
group by Orders.OrderID, Orders.CustomerID) as s
WHERE s.TotalPrice = (select max(Quantity*UnitPrice*(1-Discount)) as MaxPrice from dbo.[Order Details]) */


-- 8. Hay tính tổng tiền hàng của mỗi hóa đơn và sắp xếp theo thứ tự số hóa đơn tăng dần
select Orders.OrderID, sum(Quantity*UnitPrice*(1-Discount)) as TotalPrice from dbo.Orders
inner join dbo.[Order Details] on Orders.OrderID = [Order Details].OrderID
group by Orders.OrderID
order by Orders.OrderID asc


-- 9. Hiển thị chi tiết những đơn hàng được giao dịch vào ngày 16/7/1996
select * from dbo.Orders
where ShippedDate = '1996-07-16'  

-- 10. Hiển thị những đơn hàng đã được đặt hàng từ ngày 16/7/1996 -> 20/7/1996 và được vận chuyển luôn trong thời gian đó
select * from dbo.Orders
where OrderDate > '1996-07-16' and OrderDate < '1996-07-20' and ShippedDate > '1996-07-16' and ShippedDate < '1996-07-20'

-- 11. Tìm những nhân viên đã chịu trách nhiệm từ 30 đơn hàng trở lên
select Employees.EmployeeID, FirstName + ' ' + LastName as 'FullName', count(Employees.EmployeeID) as Quantity from dbo.Orders, dbo.Employees
where Employees.EmployeeID = Orders.EmployeeID
group by Employees.EmployeeID, FirstName + ' ' + LastName
having count(Employees.EmployeeID) > 30

-- 12. Tìm những nhân viên được thuê sau ít nhất một nhân viên 
select * from dbo.Employees
where HireDate = (select Min(hiredate) from dbo.Employees)
-- 13. Hãy tìm mã, tên, giá hiện tại những mặt hàng mã công ty Around the Horn đã mua
select Products.ProductID, ProductName, Products.UnitPrice  from dbo.Orders, dbo.Customers, dbo.[Order Details], dbo.Products
where Products.ProductID = [Order Details].ProductID and [Order Details].OrderID = Orders.OrderID and Orders.CustomerID = Orders.CustomerID and CompanyName = 'Around the Horn'

-- 14. TÌm những nhân viên vào sau Margaret Peacock
select * from dbo.Employees
where HireDate > (select HireDate from dbo.Employees where LastName = 'Peacock' and FirstName = 'Margaret')

-- 15. Hãy tìm 3 đơn hàng được đặt sau cùng
select top(3)* from dbo.Orders
Order by OrderDate desc

/* select * from dbo.Orders as O1
where 3 > (select count(*) from dbo.Orders as O2 where O1.OrderDate > O2.OrderDate) */

-- 16. Hãy hiển thị 10 khách hàng có nhiều đơn hàng nhất trong năm 1998 
select top(10)CustomerID, count(*) as Orderr from dbo.Orders
where Year(OrderDate) = '1998'
group by CustomerID
order by Orderr desc

-- 17. Tìm những khách hàng đặt hàng trong năm 1997
select CustomerID, count(*) from dbo.Orders
where Year(OrderDate) = '1997'

-- 18. Tìm tất cả những mã đơn, tên công ty, thành phố, nước của những khách hàng vào tháng của những đơn hàng đặt vào 12/1996 và yêu cầu nhận được hàng vào năm 1997
select OrderID, CompanyName, City, Country from dbo.Customers, dbo.Orders
where Year(OrderDate) = '1996' and Month(OrderDate) = '12' and Year(RequiredDate) = '1997'

-- 19. Tính tổng tiền hàng được bán theo từng năm
select Year(OrderDate) as 'Year', sum(UnitPrice*Quantity*(1-Discount)) as TotalPrice from dbo.[Order Details], dbo.Orders
where Orders.OrderID = [Order Details].OrderID
group by Year(OrderDate)

-- 20. Tìm những nhân viên được thuê sau cùng
select * from dbo.Employees
where HireDate = (select Max(HireDate) from dbo.Employees)

-- 21. Hiển thị những đơn hàng có tổng tiền hàng lớn nhất
SELECT s.OrderID, s.CustomerID, s.TotalPrice
FROM (SELECT Orders.OrderID, Orders.CustomerID, SUM(Quantity*UnitPrice*(1-Discount)) AS TotalPrice FROM dbo.[Order Details]
INNER JOIN dbo.Orders ON Orders.OrderID = [Order Details].OrderID
GROUP BY Orders.OrderID, Orders.CustomerID) AS s
WHERE s.TotalPrice = (SELECT MAX(Quantity*UnitPrice*(1-Discount)) AS MaxPrice FROM dbo.[Order Details])

-- 22. Tìm ra tên những khách hàng đặt số lượng đơn hàng lớn nhất
SELECT top(1)Customers.CustomerID, count(*) AS Quantity FROM dbo.Customers, dbo.Orders
WHERE Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID
ORDER BY Quantity desc

/* SELECT MAX(s.Quantity) as Quantity
FROM (SELECT Customers.CustomerID, count(*) AS Quantity , ContactName FROM dbo.Orders, dbo.Customers WHERE Orders.CustomerID = Customers.CustomerID 
GROUP BY Customers.CustomerID, ContactName) AS s */



-- 23. Hiển thị tên khách hàng, mã đơn hàng, tổng tiền hàng của mỗi đơn. Sắp xếp theo thứ tự tổng tiền hàng giảm dần, mã đơn hàng tăng dần
select ContactName, Orders.OrderID, sum(Quantity*UnitPrice*(1-Discount)) as TotalPrice from dbo.Orders, dbo.[Order Details], dbo.Customers
where Orders.OrderID = [Order Details].OrderID and Orders.CustomerID = Customers.CustomerID
group by ContactName, Orders.OrderID
order by TotalPrice desc, Orders.OrderID asc

-- 24. Hiển thị mã đơn hàng, tên nhân viên phụ trách những đơn hàng có giá trị doanh thu từ 200 trở lên
select Orders.OrderID, FirstName + ' ' + LastName as FullName, sum(Quantity*UnitPrice*(1-Discount)) as Revenue from dbo.Orders, dbo.Employees, dbo.[Order Details]
where Orders.OrderID = [Order Details].OrderID and Employees.EmployeeID = Orders.EmployeeID
group by Orders.OrderID, FirstName + ' ' + LastName
Having Sum(Quantity*UnitPrice*(1-Discount)) > 200


