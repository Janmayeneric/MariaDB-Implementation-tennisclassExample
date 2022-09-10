-- MySQL dump 10.19  Distrib 10.3.32-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: xh20_tennisclub
-- ------------------------------------------------------
-- Server version	10.3.32-MariaDB

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
-- Table structure for table `court`
--

DROP TABLE IF EXISTS `court`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `court` (
  `number` int(11) NOT NULL AUTO_INCREMENT,
  `venue_name` varchar(25) COLLATE utf8_bin NOT NULL,
  `surface` varchar(9) COLLATE utf8_bin NOT NULL CHECK (`surface` = 'grass' or `surface` = 'clay' or `surface` = 'hardcourt'),
  PRIMARY KEY (`number`,`venue_name`),
  KEY `court_fk` (`venue_name`),
  CONSTRAINT `court_fk` FOREIGN KEY (`venue_name`) REFERENCES `venue` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `court`
--

LOCK TABLES `court` WRITE;
/*!40000 ALTER TABLE `court` DISABLE KEYS */;
INSERT INTO `court` VALUES (1,'Great Wall Station','clay'),(1,'Jack Cole Building','grass'),(1,'Lubyanka Building','grass'),(2,'Great Wall Station','grass'),(2,'Jack Cole Building','clay'),(2,'Lubyanka Building','clay'),(3,'Great Wall Station','grass'),(3,'Jack Cole Building','clay'),(3,'Lubyanka Building','hardcourt'),(4,'Lubyanka Building','grass'),(14,'Lubyanka Building','grass');
/*!40000 ALTER TABLE `court` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `played_match`
--

DROP TABLE IF EXISTS `played_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `played_match` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `p1_email` varchar(50) COLLATE utf8_bin NOT NULL,
  `p2_email` varchar(50) COLLATE utf8_bin NOT NULL,
  `date_played` date NOT NULL,
  `court_number` int(11) NOT NULL,
  `venue_name` varchar(25) COLLATE utf8_bin NOT NULL,
  `winner` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `match_court_fk` (`court_number`,`venue_name`),
  KEY `match_p1_fk` (`p1_email`),
  KEY `match_p2_fk` (`p2_email`),
  CONSTRAINT `match_court_fk` FOREIGN KEY (`court_number`, `venue_name`) REFERENCES `court` (`number`, `venue_name`),
  CONSTRAINT `match_p1_fk` FOREIGN KEY (`p1_email`) REFERENCES `player` (`email`),
  CONSTRAINT `match_p2_fk` FOREIGN KEY (`p2_email`) REFERENCES `player` (`email`),
  CONSTRAINT `check_players_not_equal` CHECK (`p1_email` <> `p2_email`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `played_match`
--

LOCK TABLES `played_match` WRITE;
/*!40000 ALTER TABLE `played_match` DISABLE KEYS */;
INSERT INTO `played_match` VALUES (1,'jwh@hotmail.com','1@163.com','2009-09-01',1,'Lubyanka Building','1@163.com'),(28,'jwh@hotmail.com','tasha.marsden@gmail.com','2014-09-01',1,'Lubyanka Building','jwh@hotmail.com'),(29,'jwh@hotmail.com','srrogers@yahoo.co.uk','2014-09-01',1,'Lubyanka Building','jwh@hotmail.com'),(30,'jwh@hotmail.com','srrogers@yahoo.co.uk','2014-09-01',2,'Lubyanka Building','jwh@hotmail.com'),(31,'tabitha.stacey@gmail.com','final_fantasy_freak1993@hotmail.com','2017-09-01',1,'Jack Cole Building','tabitha.stacey@gmail.com'),(32,'tabitha.stacey@gmail.com','final_fantasy_freak1993@hotmail.com','2017-09-01',3,'Jack Cole Building','tabitha.stacey@gmail.com'),(33,'tabitha.stacey@gmail.com','leighton.buzzard@gmail.com','2017-09-01',3,'Jack Cole Building','tabitha.stacey@gmail.com'),(34,'mad_maddy@gmail.com','louis.payne@gmail.com','2019-10-01',3,'Great Wall Station','mad_maddy@gmail.com'),(35,'mad_maddy@gmail.com','louis.payne@gmail.com','2019-10-01',1,'Great Wall Station','louis.payne@gmail.com'),(36,'sylvia.hathaway@gmail.com','louis.payne@gmail.com','2019-10-01',1,'Great Wall Station','louis.payne@gmail.com'),(37,'sylvia.hathaway@gmail.com','louis.payne@gmail.com','2019-10-01',1,'Lubyanka Building','louis.payne@gmail.com'),(38,'1@163.com','jwh@hotmail.com','2022-01-01',1,'Great Wall Station','1@163.com');
/*!40000 ALTER TABLE `played_match` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `played_set`
--

DROP TABLE IF EXISTS `played_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `played_set` (
  `match_id` int(11) NOT NULL,
  `set_number` int(11) NOT NULL CHECK (`set_number` > 0 and `set_number` < 4),
  `p1_games_won` int(11) NOT NULL CHECK (`p1_games_won` >= 0 and `p1_games_won` <= 7),
  `p2_games_won` int(11) NOT NULL CHECK (`p2_games_won` >= 0 and `p2_games_won` <= 7),
  PRIMARY KEY (`match_id`,`set_number`),
  CONSTRAINT `played_set_fk` FOREIGN KEY (`match_id`) REFERENCES `played_match` (`id`),
  CONSTRAINT `check_win_condition` CHECK (`p1_games_won` = 6 and `p2_games_won` < 5 or `p1_games_won` < 5 and `p2_games_won` = 6 or `p1_games_won` = 7 and `p2_games_won` < 7 or `p2_games_won` = 7 and `p1_games_won` < 7)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `played_set`
--

LOCK TABLES `played_set` WRITE;
/*!40000 ALTER TABLE `played_set` DISABLE KEYS */;
INSERT INTO `played_set` VALUES (1,1,4,7),(1,2,4,7),(28,1,7,6),(28,2,6,1),(29,1,7,6),(29,2,1,6),(29,3,6,4),(30,1,6,1),(30,2,1,6),(30,3,6,4),(31,1,6,1),(31,2,1,6),(31,3,6,4),(32,1,6,1),(32,2,1,6),(32,3,6,4),(33,1,6,1),(33,2,1,6),(33,3,6,4),(34,1,6,1),(34,2,1,6),(34,3,6,4),(35,1,6,1),(35,2,1,6),(35,3,5,7),(36,1,6,1),(36,2,1,6),(36,3,5,7),(37,1,6,1),(37,2,1,6),(37,3,5,7),(38,1,7,5),(38,2,7,5);
/*!40000 ALTER TABLE `played_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player` (
  `email` varchar(50) COLLATE utf8_bin NOT NULL,
  `forename` varchar(25) COLLATE utf8_bin NOT NULL,
  `middlenames` varchar(25) COLLATE utf8_bin DEFAULT NULL,
  `surname` varchar(25) COLLATE utf8_bin NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `elo` int(11) NOT NULL DEFAULT 1000,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES ('1@163.com','Janmayen','Svalbard','Eric','2000-01-01',1036),('butch@xyz.club','Jamie','Eugene Korey','Butcher','1985-09-21',1000),('final_fantasy_freak1993@hotmail.com','Kirsten','Aileen Louise','Jackman','1993-10-28',928),('gary_the_man@yahoo.co.uk','Gary','Carl','Marsden','1985-10-12',1000),('jwh@hotmail.com','Jeremy','Wardell','Huddleston','1991-02-13',1072),('leighton.buzzard@gmail.com','Leighton','Alan','Buzzard','1980-05-17',964),('louis.payne@gmail.com','Louis','Kennard','Payne','2000-05-31',1072),('mad_maddy@gmail.com','Madeleine',NULL,'Daubney','1991-03-08',1000),('srrogers@yahoo.co.uk','Sue','Rosemary','Rogers','1965-07-30',928),('sylvia.hathaway@gmail.com','Sylvia','Loraine','Hathaway','2004-01-02',928),('tabitha.stacey@gmail.com','Tabitha',NULL,'Stacey','2005-09-10',1108),('tasha.marsden@gmail.com','Natasha','Joy Bernardette Louise','Marsden','1960-04-28',964),('u_marsden@gmail.com','Ulysses',NULL,'Marsden','1977-05-07',1000);
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_phone`
--

DROP TABLE IF EXISTS `player_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_phone` (
  `email` varchar(50) COLLATE utf8_bin NOT NULL,
  `phone_number` varchar(20) COLLATE utf8_bin NOT NULL,
  `phone_type` varchar(6) COLLATE utf8_bin NOT NULL CHECK (`phone_type` = 'home' or `phone_type` = 'mobile' or `phone_type` = 'work'),
  PRIMARY KEY (`email`,`phone_number`),
  CONSTRAINT `player_phone_fk` FOREIGN KEY (`email`) REFERENCES `player` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_phone`
--

LOCK TABLES `player_phone` WRITE;
/*!40000 ALTER TABLE `player_phone` DISABLE KEYS */;
INSERT INTO `player_phone` VALUES ('1@163.com','090000000','mobile'),('butch@xyz.club','07969438448','mobile'),('final_fantasy_freak1993@hotmail.com','07700900909','mobile'),('gary_the_man@yahoo.co.uk','01514960777','home'),('jwh@hotmail.com','01314960470','home'),('leighton.buzzard@gmail.com','01174960714','home'),('leighton.buzzard@gmail.com','01314960962','work'),('louis.payne@gmail.com','07700900654','mobile'),('mad_maddy@gmail.com','01154960961','work'),('mad_maddy@gmail.com','02079460501','home'),('srrogers@yahoo.co.uk','07700900949','mobile'),('sylvia.hathaway@gmail.com','07700900939','mobile'),('tabitha.stacey@gmail.com','07837585417','mobile'),('tasha.marsden@gmail.com','07889344229','mobile'),('u_marsden@gmail.com','01314960745','home');
/*!40000 ALTER TABLE `player_phone` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`xh20`@`%`*/ /*!50003 trigger phone_number_format_checker before insert on player_phone for each row begin if new.phone_number not rlike '^\\p{N}+$' then signal sqlstate '45001' set message_text = 'Invalid phone number format, please only use number as input'; end if; end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `venue`
--

DROP TABLE IF EXISTS `venue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `venue` (
  `name` varchar(25) COLLATE utf8_bin NOT NULL,
  `address` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venue`
--

LOCK TABLES `venue` WRITE;
/*!40000 ALTER TABLE `venue` DISABLE KEYS */;
INSERT INTO `venue` VALUES ('Great Wall Station','Fildes Peninsula King George Island'),('Jack Cole Building','Naorth Haugh St Andrews'),('Lubyanka Building','2 Bolshaya Lubyanka Street, Moscow, Russia');
/*!40000 ALTER TABLE `venue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `view_contact_details`
--

DROP TABLE IF EXISTS `view_contact_details`;
/*!50001 DROP VIEW IF EXISTS `view_contact_details`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_contact_details` (
  `email` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `phones` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `view_grass_court`
--

DROP TABLE IF EXISTS `view_grass_court`;
/*!50001 DROP VIEW IF EXISTS `view_grass_court`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_grass_court` (
  `name` tinyint NOT NULL,
  `number` tinyint NOT NULL,
  `address` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `view_win_count`
--

DROP TABLE IF EXISTS `view_win_count`;
/*!50001 DROP VIEW IF EXISTS `view_win_count`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_win_count` (
  `email` tinyint NOT NULL,
  `elo` tinyint NOT NULL,
  `num_win` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'xh20_tennisclub'
--
/*!50003 DROP PROCEDURE IF EXISTS `check_who_won` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`xh20`@`%` PROCEDURE `check_who_won`(in p1 int, in p2 int, out res int)
begin if p1 is null or p2 is null then signal sqlstate '45004' set message_text = 'Invalid input, socre is null value'; end if; if p1 > 7 or p2 > 7 or p1 < 0 then signal sqlstate '45002' set message_text = 'Invalid score, enter score between 0 and 7'; end if; if not((p1 = 6 and p2 <5) or (p2 = 6 and p1 < 5) or (p1 = 7 and p1 > p2) or (p2 = 7 and p2 > p1))then signal sqlstate '45003' set message_text = 'Invalid score, check two players score'; end if; if p1 > p2 then set res = 1; else set res = 2; end if; end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `check_winner` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`xh20`@`%` PROCEDURE `check_winner`(in g1 int, in g2 int, in g3 int, out res int)
begin if g3 = 0 then set res = g1; else set res = g3; end if; end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_add_match` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`xh20`@`%` PROCEDURE `proc_add_match`(in p1_email varchar(50), in p2_email varchar(50), in date_played date, in venue_name varchar(25), in court_number int, in g1_p1_won int, in g1_p2_won int, in g2_p1_won int, in g2_p2_won int, in g3_p1_won int, in g3_p2_won int)
begin declare match_id int;declare elo_p1 int; declare elo_p2 int; declare c int; call check_who_won(g1_p1_won, g1_p2_won, @g1_res); call check_who_won(g2_p1_won,g2_p2_won,@g2_res);if @g1_res = 0 or @g2_res = 0 or @g1_res is null or @g2_res is null then signal sqlstate '45006' set message_text = 'Invalid input, cannot check the game result'; end if; if @g1_res = @g2_res then set @g3_res = 0; else call check_who_won(g3_p1_won, g3_p2_won, @g3_res); end if; if @g3_res is null then signal sqlstate '45006' set message_text = 'Invalid input, cannot check the game result'; end if; insert into played_match(p1_email,p2_email,date_played,court_number,venue_name) values(p1_email,p2_email,date_played,court_number,venue_name);select last_insert_id() into match_id from played_match limit 1; insert into played_set values(match_id,1,g1_p1_won,g1_p2_won);insert into played_set values(match_id,2,g2_p1_won,g2_p2_won);if @g3_res > 0 then insert into played_set values(match_id,3,g3_p1_won,g3_p2_won);end if;call check_winner(@g1_res,@g2_res,@g3_res,@res); if (not (@res = 1 or @res = 2)) or @res is null then signal sqlstate '45007' set message_text = 'Invalid input, cannot check the winner by the three sets'; end if; select elo into elo_p1 from player where email = p1_email; select elo into elo_p2 from player where email = p2_email; if @res = 1 then update played_match set winner = p1_email where id = match_id; set c = 40 * (1-1/(1+10^((elo_p2 - elo_p1)/400))); update player set elo = elo + c where email = p1_email; update player set elo = elo - c where email = p2_email; else update played_match set winner = p2_email where id = match_id;set c = 40 * (1 - 1/(1+10^((elo_p1-elo_p2)/400))); update player set elo = elo + c where email = p2_email; update player set elo = elo - c where email = p1_email; end if; end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `view_contact_details`
--

/*!50001 DROP TABLE IF EXISTS `view_contact_details`*/;
/*!50001 DROP VIEW IF EXISTS `view_contact_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`xh20`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_contact_details` AS select `xh20_tennisclub`.`player`.`email` AS `email`,concat_ws(' ',`xh20_tennisclub`.`player`.`forename`,`xh20_tennisclub`.`player`.`middlenames`,`xh20_tennisclub`.`player`.`surname`) AS `name`,`player_phones`.`phones` AS `phones` from (`xh20_tennisclub`.`player` left join (select `xh20_tennisclub`.`player_phone`.`email` AS `email`,group_concat(distinct `xh20_tennisclub`.`player_phone`.`phone_number` separator ',') AS `phones` from `xh20_tennisclub`.`player_phone` group by `xh20_tennisclub`.`player_phone`.`email`) `player_phones` on(`xh20_tennisclub`.`player`.`email` = `player_phones`.`email`)) order by `xh20_tennisclub`.`player`.`surname`,concat_ws(' ',`xh20_tennisclub`.`player`.`forename`,`xh20_tennisclub`.`player`.`middlenames`,`xh20_tennisclub`.`player`.`surname`),`xh20_tennisclub`.`player`.`email` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_grass_court`
--

/*!50001 DROP TABLE IF EXISTS `view_grass_court`*/;
/*!50001 DROP VIEW IF EXISTS `view_grass_court`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`xh20`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_grass_court` AS select `venue`.`name` AS `name`,`court`.`number` AS `number`,`venue`.`address` AS `address` from (`venue` left join `court` on(`venue`.`name` = `court`.`venue_name`)) where `court`.`surface` = 'grass' order by `venue`.`name`,`court`.`number` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_win_count`
--

/*!50001 DROP TABLE IF EXISTS `view_win_count`*/;
/*!50001 DROP VIEW IF EXISTS `view_win_count`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`xh20`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_win_count` AS select `xh20_tennisclub`.`player`.`email` AS `email`,`xh20_tennisclub`.`player`.`elo` AS `elo`,`winning`.`num_win` AS `num_win` from (`xh20_tennisclub`.`player` left join (select `xh20_tennisclub`.`played_match`.`winner` AS `winner`,count(0) AS `num_win` from `xh20_tennisclub`.`played_match` group by `xh20_tennisclub`.`played_match`.`winner`) `winning` on(`xh20_tennisclub`.`player`.`email` = `winning`.`winner`)) order by `xh20_tennisclub`.`player`.`elo` desc,`xh20_tennisclub`.`player`.`email` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-11  4:25:46
