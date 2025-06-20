create database adventure_works;

use adventure_works;


drop table if exists ProductCategory; 
create table productCategory (ProductCategoryKey int primary key,
							  ProductCategoryAlternateKey int,
                              EnglishProductCategoryName varchar(50),
                              SpanishProductCategoryName varchar(50),
                              FrenchProductCategoryName varchar(50) 
							 );
                             
select * from productCategory;


drop table if exists ProductSubCategory; 
create table productSubCategory (ProductSubcategoryKey int primary key,
							  ProductSubcategoryAlternateKey int unique,
                              EnglishProductSubcategoryName varchar(50),
                              SpanishProductSubcategoryName varchar(50),
                              FrenchProductSubcategoryName varchar(50),
                              ProductCategoryKey int,
                              foreign key (ProductCategoryKey) references productCategory(ProductCategoryKey)
							 );

select * from productsubCategory;

drop table if exists Salesterritory; 
create table Salesterritory (SalesTerritoryKey int primary key,
							 SalesTerritoryAlternateKey int unique,
							 SalesTerritoryRegion varchar(50),
							 SalesTerritoryCountry varchar(50),
							 SalesTerritoryGroup varchar(50)
							 );
                             
select * from Salesterritory;

drop table if exists date_table; 
create table date_table (DateKey int primary key,
						 FullDateAlternateKey date unique not null,
						 DayNumberOfWeek int not null,
						 EnglishDayNameOfWeek varchar(50) not null,
						 SpanishDayNameOfWeek varchar(50) not null,
                         FrenchDayNameOfWeek varchar(50) not null,
                         DayNumberOfMonth int not null,
                         DayNumberOfYear int not null,
                         WeekNumberOfYear int not null,
                         EnglishMonthName varchar(50) not null,
                         SpanishMonthName varchar(50) not null,
                         FrenchMonthName varchar(50) not null,
                         MonthNumberOfYear int not null,
                         CalendarQuarter int not null,
                         CalendarYear int not null,
                         CalendarSemester int not null,
                         FiscalQuarter int not null,
                         FiscalYear int not null,
                         FiscalSemester int not null
						 );
                             
select * from date_table;

drop table if exists product; 
create table product (ProductKey int primary key,
						 UnitPrice decimal(15,4) default 0.0,
						 ProductAlternateKey varchar(15) not null,
						 ProductSubcategoryKey int NULL,
						 WeightUnitMeasureCode varchar(10),
                         SizeUnitMeasureCode varchar(10),
                         EnglishProductName varchar(50) not null,
                         SpanishProductName varchar(50),
                         FrenchProductName varchar(50),
                         StandardCost decimal(15,4) default 0.0,
                         FinishedGoodsFlag boolean,
                         Color varchar(20),
                         SafetyStockLevel int not null,
                         ReorderPoint int not null,
                         ListPrice decimal(15,4) default 0.0,
                         Size varchar(10),
                         SizeRange varchar(20),
                         Weight decimal(15,4) default 0.0,
                         DaysToManufacture int not null,
                         ProductLine varchar(10),
                         DealerPrice decimal(15,4) default 0.0,
                         Class varchar(10),
                         Style varchar(10),
                         ModelName varchar(50),
                         EnglishDescription varchar(300),
                         FrenchDescription varchar(300),
                         ChineseDescription varchar(200),
                         ArabicDescription varchar(300),
                         HebrewDescription varchar(300),
                         ThaiDescription varchar(300),
                         GermanDescription varchar(350),
                         JapaneseDescription varchar(200),
                         TurkishDescription varchar(250),
                         StartDate date not null,
                         EndDate date,
                         Status varchar(50)                         
						 );

alter table product add constraint fk1 foreign key(ProductSubcategoryKey) references productsubcategory(ProductSubcategoryKey);
describe product;
describe productsubcategory;
                             
