--1. Get the firstname and lastname of the employees who placed orders between 15th August,1996 and 15th August,1997
Select distinct FirstName,LastName from Employee join orders on Employee.EmployeeId=Orders.EmployeeId and OrderDate between '1996-08-15' and '1997-08-15';

--2. Get the distinct EmployeeIDs who placed orders before 16th October,1996
Select distinct Employee.EmployeeId,orders.orderDate from Employee inner join Orders on Employee.EmployeeID=Orders.EmployeeID and OrderDate<'1996-10-16';

--3. How many products were ordered in total by all employees between 13th of January,1997 and 16th of April,1997.
select distinct count(OrderDetails.ProductId) as [count] from OrderDetails inner join orders on OrderDetails.OrderID=orders.OrderID and orders.orderdate between '1997-01-13' and '1997-04-16';

--4. What is the total quantity of products for which Anne Dodsworth placed orders between 13th of January,1997 and 16th of April,1997.
select sum(orderdetails.Quantity) as [quantity] from orderdetails  inner join orders on orders.orderId=orderdetails.orderId join employee on employee.EmployeeID=orders.EmployeeID and employee.firstName='Anne' and employee.LastName='Dodsworth' and orders.orderdate between  '1997-01-13' and '1997-04-16';

--5. How many orders have been placed in total by Robert King
select distinct count(orders.orderID) as [NoOfOrders] from orders inner join employee on employee.employeeId=orders.employeeId and FirstName='Robert' and LastName='king';

--6. How many products have been ordered by Robert King between 15th August,1996 and 15th August,1997
select distinct count(orders.orderId) as [count] from orders  inner join employee on employee.EmployeeID=orders.EmployeeID and FirstName='Robert' and LastName='king' and orders.orderdate between '1996-08-15' and '1997-08-15' ;

--7. I want to make a phone call to the employees to wish them on the occasion of Christmas who placed orders between 13th of January,1997 and 16th of April,1997. I want the EmployeeID, Employee Full Name, HomePhone Number.
select Employee.EmployeeId, concat(Employee.FirstName,Employee.LastName) as [FullName], Employee.HomePhone from Employee inner join orders on employee.EmployeeID=orders.EmployeeID and orders.orderdate between '1997-01-13' and '1997-04-16';

--8. Which product received the most orders. Get the product's ID and Name and number of orders it received.
select  top 1 Products.ProductID,products.ProductName,count(orders.orderId) as [number of orders] from orders 
inner join orderdetails on orderdetails.orderId=orders.orderId 
inner join  products on products.productId=orderdetails.productId group by products.ProductID,products.ProductName 
order by count(orders.orderId) desc;

--9. Which are the least shipped products. List only the top 5 from your list.
select * from products where productId in (select  top 5 productId  from  OrderDetails group by productId 
order by count(orderID));

--10.What is the total price that is to be paid by Laura Callahan for the order placed on 13th of January,1997
select Sum(UnitPrice*Quantity) as [total price] from Orderdetails inner join orders on orders.orderId=orderdetails.orderId 
inner join employee on employee.employeeId=orders.employeeId and employee.firstName='Laura' and LastName='Callahan';

--11. How many number of unique employees placed orders for Gorgonzola Telino or Gnocchi di nonna Alice or Raclette Courdavault or Camembert Pierrot in the month January,1997
select distinct count(*) as [No of orders] from employee inner join orders on employee.EmployeeID=orders.EmployeeID 
join OrderDetails on orders.orderId=orderdetails.orderid inner join products on orderdetails.ProductID=products.productId and (products.productName='Gorgonzola Telino' or products.productName='Gnocchi di nonna Alice' or 
products.productName='Raclette Courdavault' or products.productName='Camembert Pierrot') and  month(orders.orderdate)=1 and year(orders.orderdate)=1997;

