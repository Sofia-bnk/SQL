

drop table Authors;


create table Authors (
   ID  int primary key IDENTITY(1,1),
   FirstName nvarchar(50) not null,
   AfterName nvarchar(50),
   BirthDate date not null,

);


select * from Authors;

insert into Authors (Firstname, AfterName, Birthdate) values('Jonathan', 'Johanson', '1975-03-09');
insert into Authors (Firstname, AfterName, Birthdate) values('Megan', 'Baker', '1983-05-19'); 
insert into Authors (Firstname, AfterName, Birthdate) values('Alison', 'Gray', '1968-11-01'); 
insert into Authors (Firstname, AfterName, Birthdate) values('Dan', 'Kerr', '1977-10-22'); 


create table Books (
    ISBN13 bigint not null,
	Title nvarchar(120) not null,
	[Language] nvarchar(50) not null,
	Price_kr smallmoney not null, 
    PublishDate date not null,
	AuthorID int not null,
    PublisherID int,
	primary key (ISBN13),
	foreign key (AuthorId) references Authors(ID),
	CONSTRAINT chk_isbn13 CHECK (ISBN13  like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    foreign key (PublisherID) references Publishers(ID),
);

drop table Books;

select * from Books;

insert into books(isbn13, title, [Language], price_kr, PublishDate, authorid, PublisherID) values(9786797379604, 'Sky', 'En', 129.9,'2015-01-11',1,2);
insert into books(isbn13, title, [Language], price_kr, PublishDate, authorid, PublisherID ) values(9784245085381, 'Earth', 'En', 119.9,'2012-02-13',3,2);
insert into books(isbn13, title, [Language], price_kr, PublishDate, authorid, PublisherID ) values(9781852636661, 'Water', 'En', 139.9,'2020-03-03',2,1);
insert into books(isbn13, title, [Language], price_kr, PublishDate, authorid, PublisherID ) values(9786620703576, 'Wind', 'En', 129.9,'2013-07-04',2,1);
insert into books(isbn13, title, [Language], price_kr, PublishDate, authorid, PublisherID ) values(9783721497281, 'Storm', 'En', 99.9,'2014-08-09',2,3);
insert into books(isbn13, title, [Language], price_kr, PublishDate, authorid, PublisherID ) values(9784589562401, 'Lightning', 'En', 329.9,'2014-02-22',3,3);
insert into books(isbn13, title, [Language], price_kr, PublishDate, authorid, PublisherID ) values(9788339434802, 'Mountain', 'En', 109.9,'2018-10-11',3,1);
insert into books(isbn13, title, [Language], price_kr, PublishDate, authorid, PublisherID ) values(9782317268694, 'Spring', 'En', 229.9,'2020-07-16',4,2);
insert into books(isbn13, title, [Language], price_kr, PublishDate, authorid, PublisherID ) values(9786527017714, 'Autumn', 'En', 249.9,'2016-12-05',4,3);
insert into books(isbn13, title, [Language], price_kr, PublishDate, authorid, PublisherID ) values(9787662019991, 'Winter', 'En', 119.9,'2021-03-18',4,2);



drop table StoreAddress; 

create table StoreAddress(
    ID int PRIMARY KEY IDENTITY(1,1),
    Street NVARCHAR (150) not NULL,
    PostCode int not NULL,
    City NVARCHAR (50) not NULL,
    Country NVARCHAR (50) not Null

)

select * from StoreAddress;

insert into StoreAddress (Street,PostCode,City,Country) values ('Vasagatan3',41134,'Lund','Sweden')
insert into StoreAddress (Street,PostCode,City,Country) values ('Kinggatan20',11425,'Gothenburg','Sweden')
insert into StoreAddress (Street,PostCode,City,Country) values ('vargatan2',22133,'Stockholm','Sweden')



drop table Bookstores;

create table BookStores (
    ID int primary key IDENTITY(1,1),
	[Name] nvarchar(120) not null,
	AddressID int,
    FOREIGN KEY (AddressID) REFERENCES [StoreAddress](ID)
);

select * from Bookstores;

insert into Bookstores([Name],AddressID) values('Vasa Bookshop',3);
insert into Bookstores([Name],AddressID) values('King Bookshop',2);
insert into Bookstores([Name],AddressID) values('All Books',1)

drop TABLE StockBalance;

create table StockBalance (
    StoreID int not null,
    ISBN bigint ,
    Total int,

    	foreign key (StoreId) references BookStores(ID),
        foreign key (ISBN) references Books(ISBN13),
        primary key (StoreID,ISBN)
);

select * from StockBalance;


insert into StockBalance(StoreID,ISBN,Total) values (1,9786797379604,11)
insert into StockBalance(StoreID,ISBN,Total) values (2,9784245085381,12)
insert into StockBalance(StoreID,ISBN,Total) values (3,9781852636661,8)
insert into StockBalance(StoreID,ISBN,Total) values (3,9786620703576,3)
insert into StockBalance(StoreID,ISBN,Total) values (1,9783721497281,2)
insert into StockBalance(StoreID,ISBN,Total) values (1,9784589562401,3)
insert into StockBalance(StoreID,ISBN,Total) values (2,9788339434802,4)
insert into StockBalance(StoreID,ISBN,Total) values (3,9782317268694,5)
insert into StockBalance(StoreID,ISBN,Total) values (3,9786527017714,10)
insert into StockBalance(StoreID,ISBN,Total) values (2,9787662019991,1)


create TABLE [CustomerAddress] (
    ID int PRIMARY key identity(1,1),
    Street NVARCHAR (150) not NULL,
    PostCode int not NULL,
    City NVARCHAR (50) not NULL,
    Country NVARCHAR (50) not Null
)

select * from [CustomerAddress];


insert into CustomerAddress (Street,PostCode,City,Country) values ('Sparvagen5',41475,'Hindas','Sweden')
insert into CustomerAddress (Street,PostCode,City,Country) values ('Majorna2',41370,'Gothenburg','Sweden')
insert into CustomerAddress (Street,PostCode,City,Country) values ('Solgatan',48415,'Malmo','Sweden')
insert into CustomerAddress (Street,PostCode,City,Country) values ('Vindgatan22',81075,'Oslo','Norway')



create TABLE Customers (
    ID int PRIMARY key identity(1,1),
    [Name] nvarchar(50) not null,
    AfterName nvarchar (50) DEFAULT '-',
    AddressID int,
    FOREIGN KEY (AddressID) REFERENCES [CustomerAddress] (ID)

);

drop table Customers;

select * from Customers;

insert into Customers ([Name],AfterName,AddressID) values ( 'Sofia','Bonakdar',1)
insert into Customers ([Name],AfterName,AddressID) values ( 'Elham','Danesh',2)
insert into Customers ([Name],AfterName,AddressID) values ( 'Lulin','Bonakdar',3)
insert into Customers ([Name],AfterName,AddressID) values ( 'Wenji','chin',4)


drop table Orders;

create table Orders(
    OrderNumber UNIQUEIDENTIFIER default newid(),
    CustomerID int,
    BookISBN13 bigint,
    StoreID int,
    Quantity int,
    OrderDate DATE,

FOREIGN KEY(CustomerID) REFERENCES Customers(ID),
FOREIGN KEY(BookISBN13) REFERENCES Books(ISBN13),
FOREIGN KEY(StoreID) REFERENCES BookStores(ID),
FOREIGN KEY(StoreID,BookISBN13) REFERENCES StockBalance(StoreID,ISBN),


);

select * from Orders 

insert into Orders (CustomerID,BookISBN13,StoreID,Quantity,OrderDate) values (1,9786797379604,1,1,'2021-02-13')
insert into Orders (CustomerID,BookISBN13,StoreID,Quantity,OrderDate) values (3,9783721497281,1,2,'2021-03-15')
insert into Orders (CustomerID,BookISBN13,StoreID,Quantity,OrderDate) values (1,9788339434802,2,2,'2021-02-13')
insert into Orders (CustomerID,BookISBN13,StoreID,Quantity,OrderDate) values (1,9786620703576,3,3,'2020-10-13')

drop table Publishers

create TABLE Publishers (
    ID int PRIMARY KEY IDENTITY(1,1),
    [Name] NVARCHAR(50),
    Tel bigint
)

select * from Publishers;

insert into Publishers ([Name],Tel) values ('xnix',0706123426)
insert into Publishers ([Name], Tel) values ('ABD',07065437624)
insert into Publishers ([Name], Tel) values ('Green',07067854321);



--DROP view TitlePerAuthor

CREATE VIEW TitlePerAuthor AS
select concat(FirstName,' ',AfterName)as [Name],CONVERT(int, DATEDIFF(YY, LEFT(BirthDate, 4), getdate())) as Age, count(AuthorID) as Titles, sum(Price_kr) as StockValue
FROM Authors 
join Books ON Authors.ID = Books.AuthorID 
group by FirstName,AfterName,BirthDate,AuthorID



select * from TitlePerAuthor


