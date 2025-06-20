use adventure_works;
select * from customers;
select * from product;
select * from productcategory;
select * from productsubcategory;
select * from sales;
select * from salesterritory;
select * from date_table;

-- Q0 : Loaded FactInternetSales and FactInternetSalesNew to same table sales

-- Q1
select s.*, p.EnglishProductName as "Product Name"
from sales s
join product p on p.ProductKey = s.ProductKey;

-- Q2
select s.*, p.EnglishProductName as "Product Name", p.unitprice as "Unit Price", 
concat_ws(" ",c.FirstName,c.MiddleName,c.LastName) as FullName
from sales s
join product p on p.ProductKey = s.ProductKey
join customers c on c.CustomerKey = s.CustomerKey;

-- Q3
select s.OrderDate, d.CalendarYear as "Year", d.MonthNumberOfYear as "Month No",
d.EnglishMonthName as "Month Fullname", d.CalendarQuarter as "Quarter", 
concat_ws("-",d.CalendarYear,SUBSTRING(d.EnglishMonthName,1, 3)) as YearMonth,
d.WeekNumberOfYear as "Weekday No", d.EnglishDayNameOfWeek  as "Weekday Name", 
case 
	when d.MonthNumberOfYear <= 6 then d.MonthNumberOfYear + 6
    else d.MonthNumberOfYear - 6
end as "Financial Month",
d.FiscalQuarter as "Financial Quarter"
from sales s
join date_table d on s.OrderDate = d.FullDateAlternateKey;

-- Q4
select s.*, p.EnglishProductName as "Product Name", p.unitprice as "Unit Price",
(s.OrderQuantity * p.unitprice) - (s.OrderQuantity * s.UnitPriceDiscountPct) as "Sales Amount"
from sales s
join product p on p.ProductKey = s.ProductKey;

-- Q5
select *, (OrderQuantity * TotalProductCost) as "Production Cost"
from sales;

-- Q6
select s.*, p.EnglishProductName as "Product Name", p.unitprice as "Unit Price",
(s.OrderQuantity * p.unitprice) - (s.OrderQuantity * s.UnitPriceDiscountPct) as "Sales Amount",
(s.OrderQuantity * s.TotalProductCost) as "Production Cost",
(s.OrderQuantity * p.unitprice) - (s.OrderQuantity * s.UnitPriceDiscountPct) - (s.OrderQuantity * s.TotalProductCost) as "Profit"
from sales s
join product p on p.ProductKey = s.ProductKey;

-- Q8 (Year wise Sales)
select d.CalendarYear as "Year",
sum((s.OrderQuantity * p.unitprice) - (s.OrderQuantity * s.UnitPriceDiscountPct)) as "Sum of Sales Amount"
from sales s
join product p on p.ProductKey = s.ProductKey
join date_table d on s.OrderDate = d.FullDateAlternateKey
group by 1
order by 1 asc;

-- Q9 (Month wise Sales)
select d.EnglishMonthName as "Month",
d.MonthNumberOfYear as "Month No",
sum((s.OrderQuantity * p.unitprice) - (s.OrderQuantity * s.UnitPriceDiscountPct)) as "Sum of Sales Amount"
from sales s
join product p on p.ProductKey = s.ProductKey
join date_table d on s.OrderDate = d.FullDateAlternateKey
group by 1, 2
order by d.MonthNumberOfYear asc;

-- Q7
select d.CalendarYear as "Year",
d.EnglishMonthName as "Month",
d.MonthNumberOfYear as "Month No",
sum((s.OrderQuantity * p.unitprice) - (s.OrderQuantity * s.UnitPriceDiscountPct)) as "Sum of Sales Amount"
from sales s
join product p on p.ProductKey = s.ProductKey
join date_table d on s.OrderDate = d.FullDateAlternateKey
where d.CalendarYear in (2012,2013)
group by 1, 2, 3
order by d.CalendarYear,d.MonthNumberOfYear asc;

