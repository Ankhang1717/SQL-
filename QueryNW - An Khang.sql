use Northwind
go

-- 1. In danh sách tất cả nhân viên của công ty
select * from dbo.Employees

-- 2. In mã, fullname = (firstname + lastname) của tất cả các nhân viên Title là Sales Representative
select EmployeeID, firstname + ' ' + lastname as Fullname from dbo.Employees
where Title = 'Sales Representative'

-- 3. In thông tin của tất cả các nhân viên có Title liên quan tới Sale
select * from dbo.Employees
where Title like '%Sale%'

-- 4. In thông tin tất cả các nhân viên sinh trong năm 1996
select * from dbo.Employees
where year(BirthDate) = '1996'

-- 5. Tìm những nhân viên có Title là Sales Manager và ở London
select * from dbo.Employees
where Title = 'Sales Manager' and City = 'London'

-- 6. Tìm những nhân viên sinh vào năm 1996 và ở (London hoặc Seattle)
select * from dbo.Employees
where Year(BirthDate) = '1996' and (City = 'London' or City = 'Seattle')

-- 7. Hiển thị những nhân viên không có thông tin về ảnh hoặc Notes
select * from dbo.Employees
where Photo is null or Notes is null

-- 8. In thông tin của tất cả các khách hàng không có thông tin về FAX
select * from dbo.Customers
where FAX is null

-- 9. In thông tin của tất cả các khách hàng có contact title làm quản lý (manager)
select * from dbo.Customers
where ContactTitle like '%Manager%'

-- 10. In tên nước (country) của tất cả khách hàng
select Country from dbo.Customers

-- 11. Hiển thị những khách hàng không có thông tin về Region
select * from dbo.Customers
where Region is null

-- 12. Tìm tất cả các khách hàng ở Canada, UK, Brazil
select * from dbo.Customers
where Country = 'Canada' or Country = 'UK' or Country = 'Brazil'

-- 13. Tìm tất cả những mặt hàng không còn bán nữa (discontinued = 1)
select * from dbo.Products
where Discontinued = 1

-- 14. TÌm mã của tất cả các mặt hàng đã từng được đặt hàng và số lượng trong mỗi đơn hàng đều lớn hơn 10
select * from dbo.Products
where UnitsOnOrder > 10

-- 15. Tìm tất cả mã những khách hàng đã cung cấp hàng hóa
select SupplierID, count(*)  from dbo.Products
group by SupplierID

-- 16. Tìm tất cả các đơn hàng ship đến Lyon, Bern, Graz
select * from dbo.Orders
where ShipCity IN ('Lyon', 'Bern', 'Graz')

-- 17. Tìm những mã hàng đã từng được discount >= 10%
select * from dbo.[Order Details]
where Discount >= '0.1'

-- 18. Hiển thị những mặt hàng có tổng tiền tồn kho lớn hơn 1000
select *, UnitPrice * UnitsInStock as TotalPrice from dbo.Products
where UnitPrice * UnitsInStock > 1000

-- 19. Hiển thị những mặt hàng có UnitsOnOrder nhỏ hơn UnitsInStock 10 ít nhất 10 đơn vị
select * from dbo.Products
where UnitsInStock - UnitsOnOrder >= 10

-- 20. Hiển thị những đơn hàng được Ship tới France hoặc Brazil
select * from dbo.Orders
where ShipCountry = 'France' or ShipCountry = 'Brazil'


select * from dbo.Orders
select * from dbo.[Order Details]
where ProductID = 1
select * from dbo.Products
-- 21. Hiển thị những mặt hàng đã từng được đặt trong năm 1992 và có số lượng được đặt trong đơn hàng lớn hơn 10
select Products.ProductID, count(*) from dbo.Orders, dbo.[Order Details], dbo.Products
where YEAR(OrderDate) = '1992' and Orders.OrderID = [Order Details].OrderID and Quantity > 10 and Products.ProductID = [Order Details].ProductID
group by Products.ProductID


-- 22. Tìm những Shipper không có số phone
select * from dbo.Shippers
inner join dbo.Orders on Shippers.ShipperID = Orders.EmployeeID
where Phone is null

-- 23. TÌm những Shipper ở Brazil
select ShipName from dbo.Orders
where ShipCountry = 'Brazil'

-- 24. Tìm những khách hàng có contact title thuộc lĩnh vực kế toán
select * from dbo.Customers
where ContactTitle like '%Accounting%'

-- 25. Trong mỗi hóa đơn tìm mã hóa đơn, sản phẩm bán được nhiều nhất có mã và số lượng như thế nào, sắp xếp theo số lượng tăng dần
select OrderID, ProductID, sum(Quantity) as Quantity from dbo.[Order Details]
group by OrderID, ProductID
order by Quantity desc

-- 26. Đếm xem công ty có bao nhiêu khách hàng ở Brazil
select count(*) as 'Customers In Brazil' from dbo.Customers
where Country = 'Brazil'

-- 27. Tìm giá sản phẩm trung bình, max, min của các sản phẩm theo mã nhà cung cấp
select SupplierID, count(*) as Quantity, avg(UnitPrice) as AveragePrice, max(UnitPrice) as MaxPrice, min(UnitPrice) as MinPrice  from dbo.Products
group by SupplierID

-- 28. Tìm những nhân viên sinh vào tháng 10
select * from dbo.Employees
where Month(BirthDate) = '10'

-- 29. Tìm những nhân viên sinh vào một trong các tháng 1,3,5,8,9
select * from dbo.Employees
where Month(BirthDate) IN (1,3,5,8,9)

-- 30. Hiển thị mã những nhà cung cấp, cung cấp từ 5 mặt hàng trở lên
select SupplierID, count(ProductID) as 'Quantity of Product' from dbo.Products
group by SupplierID
having count(ProductID) >= 5

-- 31. Hiển thị mã nhà cung cấp, tên nhà cung cấp, mã mặt hàng, tên mặt hàng
select Suppliers.SupplierID, CompanyName, ProductID, ProductName  from dbo.Products
inner join dbo.Suppliers
on Suppliers.SupplierID = Products.SupplierID

select * from dbo.Suppliers
select * from dbo.Products
select * from dbo.Orders
select * from dbo.Categories
-- 32. Hãy hiển thị mã loại hàng, tên loại hàng, mã hàng, tên hàng của tất cả các mặt hàng có số lượng tồn kho lớn hơn 50	
select ProductID,  ProductName, Products.CategoryID, CategoryName from dbo.Products
inner join dbo.Categories
on Products.CategoryID = Categories.CategoryID
where UnitsInStock > 50


-- 33. Hãy đếm xem mỗi nhà cung cấp cung cấp bao nhiêu mặt hàng hiển thị thông tin bao gồm: mã nhà cung cấp, tên nhà cung cấp, số lượng mặt hàng tương ứng
select Products.SupplierID, count(*) as Quantity, CompanyName from dbo.Products
inner join dbo.Suppliers
on Suppliers.SupplierID = Products.SupplierID
group by Products.SupplierID, CompanyName




