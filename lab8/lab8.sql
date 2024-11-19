--1. Create a view to show details of all flights that are departing on a specific date.
CREATE OR REPLACE VIEW flights_on_specific_date AS
SELECT *
FROM flights
WHERE DATE(scheduled_departure) = '2024-01-22';

--2. Create a view that shows bookings for flights scheduled to depart within the next week.
CREATE OR REPLACE VIEW bookings_next_week AS
SELECT b.booking_id, bf.flight_id, f.scheduled_departure
FROM booking b
JOIN booking_flight bf ON b.booking_id = bf.booking_id
JOIN flights f ON bf.flight_id = f.flight_id
WHERE f.scheduled_departure BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '7 days';

--3. Create a view to show the top 5 most popular flight routes based on the number of bookings.
CREATE OR REPLACE VIEW top_5_flight_routes AS
SELECT f.departure_airport_id, f.arrival_airport_id, COUNT(bf.booking_id) AS total_bookings
FROM flights f
JOIN booking_flight bf ON f.flight_id = bf.flight_id
GROUP BY f.departure_airport_id, f.arrival_airport_id
ORDER BY total_bookings DESC
LIMIT 5;

--4. Create a view that lists all flights for a specific airline.
CREATE OR REPLACE VIEW flights_by_airline AS
SELECT *
FROM flights
WHERE airline_id = (SELECT airline_id FROM airline WHERE airline_name = 'Airline Name'); -- Replace with specific airline name

--5. Modify the view created in task 4 to show only flights departing within the next 7 days for a specific airline.
CREATE OR REPLACE VIEW flights_by_airline_next_week AS
SELECT *
FROM flights
WHERE airline_id = (SELECT airline_id FROM airline WHERE airline_name = 'Airline Name') -- Replace with specific airline name
  AND scheduled_departure BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '7 days';

--6. Create a view to show flights that are delayed by more than 24 hours.
CREATE OR REPLACE VIEW flights_delayed_24_hours AS
SELECT *
FROM flights
WHERE actual_departure IS NOT NULL
  AND scheduled_departure + INTERVAL '24 hours' < actual_departure;
--7. Create a view in which you can display the full name and country of origin of passengers who made bookings on Leffler-Thompson platform. Then show the list of that passengers.
CREATE OR REPLACE VIEW passengers_leffler_thompson AS
SELECT p.first_name || ' ' || p.last_name AS full_name, p.country_of_citizenship
FROM passengers p
JOIN booking b ON p.passenger_id = b.passenger_id
WHERE b.booking_platform = 'Leffler-Thompson';

SELECT * FROM passengers_leffler_thompson;

--8. Create a view that shows top 10 most visited countries.
CREATE OR REPLACE VIEW top_10_visited_countries AS
SELECT a.country, COUNT(f.flight_id) AS total_visits
FROM flights f
JOIN airport a ON f.arrival_airport_id = a.airport_id
GROUP BY a.country
ORDER BY total_visits DESC
LIMIT 10;

--9. Update any of the created views by adding new information in the view table. Show results.
CREATE OR REPLACE VIEW flights_on_specific_date AS
SELECT f.*, al.airline_name
FROM flights f
JOIN airline al ON f.airline_id = al.airline_id
WHERE DATE(f.scheduled_departure) = '2024-01-22'; -- Replace with your desired date

SELECT * FROM flights_on_specific_date;

--10. Drop all existing views.
DROP VIEW IF EXISTS flights_on_specific_date,
                   bookings_next_week,
                   top_5_flight_routes,
                   flights_by_airline,
                   flights_by_airline_next_week,
                   flights_delayed_24_hours,
                   passengers_leffler_thompson,
                   top_10_visited_countries CASCADE;