-- Q10 (Quarterly Sales)
select d.CalendarQuarter as "Quarter",
sum((s.OrderQuantity * p.unitprice) - (s.OrderQuantity * s.UnitPriceDiscountPct)) as "Sum of Sales Amount"
from sales s
join product p on p.ProductKey = s.ProductKey
join date_table d on s.OrderDate = d.FullDateAlternateKey
group by 1
order by 1 asc;

-- Q11
select d.CalendarYear as "Year",
sum((s.OrderQuantity * p.unitprice) - (s.OrderQuantity * s.UnitPriceDiscountPct)) as "Sum of Sales Amount",
sum((s.OrderQuantity * s.TotalProductCost)) as "Sum of Production Cost"
from sales s
join product p on p.ProductKey = s.ProductKey
join date_table d on s.OrderDate = d.FullDateAlternateKey
group by 1
order by 1 asc;

-- Q12a (Region wise Sales and Profit)
select st.SalesTerritoryRegion as "Region",
sum((s.OrderQuantity * p.unitprice) - (s.OrderQuantity * s.UnitPriceDiscountPct)) as "Sum of Sales Amount",
-- sum((s.OrderQuantity * s.TotalProductCost)) as "Sum of Production Cost",
sum((s.OrderQuantity * p.unitprice) - (s.OrderQuantity * s.UnitPriceDiscountPct) - (s.OrderQuantity * s.TotalProductCost)) as "Sum of Profit"
from sales s
join product p on p.ProductKey = s.ProductKey
join date_table d on s.OrderDate = d.FullDateAlternateKey
join salesterritory st on st.SalesTerritoryKey = s.SalesTerritoryKey
group by 1
order by 2 asc;

DROP VIEW IF EXISTS ProductsTable;

create view ProductsTable as
select p.*, psc.ProductSubcategoryAlternateKey, psc.EnglishProductSubcategoryName, psc.SpanishProductSubcategoryName, 
psc.FrenchProductSubcategoryName, psc.ProductCategoryKey, pc.ProductCategoryAlternateKey, pc.EnglishProductCategoryName,
pc.SpanishProductCategoryName, pc.FrenchProductCategoryName
from product p
join productsubcategory psc on p.ProductSubcategoryKey = psc.ProductSubcategoryKey
join productcategory pc on pc.ProductCategoryKey = psc.ProductCategoryKey;

select * from ProductsTable;

-- Q12b (Category wise Sales and Profit)
select p.englishproductcategoryname as "Category",
sum((s.OrderQuantity * p.unitprice) - (s.OrderQuantity * s.UnitPriceDiscountPct)) as "Sum of Sales Amount",
-- sum((s.OrderQuantity * s.TotalProductCost)) as "Sum of Production Cost"
sum((s.OrderQuantity * p.unitprice) - (s.OrderQuantity * s.UnitPriceDiscountPct) - (s.OrderQuantity * s.TotalProductCost)) as "Sum of Profit"
from sales s
join productstable p on p.ProductKey = s.ProductKey
join date_table d on s.OrderDate = d.FullDateAlternateKey
group by 1
order by 2 asc;

-- Q12c (Gender wise Sales and Profit)
select c.gender as "Gender",
sum((s.OrderQuantity * p.unitprice) - (s.OrderQuantity * s.UnitPriceDiscountPct)) as "Sum of Sales Amount",
-- sum((s.OrderQuantity * s.TotalProductCost)) as "Sum of Production Cost"
sum((s.OrderQuantity * p.unitprice) - (s.OrderQuantity * s.UnitPriceDiscountPct) - (s.OrderQuantity * s.TotalProductCost)) as "Sum of Profit"
from sales s
join productstable p on p.ProductKey = s.ProductKey
join date_table d on s.OrderDate = d.FullDateAlternateKey
join customers c on c.CustomerKey = s.CustomerKey
group by 1
order by 2 asc;