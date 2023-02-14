-- 1) Setting Up the Database 
SHOW DATABASES;
DROP DATABASE IF EXISTS LittleLemonDB;
CREATE DATABASE LittleLemonDB;
USE LittleLemonDB;

-- Create Tables 
CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(250),
    Role VARCHAR(100),
    Address VARCHAR(250),
    Contact_Number INT,
    Email VARCHAR(100),
    Annual_Salary VARCHAR(100)
    );
    
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT,
    FullName VARCHAR(100),
    Email VARCHAR(100),
    Contact_Number INT,
    PRIMARY KEY (CustomerID)
    );

CREATE TABLE Bookings (
    BookingID INT AUTO_INCREMENT,
    TableNo INT,
	GuestFirstName VARCHAR(100),
    GuestLastName VARCHAR(100),
    BookingSlot TIME NOT NULL,
    EmployeeID INT,
	CustomerID INT,
	BookingDate DATE,
    PRIMARY KEY (BookingID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    );
    
CREATE TABLE MenuItems (
    ItemID INT AUTO_INCREMENT,
    Name VARCHAR(200),
    Type VARCHAR(100),
    Price INT,
    PRIMARY KEY (ItemID)
    );

CREATE TABLE Menus (
    MenuID INT,
    ItemID INT,
    Cuisine VARCHAR(100),
    PRIMARY KEY (MenuID, ItemID),
    FOREIGN KEY (ItemID) REFERENCES MenuItems(ItemID)
    );

CREATE TABLE Orders (
    OrderID INT,
    TableNo INT,
    MenuID INT,
    BookingID INT,
    BillAmount INT,
    Quantity INT,
    CustomerID INT,
    PRIMARY KEY (OrderID, TableNo),
    FOREIGN KEY (MenuID) REFERENCES Menus(MenuID),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    );
    
 SHOW tables;
 DESCRIBE Customers;
 
 -- Populate the tables 
INSERT INTO Employees (EmployeeID, Name, Role, Address, Contact_Number, Email, Annual_Salary) VALUES
    (01,'Mario Gollini','Manager','724, Parsley Lane, Old Town, Chicago, IL',351258074,'Mario.g@littlelemon.com','$70,000'),
    (02,'Adrian Gollini','Assistant Manager','334, Dill Square, Lincoln Park, Chicago, IL',351474048,'Adrian.g@littlelemon.com','$65,000'),
    (03,'Giorgos Dioudis','Head Chef','879 Sage Street, West Loop, Chicago, IL',351970582,'Giorgos.d@littlelemon.com','$50,000'),
    (04,'Fatma Kaya','Assistant Chef','132  Bay Lane, Chicago, IL',351963569,'Fatma.k@littlelemon.com','$45,000'),
    (05,'Elena Salvai','Head Waiter','989 Thyme Square, EdgeWater, Chicago, IL',351074198,'Elena.s@littlelemon.com','$40,000'),
    (06,'John Millar','Receptionist','245 Dill Square, Lincoln Park, Chicago, IL',351584508,'John.m@littlelemon.com','$35,000');

INSERT INTO Customers (CustomerID, FullName, Email, Contact_Number) VALUES
    (01, 'Anna Kiesel', 'anna@gmail.com','436748822'),
    (02, 'Vanessa Hog-Traumpasten', 'vanessa@gmail.com','49333344'),
    (03, 'Tchun Hiroki', 'hiroki@gmail.com','421753211'),
    (04, 'Joakim McGyaver', 'joakim@gmail.com','433488277'),
    (05, 'Diana von Horsten', 'diana@gmail.com','13488655'),
    (06, 'Marco Bobic', 'marcos@gmail.com','20078800');
    
INSERT INTO Bookings (BookingID, TableNo, GuestFirstName, GuestLastName, BookingSlot, EmployeeID, CustomerID, BookingDate) VALUES
    (1, 5, 'Anna','Iversen','19:00:00',1, 1, '2022-10-10'),
    (2, 3, 'Joakim', 'Iversen', '19:00:00', 1, 3, '2022-11-12'),
    (3, 2, 'Vanessa', 'McCarthy', '15:00:00', 3, 2, '2022-10-11'),
    (4, 2, 'Marcos', 'Romero', '17:30:00', 4, 1, '2022-10-13');

INSERT INTO MenuItems (ItemID, Name, Type, Price) VALUES
    (1, 'Olives','Starters',5),
    (2, 'Flatbread','Starters', 5),
    (3, 'Minestrone', 'Starters', 8),
    (4, 'Tomato bread','Starters', 8),
    (5, 'Falafel', 'Starters', 7),
    (6, 'Hummus', 'Starters', 5),
    (7, 'Greek salad', 'Main Courses', 15),
    (8, 'Bean soup', 'Main Courses', 12),
    (9, 'Pizza', 'Main Courses', 15),
    (10, 'Greek yoghurt','Desserts', 7),
    (11, 'Ice cream', 'Desserts', 6),
    (12, 'Cheesecake', 'Desserts', 4),
    (13, 'Athens White wine', 'Drinks', 25),
    (14, 'Corfu Red Wine', 'Drinks', 30),
    (15, 'Rome Coffee', 'Drinks', 10),
    (16, 'Turkish Coffee', 'Drinks', 10),
    (17, 'Kabasa', 'Main Courses', 17);

INSERT INTO Menus (MenuID,ItemID,Cuisine) VALUES
    (1, 1, 'Greek'),
    (1, 7, 'Greek'),
    (1, 10, 'Greek'),
    (1, 13, 'Greek'),
    (2, 3, 'Italian'),
    (2, 9, 'Italian'),
    (2, 12, 'Italian'),
    (2, 15, 'Italian'),
    (3, 5, 'Turkish'),
    (3, 17, 'Turkish'),
    (3, 11, 'Turkish'),
    (3, 16, 'Turkish');
    
INSERT INTO Orders (OrderID, TableNo, MenuID, BookingID, Quantity, BillAmount, CustomerID) VALUES
    (1, 12, 1, 1, 2, 86, 2),
    (2, 19, 2, 2, 1, 237, 4),
    (3, 15, 3, 3, 3, 190, 3),
    (4, 5, 3, 4, 1, 40, 6),
    (5, 8, 1, 3, 4, 83, 1);
  
SELECT * FROM Menus;
SELECT * FROM MenuItems;

-- 2) Preparing Sales Reports
CREATE VIEW OrdersView AS SELECT OrderID, Quantity, BillAmount FROM Orders;
SELECT * FROM OrdersView;

