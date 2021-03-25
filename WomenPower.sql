

drop table Authors;
truncate table Authors;

--AUTHORS
create table Authors (
   ID  int primary key IDENTITY(1,1),
   FirstName nvarchar(50) not null,
   AfterName nvarchar(50),
   BirthDate date not null,

);


select * from Authors;

insert into 
    Authors (Firstname, AfterName, Birthdate) 
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

drop table Books;

select * from Books;

insert into 
    books(isbn13, title, [Language], price_kr, PublishDate, PublisherID) 
values
    (9786797379604, 'Sky', 'En', 5, '2015-01-11', 2),
    (9784245085381, 'Earth', 'En', 6, '2012-02-13', 2),
    (9781852636661, 'Water', 'En', 7, '2020-03-03', 1),
    (9786620703576, 'Wind', 'En', 8, '2013-07-04', 1),
    (9783721497282, 'Storm', 'En', 9, '2014-08-09', 3),
    (9784589562401, 'Lightning', 'En', 10, '2014-02-22',3),
    (9788339434802, 'Mountain', 'En', 1, '2018-10-11', 1),
    (9782317268694, 'Spring', 'En', 2, '2020-07-16', 2),
    (9786527017714, 'Autumn', 'En', 3, '2016-12-05', 3),
    (9787662019991, 'Winter', 'En', 4, '2021-03-18', 2);


drop table Bookstores;

--BOOKSTORES
create table BookStores (
    ID int primary key IDENTITY(1,1),
	[Name] nvarchar(120) not null,
	[Address] nvarchar(max),
    CustomerServiceID int,
    FOREIGN key (CustomerServiceID) REFERENCES CustomerServices(ID)
);

select * from Bookstores;

insert into 
    Bookstores([Name],[Address],CustomerServiceID) 
values
    ('Vasa Bookshop','Vasagatan 3,41134 Lund Sweden',1),
	('King Bookshop','Kinggatan 20,11425 Gothenburg Sweden',2),
	('All Books','vargatan 2,22133 Stockholm Sweden',1);


drop TABLE StockBalance;

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
    AfterName nvarchar (50) DEFAULT '-',
    Address nvarchar(max),

);

drop table Customers;

select * from Customers;

insert into Customers ([Name],AfterName,Address) values ( 'Sofia','Bonakdar','Sparvagen 5,41475 Hindas Sweden')
insert into Customers ([Name],AfterName,Address) values ( 'Elham','Danesh', 'Majorna 2,41370 Gothenburg Sweden')
insert into Customers ([Name],AfterName,Address) values ( 'Lulin','Shen','Solgatan 13,48415 Malmo Sweden')
insert into Customers ([Name],AfterName,Address) values ( 'Wenji','billiow','Vindgatan22,81075 Oslo Norway')


drop table Orders;

--ORDERS
create table Orders(
    OrderNumber uniqueidentifier default newid(),
    CustomerID int,
    BookISBN13 bigint,
    StoreID int,
    Quantity int,
    OrderDate DATE,

FOREIGN KEY(CustomerID) REFERENCES Customers(ID),
FOREIGN KEY(BookISBN13) REFERENCES Books(ISBN13),
FOREIGN KEY(StoreID) REFERENCES BookStores(ID),
FOREIGN KEY(StoreID,BookISBN13) REFERENCES StockBalance(StoreID,ISBN)


);

select * from Orders 

insert into 
    Orders (CustomerID,BookISBN13,StoreID,Quantity,OrderDate) 
values 
    (1, 9786797379604, 1, 1, '2021-02-13'),
	(3, 9783721497282, 1, 2, '2021-03-15'),
	(1, 9788339434802, 2, 2, '2021-02-13'),
	(1, 9786620703576, 3, 3, '2020-10-13');



drop table Publishers

CREATE table Publishers
(

    ID int PRIMARY KEY IDENTITY(1,1),
    [Name] NVARCHAR(50),
    Tel varchar(50)

)

select * from Publishers;

insert into Publishers ([Name],Tel) values ('xnix','0706123426')
insert into Publishers ([Name], Tel) values ('ABD','07065437624')
insert into Publishers ([Name], Tel) values ('Green','07067854321');


drop table CustomerServices

--CUSTOMERSSERVICES used in BookStores

create table CustomerServices(

    ID int PRIMARY KEY IDENTITY(1,1),
    Tel varchar(50),
    Region varchar(50)
)

select * from CustomersServices
insert into CustomerServices (Tel) values ('06568826547')
insert into CustomerServices (Tel) values ('06534565554')


drop view TitlePerAuthor;



create view 
TitlePerAuthor 
as
select 
    concat(FirstName,' ',AfterName)as [Name],
	convert(int, datediff(YY, LEFT(BirthDate, 4), getdate())) as Age, 
	count(AuthorID) as Titles, 
    sum(Price_kr) as StockValue

from Authors 
join AuthorsBooks 
on Authors.ID = AuthorsBooks.AuthorID 
join Books 
on  Books.ISBN13 = AuthorsBooks.ISBN
group by 
    FirstName,
	AfterName,
	BirthDate,
	AuthorID;


drop table AuthorsBooks

--AUTHORSBOOKS many to many
create table AuthorsBooks (
    AuthorID int,
    ISBN bigint,
    foreign key (AuthorID) references Authors(ID),
    foreign key (ISBN) references Books(ISBN13)
)
--select * from books
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

   

create view 
 PublishersRevenue 
as
select p.Name, sum(Quantity*Price_kr) as TotalRevenue
from  orders o  
join books b on (o.BookISBN13 = b.ISBN13)
join Publishers p on (b.PublisherID = p.ID)
GROUP by p.Name

select * from  PublishersRevenue ;
select * from books;
select * from orders;
select * from publishers;

--Why we need this table?
--It's good to know how much we are selling from each publishers for future planning. We can see from which publisher we make the most money.