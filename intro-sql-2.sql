

--- auto increment 
-- id de�eri unique olmas�n� istiyorsunuz �o�u zaman
-- id de�erleri 3 tip ile yap�l�yor 
-- 1.tip integer de�er atan�p, de�eri 1'er 1'er artan veya 3'er 3'er, buna ba�lang�� de�eri at�yorsunuz, ilk kullan�c� �u kadar olsun sonras�nda 1'er 1'er arts�n gibi
-- 3.tip ise sizin TC kimlik numaran�z veya belli bir form�le g�re hesaplanan �d de�eriniz
-- Employees isminde bir tablo olu�tur, 1905 de�eri ile ba�las�n ve 2'�er 2'�er arts�n diyebilirsiniz
-- Employees'da Edit Top 200 Rows diyip girerseniz empid k�sm�na veri giri�i yapamazs�n�z ve di�er de�erleri girdikten sonra kendisi otomatik atayacakt�r.

CREATE TABLE dbo.Employees
(
  empid     INT         NOT NULL identity(1907,2) primary key clustered,
  firstname VARCHAR(30) NOT NULL,
  lastname  VARCHAR(30) NOT NULL,
  hiredate  DATE        NOT NULL,
  mgrid     INT         NULL,
  ssn       VARCHAR(20) NOT NULL,
  salary    MONEY       NOT NULL
);

-- bu da primary key'dir ve siz her �al��t�rd���n�zda bamba�ka kodlar olu�tururur
-- e�er oyunlara crack yapt�ysan�z orada da kullanm�� olabilirsiniz
-- integer ile newid aras�nda ki fark �u sizin bir internet siteniz var mesela hepsiburada siz birer birer artan numeric de�er verirseniz ve url'den onu sorgulatabilirseniz
-- hepsiburada.com'un t�m verilerini indirebilirsiniz ve request limiti yoksa 
-- integer olmas�n�n g�zel yani ise indexledi�iniz zaman performans� daha y�ksek olur unique identifier'a g�re 

SELECT NEWID()

--Primary key ekleme. Create table esnas�nda da yap�labilir primary key clustered ile
-- Alter table ile g�ncelleme yapabiliyorsunuz, add constraint ise ko�ul ekle demek
ALTER TABLE dbo.Employees
  ADD CONSTRAINT PK_Employees
  PRIMARY KEY(empid);
  


-- Unique �zelli�i
-- ko�ulun ismini verdik
-- ssn numaras�n�n unique olmas�n� sa�layabilirsiniz
-- e-mail gibi d���nebilirsiniz, bir yere kay�t olurken sizden e-mail adresinizi istiyorlar
ALTER TABLE dbo.Employees
  ADD CONSTRAINT UNQ_Employees_ssn
  UNIQUE(ssn);

  -- veri giri�i
  -- insert into fonksiyonunu kullanmals�n�z
  -- hangi columns'lara veri giri�i yapacaksan�z onlar� yazabilirsiniiz
  -- values'den sonra de�erleri yazabilirsiniz 
  -- siz bu kodu �al��t�r�rsan�z �al��mayacakt�r, ��nk� id k�sm�n� otomatik artan yapm��t�n�z
INSERT INTO [Employees]
([empid],[firstname],[lastname],[hiredate],[mgrid],[ssn],[salary])
VALUES 
(1907,'ismet','can','2012-03-04',132,'49715774718',100)

-- bu k�s�m� �al��t�r�rsan�z �al��t���n� g�receksiniz 
-- ama yukar� k�s�mda ssn numaras�n� unique yapt���n�z i�in iki defa �al��t�rd���n�z da �al��mayacakt�r ve onu de�i�tirmelisiniz

INSERT INTO [Employees]
([firstname],[lastname],[hiredate],[mgrid],[ssn],[salary])
VALUES 
('ismet','can','2012-03-04',132,'49715774718',100)


--  foreign key i�in tablo kontrolu ve olu�turma
--  kullan�c� tablonuz var bir de order tablosu olu�turmak istiyorsan�z, kontrolunu yap�p silebilirsiniz
IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL
  DROP TABLE dbo.Orders;

-- order tablosu olu�turma 
-- constraint'i tablo olu�tururken olu�turabilirsiniz, orderid'leri primary key yapm�� oldunuz
-- ve art�k iki tane tablonuz var employees ve order diye 
-- employees tablosunda ki empid'den order tablosunda ki empid referans almal� 
-- employees tablosunda ki order tablosunda ki empid ba��ml� olmas� gerekiyor ki veriniz g�venli olsun 
CREATE TABLE dbo.Orders
(
  orderid   INT         NOT NULL,
  empid     INT         NOT NULL,
  eventid int not null,
  custid    VARCHAR(10) NOT NULL,
  orderts   DATETIME2   NOT NULL,
  qty       INT         NOT NULL,
  CONSTRAINT PK_Orders PRIMARY KEY(orderid)
);

-- Foreign key ekleme
-- order tablosunu g�ncelle, ve ko�ul ekle
-- ko�ul ise empid de�erin foreign key olsun, referans al�nan yer olmas�n� istiyorsunuz
-- referens almas� gereken yer ise employees tablosunda ki empid olacak 

ALTER TABLE dbo.Orders
  ADD CONSTRAINT FK_Orders_Employees
  FOREIGN KEY(empid)
  REFERENCES dbo.Employees(empid);

--Constraint ekleme
ALTER TABLE dbo.Employees
  ADD CONSTRAINT CHK_Employees_salary
  CHECK(salary > 100.00);


--Tablonun silinmesi
DROP TABLE dbo.Orders, dbo.Employees;