--12. What is the full name of the employees who ordered Tofu between 13th of January,1997 and 30th of January,1997
select concat(Employee.FirstName,' ',Employee.LastName) as [FullName] from Employee inner join orders on employee.EmployeeID=orders.EmployeeID 
join orderdetails on orders.orderid=OrderDetails.OrderID join products on OrderDetails.ProductID=Products.ProductID where Products.ProductName='Tofu' 
and orders.orderdate between '1997-01-13' and '1997-01-30';

--13. What is the age of the employees in days, months and years who placed orders during the month of August. Get employeeID and full name as well
select EmployeeId,Concat(FirstName,' ',LastName) as FullName,Datediff(dd,birthdate,getdate()) as [Age in days], Datediff(dd,birthdate,getdate())/12 as [Age in months] , Datediff(dd,birthdate,getdate())/365.25 as [Age in days]	
from employee where month(hiredate)=8;

--14. Get all the shipper's name and the number of orders they shipped
select Shippers.CompanyName,count(shippers.shipperId) as [Number of orders] from orders inner join Shippers on orders.ShipperID=Shippers.ShipperID group by Shippers.CompanyName;
select * from orders inner join Shippers on orders.ShipperID=Shippers.ShipperID;

--15. Get the all shipper's name and the number of products they shipped.
select shippers.CompanyName,count(Products.ProductId) as [Number Of Products] from products 
inner join orderdetails on orderdetails.productId=products.productId 
inner join orders on orders.orderId=orderdetails.orderId 
inner join shippers on Shippers.shipperId=orders.shipperId
group by shippers.CompanyName;

--16. Which shipper has bagged most orders. Get the shipper's id, name and the number of orders.
select top 1 shippers.shipperId,shippers.companyName,count(orders.orderId) as [Number of orders] from shippers 
inner join orders on orders.shipperId=Shippers.shipperId group by shippers.shipperId,shippers.CompanyName
order by Count(orders.orderId) desc;

--17. Which shipper supplied the most number of products between 10th August,1996 and 20th  September,1998. Get the shipper's name and the number of products.
select top 1 shippers.CompanyName,count(products.productId) as [number of products] from shippers 
inner join orders on orders.shipperId=shippers.ShipperID 
inner join orderdetails on orderdetails.orderId=orders.orderId
inner join products on Products.ProductID=orderdetails.ProductID where orders.shippeddate between '1996-08-10' and '1998-09-20'
group by shippers.CompanyName ;

--18. Which employee didn't order any product 4th of April 1997
select distinct *
from Employee e
inner join Orders ON e.EmployeeID = orders.EmployeeID
where orders.OrderDate != '1997-04-04';

--19. How many products where shipped to Steven Buchanan
select distinct count(products.productId) as [Number of Products] from Employee 
inner join orders on orders.EmployeeID=employee.EmployeeID 
inner join orderdetails on orderdetails.OrderID=orders.orderId
inner join products on products.productId=orderdetails.ProductID 
where Employee.firstName='Steven' and Employee.LastName='Buchanan';

--20. How many orders where shipped to Michael Suyama by Federal Shipping
select Count(orders.orderId) as [Number of orders] from orders 
inner join Employee  on orders.EmployeeId=Employee.employeeId 
inner join shippers on orders.shipperId=shippers.shipperId  
where shippers.CompanyName='Federal Shipping' and Employee.LastName='Suyama' and Employee.FirstName='Michael';

--21. How many orders are placed for the products supplied from UK and Germany
select count(orders.orderId) as [Number of orders] from orders inner join orderdetails on orders.orderId=orderdetails.orderId 
inner join products on orderdetails.productId=products.productId 
inner join suppliers on products.supplierId=suppliers.supplierId
where suppliers.Country='UK' or suppliers.country='Germany';

