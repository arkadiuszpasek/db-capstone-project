CREATE DATABASE  IF NOT EXISTS `capstone`
USE `capstone`;

--
-- Table structure for table `bookings`
--
CREATE TABLE `bookings` (
  `BookingId` int NOT NULL,
  `Date` datetime NOT NULL,
  `TableNumber` int NOT NULL,
  `CustomerId` int NOT NULL,
  `StaffId` int NOT NULL,
  PRIMARY KEY (`BookingId`),
  KEY `fk_bookings_customer` (`CustomerId`),
  KEY `fk_bookings_staff` (`StaffId`),
  CONSTRAINT `fk_bookings_customer` FOREIGN KEY (`CustomerId`) REFERENCES `customers` (`CustomerId`),
  CONSTRAINT `fk_bookings_staff` FOREIGN KEY (`StaffId`) REFERENCES `staff` (`StaffId`)
);

--
-- Table structure for table `customers`
--
CREATE TABLE `customers` (
  `CustomerId` int NOT NULL,
  `Name` varchar(255) NOT NULL,
  `ContactDetails` varchar(255) NOT NULL,
  PRIMARY KEY (`CustomerId`)
);

--
-- Table structure for table `menu`
--
CREATE TABLE `menu` (
  `ItemId` int NOT NULL,
  `Cuisine` varchar(45) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Type` varchar(45) NOT NULL,
  PRIMARY KEY (`ItemId`)
);

--
-- Table structure for table `order_delivery`
--
CREATE TABLE `order_delivery` (
  `DeliveryId` int NOT NULL,
  `OrderId` int NOT NULL,
  `Date` datetime NOT NULL,
  `Status` varchar(45) NOT NULL,
  PRIMARY KEY (`DeliveryId`),
  KEY `fk_order_delivery_order` (`OrderId`),
  CONSTRAINT `fk_order_delivery_order` FOREIGN KEY (`OrderId`) REFERENCES `orders` (`OrderId`)
);

--
-- Table structure for table `orders`
--
CREATE TABLE `orders` (
  `OrderId` int NOT NULL,
  `Date` datetime NOT NULL,
  `Quantity` int NOT NULL,
  `TotalCost` decimal(10,0) NOT NULL,
  `MenuId` int NOT NULL,
  `CustomerId` int NOT NULL,
  PRIMARY KEY (`OrderId`),
  KEY `fk_order_customer` (`CustomerId`),
  KEY `fk_order_menu` (`MenuId`),
  CONSTRAINT `fk_order_customer` FOREIGN KEY (`CustomerId`) REFERENCES `customers` (`CustomerId`),
  CONSTRAINT `fk_order_menu` FOREIGN KEY (`MenuId`) REFERENCES `menu` (`ItemId`)
);

--
-- Table structure for table `staff`
--
CREATE TABLE `staff` (
  `StaffId` int NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Role` varchar(45) NOT NULL,
  `Salary` int NOT NULL,
  PRIMARY KEY (`StaffId`)
);