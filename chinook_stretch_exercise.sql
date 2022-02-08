/* SQL Stretch Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing&resourcekey=0-7zGUhDz0APEfX58SA8UKog

 The Chinook Database is about an imaginary video and music store. Each track is stored using one of the digital formats and has a genre. The store has also some playlists, where a single track can be part of several playlists. Orders are recorded for customers, but are called invoices. Every customer is assigned a support employee, and Employees report to other employees.
*/

SELECT name, sql FROM sqlite_master
    WHERE type='table'
    ORDER BY name;

--==================================================================
/* TASK I
How many audio tracks in total were bought by German customers? And what was the total price paid for them?
hint: use subquery to find all of tracks with their prices
*/

SELECT ROUND(SUM(UnitPrice), 2) AS Total_Spent, SUM(Quantity) AS Num_Tracks
    FROM invoices JOIN invoice_items
    WHERE BillingCountry = 'Germany';

/* TASK II
What is the space, in bytes, occupied by the playlist “Grunge”, and how much would it cost?
(Assume that the cost of a playlist is the sum of the price of its constituent tracks).
*/

SELECT SUM(bytes) FROM tracks
    WHERE TrackId IN
    (SELECT playlist_track.TrackID FROM playlists
    LEFT JOIN playlist_track
    WHERE playlists.Name = 'Grunge');

/* TASK III
List the names and the countries of those customers who are supported by an employee who was younger than 35 when hired. 
*/

SELECT customers.FirstName, customers.LastName, customers.Country FROM customers
    LEFT JOIN employees ON employees.EmployeeId = customers.SupportRepId
    WHERE (employees.HireDate - employees.BirthDate) < 35;