select * from product;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\AdventureWorks\\DimProduct.csv'
INTO TABLE product
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS 
(@ProductKey, @UnitPrice, @ProductAlternateKey, @ProductSubcategoryKey, @WeightUnitMeasureCode, 
 @SizeUnitMeasureCode, @EnglishProductName, @SpanishProductName, @FrenchProductName, @StandardCost, 
 @FinishedGoodsFlag, @Color, @SafetyStockLevel, @ReorderPoint, @ListPrice, @Size, @SizeRange, 
 @Weight, @DaysToManufacture, @ProductLine, @DealerPrice, @Class, @Style, @ModelName, 
 @EnglishDescription, @FrenchDescription, @ChineseDescription, @ArabicDescription, 
 @HebrewDescription, @ThaiDescription, @GermanDescription, @JapaneseDescription, @TurkishDescription, 
 @StartDate, @EndDate, @Status)
SET
    ProductKey = NULLIF(@ProductKey, ''),
--     UnitPrice = NULLIF(@UnitPrice, ''),
    UnitPrice = NULLIF(NULLIF(@UnitPrice, ''), ' '),
    ProductAlternateKey = @ProductAlternateKey,
    ProductSubcategoryKey = NULLIF(@ProductSubcategoryKey, ''),
    WeightUnitMeasureCode = NULLIF(@WeightUnitMeasureCode, ''),
    SizeUnitMeasureCode = NULLIF(@SizeUnitMeasureCode, ''),
    EnglishProductName = @EnglishProductName,
    SpanishProductName = NULLIF(@SpanishProductName, ''),
    FrenchProductName = NULLIF(@FrenchProductName, ''),
    StandardCost = NULLIF(@StandardCost, ''),
    FinishedGoodsFlag = NULLIF(@FinishedGoodsFlag, ''),
    Color = NULLIF(@Color, ''),
    SafetyStockLevel = NULLIF(@SafetyStockLevel, ''),
    ReorderPoint = NULLIF(@ReorderPoint, ''),
    ListPrice = NULLIF(@ListPrice, ''),
    Size = NULLIF(@Size, ''),
    SizeRange = NULLIF(@SizeRange, ''),
    Weight = NULLIF(@Weight, ''),
    DaysToManufacture = NULLIF(@DaysToManufacture, ''),
    ProductLine = NULLIF(@ProductLine, ''),
    DealerPrice = NULLIF(@DealerPrice, ''),
    Class = NULLIF(@Class, ''),
    Style = NULLIF(@Style, ''),
    ModelName = NULLIF(@ModelName, ''),
    EnglishDescription = NULLIF(@EnglishDescription, ''),
    FrenchDescription = NULLIF(@FrenchDescription, ''),
    ChineseDescription = NULLIF(@ChineseDescription, ''),
    ArabicDescription = NULLIF(@ArabicDescription, ''),
    HebrewDescription = NULLIF(@HebrewDescription, ''),
    ThaiDescription = NULLIF(@ThaiDescription, ''),
    GermanDescription = NULLIF(@GermanDescription, ''),
    JapaneseDescription = NULLIF(@JapaneseDescription, ''),
    TurkishDescription = NULLIF(@TurkishDescription, ''),
    StartDate = NULLIF(@StartDate, ''),
    EndDate = NULLIF(@EndDate, ''),
    Status = NULLIF(@Status, '');

SHOW VARIABLES LIKE 'secure_file_priv';



drop table if exists Sales; 
create table Sales (ProductKey int not null,
					OrderDateKey int not null,
                    DueDateKey int not null,
                    ShipDateKey int not null,
                    CustomerKey int not null,
                    PromotionKey int not null,
                    CurrencyKey int not null,
                    SalesTerritoryKey int not null,
                    SalesOrderNumber varchar(50),
                    SalesOrderLineNumber int not null,
                    RevisionNumber int not null,
                    OrderQuantity int not null,
                    UnitPrice decimal(15,4) not null,
                    ExtendedAmount decimal(15,4) not null,
                    UnitPriceDiscountPct int not null,
                    DiscountAmount int not null,
                    ProductStandardCost decimal(15,4) not null,
                    TotalProductCost decimal(15,4) not null,
                    SalesAmount decimal(15,4) not null,
                    TaxAmt decimal(15,4) not null,
                    Freight decimal(15,4) not null,
                    CarrierTrackingNumber varchar(50) NULL,
                    CustomerPONumber varchar(50) NULL,
                    OrderDate date not null,
                    DueDate date not null,
                    ShipDate date not null
                    );
alter table Sales add constraint fk2 foreign key(ProductKey) references product(ProductKey);
alter table Sales add constraint fk3 foreign key(CustomerKey) references customers(CustomerKey);
alter table Sales add constraint fk4 foreign key(SalesTerritoryKey) references salesterritory(SalesTerritoryKey);