SELECT c.CustomerID, c.FullName FROM Customers AS c INNER JOIN Orders AS o
ON c.CustomerID = o.CustomerID
WHERE o.BillAmount > 150;

SELECT OrderID, BillAmount FROM Orders WHERE BillAmount > 150;

SELECT c.CustomerID, c.FullName, o.OrderID, o.BillAmount 
FROM Customers AS c 
INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID
WHERE o.BillAmount > 150;

SELECT DISTINCT m.Cuisine 
FROM Menus AS m 
INNER JOIN Orders AS o
ON m.MenuID = o.MenuID 
WHERE o.BillAmount > 150;

SELECT DISTINCT c.CustomerID, c.FullName, o.OrderID, o.BillAmount, m.Cuisine, mi.Name
FROM Customers AS c 
INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID
INNER JOIN Menus AS m ON m.MenuID = o.MenuID 
INNER JOIN MenuItems As mi ON mi.ItemID = m.ItemID
WHERE o.BillAmount > 150;

SELECT DISTINCT m.Cuisine
FROM Customers AS c 
INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID
INNER JOIN Menus AS m ON m.MenuID = o.MenuID 
INNER JOIN MenuItems As mi ON mi.ItemID = m.ItemID
WHERE o.Quantity > 2;

DROP PROCEDURE IF EXISTS GetMaxQuantity;
CREATE PROCEDURE GetMaxQuantity() 
SELECT MAX(Quantity) AS 'Max Quantity in Orders' FROM Orders;
CALL GetMaxQuantity();

PREPARE GetOrderDetail FROM 
'SELECT OrderID, Quantity, BillAmount FROM Orders WHERE OrderID = ? ';
SET @id = 1;
EXECUTE GetOrderDetail USING @id;

CREATE TABLE Confirmations (
    Confirmation VARCHAR(100)
    );
SELECT * FROM Confirmations;
    
DROP PROCEDURE IF EXISTS CancelOrder;
DELIMITER //
CREATE PROCEDURE CancelOrder(Nr INT)
BEGIN
	DELETE FROM Orders WHERE OrderID = Nr;
	INSERT INTO Confirmations(Confirmation) VALUES ( CONCAT('Order', Nr, ' was deleted'));
END //
DELIMITER ;
SELECT * FROM Orders;
CALL CancelOrder(3);
SELECT * FROM Orders;
SELECT * FROM Confirmations;

-- 3) Creating Booking System
SELECT TableNo FROM Bookings;
SELECT TableNo FROM Bookings WHERE TableNo=2;
SELECT TableNo FROM Bookings WHERE FIND_IN_SET(3, TableNo) = 1;

