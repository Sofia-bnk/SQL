
--drop table Authors;
truncate table Authors;

--AUTHORS
create table Authors (
   ID  int primary key IDENTITY(1,1),
   FirstName nvarchar(50) not null,
   LastName nvarchar(50),
   BirthDate date not null,

);


select * from Authors;

insert into 
    Authors (Firstname, LastName, Birthdate) 
values
    ('Jonathan', 'Johanson', '1975-03-09'),
	('Megan', 'Baker', '1983-05-19'),
	('Alison', 'Gray', '1968-11-01'),
	('Dan', 'Kerr', '1977-10-22'); 


--BOOKS
create table Books (
    ISBN13 bigint not null,
	Title nvarchar(120) not null,
	[Language] nvarchar(50) not null,
	Price_kr int not null, 
    PublishDate date not null,
	--AuthorID int not null,
    PublisherID int,
	primary key (ISBN13),
	--foreign key (AuthorId) references Authors(ID),
	constraint chk_isbn13 
	check (ISBN13  like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    foreign key (PublisherID) references Publishers(ID),
);

--drop table Books;

select * from Books;

insert into 
    books(isbn13, title, [Language], price_kr, PublishDate, PublisherID) 
values
    (9786797379604, 'Sky', 'En', 50, '2015-01-11', 2),
    (9784245085381, 'Earth', 'En', 60, '2012-02-13', 2),
    (9781852636661, 'Water', 'En', 70, '2020-03-03', 1),
    (9786620703576, 'Wind', 'En', 80, '2013-07-04', 1),
    (9783721497282, 'Storm', 'En', 90, '2014-08-09', 3),
    (9784589562401, 'Lightning', 'En', 100, '2014-02-22',3),
    (9788339434802, 'Mountain', 'En', 100, '2018-10-11', 1),
    (9782317268694, 'Spring', 'En', 20, '2020-07-16', 2),
    (9786527017714, 'Autumn', 'En', 30, '2016-12-05', 3),
    (9787662019991, 'Winter', 'En', 40, '2021-03-18', 2);


--drop table Bookstores;

--BOOKSTORES
create table BookStores (
    ID int primary key IDENTITY(1,1),
	[Name] nvarchar(120) not null,
	Street nvarchar(150),
    PostCode nvarchar(150),
    City nvarchar(150),
    Country nvarchar(150),
    CustomerServiceID int,
    FOREIGN key (CustomerServiceID) REFERENCES CustomerServices(ID)
);

select * from Bookstores;

insert into 
    Bookstores([Name],Street,PostCode,City,Country,CustomerServiceID) 
values
    ('Vasa Bookshop','Vasagatan 3','41134','Lund','Sweden',1),
	('King Bookshop','Kinggatan 20','11425' ,'Gothenburg' ,'Sweden',2),
	('All Books','vargatan 2','22133','Stockholm', 'Sweden',1);


--drop TABLE StockBalance;

--STOCKBALANCE
create table StockBalance (

    StoreID int not null,
    ISBN bigint ,
    Total int,

    	foreign key (StoreId) references BookStores(ID),
        foreign key (ISBN) references Books(ISBN13),
        primary key (StoreID,ISBN)
);

select * from StockBalance;


insert into 
    StockBalance(StoreID, ISBN, Total) 
values 
    (1, 9786797379604, 11),
	(2, 9784245085381, 12),
	(3, 9781852636661, 8),
	(3, 9786620703576, 3),
	(1, 9783721497282, 2),
	(1, 9784589562401, 3),
	(2, 9788339434802, 4),
	(3, 9782317268694, 5),
	(3, 9786527017714, 10),
	(2, 9787662019991, 1);
  


--CUSTOMERS
create TABLE Customers (
    ID int PRIMARY key identity(1,1),
    [Name] nvarchar(50) not null,
    LastName nvarchar (50) DEFAULT '-',
    Street nvarchar(150),
    PostCode nvarchar(150),
    City nvarchar(150),
    Country nvarchar(150)

);

--drop table Customers;

select * from Customers;

insert into Customers ([Name],LastName,Street,PostCode,City,Country) values ( 'Sofia','Bonakdar','Sparvagen 5','41475','Hindas','Sweden')
insert into Customers ([Name],LastName,Street,PostCode,City,Country) values ( 'Elham','Danesh', 'Majorna 2','41370','Gothenburg','Sweden')
insert into Customers ([Name],LastName,Street,PostCode,City,Country) values ( 'Lulin','Shen','Solgatan 13','48415','Malmo','Sweden')
insert into Customers ([Name],LastName,Street,PostCode,City,Country) values ( 'Wenji','billiow','Vindgatan22','81075','Oslo','Norway')


--drop table Orders;

--ORDERS
create table Orders(
    OrderNumber bigint PRIMARY key identity(100,1),
    CustomerID int,
    StoreID int,
    OrderDate DATE,

FOREIGN KEY(CustomerID) REFERENCES Customers(ID),
FOREIGN KEY(StoreID) REFERENCES BookStores(ID),

);


select * from Orders 

insert into 
    Orders (CustomerID,StoreID,OrderDate) 
values 
    (1, 1,'2021-02-13'),
	(3,1,'2021-03-15'),
	(4, 2,'2021-02-13'),
	(2,3,'2020-10-13');


--ORDERDETAILS
create table OrderDetails(
     ID int PRIMARY key identity(1,1),
     OrderNumber bigint,
     BookISBN13 bigint,
     UnitPrice SMALLMONEY,
     Quantity int,
FOREIGN KEY(BookISBN13) REFERENCES Books(ISBN13),
FOREIGN KEY(OrderNumber) REFERENCES Orders(OrderNumber)
);
 select * from OrderDetails;
 INSERT INTO OrderDetails (OrderNumber,BookISBN13,UnitPrice,Quantity)
 values
 (101,9786797379604,50,2),
 (101,9786620703576,80,2),
 (102,9784589562401,100,1),
 (102,9788339434802,100,2),
 (103,9786797379604,50,4),
 (100,9787662019991,40,1);


--drop table Publishers

CREATE table Publishers
(

    ID int PRIMARY KEY IDENTITY(1,1),
    [Name] NVARCHAR(50),
    Tel nvarchar(50)

)

select * from Publishers;

insert into Publishers ([Name],Tel) values ('xnix','0706123426')
insert into Publishers ([Name], Tel) values ('ABD','07065437624')
insert into Publishers ([Name], Tel) values ('Green','07067854321');


--drop table CustomerServices

--CUSTOMERSSERVICES used in BookStores

create table CustomerServices(

    ID int PRIMARY KEY IDENTITY(1,1),
    Tel nvarchar(50),
    Region nvarchar(50)
)

select * from CustomersServices
insert into CustomerServices (Tel) values ('06568826547')
insert into CustomerServices (Tel) values ('06534565554')



--drop view TitlePerAuthor;

create view 
TitlePerAuthor 
as
select 
    concat(FirstName,' ',LastName)as [Name],
	convert(int, datediff(YY, LEFT(BirthDate, 4), getdate())) as Age, 
	count(AuthorID) as Titles,
    sum(Total*Price_kr) as StockValue

from Authors 
join AuthorsBooks 
on Authors.ID = AuthorsBooks.AuthorID 
join StockBalance 
on  StockBalance.ISBN = AuthorsBooks.ISBN
join Books
on Books.ISBN13=StockBalance.ISBN
group by 
    FirstName,
	LastName,
	BirthDate,
	AuthorID;


select * from TitlePerAuthor;
select * from StockBalance;
select * from AuthorsBooks;
select * from books;




--drop table AuthorsBooks

--AUTHORSBOOKS many to many
create table AuthorsBooks (
    AuthorID int,
    ISBN bigint,
    foreign key (AuthorID) references Authors(ID),
    foreign key (ISBN) references Books(ISBN13),
    PRIMARY key (AuthorID,ISBN)

)
select * from books
--select * from AuthorsBooks

insert into 
    AuthorsBooks (AuthorID,ISBN) 
values 
    (1, 9786797379604),
	(2, 9786797379604),
	(3, 9784245085381),
    (4, 9784245085381),
	(2, 9781852636661),
    (3, 9786620703576),
    (4, 9783721497282),
    (3, 9784589562401),
    (2, 9788339434802),
    (2, 9782317268694),
    (1, 9786527017714),
    (1, 9787662019991);

   
--drop VIEW PublishersRevenue 
create view 
 PublishersRevenue 
as
select p.Name, sum(Quantity*UnitPrice) as TotalRevenue
from  OrderDetails   
join books b on (OrderDetails.BookISBN13 = b.ISBN13)
join Publishers p on (b.PublisherID = p.ID)
GROUP by p.Name

select * from PublishersRevenue 


--Why we need this table?
--It's good to know how much we are selling from each publishers for future planning. We can see from which publisher we make the most money.