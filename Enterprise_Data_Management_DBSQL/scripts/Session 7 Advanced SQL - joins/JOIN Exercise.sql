---print out the titles of the artist whose ArtistId is 50, in a second column, print also the name of the artist---
SELECT a.Title, b.Name
FROM albums a JOIN artists b 
ON a.ArtistId = b.ArtistId
WHERE a.ArtistId = 50;

---print out the track name and albums title of the first 20 tracks in the tracks table---
SELECT T.Name, A.Title
FROM albums A JOIN tracks T
ON A.AlbumId = T.AlbumId
LIMIT 20;

---for the first 12 sales, print what are the names of the track sold, and the quantity sold---
SELECT T.Name, sum(Inv.Quantity)
FROM invoice_items Inv JOIN tracks T
ON Inv.TrackId = T.TrackId
WHERE Inv.InvoiceLineId <= 12
GROUP BY T.Name;

---print the names of top 5 tracks sold, and how many times they were sold---
SELECT T.Name, COUNT(*) AS TimesSold
FROM invoice_items Inv JOIN tracks T
ON Inv.TrackId = T.TrackId
GROUP BY T.TrackId, T.Name
ORDER BY TimesSold DESC
LIMIT 5;

---Provide a query showing the Invoices of customers who are from Brazil.---
----The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.----
SELECT CONCAT(Cus.FirstName, ' ', Cus.LastName), Inv.InvoiceId, Inv.InvoiceDate, Inv.BillingCountry 
FROM invoices Inv JOIN customers Cus
ON Inv.CustomerId = Cus.CustomerId
WHERE Cus.Country is 'Brazil';

---Provide a query that shows the invoices associated with each sales agent.---
---The resultant table should include the Sales Agent's full name.---
SELECT Inv.*, CONCAT(Emp.FirstName, ' ', Emp.LastName)
FROM invoices Inv JOIN customers Cus ON Inv.CustomerId = Cus.CustomerId
JOIN employees Emp ON Cus.SupportRepId = Emp.EmployeeId
WHERE Emp.Title LIKE 'sales%agent';

---Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.---
SELECT DISTINCT Inv.Total, CONCAT(Cus.FirstName, ' ', Cus.LastName) AS CustomerName, Inv.BillingCountry, CONCAT(Emp.FirstName, ' ', Emp.LastName) AS AgentName
FROM invoices Inv JOIN customers Cus ON Inv.CustomerId = Cus.CustomerId
JOIN employees Emp ON Cus.SupportRepId = Emp.EmployeeId
WHERE Emp.Title LIKE 'sales%agent';

--- If an employee reports to a manager, the value of the ReportsTo column of the employee's row is equal to ---
----the value of the EmployeeId column of the manager's row. ----
----In case an employee does not report to anyone, the ReportsTo column is NULL.
----Get the information on who is the direct report of whom..----
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS Employees, CONCAT(M.FirstName, ' ', M.LastName) As Managers
FROM employees E, employees M 
WHERE M.EmployeeId = E.ReportsTo;

SELECT CONCAT(E.FirstName, ' ', E.LastName) AS Employees, CONCAT(M.FirstName, ' ', M.LastName) As Managers
FROM employees E JOIN employees M ON M.EmployeeId = E.ReportsTo;

---Looking at the Invoice items table, provide a query that COUNTs the number of line items for Invoice ID 37.---
SELECT COUNT(InvT.InvoiceLineId)
FROM invoice_items InvT JOIN invoices Inv ON InvT.InvoiceId = Inv.InvoiceId
WHERE InvT.InvoiceId = 37;

---Looking at the Invoice items table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY---
SELECT InvT.InvoiceId, COUNT(InvT.InvoiceLineId)
FROM invoice_items InvT JOIN invoices Inv ON InvT.InvoiceId = Inv.InvoiceId
GROUP BY InvT.InvoiceId
ORDER BY InvT.InvoiceId ASC;

---Provide a query that shows all the Tracks, but displays no IDs.---
---The resultant table should include the Album name, Media type and Genre.---
SELECT T.Name AS TrackName, A.Title AS AlbumName, MT.Name AS MediaTypeName, G.Name AS GenresName
FROM tracks T JOIN albums A ON T.AlbumId = A.AlbumId
JOIN media_types MT ON T.MediaTypeId = MT.MediaTypeId
JOIN genres G ON T.GenreId = G.GenreId;