DROP PROCEDURE IF EXISTS CheckBooking;
DELIMITER //
CREATE PROCEDURE CheckBooking(IN Date DATE, IN TableNr INT)
BEGIN
IF (SELECT TableNo FROM Bookings WHERE FIND_IN_SET(TableNr, TableNo) = 1 
	AND FIND_IN_SET(Date, BookingDate) = 1) THEN
	SELECT CONCAT('Table ', TableNr, ' is already booked!') As 'Booking status';
END IF;
END //
DELIMITER ;
CALL CheckBooking('2022-11-12', 3);

DROP PROCEDURE IF EXISTS ManageBooking;
START TRANSACTION;
	DELIMITER //
	CREATE PROCEDURE ManageBooking(IN Date DATE, IN TableNr INT)
	BEGIN
	IF (SELECT TableNo FROM Bookings WHERE FIND_IN_SET(TableNr, TableNo) = 1 
		AND FIND_IN_SET(Date, BookingDate) = 1) THEN
		SELECT CONCAT('Table ', TableNr, ' is already booked! Booking canceled!') As 'Booking status';
        ROLLBACK;
	ELSE 
		INSERT INTO Bookings(BookingID, BookingDate, TableNo, CustomerID, BookingSlot, EmployeeID)
		VALUES (DEFAULT, Date, TableNr, 4, '17:30:00', 6);
        COMMIT;
	END IF;
	END //
	DELIMITER ;
	CALL ManageBooking('2022-10-10', 5);
	CALL ManageBooking('2022-10-10', 6);
	SELECT * FROM Bookings;
-- DELETE FROM Bookings WHERE ISNULL(CustomerID);

DROP PROCEDURE IF EXISTS AddBooking;
DELIMITER //
CREATE PROCEDURE AddBooking(IN booking_id INT, IN customer_id INT, IN booking_date DATE, IN table_nr INT)
BEGIN
	IF (SELECT TableNo FROM Bookings WHERE FIND_IN_SET(table_nr, TableNo) = 1 
		AND FIND_IN_SET(booking_date, BookingDate) = 1 AND FIND_IN_SET(booking_id, BookingID) = 1 
        AND FIND_IN_SET(customer_id, CustomerID) = 1) THEN
		SELECT CONCAT('Table ', table_nr, ' is already booked! Booking canceled!') As 'Confirmation';
        ROLLBACK;
	ELSE 
		INSERT INTO Bookings(BookingID, BookingDate, TableNo, CustomerID, BookingSlot, EmployeeID)
		VALUES (booking_id, booking_date, table_nr, customer_id, '19:00:00', 3);
        SELECT CONCAT('New booking added!') As 'Confirmation';
        COMMIT;
	END IF;
END //
DELIMITER ;
SELECT * FROM Bookings;
CALL AddBooking(6, 4, '2022-10-10', 6);

DROP PROCEDURE IF EXISTS UpdateBooking;
DELIMITER //
CREATE PROCEDURE UpdateBooking(IN booking_id INT, booking_date DATE)
BEGIN
	IF (SELECT TableNo FROM Bookings WHERE FIND_IN_SET(booking_id, BookingID) = 1) THEN
        UPDATE Bookings SET BookingDate = booking_date 
        WHERE  BookingID = booking_id; 
		SELECT CONCAT('Booking ', booking_id, ' updated!') As 'Confirmation';
        COMMIT;
	ELSE 
        SELECT CONCAT('The desired booking not found. No updates!') As 'Confirmation';
        ROLLBACK;
	END IF;
END //
DELIMITER ;
SELECT * FROM Bookings;
CALL UpdateBooking(6, '2023-04-23');
SELECT * FROM Bookings;

DROP PROCEDURE IF EXISTS CancelBooking;
DELIMITER //
CREATE PROCEDURE CancelBooking(IN booking_id INT)
BEGIN
	IF (SELECT TableNo FROM Bookings WHERE FIND_IN_SET(booking_id, BookingID) = 1) THEN
        DELETE FROM Bookings WHERE BookingID = booking_id;
		SELECT CONCAT('Booking ', booking_id, ' deleted!') As 'Confirmation';
        COMMIT;
	ELSE 
        SELECT CONCAT('The desired booking not found. Nothing deleted!') As 'Confirmation';
        ROLLBACK;
	END IF;
END //
DELIMITER ;
SELECT * FROM Bookings;
CALL CancelBooking(6);
SELECT * FROM Bookings;

