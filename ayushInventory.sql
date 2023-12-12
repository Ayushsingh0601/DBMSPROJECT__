CREATE DATABASE  IF NOT EXISTS `ayushinventorydb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ayushinventorydb`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: ayushinventorydb
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `ClientID` int NOT NULL,
  `ClientName` varchar(255) NOT NULL,
  `ContactInfo` varchar(255) NOT NULL,
  `ContractDetails` text NOT NULL,
  PRIMARY KEY (`ClientID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `EmployeeID` int NOT NULL,
  `Name` varchar(115) NOT NULL,
  `Position` varchar(100) NOT NULL,
  `Contactinfo` varchar(255) NOT NULL,
  `Salary` decimal(12,0) NOT NULL,
  `ProjectID` int NOT NULL,
  PRIMARY KEY (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='this table willl give the details of the employee';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `EquipmentID` int NOT NULL,
  `EquipmentName` varchar(45) NOT NULL,
  `Manufacturer` varchar(45) NOT NULL,
  `PurchaseDate` date NOT NULL,
  `EquipmentCondition` varchar(100) NOT NULL,
  `ProjectID` int NOT NULL,
  PRIMARY KEY (`EquipmentID`),
  KEY `ProjectID_idx` (`ProjectID`),
  CONSTRAINT `ProjectID` FOREIGN KEY (`ProjectID`) REFERENCES `projects` (`ProjectID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `materials`
--

DROP TABLE IF EXISTS `materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materials` (
  `MaterialID` int NOT NULL,
  `MaterialName` varchar(45) NOT NULL,
  `Supplier` varchar(255) NOT NULL,
  `UnitPrice` decimal(12,0) NOT NULL,
  `QuantityAvailable` int NOT NULL,
  PRIMARY KEY (`MaterialID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `PaymentID` int NOT NULL,
  `Amount` decimal(15,0) NOT NULL,
  `Date` date NOT NULL,
  `ProjectID` int NOT NULL,
  `EmployeeID` int NOT NULL,
  PRIMARY KEY (`PaymentID`),
  KEY `ProjectID_idx` (`ProjectID`),
  KEY `EmployeeID_idx` (`EmployeeID`),
  CONSTRAINT `EmployeeID_Payment` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`),
  CONSTRAINT `ProjectID_Payment` FOREIGN KEY (`ProjectID`) REFERENCES `projects` (`ProjectID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects` (
  `ProjectID` int NOT NULL,
  `ProjectName` varchar(45) NOT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL,
  `Budget` float NOT NULL,
  `ClientID` int DEFAULT NULL,
  `SupervissionID` int NOT NULL,
  PRIMARY KEY (`ProjectID`),
  KEY `ClientID_idx` (`ClientID`),
  CONSTRAINT `ClientID` FOREIGN KEY (`ClientID`) REFERENCES `clients` (`ClientID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `TaskID` int NOT NULL,
  `Description` longtext NOT NULL,
  `Deadline` date NOT NULL,
  `Status` varchar(50) NOT NULL,
  `ProjectID` int NOT NULL,
  `EmployeeID` int NOT NULL,
  PRIMARY KEY (`TaskID`),
  KEY `EmployeeID_idx` (`EmployeeID`),
  CONSTRAINT `EmployeeID` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='This table will allow the user to know about the task status';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'ayushinventorydb'
--

--
-- Dumping routines for database 'ayushinventorydb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-11 19:21:43
DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE users (
  user_id INT PRIMARY KEY,
  username VARCHAR(50),
  email VARCHAR(100) UNIQUE,
  password_hash VARCHAR(255)
);
/*INSERT INTO employees (EmployeeID,Name, Position, ContactInfo,Salary)
VALUES ('John Doe', '12345', '10th', 'John Doe Sr.'),
       ('Jane Doe', '54321', '12th', 'John Doe Sr.');
*/
INSERT INTO equipments (EquipmentID, EquipmentName, Manufacturer, PurchaseDate, EquipmentCondition, ProjectID)
VALUES 
  (101, 'Hammer', 'Jindal', '2020-03-12', 'Good', 10),
  (102, 'Axe', 'Reliance', '2019-11-19', 'CanBeUsed', 20),
  (103, 'DrillMachine', 'BHEL', '2021-05-15', 'NotGood', 20),
  (104, 'Mixer', 'BAJAJ', '2017-06-11', 'Discard', 30),
  (105, 'IronRods', 'TISCO', '2023-11-09', 'Good', 30),
  (106, 'Tractor', 'Sonalika', '2019-10-12', 'Good', 10);


INSERT INTO clients (ClientID, ClientName,ContactInfo, ContractDetails)
VALUES 
  (1001, 'Karthik', 'Mumbai', 'karthik121@gmail.com'),
  (1002, 'Ashwath', 'Gurgaon', 'ashwathg@gmail.com'),
  (1003, 'Ashutosh', 'Gorakhpur', 'portable69@gmail.com'),
  (1004, 'BadassRaviKumar', 'Patna', 'badassbabu@outlook.com'),
  (1005, 'Ajay', 'Chennai', 'ajay999@gmail.com');


INSERT INTO employees (EmployeeID,Name, Position, ContactInfo, Salary, ProjectID)
VALUES 
  (1, 'Rudraksh', 'Mechanic', '8873421754', 25000, 10),
  (2, 'Aditya', 'Labour', '9525636899', 17000, 20),
  (3, 'Aman', 'Labour', '8873421754', 17000, 30),
  (4, 'Ayush', 'Manager', '9931665862', 50000, 40),
  (5, 'Amit', 'Mechanic', '9135095754', 25000, 50);


INSERT INTO materials (MaterialID, MaterialName, Supplier,UnitPrice, , QuantityAvailable)
VALUES 
  (1, 'Cement', 'Ambuja', 5000, 1),
  (2, 'Concrete', 'ACC', 2542, 1),
  (3, 'IronRods', 'TISCO', 2654, 5),
  (4, 'Paint', 'Nerolac', 5487, 7),
  (5, 'Stainer', 'Deluxe', 7845, 12);


  INSERT INTO payments (PaymentID, Amount,Date, PaymentID, EmployeeID)
VALUES 
  (16659486, 9657, '2018-07-15', 40, 3),
  (168845486, 46549, '2022-09-11', 10, 5),
  (549945445, 55154, '2023-11-17', 30, 2),
  (550046794, 25250, '2023-11-19', 20, 1),
  (636899540, 213156, '2019-03-18', 50, 4);

INSERT INTO projects (ProjectID, ProjectName, StartDate, EndDate, Budget, ClientID,SupervissionID)
VALUES 
  (10, 'Dream121', '2022-10-12', '2023-12-31', 956314, 1001, 5),
  (20, 'DLF', '2023-01-09', '2023-03-12', 1500000, 1003, 1),
  (30, 'ShivajiPark', '2022-05-06', '2024-02-14', 240578, 1002, 2),
  (40, 'JSSSTU', '2022-09-11', '2025-11-09', 256787, 1005, 3),
  (50, 'Mall', '2021-03-18', '2024-01-01', 874981, 1004, 4);


INSERT INTO tasks (TaskID, Description, Deadline, Status,ProjectID, EmployeeID)
VALUES 
  (150, 'Maintenance', '2023-01-05', 'Completed', 10, 3),
  (151, 'Work', '2024-01-05', 'Completed', 20, 2),
  (152, 'Work', '2024-06-15', 'NotCompleted', 20, 5),
  (153, 'Logistics', '2024-04-16', 'Completed', 30, 1),
  (154, 'Food', '2024-07-19', 'NotCompleted', 40, 4),
  (155, 'Maintenance', '2024-04-23', 'NotCompleted', 50, 3),
  (156, 'Work', '2023-12-29', 'NotCompleted', 10, 3),
  (157, 'Work', '2023-12-19', 'NotCompleted', 30, 4),
  (158, 'Work', '2024-03-11', 'Completed', 30, 5);
