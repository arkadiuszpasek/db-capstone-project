INSERT INTO Staff (StaffId, Name, Role, Salary)
VALUES (1, "Jack", "Employee", 1000);

INSERT INTO Staff (StaffId, Name, Role, Salary)
VALUES (2, "Diego", "Employee", 1000);

INSERT INTO customers (CustomerId, Name, ContactDetails)
VALUES (1, "Gorn", "New camp valley");

INSERT INTO customers (CustomerId, Name, ContactDetails)
VALUES (2, "Lee", "New camp valley");

INSERT INTO bookings (BookingId, Date, TableNumber, CustomerId, StaffId)
VALUES (1, "2026-08-19", 1, 1, 1), (2, "2026-08-20", 2, 2, 2)

-- Check Booking Procedure

DELIMITER //
CREATE PROCEDURE CheckBooking(IN p_BookingDate DATETIME, IN p_TableNumber INT)
BEGIN
    SELECT 
        CASE 
            WHEN EXISTS (
                SELECT 1 
                FROM bookings 
                WHERE Date = p_BookingDate AND TableNumber = p_TableNumber
            )
            THEN CONCAT('Table ', p_TableNumber, ' is already booked')
            ELSE CONCAT('Table ', p_TableNumber, ' is available')
        END AS "Booking Status";
END //

DELIMITER ;

-- Add Valid Booking Procedure

DELIMITER //

CREATE PROCEDURE AddValidBooking(p_Date DATETIME, p_TableNumber INT, p_BookingId INT, p_CustomerId INT, p_StaffId INT)
BEGIN
DECLARE v_BookingCount INT DEFAULT 0;
START TRANSACTION;

SELECT COUNT(*)
INTO v_BookingCount
FROM bookings
WHERE Date = p_Date AND TableNumber = p_TableNumber;

INSERT INTO bookings(BookingId, Date, TableNumber, CustomerId, StaffId)
VALUES (p_BookingId, p_Date, p_TableNumber, p_CustomerId, p_StaffId);

IF v_BookingCount > 0 THEN
  ROLLBACK;
  SELECT CONCAT("Table ", p_TableNumber, " is already booked - booking cancelled");
ELSE
  COMMIT;
  SELECT CONCAT("Table ", p_TableNumber, " is available - booking placed");
END IF;

END //

DELIMITER ;

-- Add Booking Procedure

DELIMITER //

CREATE PROCEDURE AddBooking(
    IN p_BookingId INT,
    IN p_CustomerId INT,
    IN p_BookingDate DATE,
    IN p_TableNumber INT
)
BEGIN
    INSERT INTO bookings (BookingId, CustomerId, Date, TableNumber)
    VALUES (p_BookingId, p_CustomerId, p_BookingDate, p_TableNumber);

    SELECT 'New booking added' AS `Confirmation`;
END //

DELIMITER ;

-- Update Booking Procedure

DELIMITER //

CREATE PROCEDURE UpdateBooking(
    IN p_BookingId INT,
    IN p_BookingDate DATE
)
BEGIN
    UPDATE bookings
    SET Date = p_BookingDate
    WHERE BookingId = p_BookingId;

    SELECT CONCAT('Booking ', p_BookingId, ' updated') AS `Confirmation`;
END //

DELIMITER ;

-- Cancel Booking Procedure

DELIMITER //

CREATE PROCEDURE CancelBooking(
    IN p_BookingId INT
)
BEGIN
    DELETE FROM bookings
    WHERE BookingId = p_BookingId;

    SELECT CONCAT('Booking ', p_BookingId, ' cancelled') AS `Confirmation`;
END //

DELIMITER ;