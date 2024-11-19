-- Passengers with Secuitiry_check, Booking, Baggage_check by passenger_id;
ALTER TABLE Security_check ADD CONSTRAINT fk_passenger_security FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id);
ALTER TABLE Booking ADD CONSTRAINT fk_passenger_booking FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id);
ALTER TABLE Baggage_check ADD CONSTRAINT fk_passenger_baggage_check FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id);

-- Booking with Baggage_check, Baggage, Boarding_pass, Booking_flight by booking_id;
ALTER TABLE Baggage_check ADD CONSTRAINT fk_booking_baggage_check FOREIGN KEY (booking_id) REFERENCES Booking(booking_id);
ALTER TABLE Baggage ADD CONSTRAINT fk_booking_baggage FOREIGN KEY (booking_id) REFERENCES Booking(booking_id);
ALTER TABLE Boarding_pass ADD CONSTRAINT fk_booking_boarding_pass FOREIGN KEY (booking_id) REFERENCES Booking(booking_id);
ALTER TABLE Booking_flight ADD CONSTRAINT fk_booking_flight FOREIGN KEY (booking_id) REFERENCES Booking(booking_id);

-- Flights with Booking_flight by flight_id;
ALTER TABLE Booking_flight ADD CONSTRAINT fk_flight_booking_flight FOREIGN KEY (flight_id) REFERENCES Flights(flight_id);

-- Airport with Flights by departing_airport_id;
ALTER TABLE Flights ADD CONSTRAINT fk_departing_airport FOREIGN KEY (departing_airport_id) REFERENCES Airport(airport_id);

-- Airport with Flights by arriving_ airport_id;
ALTER TABLE Flights ADD CONSTRAINT fk_arriving_airport FOREIGN KEY (arriving_airport_id) REFERENCES Airport(airport_id);

-- Airline with Flights by airline_id
ALTER TABLE Flights ADD CONSTRAINT fk_airline_flight FOREIGN KEY (airline_id) REFERENCES Airline(airline_id);


--insert 10 random rows
INSERT INTO Airport (airport_id, airport_name, country, state, city, created_at, updated_at)
VALUES
    (1, 'Los Angeles International', 'USA', 'California', 'Los Angeles', TIMESTAMP '2022-08-15 10:45:23', TIMESTAMP '2023-01-10 08:33:45'),
    (2, 'Heathrow', 'UK', 'England', 'London', TIMESTAMP '2023-03-14 16:23:12', TIMESTAMP '2023-10-29 19:47:56'),
    (3, 'Charles de Gaulle', 'France', 'Ile-de-France', 'Paris', TIMESTAMP '2022-06-20 09:12:45', TIMESTAMP '2023-05-18 14:29:34'),
    (4, 'Dubai International', 'UAE', 'Dubai', 'Dubai', TIMESTAMP '2023-02-02 11:45:23', TIMESTAMP '2023-07-10 06:19:15'),
    (5, 'Singapore Changi', 'Singapore', 'Central Region', 'Singapore', TIMESTAMP '2022-04-12 12:30:33', TIMESTAMP '2023-03-20 15:45:56'),
    (6, 'Haneda', 'Japan', 'Tokyo', 'Tokyo', TIMESTAMP '2021-11-05 07:34:56', TIMESTAMP '2023-01-10 20:10:42'),
    (7, 'Frankfurt International', 'Germany', 'Hesse', 'Frankfurt', TIMESTAMP '2023-04-17 13:22:21', TIMESTAMP '2023-09-12 08:45:11'),
    (8, 'O’Hare International', 'USA', 'Illinois', 'Chicago', TIMESTAMP '2022-01-19 14:45:23', TIMESTAMP '2023-06-07 10:33:20'),
    (9, 'Indira Gandhi International', 'India', 'Delhi', 'New Delhi', TIMESTAMP '2022-07-15 16:47:19', TIMESTAMP '2023-05-01 18:12:34'),
    (10, 'Kuala Lumpur International', 'Malaysia', 'Selangor', 'Kuala Lumpur', TIMESTAMP '2021-08-30 11:14:57', TIMESTAMP '2023-01-02 09:56:43')


--Add a new airline named "KazAir" based in "Kazakhstan" to the airline table.
INSERT INTO Airline (airline_id, airline_code, airline_name, airline_country, created_at, updated_at)
VALUES (11, 'KZA', 'KazAir', 'Kazakhstan', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


--Update the airline country "KazAir" to "Turkey"
UPDATE Airline
SET airline_country = 'Turkey'
WHERE airline_name = 'KazAir';


--Remove the airline named "SIT" from the airline table.
DELETE FROM Airline
WHERE airline_name = 'SIT';


--Add three airlines at once: "AirEasy" in "France", "FlyHigh" in "Brazil" and "FlyFly" in "Poland".
INSERT INTO Airline (airline_id, airline_code, airline_name, airline_country, created_at, updated_at)
VALUES
    (12, 'EZY', 'AirEasy', 'France', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (13, 'FLH', 'FlyHigh', 'Brazil', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (14, 'FLY', 'FlyFly', 'Poland', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


--Delete all flights whose arrival in 2024 year.
DELETE FROM Flights
WHERE EXTRACT(YEAR FROM sch_arrival_time) = 2024;


--Increase the price of all tickets in booking table for flights by 10%.
UPDATE Booking
SET ticket_price = ticket_price * 1.1;


--Delete all tickets whose price is less than 1000 units.
DELETE FROM Booking
WHERE ticket_price < 1000;

