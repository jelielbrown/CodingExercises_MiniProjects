-- Author: Jeliel Brown
-- Date: 12/04/25

-- Task #1

SELECT CONCAT(city, ', ', state_code) AS Location, COUNT(*) AS Count
FROM PUBLISHER
GROUP BY city, state_code;

-- Task #2

SELECT t1.title AS Title, COUNT(t2.rating) AS 'Total Ratings',
    MIN(t2.rating) AS Low,
    MAX(t2.rating) AS High,
    ROUND(AVG(t2.rating), 2) AS Average
FROM book AS t1
LEFT JOIN book_review AS t2 ON t1.isbn = t2.isbn
GROUP BY t1.isbn, t1.title
ORDER BY 'Total Ratings' DESC, Average DESC;

-- Task #3

SELECT t1.name AS 'Publisher Name', COUNT(t2.isbn) AS 'Book Count'
FROM publisher AS t1
JOIN book AS t2 ON t1.publisher_id = t2.publisher_id
GROUP BY t1.name
HAVING 'Book COunt' > 2
ORDER BY 'Book Count' DESC, 'Publisher Name' DESC;

-- Task #4

SELECT title AS Title, LENGTH(title) AS Length, TRIM(SUBSTR(title, INSTR(title, 'Bill'))) AS 'After Bill'
FROM book
WHERE title LIKE '%Bill%';

-- Task #5

SELECT DISTINCT t2.title
FROM owners_book AS t1
JOIN book AS t2 ON T1.isbn = T2.isbn;

-- Task #6

SELECT t3.name AS 'Review Name', t2.title AS 'Book Title', t1.rating AS Rating
FROM book_review AS t1
JOIN book AS t2 ON t1.isbn = t2.isbn
JOIN reviewer AS t3 ON T1.reviewer_id = t3.reviewer_id
WHERE t1.rating BETWEEN 5 AND 7
ORDER BY rating DESC, 'Book Title' DESC;

-- Task #7
SELECT CONCAT(t1.name, ' in ', t1.city, ', ', t1.state_code) AS publisher,
FROM owner AS t1
LEFT JOIN owners_book AS t2 ON t1.owner_id = t2.owner_id
LEFT JOIN book AS t3 ON t2.isbn = t3.isbn
ORDER BY 'Last Name' DESC, 'FIrst Name' DESC;

-- Task #8

SELECT CONCAT(t1.name, ' in ', t1.city, ', ', t1.state_code) AS publisher,
    COUNT(t2.isbn) AS '# Of Books',
    MAX(LENGTH(t2.title)) AS 'Longest Title',
    MIN(LENGTH(t2.title)) AS 'Shortest Title'
FROM publisher AS t1
INNER JOIN book AS t1 ON t1.publisher_id = t2.publisher_id
WHERE INSTR(t1.name, 'read') > 0 OR INSTR(t1.name, 'Read') > 0
GROUP BY t1.publisher_id, t1.name, t1.city, t1.state_code
HAVING '# Of Books' > 1;