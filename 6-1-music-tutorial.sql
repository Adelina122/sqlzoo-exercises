/*
Tables:
album(asin, title, artist, price, release, label, rank)
track(album, dsk, posn, song)
*/

--#1
/*
Find the title and artist who recorded the song 'Alison'.
*/
SELECT title, artist
FROM album 
JOIN track ON (album.asin=track.album)
WHERE song = 'Alison'

--#2
/*
Which artist recorded the song 'Exodus'?
*/
SELECT album.artist
FROM album
JOIN track ON album.asin=track.album
WHERE track.song = 'Exodus'

--#3
/*
Show the song for each track on the album 'Blur'
*/
SELECT track.song
FROM track
JOIN album ON album.asin=track.album
WHERE album.title = 'Blur'

--#4
/*
For each album show the title and the total number of track.
*/
SELECT title, COUNT(*)
FROM album 
JOIN track ON (asin=album)
GROUP BY title

--#5
/*
For each album show the title and the total number of tracks containing the word 'Heart' 
(albums with no such tracks need not be shown).
*/
SELECT album.title, COUNT(track.song) AS 'number_of_songs'
FROM album
JOIN track ON album.asin=track.album
WHERE track.song LIKE '%Heart%'
GROUP BY 1

--#6
/*
A "title track" is where the song is the same as the title. Find the title tracks.
*/
SELECT track.song
FROM album
JOIN track ON album.asin=track.album
WHERE album.title = track.song

--#7
/*
An "eponymous" album is one where the title is the same as the artist (for example the album 'Blur' by the band 'Blur'). 
Show the eponymous albums.
*/
SELECT title
FROM album
WHERE title = artist

--#8
/*
Find the songs that appear on more than 2 albums. Include a count of the number of times each shows up.
*/
SELECT track.song, COUNT(DISTINCT track.album) AS album
FROM album JOIN track
ON album.asin = track.album
GROUP BY track.song
HAVING COUNT(DISTINCT track.album) > 2;

--#9
/*
A "good value" album is one where the price per track is less than 50 pence. 
Find the good value album - show the title, the price and the number of tracks.
*/
SELECT album.title, album.price, COUNT(track.song) AS songs
FROM album JOIN track
ON album.asin=track.album
GROUP BY album.title, album.price
HAVING album.price/COUNT(track.song) * 100 < 50

--#10
/*
Wagner's Ring cycle has an imposing 173 tracks, Bing Crosby clocks up 101 tracks.
List albums so that the album with the most tracks is first. Show the title and the number of tracks
Where two or more albums have the same number of tracks you should order alphabetically
*/
SELECT album.title, COUNT(track.song) AS track_count
FROM album JOIN track 
ON album.asin = track.album
GROUP BY album.asin, album.title
ORDER BY 2 DESC, 1;









