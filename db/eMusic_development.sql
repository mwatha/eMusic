-- MySQL dump 10.13  Distrib 5.1.61, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: eMusic_development
-- ------------------------------------------------------
-- Server version	5.1.61-0ubuntu0.11.10.1

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
-- Table structure for table `albums`
--

DROP TABLE IF EXISTS `albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albums` (
  `album_id` int(11) NOT NULL AUTO_INCREMENT,
  `artist` varchar(255) DEFAULT NULL,
  `album_title` varchar(255) DEFAULT NULL,
  `genre` varchar(255) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT '2012-02-29 18:48:26',
  `retired` tinyint(1) DEFAULT '0',
  `creator_id` int(11) DEFAULT NULL,
  `retired_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`album_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums`
--

LOCK TABLES `albums` WRITE;
/*!40000 ALTER TABLE `albums` DISABLE KEYS */;
/*!40000 ALTER TABLE `albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_type` varchar(255) DEFAULT NULL,
  `description` text,
  `image_url` text,
  `date_created` datetime DEFAULT '2012-02-29 18:36:20',
  `retired` tinyint(1) DEFAULT '0',
  `retired_datetime` datetime DEFAULT NULL,
  `retired_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_type`
--

DROP TABLE IF EXISTS `item_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_type` (
  `item_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `date_created` datetime DEFAULT '2012-02-29 18:36:19',
  `retired` tinyint(1) DEFAULT '0',
  `retired_datetime` datetime DEFAULT NULL,
  `retired_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`item_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_type`
--

LOCK TABLES `item_type` WRITE;
/*!40000 ALTER TABLE `item_type` DISABLE KEYS */;
INSERT INTO `item_type` VALUES (1,'Audio albums','2012-02-29 18:36:19',0,NULL,NULL),(2,'Audio songs','2012-02-29 18:36:19',0,NULL,NULL);
/*!40000 ALTER TABLE `item_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_type` int(11) DEFAULT NULL,
  `product_unique_id` int(11) DEFAULT NULL,
  `order_status` int(11) DEFAULT NULL,
  `orderer` int(11) DEFAULT NULL,
  `instruction` text,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `canceled` tinyint(1) DEFAULT '0',
  `cancel_date` datetime DEFAULT NULL,
  `date_created` datetime DEFAULT '2012-03-05 15:51:36',
  `retired` tinyint(1) DEFAULT '0',
  `retired_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `people`
--

DROP TABLE IF EXISTS `people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `people` (
  `people_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `date_created` datetime DEFAULT '2012-02-29 18:36:18',
  `retired` tinyint(1) DEFAULT '0',
  `retired_datetime` datetime DEFAULT NULL,
  `retired_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`people_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people`
--

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;
INSERT INTO `people` VALUES (1,'Tina','Turner','1992-02-29','Female','2012-02-29 18:36:18',0,NULL,NULL),(2,'Grace','Banda','1992-03-01','Female','2012-02-29 18:36:18',0,NULL,NULL),(3,'Ester','Jere','1992-03-03','Female','2012-02-29 18:36:18',0,NULL,NULL),(4,'Ryan','Tedder','1992-03-04','Male','2012-02-29 18:36:18',0,NULL,NULL),(5,'Usher','Banda','1992-03-05','Male','2012-02-29 18:36:18',0,NULL,NULL),(6,'Aliyah','Haughton','1992-03-05','Female','2012-02-29 18:36:18',0,NULL,NULL),(7,'Keanu','Reeves','1992-03-05','Male','2012-02-29 18:36:18',0,NULL,NULL),(8,'alice','banda','1992-03-06','Select sex','2012-02-29 18:36:18',0,NULL,NULL),(9,'Kaz','Chirwa','1992-03-06','Female','2012-02-29 18:36:18',0,NULL,NULL),(10,'Mwatha','Bwanali','1992-03-06','Male','2012-02-29 18:36:18',0,NULL,NULL),(11,'Sly','Katops','1992-03-13','Male','2012-02-29 18:36:18',0,NULL,NULL);
/*!40000 ALTER TABLE `people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `people_identifier`
--

DROP TABLE IF EXISTS `people_identifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `people_identifier` (
  `people_identifier_id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) DEFAULT NULL,
  `identifier_type` int(11) NOT NULL,
  `people_id` int(11) NOT NULL,
  `date_created` datetime DEFAULT '2012-02-29 18:36:19',
  `retired` tinyint(1) DEFAULT '0',
  `retired_datetime` datetime DEFAULT NULL,
  `retired_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`people_identifier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people_identifier`
--

LOCK TABLES `people_identifier` WRITE;
/*!40000 ALTER TABLE `people_identifier` DISABLE KEYS */;
/*!40000 ALTER TABLE `people_identifier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `people_identifier_type`
--