--22. How much amount Exotic Liquids received due to the order placed for its products in the month of January,1997
select sum((orderdetails.unitprice*orderdetails.Quantity)-(OrderDetails.Discount)) as [Total amount]  from orderdetails 
inner join orders on orderdetails.OrderID=orders.orderId 
inner join products on orderdetails.productId=products.productId 
inner join suppliers on products.SupplierID=suppliers.supplierId
where suppliers.CompanyName='Exotic Liquids' and month(orders.OrderDate)=1 and year(orders.orderdate)=1997;

--23. In which days of January, 1997, the supplier Tokyo Traders haven't received any orders.
select distinct day(orders.orderdate) as [No orders] from orders 
where orders.orderdate not in (select orders.orderdate from orders
inner join orderdetails on orders.orderID=OrderDetails.orderID 
inner join products on orderdetails.productId=products.productId
inner join suppliers on products.productId=suppliers.supplierId
and Suppliers.CompanyName='Tokyo Traders'  where Orders.orderdate between '1997-01-01' and '1997-01-31') ;
    
--24. Which of the employees did not place any order for the products supplied by Ma Maison in the month of May
select Employee.EmployeeID,concat(Employee.FirstName,' ',Employee.LastName) as [Employee Name] from Employee where Employee.EmployeeId  not in
(select Employee.EmployeeId from Employee inner join orders on Employee.EmployeeId=Orders.OrderId  and month(orders.orderdate)=5
inner join orderdetails on Orders.orderId=orderDetails.OrderID 
inner join products on orderdetails.productId = products.productId 
inner join suppliers on products.SupplierID = suppliers.supplierId and suppliers.CompanyName='Ma Maison');

--25. Which shipper shipped the least number of products for the month of September and October,1997 combined.
select top 1 shippers.CompanyName,count(orders.orderId) as[Number of Orders] from shippers 
inner join orders on shippers.shipperId=orders.shipperId
group by shippers.shipperId,shippers.CompanyName order by count(orders.orderId);

--26. What are the products that weren't shipped at all in the month of August, 1997
select products.productId,products.productName from Products where 
products.productId not in
(select products.productId from products 
inner join orderdetails on products.ProductID=orderdetails.productId
inner join orders on orderdetails.orderId=orders.orderId and orders.ShippedDate between '1997-08-01' and '1997-08-31');

--27. What are the products that weren't ordered by each of the employees. List each employee and the products that he didn't order.
select distinct employee.employeeID, products.productId from (((employee
join orders on employee.employeeId=orders.EmployeeID)
left join OrderDetails on orders.orderid=orderdetails.orderid)
left join Products on orderdetails.productid=products.productId)
where products.productId  not in
(select distinct orderdetails.productId from orders
 join Orderdetails on orderdetails.orderID=orders.orderId) order by employee.employeeId;


--28. Who is busiest shipper in the months of April, May and June during the year 1996 and 1997
select top 1 shippers.CompanyName from shippers
inner join orders on shippers.shipperId=orders.shipperId
where month(orders.orderdate)=4 or month(orders.orderdate)=5 or month(orders.orderdate)=6
group by month(orders.OrderDate),shippers.CompanyName order by count(orders.orderId) desc;

--29. Which country supplied the maximum products for all the employees in the year 1997
select suppliers.country from suppliers 
inner join products on suppliers.supplierId=products.supplierId 
inner join orderdetails on products.productId=orderdetails.productId
inner join orders on orderdetails.orderId=orders.orderId and year(orders.orderdate)=1997
inner join employee on orders.employeeId=employee.employeeId 
group by suppliers.country order by count(products.productId) desc;

--30. What is the average number of days taken by all shippers to ship the product after the order has been placed by the employees
select shippers.companyName,avg(datediff(day,orders.orderDate,orders.ShippedDate)) as [Average days]  from orders 
inner join shippers on shippers.ShipperID=orders.ShipperID
group by shippers.CompanyName;

--31. Who is the quickest shipper of all.
select top 1 shippers.CompanyName from shippers 
inner join orders on shippers.ShipperID=orders.ShipperID group by shippers.CompanyName;

