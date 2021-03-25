

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
	Price_kr smallmoney not null, 
    PublishDate date not null,
	AuthorID int not null,
    PublisherID int,
	--primary key (ISBN13),
	foreign key (AuthorId) references Authors(ID),
	constraint chk_isbn13 
	check (ISBN13  like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    foreign key (PublisherID) references Publishers(ID),
);

drop table Books;

select * from Books;

insert into 
    books(isbn13, title, [Language], price_kr, PublishDate, authorid, PublisherID) 
values
    (9786797379604, 'Sky', 'En', 129.9, '2015-01-11', 1, 2),
    (9786797379604, 'Sky', 'En', 129.9, '2015-01-11', 2, 2),
    (9784245085381, 'Earth', 'En', 119.9, '2012-02-13', 3, 2),
    (9784245085381, 'Earth', 'En', 119.9, '2012-02-13', 2, 2),
    (9781852636661, 'Water', 'En', 139.9, '2020-03-03', 2, 1),
    (9786620703576, 'Wind', 'En', 129.9, '2013-07-04', 2, 1),
    (9783721497281, 'Storm', 'En', 99.9, '2014-08-09', 2, 3),
    (9784589562401, 'Lightning', 'En', 329.9, '2014-02-22', 3, 3),
    (9788339434802, 'Mountain', 'En', 109.9, '2018-10-11', 3, 1),
    (9782317268694, 'Spring', 'En', 229.9, '2020-07-16', 4, 2),
    (9786527017714, 'Autumn', 'En', 249.9, '2016-12-05', 4, 3),
    (9787662019991, 'Winter', 'En', 119.9, '2021-03-18', 4, 2);


drop table Bookstores;

--BOOKSTORES
create table BookStores (
    ID int primary key IDENTITY(1,1),
	[Name] nvarchar(120) not null,
	Address nvarchar(max),
   
);

select * from Bookstores;

insert into 
    Bookstores([Name],[Address]) 
values
    ('Vasa Bookshop','Vasagatan 3,41134 Lund Sweden'),
	('King Bookshop','Kinggatan 20,11425 Gothenburg Sweden'),
	('All Books','vargatan 2,22133 Stockholm Sweden');


drop TABLE StockBalance;

--STOCKBALANCE
create table StockBalance (
    StoreID int not null,
    ISBN bigint ,
    Total int,

    	foreign key (StoreId) references BookStores(ID),
     -- foreign key (ISBN) references Books(ISBN13),
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
	(1, 9783721497281, 2),
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

--drop table Customers;

select * from Customers;

insert into 
    Customers ([Name], AfterName, [Address]) --changed from addressID to address otherwise it didn't work
values 
    ('Sofia', 'Bonakdar', 'Sparvagen 5, 41475 Hindas Sweden'),
	('Elham', 'Danesh', 'Majorna 2, 41370 Gothenburg Sweden'),
	('Lulin', 'Bonakdar', 'Solgatan 13,48415 Malmo Sweden'),
	('Wenji', 'chin', 'Vindgatan22,81075 Oslo Norway');



drop table Orders;

--ORDERS
create table Orders(
    OrderNumber uniqueidentifier default newid(),
    CustomerID int,
    BookISBN13 bigint,
    StoreID int,
    Quantity int,
    OrderDate DATE,

foreign key(CustomerID) references Customers(ID),
foreign key(BookISBN13) references Books(ISBN13),
foreign key(StoreID) references BookStores(ID),
foreign key(StoreID,BookISBN13) references StockBalance(StoreID,ISBN),


);

select * from Orders 

insert into 
    Orders (CustomerID,BookISBN13,StoreID,Quantity,OrderDate) 
values 
    (1, 9786797379604, 1, 1, '2021-02-13'),
	(3, 9783721497281, 1, 2, '2021-03-15'),
	(1, 9788339434802, 2, 2, '2021-02-13'),
	(1, 9786620703576, 3, 3, '2020-10-13');


drop table Publishers

--PUBLISHERS used in books table
create TABLE Publishers (
    ID int primary key identity(1,1),
    [Name] nvarchar(50),
    Tel bigint
)

select * from Publishers;

insert into 
    Publishers ([Name],Tel) 
values 
    ('xnix',0706123426),
	('ABD',07065437624),
	('Green',07067854321);

select * from CustomersServices
insert into CustomersServices (BookStoresID,Tel) values (1,'06568826547')
insert into CustomersServices (BookStoresID,Tel) values (2,'03573245754')
insert into CustomersServices (BookStoresID,Tel) values (3,'06534565554')

drop view TitlePerAuthor;

--TITLEPERAUTHOR
create view 
    TitlePerAuthor 
as
select 
    concat(FirstName,' ',AfterName)as [Name],
	convert(int, datediff(YY, LEFT(BirthDate, 4), getdate())) as Age, 
	count(AuthorID) as Titles, 
	sum(Price_kr) as StockValue
from Authors 
join Books 
on Authors.ID = Books.AuthorID 
group by 
    FirstName,
	AfterName,
	BirthDate,
	AuthorID;



select * from TitlePerAuthor

drop table AuthorsBooks

--AUTHORBOOKS
create table AuthorsBooks (
    AuthorID int,
    ISBN bigint,
    foreign key (AuthorID) references Authors(ID),
    foreign key (ISBN) references Books(ISBN13)
)

select * from AuthorsBooks

insert into 
    AuthorsBooks (AuthorID,ISBN) 
values 
    (1, 9786797379604),
	(2, 9786797379604),
	(3, 9784245085381),
	(2, 9784245085381);
 

-- first try

-- CREATE VIEW Most_Popular_Publisher AS
-- SELECT COUNT(ID) as TotalTimes, BookStores.ID as StoreID
-- from BookStores, Orders
-- where BookStores.ID = Orders.StoreID
-- GROUP BY BookStores.ID

-- drop view Most_Popular_Publisher
-- select * FROM Most_Popular_Publisher

-- modified our everyone's idea
-- CREATE VIEW Publisher_Revenue_Each_Store AS
-- SELECT  count(books.PublisherID), count(Publishers.Name)
-- from Orders
-- inner join Books
-- ON orders.BookISBN13 = books.isbn13
-- inner join Publishers
-- ON books.PublisherID = Publishers.ID
-- GROUP by books.PublisherID, Publishers.Name

--lulin's original code
-- CREATE VIEW Publisher_Revenue_Each_Store AS
-- SELECT Orders.StoreID, Orders.BookISBN13, orders.Quantity*books.price_kr as totalRevenue, books.PublisherID, Publishers.Name
-- from Orders
-- inner join Books
-- ON orders.BookISBN13 = books.isbn13
-- inner join Publishers
-- ON books.PublisherID = Publishers.ID


-- SELECT * FROM Publisher_Revenue_Each_Store
-- drop VIEW Publisher_Revenue_Each_Store

 

