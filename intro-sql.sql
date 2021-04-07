--Sunucudaki veritabanlar�n�n listelenmesi
--E�er bir tablo okuyacaksan�z, FROM'dan sonra yazman�z gerekiyor.�
--SELECT k�sm�nda ise hangi Columns'� g�rmek istiyorsan�z o k�s�ma yazmal�s�n�z.
SELECT * FROM sys.databases; 

--Veritabanlar�n�n dosyalar� ve lokasyonlar� 
-- dbid diye columns koyduk, e�er biz ldf veya mdf dosyalar�n� g�rmek istiyorsak 
-- db_name diye bir fonksiyon koyabilirsiniz o i�erisin de dbid al�r ve o db'nin ismini d�ner size 
-- ayr�ca bunu da sys.sysaltfiles �zerinden oku diyebilirsiniz
select dbid,db_name(dbid), filename from sys.sysaltfiles 
select db_name(dbid) dbname, filename from sys.sysaltfiles

--�zerinde �al���lan veri taban�na ait �zellikler
-- �zerinde �al��t���n�z veri taban� �zelliklerini size d�ner 
-- Execute'un yan taraf�nda yer alan k�s�mndan veri taban�n�z� se�ip yapabilirsiniz
SELECT * FROM sys.database_files;

--Veritaban� olu�turma
-- E�er sorgu seviyesinde veri taban� olu�turmak istiyorsan�z CREATE DATABASE yazman�z gerekiyor
-- Veri taban�n�z�n ismini yazmal�s�n�z, FILENAME'in Path'ini belirtmelisiniz
CREATE DATABASE introsql ON (FILENAME = 'D:\yedek\DataScienceEarth_Data.mdf');

--Kullan�lacak veritaban� se�imi
-- Execute'un yan taraf�nda de�i�ti�ini g�rebilirsiniz
Use introsql

--Kullan�lacak tablonun varl���n�n sorgulanmas� ve varsa silinmesi
-- Di�er programlama dillerinde ki gibi IF ko�ulu asl�nda ayn� i�i yapar 
-- Veri taban�nda Employees diye bir tablo varsa ve bo� de�ilse 
-- DROP TABLE ile sil diyor
IF OBJECT_ID('dbo.Employees', 'U') IS NOT NULL
  DROP TABLE dbo.Employees;




--Tablo olu�turma
-- �st sat�rda sildi�iniz tabloyu �imdi olu�turacaks�n�z
-- Employees tablosu olu�tur
-- NOT NULL - Bo� olmamas�n� sa�l�yor
-- Tables �zerine Refresh yaparsan�z tablonuzu g�r�nt�leyebilirsiniz
CREATE TABLE dbo.Employees
(
  empid     INT         NOT NULL,
  firstname VARCHAR(30) NOT NULL,
  lastname  VARCHAR(30) NOT NULL,
  hiredate  DATE        NOT NULL,
  mgrid     INT         NULL,
  ssn       VARCHAR(20) NOT NULL,
  salary    MONEY       NOT NULL
);