/* SQL Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing&resourcekey=0-7zGUhDz0APEfX58SA8UKog

 The Chinook Database is about an imaginary video and music store. Each track is stored using one of the digital formats and has a genre. The store has also some playlists, where a single track can be part of several playlists. Orders are recorded for customers, but are called invoices. Every customer is assigned a support employee, and Employees report to other employees.
*/


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE




--==================================================================
/* TASK I
Which artists did not make any albums at all? Include their names in your answer.
*/

SELECT Name FROM artists
    LEFT JOIN albums ON artists.ArtistId = albums.ArtistId
    GROUP BY Name
    HAVING COUNT(title) = 0;


/* TASK II
Which artists recorded any tracks of the Latin genre?
*/

SELECT artists.Name FROM artists
    JOIN albums ON artists.ArtistID = albums.ArtistId
    JOIN tracks ON tracks.AlbumId = albums.AlbumId
    WHERE GenreID = 7
    GROUP BY artists.Name;


/* TASK III
Which video track has the longest length?
*/

SELECT tracks.Name, MAX(milliseconds) as ms FROM tracks
    LEFT JOIN media_types ON tracks.MediaTypeId = media_types.MediaTypeId
    WHERE media_types.Name LIKE '%video%';

/* TASK IV
Find the names of customers who live in the same city as the top employee (The one not managed by anyone).
*/

SELECT customers.FirstName, customers.LastName from customers
    WHERE customers.City IN (SELECT City FROM employees WHERE ReportsTo IS NULL)

/* TASK V
Find the managers of employees supporting Brazilian customers.
*/

SELECT FirstName, LastName FROM employees
    WHERE EmployeeId IN (SELECT ReportsTo FROM employees
        JOIN customers ON SupportRepId = EmployeeId
        WHERE customers.Country = 'Brazil');
 

/* TASK VI
Which playlists have no Latin tracks?
*/

SELECT playlists.Name FROM playlists
    JOIN playlist_track ON playlist. = playlist_track.PlaylistId
    JOIN tracks ON playlists.TrackId = tracks.TrackId
    GROUP BY playlists.Name
    HAVING COUNT(tracks.GenreId = 7) = 0;
