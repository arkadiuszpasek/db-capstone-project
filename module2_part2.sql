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