--Questuin 1--
SELECT *
FROM albums;

--Questuin 2--
SELECT Title
FROM albums
WHERE ArtistId = 50;

--Questuin 3--
SELECT DISTINCT(BillingCountry)
FROM invoices;

--Questuin 4--
SELECT COUNT(DISTINCT ArtistId)
FROM artists;

--Questuin 5--
SELECT Name
FROM tracks
LIMIT 3;

--Questuin 6--
SELECT
    TrackId,
    SUM(UnitPrice * Quantity) As Sales
FROM invoice_items
GROUP BY TrackId
ORDER BY Sales DESC
LIMIT 8;

--Questuin 7--
SELECT 
    CONCAT(FirstName, ' ', LastName) AS FullName,
    CustomerId, Country
FROM customers
WHERE Country = 'Brazil';

--Questuin 8--
SELECT 
    CONCAT(FirstName, ' ', LastName) AS FullName,
    CustomerId, Country
FROM customers
WHERE Country is not 'USA';

--Questuin 9--
SELECT *
FROM employees
WHERE Title LIKE 'Sales%Agent';

--Questuin 10--
SELECT BillingCountry, COUNT(InvoiceId) as InvoicesPerCountry
FROM invoices
Group By BillingCountry;

--Questuin 11--
--Summarize the sales (sum of total in invoices) by country--
--show them in descending order by the total sales--
SELECT BillingCountry, Sum(Total) AS TotalSale
FROM invoices
GROUP BY BillingCountry
ORDER BY TotalSale DESC;

--Questuin 12--
--Summarize the sales (sum of total in invoices) by country--
--show only countries with more than 50 sales--
--them in descending order by the total sales--
SELECT BillingCountry, Sum(Total) AS TotalSale
FROM invoices
GROUP BY BillingCountry
Having TotalSale > 50
ORDER BY TotalSale DESC;

--Questuin 13--
--Summarize the sales (sum of total in invoices) by country--
--show only countries with more than 50 sales--
--them in descending order by the total sales--
--Use only the first 99 invoices--
SELECT 
    BillingCountry, 
    Sum(Total) AS TotalSale
FROM invoices
WHERE InvoiceId < 100
GROUP BY BillingCountry
Having TotalSale > 50
ORDER BY TotalSale DESC;


SELECT 
    BillingCountry, 
    Sum(Total) AS TotalSale
FROM
    (SELECT *
    FROM invoices
    LIMIT 99)
GROUP BY BillingCountry
Having TotalSale > 50
ORDER BY TotalSale DESC;

--Questuin 14--
--Summarize the sales (sum of total in invoices) by country--
--show only countries with more than 50 sales--
--them in ascending order by the total sales--
--Use only invoices in 2012 or later--
SELECT 
    BillingCountry, 
    Sum(Total) AS TotalSale
FROM invoices
WHERE InvoiceDate IN (
    SELECT InvoiceDate
    FROM invoices
    WHERE InvoiceDate >= '2012%')
GROUP BY BillingCountry
Having TotalSale > 50
ORDER BY TotalSale ASC;

SELECT 
    BillingCountry, 
    Sum(Total) AS TotalSale,
    COUNT(InvoiceId)
FROM invoices
WHERE InvoiceDate >= '2012%'
GROUP BY BillingCountry
Having TotalSale > 50
ORDER BY TotalSale ASC;

--Questuin 15--
SELECT 
    BillingCity, 
    Sum(Total) AS TotalSale
FROM invoices
GROUP BY BillingCity
ORDER BY TotalSale DESC
LIMIT 1;

SELECT 
    BillingCity, 
    Sum(Total) AS TotalSale
FROM invoices
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

