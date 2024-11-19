--1. Add a CHECK constraint to passenger table to provide that passengers must be at least 10 years old.
ALTER TABLE Passengers
ADD CONSTRAINT chk_passenger_age CHECK (DATE_PART('year', AGE(date_of_birth)) >= 10);
--2.Add a CHECK constraint to accept values in booking price not more than 50000tg and less than 0tg.
ALTER TABLE Booking
ADD CONSTRAINT chk_booking_price CHECK (ticket_price > 0 AND ticket_price <= 50000);

--3.Add a CHECK constraint to accept the luggage weight between 1 and 23 kg.
ALTER TABLE Baggage
ADD CONSTRAINT chk_baggage_weight CHECK (weight_in_kg BETWEEN 1 AND 23);

--4.Add a CHECK constraint to ensure that all values in airport_name must have at least 10 characters.
ALTER TABLE Airport
ADD CONSTRAINT chk_airport_name_length CHECK (LENGTH(airport_name) >= 10);

--5.Add UNIQUE constraint to some columns in each table in database.
ALTER TABLE Airline
ADD CONSTRAINT unique_airline_code UNIQUE (airline_code);

ALTER TABLE Airport
ADD CONSTRAINT unique_airport_name UNIQUE (airport_name);

ALTER TABLE Passengers
ADD CONSTRAINT unique_passport_number UNIQUE (passport_number);

ALTER TABLE Flights
ADD CONSTRAINT unique_flight_id UNIQUE (flight_id);

ALTER TABLE Booking
ADD CONSTRAINT unique_booking_id UNIQUE (booking_id);

--6.Add a CHECK constraint to ensure that male passengers must be at least 18 years old and female passengers must be 19 years old.
ALTER TABLE Passengers
ADD CONSTRAINT chk_gender_age CHECK (
    (gender = 'Male' AND DATE_PART('year', AGE(date_of_birth)) >= 18) OR
    (gender = 'Female' AND DATE_PART('year', AGE(date_of_birth)) >= 19)
);

--7.Add a CHECK constraint to add rule as follow (use column country_of_citizenship):
-- Passengers from Kazakhstan must be at least 18 years old,
-- Passengers from France must be at least 17 years old.
--Passengers from other countries must be at least 19 years old.
ALTER TABLE Passengers
ADD CONSTRAINT chk_country_age CHECK (
    (country_of_citizenship = 'Kazakhstan' AND DATE_PART('year', AGE(date_of_birth)) >= 18) OR
    (country_of_citizenship = 'France' AND DATE_PART('year', AGE(date_of_birth)) >= 17) OR
    (country_of_citizenship NOT IN ('Kazakhstan', 'France') AND DATE_PART('year', AGE(date_of_birth)) >= 19)
);


--Add a ticket_discount column to table booking and a CHECK constraint to apply some
-- discount based on ticket price and created time: the constraint applies a 5% discount
-- for tickets created after 2024-01-01, and 10% discount for tickets created before 2024-01-01.
ALTER TABLE Booking
ADD COLUMN ticket_discount DECIMAL(5, 2);

ALTER TABLE Booking
ADD CONSTRAINT chk_ticket_discount CHECK (
    (created_at >= '2024-01-01' AND ticket_discount = ticket_price * 0.05) OR
    (created_at < '2024-01-01' AND ticket_discount = ticket_price * 0.10)
);