describe sales;
                             
select count(*) from Sales;

commit;


drop table if exists customers; 
create table customers (CustomerKey int primary key,
GeographyKey int not null,
CustomerAlternateKey varchar(50) not null,
Title varchar(20) NULL,
FirstName varchar(50) not null,
MiddleName varchar(20) NULL,
LastName varchar(50) not null,
NameStyle boolean not null,
BirthDate date not null,
MaritalStatus ENUM('M', 'S'),
Suffix varchar(20) NULL,
Gender ENUM('M', 'F'),
EmailAddress varchar(100) not null,
YearlyIncome int not null,
TotalChildren int not null,
NumberChildrenAtHome int not null,
EnglishEducation varchar(100) not null,
SpanishEducation varchar(100) not null,
FrenchEducation varchar(50) not null,
EnglishOccupation varchar(50) not null,
SpanishOccupation varchar(50) not null,
FrenchOccupation varchar(50) not null,
HouseOwnerFlag boolean not null,
NumberCarsOwned int not null,
AddressLine1 varchar(200) not null,
AddressLine2 varchar(100) NULL,
Phone varchar(50) not null,
DateFirstPurchase date not null,
CommuteDistance varchar(50) not null
);

select * from customers;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\AdventureWorks\\DimCustomer.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','  
OPTIONALLY ENCLOSED BY '"'  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS  
(@CustomerKey, @GeographyKey, @CustomerAlternateKey, @Title, @FirstName, 
 @MiddleName, @LastName, @NameStyle, @BirthDate, @MaritalStatus, @Suffix, 
 @Gender, @EmailAddress, @YearlyIncome, @TotalChildren, @NumberChildrenAtHome, 
 @EnglishEducation, @SpanishEducation, @FrenchEducation, @EnglishOccupation, 
 @SpanishOccupation, @FrenchOccupation, @HouseOwnerFlag, @NumberCarsOwned, 
 @AddressLine1, @AddressLine2, @Phone, @DateFirstPurchase, @CommuteDistance)
SET  
    CustomerKey = NULLIF(@CustomerKey, ''),  
    GeographyKey = NULLIF(@GeographyKey, ''),  
    CustomerAlternateKey = NULLIF(@CustomerAlternateKey, ''),  
    Title = NULLIF(@Title, ''),  
    FirstName = NULLIF(@FirstName, ''),  
    MiddleName = NULLIF(@MiddleName, ''),  
    LastName = NULLIF(@LastName, ''),  
    NameStyle = NULLIF(@NameStyle, ''),  
    BirthDate = STR_TO_DATE(NULLIF(@BirthDate, ''), '%Y-%m-%d'),  
    MaritalStatus = NULLIF(@MaritalStatus, ''),  
    Suffix = NULLIF(@Suffix, ''),  
    Gender = NULLIF(@Gender, ''),  
    EmailAddress = NULLIF(@EmailAddress, ''),  
    YearlyIncome = NULLIF(@YearlyIncome, ''),  
    TotalChildren = NULLIF(@TotalChildren, ''),  
    NumberChildrenAtHome = NULLIF(@NumberChildrenAtHome, ''),  
    EnglishEducation = NULLIF(@EnglishEducation, ''),  
    SpanishEducation = NULLIF(@SpanishEducation, ''),  
    FrenchEducation = NULLIF(@FrenchEducation, ''),  
    EnglishOccupation = NULLIF(@EnglishOccupation, ''),  
    SpanishOccupation = NULLIF(@SpanishOccupation, ''),  
    FrenchOccupation = NULLIF(@FrenchOccupation, ''),  
    HouseOwnerFlag = NULLIF(@HouseOwnerFlag, ''),  
    NumberCarsOwned = NULLIF(@NumberCarsOwned, ''),  
    AddressLine1 = NULLIF(@AddressLine1, ''),  
    AddressLine2 = NULLIF(@AddressLine2, ''),  
    Phone = NULLIF(@Phone, ''),  
    DateFirstPurchase = STR_TO_DATE(NULLIF(@DateFirstPurchase, ''), '%Y-%m-%d'),  
    CommuteDistance = NULLIF(@CommuteDistance, '');

