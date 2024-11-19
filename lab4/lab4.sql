--Retrieve all airline names in uppercase.
SELECT UPPER(airline_name) AS airline_name_uppercase
FROM Airline;

--Replace any occurrence of the word "Air" in airline names with "Aero".
SELECT REPLACE(airline_name, 'Air', 'Aero') AS modified_airline_name
FROM Airline;

--Find all flight numbers that coordinates with both airline 1 and airline 2.
SELECT flight_id
FROM Flights
WHERE airline_id = 1
INTERSECT
SELECT flight_id
FROM Flights
WHERE airline_id = 2;

--Retrieve airports that contain the word "Regional" and "Air"  in their names.
SELECT airport_name
FROM Airport
WHERE airport_name LIKE '%Regional%' AND airport_name LIKE '%Air%';

--Retrieve passenger names and format their birth dates as 'Month DD, YYYY'.
SELECT first_name, last_name,
       TO_CHAR(date_of_birth, 'Month DD, YYYY') AS formatted_birth_date
FROM Passengers;

--Find flight numbers that have been delayed based on the actual arrival time.
SELECT flight_id
FROM Flights
WHERE act_arrival_time > sch_arrival_time;

--Create a query that divides passengers into age groups like ‘Young’  and ‘Adult’ based on their birth date. Young passengers age between 18 and 35, Adult passengers age between 36 and 55.
SELECT first_name, last_name,
       CASE
           WHEN AGE(date_of_birth) BETWEEN INTERVAL '18 years' AND INTERVAL '35 years' THEN 'Young'
           WHEN AGE(date_of_birth) BETWEEN INTERVAL '36 years' AND INTERVAL '55 years' THEN 'Adult'
           ELSE 'Other'
       END AS age_group
FROM Passengers;

--Create a query that categorizes ticket prices based on their price as "Cheap," "Medium" or "Expensive."
SELECT ticket_price,
       CASE
           WHEN ticket_price < 500 THEN 'Cheap'
           WHEN ticket_price BETWEEN 500 AND 1000 THEN 'Medium'
           ELSE 'Expensive'
       END AS price_category
FROM Booking;

--Find number of airline names in each airline country.
SELECT airline_country, COUNT(airline_name) AS number_of_airlines
FROM Airline
GROUP BY airline_country;

--Find  flights that arrived late according to  their actual arrival time compared to the scheduled arrival time.
SELECT flight_id, sch_arrival_time, act_arrival_time
FROM Flights
WHERE act_arrival_time > sch_arrival_time;
