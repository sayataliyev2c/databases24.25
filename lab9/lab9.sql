--1. A passenger cancels their booking. You need to remove the booking for the flight. Ensure the ‘booking’ table no longer contains the booking. Simulate an error to test rollback (for example, invalid booking_id).
DO $$
BEGIN
    DELETE FROM booking
    WHERE booking_id = 12345;

    IF NOT FOUND THEN
        RAISE NOTICE 'Error: Booking ID does not exist.';
    ELSE
        RAISE NOTICE 'Booking successfully deleted.';
    END IF;
END $$;


--2. Rescheduling a flight. You need to reschedule a flight. Verify the ‘flights’ table reflects the new departure time. Simulate an error to test rollback (for example, invalid flight_id).
DO $$
BEGIN
    -- Update the flight's departure time
    UPDATE flights
    SET scheduled_departure = '2024-11-25 14:00:00' -- New departure time
    WHERE flight_id = 140000;

    IF NOT FOUND THEN
        RAISE NOTICE 'Error: Flight ID does not exist.';
    ELSE
        RAISE NOTICE 'Flight rescheduled successfully.';
    END IF;
END $$;


--3. Updating ticket prices. You need to decrease the ticket price for a specific flight for all existing bookings. If an error occurs, no changes should be applied.
DO $$
BEGIN
    UPDATE booking
    SET price = price - 50.00
    WHERE booking_id IN (
        SELECT booking_id
        FROM booking_flight
        WHERE flight_id = 56789
    );

    IF NOT FOUND THEN
        RAISE NOTICE 'Error: No bookings found for the flight.';
    ELSE
        RAISE NOTICE 'Ticket prices updated successfully.';
    END IF;
END $$;


--4. A passenger updates their details. Ensure the update is reflected across all associated records, including bookings.
DO $$
BEGIN
    -- Update passenger details
    UPDATE passengers
    SET first_name = 'UpdatedFirstName', last_name = 'UpdatedLastName'
    WHERE passenger_id = 123; -- Replace with the valid passenger_id

    -- Ensure associated bookings are updated (if necessary)
    UPDATE booking
    SET status = 'Updated'
    WHERE passenger_id = 123;

    RAISE NOTICE 'Passenger and associated bookings updated successfully.';
END $$;


--5. A new passenger is registered, and a booking is created. Ensure the new passenger is added and the booking succeeds.
DO $$
DECLARE
    new_passenger_id INT;
BEGIN
    -- Insert a new passenger
    INSERT INTO passengers (passenger_id,first_name, last_name, date_of_birth, gender, country_of_citizenship, passport_number, created_at,update_at)
    VALUES (501,'John', 'Doe', '1990-01-01', 'Male', 'USA', 'P123456', NOW(),Now())
    RETURNING passenger_id INTO new_passenger_id;

    -- Insert a booking for the new passenger
    INSERT INTO booking (booking_id, passenger_id, booking_platform, created_at, update_at, status, price)
    VALUES (501,new_passenger_id, 'Web', NOW(), NOW(), 'Confirmed', 500.00);

    RAISE NOTICE 'New passenger registered and booking created successfully.';
END $$;

--6. Increase the ticket price for all bookings on a specific flight by a fixed amount.
DO $$
BEGIN
    UPDATE booking
    SET price = price + 30.00
    WHERE booking_id IN (
        SELECT booking_id
        FROM booking_flight
        WHERE flight_id = 20
    );

    RAISE NOTICE 'Ticket prices increased successfully for flight.';
END $$;

--7. Update a baggage weight. A passenger updates the declared weight of their baggage. Ensure that the change is correctly reflected in the database.
DO $$
BEGIN
    UPDATE baggage
    SET weight_in_kg = 25.00
    WHERE baggage_id = 34;

    RAISE NOTICE 'Baggage weight updated successfully.';
END $$;

--8. Apply a discount to a booking for a specific passenger. If any error occurs, roll back.
DO $$
BEGIN
    UPDATE booking
    SET price = price - 50.00
    WHERE passenger_id = 123 AND booking_id = 67890;


    RAISE NOTICE 'Discount applied successfully.';
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred. Rolling back transaction.';
        ROLLBACK;
END $$;


--9. Reschedule all bookings for a flight to a new flight.
DO $$
BEGIN
    UPDATE booking_flight
    SET flight_id = 21
    WHERE flight_id = 23;

    RAISE NOTICE 'All bookings successfully rescheduled';
END $$;

