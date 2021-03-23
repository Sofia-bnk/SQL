--Tabell: Författare I tabellen författare vill vi ha
--en Identietskolumn (identity) kallad ID som PK. 
--Därutöver vill vi ha 
--kolumnerna: Förnamn, Efternamn och Födelsedatum i passande datatyper.

drop table Authors;


create table Authors (
   ID  int primary key IDENTITY(1,1),
   FirstName nvarchar(50) not null,
  AfterName nvarchar(50),
   BirthDate date not null,

);

--add this line if for date a certain format is needed like format 103 etc.
--birthDate_ddmmyyyy as ( replace(convert(varchar(11), birthDate, 103), ' ', '-') ), 

select * from Authors
insert into Authors (Firstname, AfterName, Birthdate) values('Jonathan', 'Johanson', '1975-03-09');
insert into Authors (Firstname, AfterName, Birthdate) values('Megan', 'Baker', '1983-05-19'); 
insert into Authors (Firstname, AfterName, Birthdate) values('Alison', 'Gray', '1968-11-01'); 
insert into Authors (Firstname, AfterName, Birthdate) values('Dan', 'Kerr', '1977-10-22'); 

--truncate table authors;
--the same result as the date format aboue



--Tabell: Böcker I tabellen böcker vill vi ha ISBN13 som primärnyckel med 
--lämpliga constraints. Utöver det vill vi ha kolumnerna: Titel, Språk, Pris, 
--och Utgivningsdatum av passande datatyper. Sist vill vi ha en FK-kolumn FörfattareID
--som pekar mot tabellen Författare. Utöver dessa kolumner får ni gärna lägga till egna med
--information som ni tycker kan vara bra att lagra om varje bok. 
-- International Standard Book Number (ISBN)

create table Books (
    ISBN13 bigint not null,
	Title nvarchar(120) not null,
	[Language] nvarchar(50) not null,
	Price_kr smallmoney not null, 
    PublishDate date not null,
	AuthorID int not null,
    BookStoreID int,
	primary key (ISBN13),
	foreign key (AuthorId) references Authors(ID),
	CONSTRAINT chk_isbn13 CHECK (ISBN13  like '%[0-9]%')
);
--select * from Bookstores;
drop table Books;
select * from Books;

insert into books(isbn13, title, [Language], price_kr, PublishDate, authorid ) values(9786797379604, 'Sky', 'En', 129.9,'2015-01-11',1);
insert into books(isbn13, title, [Language], price_kr, PublishDate, authorid ) values(9784245085381, 'Earth', 'En', 119.9,'2012-02-13',3);
insert into books(isbn13, title, [Language], price_kr, PublishDate, authorid ) values(9781852636661, 'Water', 'En', 139.9,'1989-03-03',2);
insert into books(isbn13, title, [Language], price_kr, PublishDate, authorid ) values(9786620703576, 'Wind', 'En', 129.9,'1974-07-04',2);
insert into books(isbn13, title, [Language], price_kr, PublishDate, authorid ) values(9783721497281, 'Storm', 'En', 99.9,'2020-08-09',2);
insert into books(isbn13, title, [Language], price_kr, PublishDate, authorid ) values(9784589562401, 'Lightning', 'En', 329.9,'1990-02-22',3);
insert into books(isbn13, title, [Language], price_kr, PublishDate, authorid ) values(9788339434802, 'Mountain', 'En', 109.9,'1995-10-11', 3);
insert into books(isbn13, title, [Language], price_kr, PublishDate, authorid ) values(9782317268694, 'Spring', 'En', 229.9,'2008-07-16', 4);
insert into books(isbn13, title, [Language], price_kr, PublishDate, authorid ) values(9786527017714, 'Autumn', 'En', 249.9,'2016-12-05', 4);
insert into books(isbn13, title, [Language], price_kr, PublishDate, authorid )  values(9787662019991, 'Winter', 'En', 119.9,'2021-03-18', 4);





--Tabell: Butiker Utöver ett identity-ID så behöver tabellen 
--kolumner för att lagra butiksnamn samt addressuppgifter. 

drop table Bookstores;
create table BookStores (
    ID int primary key IDENTITY(1,1),
	[Name] nvarchar(120) not null,
	[Address] nvarchar(120) not null,
);

select * from Bookstores;
insert into Bookstores([Name],[Address]) values('Vasa Bookshop', 'Vasa Street 3, 41134 Gothenburg');
insert into Bookstores([Name],[Address]) values('King Bookshop', 'King Street 20, 11425 Stockholm');
insert into Bookstores([Name],[Address]) values('All Books', 'Spring Street 46, 22133 Lund')

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
insert into StockBalance(StoreID,ISBN,Total) values (1,9786797379604,1)
insert into StockBalance(StoreID,ISBN,Total) values (2,9784245085381,1)
insert into StockBalance(StoreID,ISBN,Total) values (3,9781852636661,1)
insert into StockBalance(StoreID,ISBN,Total) values (3,9786620703576,1)
insert into StockBalance(StoreID,ISBN,Total) values (1,9783721497281,1)
insert into StockBalance(StoreID,ISBN,Total) values (1,9784589562401,1)
insert into StockBalance(StoreID,ISBN,Total) values (2,9788339434802,1)
insert into StockBalance(StoreID,ISBN,Total) values (3,9782317268694,1)
insert into StockBalance(StoreID,ISBN,Total) values (3,9786527017714,1)
insert into StockBalance(StoreID,ISBN,Total) values (2,9787662019991,1)