DROP TABLE IF EXISTS `people_identifier_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `people_identifier_type` (
  `people_identifier_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `date_created` datetime DEFAULT '2012-02-29 18:36:20',
  `retired` tinyint(1) DEFAULT '0',
  `retired_datetime` datetime DEFAULT NULL,
  `retired_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`people_identifier_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people_identifier_type`
--

LOCK TABLES `people_identifier_type` WRITE;
/*!40000 ALTER TABLE `people_identifier_type` DISABLE KEYS */;
INSERT INTO `people_identifier_type` VALUES (1,'Pin number',NULL,'2012-02-29 18:36:20',0,NULL,NULL),(2,'Card number',NULL,'2012-02-29 18:36:20',0,NULL,NULL),(3,'Bank card',NULL,'2012-02-29 18:36:20',0,NULL,NULL),(4,'Zip code',NULL,'2012-02-29 18:36:20',0,NULL,NULL),(5,'Mailing address',NULL,'2012-02-29 18:36:20',0,NULL,NULL),(6,'Phone number',NULL,'2012-02-29 18:36:20',0,NULL,NULL),(7,'Email',NULL,'2012-02-29 18:36:20',0,NULL,NULL);
/*!40000 ALTER TABLE `people_identifier_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_order`
--

DROP TABLE IF EXISTS `product_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_order` (
  `product_order_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `total_cost` double DEFAULT NULL,
  PRIMARY KEY (`product_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_order`
--

LOCK TABLES `product_order` WRITE;
/*!40000 ALTER TABLE `product_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_price_category`
--

DROP TABLE IF EXISTS `product_price_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_price_category` (
  `product_price_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `date_created` datetime DEFAULT '2012-03-03 19:58:17',
  `retired` tinyint(1) DEFAULT '0',
  `retired_datetime` datetime DEFAULT NULL,
  `retired_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_price_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_price_category`
--

LOCK TABLES `product_price_category` WRITE;
/*!40000 ALTER TABLE `product_price_category` DISABLE KEYS */;
INSERT INTO `product_price_category` VALUES (1,'Audio CD album','2012-03-03 19:58:17',0,NULL,NULL),(2,'Audio Song','2012-03-03 19:58:17',0,NULL,NULL);
/*!40000 ALTER TABLE `product_price_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_prices`
--

DROP TABLE IF EXISTS `product_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_prices` (
  `product_price_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_unique_id` int(11) DEFAULT NULL,
  `product_category` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `quantity` double DEFAULT NULL,
  `date_created` datetime DEFAULT '2012-03-03 19:58:15',
  `retired` tinyint(1) DEFAULT '0',
  `retired_datetime` datetime DEFAULT NULL,
  `retired_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_price_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_prices`
--

LOCK TABLES `product_prices` WRITE;
/*!40000 ALTER TABLE `product_prices` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relationships`
--

DROP TABLE IF EXISTS `relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relationships` (
  `parent` int(11) DEFAULT NULL,
  `child` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relationships`
--

LOCK TABLES `relationships` WRITE;
/*!40000 ALTER TABLE `relationships` DISABLE KEYS */;
/*!40000 ALTER TABLE `relationships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20120226123645'),('20120226123652'),('20120226123706'),('20120226123721'),('20120226125936'),('20120226125941'),('20120229161807'),('20120229162013'),('20120229163005'),('20120301074651'),('20120303165754'),('20120303165804'),('20120305112606'),('20120306151342');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `songs`
--

DROP TABLE IF EXISTS `songs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `songs` (
  `song_id` int(11) NOT NULL AUTO_INCREMENT,
  `album_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `time` time DEFAULT NULL,
  `track_number` int(11) DEFAULT NULL,
  `genre` varchar(255) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `url` text,
  `date_created` datetime DEFAULT '2012-02-29 18:48:26',
  `retired` tinyint(1) DEFAULT '0',
  `creator_id` int(11) DEFAULT NULL,
  `retired_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`song_id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `songs`
--

LOCK TABLES `songs` WRITE;
/*!40000 ALTER TABLE `songs` DISABLE KEYS */;
/*!40000 ALTER TABLE `songs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_roles` (
  `user_id` int(11) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (8,'admin');
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `people_id` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT '2012-03-03 19:58:15',
  `retired` tinyint(1) DEFAULT '0',
  `creator_id` int(11) DEFAULT NULL,
  `retired_datetime` datetime DEFAULT NULL,
  `retired_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'ester','ad9dee872936c549a4890885cfb6ba4ca2df2692','Pd5DxR2QcK',3,'2012-03-03 19:58:15',0,NULL,NULL,NULL),(2,'ryan','023d414db914d2907b621e57cc8aff7e28895895','TonZrea8WO',4,'2012-03-03 19:58:15',0,NULL,NULL,NULL),(3,'usher','fb88cda5ff897ff7a940c9ee33687974f69383c0','DBxTaMb8gz',5,'2012-03-03 19:58:15',0,NULL,NULL,NULL),(4,'aliyah','f6f5335e303ffe91b948bb5fcbc9f0cf4fb127e6','VkYb8hYxgy',6,'2012-03-03 19:58:15',0,NULL,NULL,NULL),(5,'speed','a05b04d0f3f1fd53be8d79cf81f659e3f491bd6c','xcMJBpq4IF',7,'2012-03-03 19:58:15',0,NULL,NULL,NULL),(6,'alice','8a96374b78aadbeeb79f8a7e3db31fac684acc8f','YtG0uDdR8O',8,'2012-03-03 19:58:15',0,NULL,NULL,NULL),(7,'kaz','21bb0dfbedf50d6c03f6afb2df0cf4c602c184f0','7A7RfjiRDo',9,'2012-03-03 19:58:15',0,NULL,NULL,NULL),(8,'admin','907610a012825cdd40146e2bff4248ec0a8b6e37','x8iJddEBRY',10,'2012-03-03 19:58:15',0,NULL,NULL,NULL),(9,'sly','8e890b879b1018fb6d523ad9790a5238cb57d2f5','FKHNXeIWuw',11,'2012-03-03 19:58:15',0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-04-17 19:42:29
