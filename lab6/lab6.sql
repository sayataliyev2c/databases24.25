--1. Write a query that displays all flights of a specific airline.
SELECT *
FROM Flights
WHERE airline_id = (SELECT airline_id FROM Airline WHERE airline_name = 'NQX');

--2. Compose a query to obtain a list of all flights with the names of departure airports.
SELECT f.flight_id, f.scheduled_departure, a.airport_name AS departure_airport
FROM Flights f
JOIN Airport a ON f.departure_airport_id = a.airport_id;

--3. Create a query that finds all airlines that have no flights scheduled for the next month.
SELECT airline_name
FROM Airline
WHERE airline_id NOT IN (
    SELECT DISTINCT airline_id
    FROM Flights
    WHERE flights.scheduled_departure BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '1 month'
);

--4. Create a query to display a list of passengers on a specific flight.
SELECT p.first_name, p.last_name
FROM Passengers p
JOIN Booking b ON p.passenger_id = b.passenger_id
JOIN Booking_flight bf ON b.booking_id = bf.booking_id
WHERE bf.flight_id = '7';

--5. Write a query that calculates the average, total, maximum and minimum price of tickets for each flight.
SELECT bf.flight_id,
       AVG(b.price) AS avg_ticket_price,
       SUM(b.price) AS total_ticket_price,
       MAX(b.price) AS max_ticket_price,
       MIN(b.price) AS min_ticket_price
FROM Booking_flight bf
JOIN Booking b ON bf.booking_id = b.booking_id
GROUP BY bf.flight_id;

--6. Create a query that shows all flights flying to a specific country by combining flights, airports and airline, and using the condition on the country name.
SELECT f.flight_id, f.scheduled_departure, f.scheduled_arrival, a.airport_name AS arriving_airport, al.airline_name
FROM Flights f
JOIN Airport a ON f.arrival_airport_id = a.airport_id
JOIN Airline al ON f.airline_id = al.airline_id
WHERE a.country = 'Russia';

--7. Display a list of minor passengers and their arrival destination.
SELECT p.first_name, p.last_name, a.airport_name AS arrival_destination
FROM Passengers p
JOIN Booking b ON p.passenger_id = b.passenger_id
JOIN Booking_flight bf ON b.booking_id = bf.booking_id
JOIN Flights f ON bf.flight_id = f.flight_id
JOIN Airport a ON f.arrival_airport_id = a.airport_id
WHERE DATE_PART('year', AGE(p.date_of_birth)) < 18;

--8. Display the passenger’s full name, passport number, and the passenger’s current time of arrival at the destination.
SELECT p.first_name, p.last_name, p.passport_number, f.actual_arrival
FROM Passengers p
JOIN Booking b ON p.passenger_id = b.passenger_id
JOIN Booking_flight bf ON b.booking_id = bf.booking_id
JOIN Flights f ON bf.flight_id = f.flight_id;

--9. Print a list of flights where the airline's home country and origin country are the same. Group them by the airport country.
SELECT a.country AS airport_country, COUNT(f.flight_id) AS number_of_flights
FROM Flights f
JOIN Airport a ON f.departure_airport_id = a.airport_id
JOIN Airline al ON f.airline_id = al.airline_id
WHERE al.airline_country = a.country
GROUP BY a.country;
