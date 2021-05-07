
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



select * from Books;

insert into 
    books(isbn13, title, [Language], price_kr, PublishDate, PublisherID) 
values
    (9789113101880, 'Sky', 'En', 50, '2015-01-11', 2),
    (9780393640311, 'Earth', 'En', 60, '2012-02-13', 2),
    (9780962689543, 'Water', 'En', 70, '2020-03-03', 1),
    (9781108478328, 'Wind', 'En', 80, '2013-07-04', 1),
    (9789151916484, 'Storm', 'En', 90, '2014-08-09', 3),
    (9780141346809, 'Lightning', 'En', 100, '2014-02-22',3),
    (9780954151157, 'Mountain', 'En', 100, '2018-10-11', 1),
    (9789178190492, 'Spring', 'En', 20, '2020-07-16', 2),
    (9781593279929, 'Autumn', 'En', 30, '2016-12-05', 3),
    (9780141340241, 'Winter', 'En', 40, '2021-03-18', 2);




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
	('Eli Bookshop','vargatan 2','22133','Stockholm', 'Sweden',1);



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
    (1, 9789113101880, 11),
	(2, 9780393640311, 12),
	(3, 9780962689543, 8),
	(3, 9781108478328, 3),
	(1, 9789151916484, 2),
	(1, 9780141346809, 3),
	(2, 9780954151157, 4),
    (2, 9789178190492, 3),
	(1, 9781108478328, 5),
	(3, 9781593279929, 10),
	(2, 9780141340241, 1);


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


select * from Customers;

insert into Customers ([Name],LastName,Street,PostCode,City,Country) values ( 'Sofia','Bonakdar','Sparvagen 5','41475','Hindas','Sweden')
insert into Customers ([Name],LastName,Street,PostCode,City,Country) values ( 'Elham','Danesh', 'Majorna 2','41370','Gothenburg','Sweden')
insert into Customers ([Name],LastName,Street,PostCode,City,Country) values ( 'Lulin','Shen','Solgatan 13','48415','Malmo','Sweden')
insert into Customers ([Name],LastName,Street,PostCode,City,Country) values ( 'Wenji','billiow','Vindgatan22','81075','Oslo','Norway')



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
    (1,1,'2021-02-13'),
	(3,1,'2021-03-15'),
	(4,2,'2021-02-13'),
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
 (101,9789113101880,50,2),
 (101,9780393640311,60,2),
 (102,9780962689543,70,1),
 (102,9781108478328,80,2),
 (103,9789113101880,50,4),
 (100,9780141340241,40,1);


--PUBLISHERS
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




--CUSTOMERSSERVICES used in BookStores

create table CustomerServices(

    ID int PRIMARY KEY IDENTITY(1,1),
    Tel nvarchar(50),
    Region nvarchar(50)
)

select * from CustomersServices
insert into CustomerServices (Tel) values ('06568826547')
insert into CustomerServices (Tel) values ('06534565554')



create view 
TitlePerAuthor 
as
select 
AuthorID,
    concat(FirstName,' ',LastName)as [Name],
	convert(int, datediff(YY, LEFT(BirthDate, 4), getdate())) as Age, 
	count(distinct Title) as Titles,
    sum(Total) as StockCount,
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
select * from Books;
select * from BookStores;





--AUTHORSBOOKS many to many
create table AuthorsBooks (
    AuthorID int,
    ISBN bigint,
    foreign key (AuthorID) references Authors(ID),
    foreign key (ISBN) references Books(ISBN13),
    PRIMARY key (AuthorID,ISBN)

)
select * from books
select * from AuthorsBooks

insert into 
    AuthorsBooks (AuthorID,ISBN) 
values 
    (1, 9789113101880),
	(2, 9789113101880),
	(3, 9780393640311),
    (4, 9780393640311),
	(2, 9780962689543),
    (3, 9781108478328),
    (4, 9789151916484),
    (3, 9780141346809),
    (2, 9780954151157),
    (2, 9789178190492),
    (1, 9781593279929),
    (1, 9780141340241);


   

create view 
PublishersRevenue 
as
select p.Name, sum(Quantity*UnitPrice) as TotalRevenue
from  OrderDetails   
join books b on (OrderDetails.BookISBN13 = b.ISBN13)
join Publishers p on (b.PublisherID = p.ID)
GROUP by p.Name

select * from PublishersRevenue;




select  ISBN13, Title, concat(Author, iif(numberOfAuthors > 1, ' m.fl.', ''))as Author, Price_kr,PublishDate from(
select 
ROW_NUMBER() OVER (PARTITION BY ISBN13, Title order by ISBN13, Title) as rownumber, 
count(Authors.ID) over (partition by isbn13, title) as numberOfAuthors,
ISBN13, 
Title, 
concat(Firstname,' ',LastName) as Author,
Price_kr,PublishDate
from Authors
join AuthorsBooks on (AuthorsBooks.AuthorID=Authors.ID)
join Books on (AuthorsBooks.ISBN=Books.isbn13)
where ISBN13 = '9781852636661'
) q where rownumber = 1



select * from Bookstores


select bs.Name, ISNULL(convert(varchar(10),q.Total),'ej i lager') as 'In Stock' from (
    select [name], Total 
 from StockBalance
 join BookStores ON (StockBalance.StoreID=BookStores.ID) 
   where StockBalance.ISBN='9784245085381'
) q
right join BookStores bs on bs.Name=q.name 



-- Delete order

drop table StockBalance;
drop table OrderDetails;
drop table AuthorsBooks;
drop table Authors;
drop table Books;
drop table Publishers;
drop table Orders;
drop table BookStores;
drop table CustomerServices;
drop table Customers;


