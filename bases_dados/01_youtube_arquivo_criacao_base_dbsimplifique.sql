CREATE DATABASE  IF NOT EXISTS `dbsimplifique` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `dbsimplifique`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: dbsimplifique
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionario` (
  `idFuncionario` int NOT NULL AUTO_INCREMENT,
  `CPF` varchar(14) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `sobrenome` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `sexo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idFuncionario`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES (2,'555.555.555-55','Ana','Soares','anasoares@minhaempresa.com',0),(3,'333.333.333-33','José','Silva','josesilva@minhaempresa.com',1),(4,'111.111.111-11','Monica','Santos','msantos@minhaempresa.com',0),(5,'111.111.111-12','Minerva','Nóbrega','mnobrega@minhaempresa.com',0),(6,'111.111.111-13','Arthur','Fernandes','afernandes@minhaempresa.com',1),(7,'111.111.111-14','Alice','Fernandes','afernandes1@minhaempresa.com',0),(8,'111.111.111-15','Heitor','Santos','hsantos@minhaempresa.com',1),(9,'222.222.222-22','Luana','Santos','lsantos@minhaempresa.com',0),(10,'222.222.222-23','Teófilo','Albuquerque','talbuquerque@minhaempresa.com',1),(11,'222.222.222-23','Janaína','Schimidt','jschimidt@minhaempresa.com',0);
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionario_projeto`
--

DROP TABLE IF EXISTS `funcionario_projeto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionario_projeto` (
  `idFuncionarioProjeto` int NOT NULL AUTO_INCREMENT,
  `idFuncionario` int NOT NULL,
  `idProjeto` int NOT NULL,
  `horas` int DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idFuncionarioProjeto`),
  KEY `idFuncionario` (`idFuncionario`),
  KEY `idProjeto` (`idProjeto`),
  CONSTRAINT `funcionario_projeto_ibfk_1` FOREIGN KEY (`idFuncionario`) REFERENCES `funcionario` (`idFuncionario`),
  CONSTRAINT `funcionario_projeto_ibfk_2` FOREIGN KEY (`idProjeto`) REFERENCES `projeto` (`idProjeto`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario_projeto`
--

LOCK TABLES `funcionario_projeto` WRITE;
/*!40000 ALTER TABLE `funcionario_projeto` DISABLE KEYS */;
INSERT INTO `funcionario_projeto` VALUES (29,2,1,8,0),(30,5,1,8,0),(31,3,2,4,0),(32,4,2,8,0),(33,6,2,8,0),(34,7,3,8,0),(35,8,4,8,0),(36,9,5,8,1),(37,10,5,8,1),(38,8,5,8,1),(39,2,6,4,1),(40,5,6,8,1),(41,7,6,4,1),(42,3,6,4,1);
/*!40000 ALTER TABLE `funcionario_projeto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projeto`
--

DROP TABLE IF EXISTS `projeto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projeto` (
  `idProjeto` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  `data_inicio` date NOT NULL,
  `data_termino` date DEFAULT NULL,
  PRIMARY KEY (`idProjeto`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projeto`
--

LOCK TABLES `projeto` WRITE;
/*!40000 ALTER TABLE `projeto` DISABLE KEYS */;
INSERT INTO `projeto` VALUES (1,'Projeto Alpha','','2022-10-01','2022-12-15'),(2,'Projeto Beta','','2022-10-01','2023-01-30'),(3,'Projeto Gama','','2023-01-02','2023-02-25'),(4,'Projeto Delta','','2023-01-20','2023-03-30'),(5,'Projeto Épsilon','','2023-02-20',NULL),(6,'Projeto Zeta','','2023-04-22',NULL);
/*!40000 ALTER TABLE `projeto` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-08 12:22:00
