--1. Select all the data of passengers whose last name is same as first name
SELECT *
FROM Passengers
WHERE first_name = last_name;


--2. Select the last name of all passangers without duplicates.
SELECT DISTINCT last_name
FROM Passengers;


--3. Find all male passengers born between 1990 and 2000.
SELECT *
FROM Passengers
WHERE gender = 'Male'
  AND date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';


--4. Find price of tickets sold for each month in sorted way.
SELECT DATE_TRUNC('month', created_at) AS month, SUM(ticket_price) AS total_price
FROM Booking
GROUP BY DATE_TRUNC('month', created_at)
ORDER BY month;


--5. Create a query that shows all flights flying to ‘China’.
SELECT Flights.*
FROM Flights
JOIN Airport ON Flights.arriving_airport_id = Airport.airport_id
WHERE Airport.country = 'China';


--6. Find all airline names based in Kazakhstan.
SELECT airline_name
FROM Airline
WHERE airline_country = 'Kazakhstan';


--7. Reduce the cost of booking price by 10% created before ’12-12-2010’
UPDATE Booking
SET ticket_price = ticket_price * 0.90
WHERE created_at < '2010-12-12';


--8. Find top3 overweighted baggage with more than 25kg.
SELECT *
FROM Baggage
WHERE weight_in_kg > 25
ORDER BY weight_in_kg DESC
LIMIT 3;


--9. Find the youngest passengers’ full name.
SELECT first_name, last_name
FROM Passengers
ORDER BY date_of_birth DESC
LIMIT 1;


--10. Find the cheapest booking price in each booking platform.
SELECT booking_platform, MIN(ticket_price) AS cheapest_price
FROM Booking
GROUP BY booking_platform;