--32. Which order took the least number of shipping days. Get the orderid, employees full name, number of products, number of days took to ship and shipper company name
select orders.orderId,concat(employee.lastName,' ',employee.firstName) as [Full Name] ,count(orderdetails.productID) as [Number of Products] ,count(datediff(day,orders.orderdate,orders.RequiredDate)) as [No of days] from employee
inner join orders on employee.EmployeeID=orders.EmployeeID 
inner join orderdetails on orders.orderID=OrderDetails.OrderID
group by orders.orderId,employee.LastName,employee.FirstName 
order by count(datediff(day,orders.orderdate,orders.RequiredDate));

--'Unions'
--1. Which orders took the least number and maximum number of shipping days? Get the orderid, employees full name, number of products, number of days taken to ship the product and shipper company name. Use 1 and 2 in the final result set to distinguish the 2 orders.
select  1 as label,* from (select top 1 orders.orderId,concat(employee.lastName,' ',employee.firstName) as [Full Name] ,count(orderdetails.productID) as [Number of Products] ,count(datediff(day,orders.orderdate,orders.RequiredDate)) as [No of days]
from employee inner join orders on employee.EmployeeID=orders.EmployeeID 
inner join orderdetails on orders.orderID=OrderDetails.OrderID 
group by orders.orderId,employee.LastName,employee.FirstName 
order by count(datediff(day,orders.orderdate,orders.RequiredDate))) as T1
union
select 2 as label,* from (select top 1 orders.orderId,concat(employee.lastName,' ',employee.firstName) as [Full Name] ,count(orderdetails.productID) as [Number of Products] ,count(datediff(day,orders.orderdate,orders.RequiredDate)) as [No of days]
from employee inner join orders on employee.EmployeeID=orders.EmployeeID 
inner join orderdetails on orders.orderID=OrderDetails.OrderID 
group by orders.orderId,employee.LastName,employee.FirstName 
order by count(datediff(day,orders.orderdate,orders.RequiredDate)) desc) as T2
order by label;

--or

with [least_Shipping_days] as(
select top 1 orders.orderId from orders
inner join OrderDetails on orders.orderId=OrderDetails.orderId
group by orders.orderId
order by count(datediff(day,orders.orderdate,orders.RequiredDate))),
[Most_Shipping_days] as(
select top 1 orders.orderId  from orders
inner join OrderDetails on orders.orderId=OrderDetails.orderId
group by orders.orderId
order by count(datediff(day,orders.orderdate,orders.RequiredDate)) desc)

select  1 as label,orders.orderId,concat(employee.lastName,' ',employee.firstName) as [Full Name] 
,count(orderdetails.productID) as [Number of Products] ,count(datediff(day,orders.orderdate,orders.RequiredDate)) as [No of shipping days]
from orders 
inner join	OrderDetails on	 orders.orderId=OrderDetails.orderId
inner join employee on employee.EmployeeID=orders.EmployeeID 
inner join least_Shipping_days on least_Shipping_days.OrderID=orders.OrderID
group by orders.orderId,employee.LastName,employee.FirstName
union
select  2 as label,orders.orderId,concat(employee.lastName,' ',employee.firstName) as [Full Name] 
,count(orderdetails.productID) as [Number of Products] ,count(datediff(day,orders.orderdate,orders.RequiredDate)) as [No of shipping days]
from orders 
inner join	OrderDetails on	 orders.orderId=OrderDetails.orderId
inner join employee on employee.EmployeeID=orders.EmployeeID 
inner join Most_Shipping_days on Most_Shipping_days.OrderID=orders.OrderID
group by orders.orderId,employee.LastName,employee.FirstName
order by label;

