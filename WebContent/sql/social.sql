-- MySQL dump 10.13  Distrib 5.6.27, for Win64 (x86_64)
--
-- Host: localhost    Database: social
-- ------------------------------------------------------
-- Server version	5.6.27-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `amico`
--

DROP TABLE IF EXISTS `amico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amico` (
  `id_richiesta` int(11) NOT NULL AUTO_INCREMENT,
  `id_richiedente` int(11) NOT NULL,
  `id_ricevente` int(11) NOT NULL,
  `accettato` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_richiesta`),
  KEY `id_richiedente` (`id_richiedente`),
  KEY `id_ricevente` (`id_ricevente`),
  CONSTRAINT `amico_ibfk_1` FOREIGN KEY (`id_richiedente`) REFERENCES `utenti` (`id`),
  CONSTRAINT `amico_ibfk_2` FOREIGN KEY (`id_ricevente`) REFERENCES `utenti` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amico`
--

LOCK TABLES `amico` WRITE;
/*!40000 ALTER TABLE `amico` DISABLE KEYS */;
/*!40000 ALTER TABLE `amico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domanda`
--

DROP TABLE IF EXISTS `domanda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domanda` (
  `id_domanda` int(11) NOT NULL AUTO_INCREMENT,
  `id_domandante` int(11) NOT NULL,
  `titolo` varchar(255) NOT NULL,
  `descrizione` varchar(512) DEFAULT NULL,
  `data` date NOT NULL,
  `visualizzazioni` int(11) NOT NULL DEFAULT '0',
  `ora` time NOT NULL,
  PRIMARY KEY (`id_domanda`),
  KEY `id_domandante` (`id_domandante`),
  CONSTRAINT `domanda_ibfk_1` FOREIGN KEY (`id_domandante`) REFERENCES `utenti` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domanda`
--

LOCK TABLES `domanda` WRITE;
/*!40000 ALTER TABLE `domanda` DISABLE KEYS */;
INSERT INTO `domanda` VALUES (1,1,'Amicu Amicu?','Uppercut ','2016-01-21',0,'00:00:00'),(3,1,'a che ora?','','2016-01-21',0,'00:00:00'),(4,1,'come si chiama il mio cane?','','2016-01-21',0,'00:00:00'),(5,1,'fuck you or fuck me?','','2016-01-21',0,'00:00:00'),(6,1,'come si chiama il presidente del messico?','','2016-01-24',0,'17:35:36'),(7,1,'osvaldo beve l\'acqua?','hahahah come sono simpa!','2016-01-27',0,'19:01:21'),(8,1,'come è la pizza argentina?','Siccome quest\'estate devo andare in argentina e siccome so che li l\'unica cosa commestibile è la pizza volevo sapere se fosse buona','2016-01-28',0,'11:35:45'),(9,1,'Quando costa il galxy neo plu one?','malagattai','2016-01-28',0,'12:19:23'),(10,1,'è bona la cucina azteca?','quazquetzavdkakjaflneaf quazquetzavdkakjaflneaf quazquetzavdkakjaflneaf quazquetzavdkakjaflneaf quazquetzavdkakjaflneaf quazquetzavdkakjaflneaf quazquetzavdkakjaflneaf quazquetzavdkakjaflneaf quazquetzavdkakjaflneaf quazquetzavdkakjaflneaf quazquetzavdkakjaflneaf quazquetzavdkakjaflneaf quazquetzavdkakjaflneafquazquetzavdkakjaflneafquazquetzavdkakjaflneafquazquetzavdkakjaflneafquazquetzavdkakjaflneafquazquetzavdkakjaflneaf','2016-01-28',0,'14:12:58'),(11,1,'il titolo?','il titolo','2016-01-28',0,'20:46:48'),(12,1,'esisto?','','2016-01-28',0,'20:48:23'),(13,1,'ma i pinguini ce li hanno i ginocchi?','newfag cant triforce\r\n\r\n  &#9650;\r\n&#9650; &#9650;','2016-01-28',0,'20:49:55');
/*!40000 ALTER TABLE `domanda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interesse`
--

DROP TABLE IF EXISTS `interesse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interesse` (
  `id_interesse` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  PRIMARY KEY (`id_interesse`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interesse`
--

LOCK TABLES `interesse` WRITE;
/*!40000 ALTER TABLE `interesse` DISABLE KEYS */;
INSERT INTO `interesse` VALUES (2,'informatica'),(3,'psicologia'),(4,'hacking'),(5,'politica'),(6,'filosofia'),(7,'alimentazione'),(8,'storia'),(9,'lingue'),(10,'arte');
/*!40000 ALTER TABLE `interesse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interesse_domanda`
--

DROP TABLE IF EXISTS `interesse_domanda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interesse_domanda` (
  `id_interesse` int(11) NOT NULL,
  `id_domanda` int(11) NOT NULL,
  PRIMARY KEY (`id_interesse`,`id_domanda`),
  KEY `id_domanda` (`id_domanda`),
  CONSTRAINT `interesse_domanda_ibfk_1` FOREIGN KEY (`id_interesse`) REFERENCES `interesse` (`id_interesse`),
  CONSTRAINT `interesse_domanda_ibfk_2` FOREIGN KEY (`id_domanda`) REFERENCES `domanda` (`id_domanda`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interesse_domanda`
--

LOCK TABLES `interesse_domanda` WRITE;
/*!40000 ALTER TABLE `interesse_domanda` DISABLE KEYS */;
INSERT INTO `interesse_domanda` VALUES (4,1),(2,3),(3,3),(6,4),(2,5),(3,6),(3,7),(6,8),(2,9),(6,10),(4,11),(3,12),(6,13);
/*!40000 ALTER TABLE `interesse_domanda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interesse_utenti`
--

DROP TABLE IF EXISTS `interesse_utenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interesse_utenti` (
  `id_persona` int(11) NOT NULL,
  `id_interesse` int(11) NOT NULL,
  PRIMARY KEY (`id_persona`,`id_interesse`),
  KEY `id_interesse` (`id_interesse`),
  CONSTRAINT `interesse_utenti_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `utenti` (`id`),
  CONSTRAINT `interesse_utenti_ibfk_2` FOREIGN KEY (`id_interesse`) REFERENCES `interesse` (`id_interesse`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interesse_utenti`
--

LOCK TABLES `interesse_utenti` WRITE;
/*!40000 ALTER TABLE `interesse_utenti` DISABLE KEYS */;
/*!40000 ALTER TABLE `interesse_utenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messaggio`
--

DROP TABLE IF EXISTS `messaggio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messaggio` (
  `id_messaggio` int(11) NOT NULL AUTO_INCREMENT,
  `id_mittente` int(11) NOT NULL,
  `id_destinatario` int(11) NOT NULL,
  `titolo` varchar(255) NOT NULL,
  `testo` varchar(512) NOT NULL,
  `data` date NOT NULL,
  `letto` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_messaggio`),
  KEY `id_mittente` (`id_mittente`),
  KEY `id_destinatario` (`id_destinatario`),
  CONSTRAINT `messaggio_ibfk_1` FOREIGN KEY (`id_mittente`) REFERENCES `utenti` (`id`),
  CONSTRAINT `messaggio_ibfk_2` FOREIGN KEY (`id_destinatario`) REFERENCES `utenti` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messaggio`
--

LOCK TABLES `messaggio` WRITE;
/*!40000 ALTER TABLE `messaggio` DISABLE KEYS */;
/*!40000 ALTER TABLE `messaggio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `risposta`
--

DROP TABLE IF EXISTS `risposta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `risposta` (
  `id_risposta` int(11) NOT NULL AUTO_INCREMENT,
  `id_domanda` int(11) NOT NULL,
  `id_rispondente` int(11) NOT NULL,
  `testo` varchar(512) NOT NULL,
  `data` date NOT NULL,
  `letto` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_risposta`),
  KEY `id_domanda` (`id_domanda`),
  KEY `id_rispondente` (`id_rispondente`),
  CONSTRAINT `risposta_ibfk_1` FOREIGN KEY (`id_domanda`) REFERENCES `domanda` (`id_domanda`),
  CONSTRAINT `risposta_ibfk_2` FOREIGN KEY (`id_rispondente`) REFERENCES `utenti` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `risposta`
--

LOCK TABLES `risposta` WRITE;
/*!40000 ALTER TABLE `risposta` DISABLE KEYS */;
/*!40000 ALTER TABLE `risposta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utenti`
--

DROP TABLE IF EXISTS `utenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utenti` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(128) NOT NULL,
  `data_registrazione` date NOT NULL,
  `attivato` enum('0','1') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utenti`
--

LOCK TABLES `utenti` WRITE;
/*!40000 ALTER TABLE `utenti` DISABLE KEYS */;
INSERT INTO `utenti` VALUES (1,'braccone','logro@desbloqueado.com','aRoqV7b2abqgK/AYwOEoUd+mLW4oW8ZrkQX99GZToBsc3RTCabqtDX0QJ3AGjwV2','2016-01-21','0'),(2,'brenko','bomber@server.it','yNgtHxgIAP8dMk/p7rkI4FZKH/6RNqqdyt7wNO7By+0Dpo38bOwWRHpXKCU7/MVP','2016-01-28','0'),(3,'bomber','figo@server.it','jFdoYP+gIhkLKrxTD/d/TSba2pd4uTf2o4nFIt0EX0W5eHxKf+vycY93/OO1AEZQ','2016-01-28','0');
/*!40000 ALTER TABLE `utenti` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-02-01 19:06:40
