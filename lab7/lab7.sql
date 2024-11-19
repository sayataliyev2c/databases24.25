--1. Create an index on the actual_departure column in the flights table.
CREATE INDEX idx_actual_departure
ON flights(actual_departure);

--2. Create a unique index to ensure flight_no and scheduled_departure combinations are unique.
CREATE UNIQUE INDEX idx_flight_no_scheduled_departure
ON flights(flight_no, scheduled_departure);

--3. Create a composite index on the departure_airport_id and arrival_airport_id columns.
CREATE INDEX idx_airports
ON flights(departure_airport_id, arrival_airport_id);

--4. Evaluate the difference in query performance with and without indexes. Measure performance differences.
SELECT *
FROM flights
WHERE departure_airport_id = 1 AND arrival_airport_id = 2;

--5. Use EXPLAIN ANALYZE to check index usage in a query filtering by departure_airport and arrival_airport.
DROP INDEX IF EXISTS idx_airports;
SELECT *
FROM flights
WHERE departure_airport_id = 1 AND arrival_airport_id = 2;

CREATE INDEX idx_airports ON flights(departure_airport_id, arrival_airport_id);
EXPLAIN ANALYZE
SELECT *
FROM flights
WHERE departure_airport_id = 1 AND arrival_airport_id = 2;

--6. Create a unique index for the passport_number of the Passengers table. Check if the index was created or not.
-- Insert into the table two new passengers.Explain in your own words what is going on in the output?
CREATE UNIQUE INDEX idx_passport_number ON passengers(passport_number);

SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'passengers';


INSERT INTO passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, update_at)
VALUES (1, 'John', 'Doe', '1990-01-01', 'Male', 'USA', 'USA', 'A123456', NOW(), NOW());
INSERT INTO passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, update_at)
VALUES (2, 'Jane', 'Smith', '1995-05-05', 'Female', 'Canada', 'Canada', 'A123456', NOW(), NOW());
--7. Create an index for the Passengers table. Use for that first name, last name, date of birth and country of citizenship. Then, write a SQL query to find a passenger who was born in Philippines and was born in 1984 and check if the query uses indexes or not. Give the explanation of the results.
CREATE INDEX idx_passenger_details ON passengers(first_name, last_name, date_of_birth, country_of_citizenship);

SELECT *
FROM passengers
WHERE country_of_citizenship = 'Philippines'
  AND EXTRACT(YEAR FROM date_of_birth) = 1984;

EXPLAIN ANALYZE
SELECT *
FROM passengers
WHERE country_of_citizenship = 'Philippines'
  AND EXTRACT(YEAR FROM date_of_birth) = 1984;

--8. Write a SQL query to list indexes for table Passengers. After delete the created indexes.
SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'passengers';

DROP INDEX IF EXISTS idx_passport_number;
DROP INDEX IF EXISTS idx_passenger_details;