--2. Which is cheapest and the costliest of products purchased in the second week of October, 1997. Get the product ID, product Name and unit price. Use 1 and 2 in the final result set to distinguish the 2 product
select 1 as label,* from
(select top 1 products.productID,products.ProductName,products.UnitPrice from Products 
inner join orderdetails on products.ProductID=OrderDetails.productID
inner join orders on orderdetails.orderID=orders.orderId and (month(orders.orderdate)=10 and year(orders.orderdate)=1997 and (datename(dd,orders.OrderDate)<15 and datename(dd,orders.OrderDate)>8))
group by products.productID,products.ProductName,products.UnitPrice,orders.orderdate,orderdetails.Quantity
order by (products.unitprice*orderdetails.Quantity)) as T1
union
select 2 as label,* from
(select top 1 products.productID,products.ProductName,products.UnitPrice  from Products 
inner join orderdetails on products.ProductID=OrderDetails.productID
inner join orders on orderdetails.orderID=orders.orderId and (month(orders.orderdate)=10 and year(orders.orderdate)=1997 and (datename(dd,orders.OrderDate)<15 and datename(dd,orders.OrderDate)>8))
group by products.productID,products.ProductName,products.UnitPrice,orders.orderdate,orderdetails.Quantity
order by (products.unitprice*orderdetails.Quantity)desc) as T2
order by label;

--or

with 
[chepest_product] as(
select  top 1 products.ProductID as Id from orders 
inner join OrderDetails on orders.orderId=OrderDetails.OrderID
inner join Products on products.ProductID=OrderDetails.ProductID
where (month(orders.orderdate)=10 and year(orders.orderdate)=1997 and (datename(dd,orders.OrderDate)<15 and datename(dd,orders.OrderDate)>8))
order by (products.unitprice*orderdetails.Quantity)),
[Costliest_product] as(
select  top 1 products.ProductID as Id from orders 
inner join OrderDetails on orders.orderId=OrderDetails.OrderID
inner join Products on products.ProductID=OrderDetails.ProductID
where (month(orders.orderdate)=10 and year(orders.orderdate)=1997 and (datename(dd,orders.OrderDate)<15 and datename(dd,orders.OrderDate)>8))
order by (products.unitprice*orderdetails.Quantity) desc)

select 1 as label,products.productID,products.ProductName,products.UnitPrice  from Products
inner join orderdetails on products.ProductID=OrderDetails.productID
inner join orders on orderdetails.orderID=orders.orderId and (month(orders.orderdate)=10 and year(orders.orderdate)=1997 and (datename(dd,orders.OrderDate)<15 and datename(dd,orders.OrderDate)>8))
inner join [chepest_product] on chepest_product.Id=Products.ProductID
group by products.productID,products.ProductName,products.UnitPrice,orders.orderdate,orderdetails.Quantity
union
select 2 as label,products.productID,products.ProductName,products.UnitPrice  from Products
inner join orderdetails on products.ProductID=OrderDetails.productID
inner join orders on orderdetails.orderID=orders.orderId and (month(orders.orderdate)=10 and year(orders.orderdate)=1997 and (datename(dd,orders.OrderDate)<15 and datename(dd,orders.OrderDate)>8))
inner join [Costliest_product] on [Costliest_product].Id=Products.ProductID
group by products.productID,products.ProductName,products.UnitPrice,orders.orderdate,orderdetails.Quantity
order by label;







--'Case'
--1. Find the distinct shippers who are to ship the orders placed by employees with IDs 1, 3, 5, 7 Show the shipper's name as "Express Speedy" if the shipper's ID is 2 and "United Package" if the shipper's ID is 3 and "Shipping Federal" if the shipper's ID is 1
select distinct shippers.shipperID, 
case 
  when Shippers.shipperId=1 then 'Express speedy' 
  when Shippers.shipperId=2 then 'United Package' 
  when Shippers.shipperId=3 then 'Shipping Federal'
End as CompanyName
from shippers 
inner join orders on orders.shipperID=shippers.shipperId
inner join Employee on Orders.EmployeeID=Employee.EmployeeID and (Employee.EmployeeId=1 or Employee.EmployeeID=3 or Employee.EmployeeID=5 or Employee.EmployeeID=7);