CREATE DATABASE  IF NOT EXISTS `bd_gimnasio_integradora` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bd_gimnasio_integradora`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: bd_gimnasio_integradora
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `areas`
--

DROP TABLE IF EXISTS `areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `areas` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(80) NOT NULL,
  `Descripcion` text,
  `Responsable_ID` int DEFAULT NULL,
  `Sucursal_ID` int unsigned DEFAULT NULL,
  `Total_Equipos` int unsigned NOT NULL DEFAULT '0',
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ID`),
  KEY `fk_empleado_3` (`Responsable_ID`),
  KEY `fk_sucursales_2` (`Sucursal_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areas`
--

LOCK TABLES `areas` WRITE;
/*!40000 ALTER TABLE `areas` DISABLE KEYS */;
INSERT INTO `areas` VALUES (1,'Atencion a clientes',NULL,2,1,0,_binary ''),(2,'Control de Inventarios',NULL,45,1,0,_binary ''),(3,'Gerencia',NULL,45,1,0,_binary ''),(4,'Marketing',NULL,2,1,0,_binary ''),(5,'Membresias',NULL,2,1,0,_binary ''),(6,'Nutricion',NULL,2,2,0,_binary ''),(7,'Recursos Humanos',NULL,45,2,0,_binary ''),(8,'Recursus Materiales',NULL,2,2,0,_binary ''),(9,'Training',NULL,45,2,0,_binary '');
/*!40000 ALTER TABLE `areas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `areas_AFTER_INSERT` AFTER INSERT ON `areas` FOR EACH ROW BEGIN
    -- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
    DECLARE v_nombre_responsable varchar(60) default null;
    DECLARE v_nombre_sucursal varchar(60) default null;

    -- Iniciación de las variables
    -- El estatus de la sucursal se almacena en un dato del tipo BIT, por
    -- cuestiones de memoria, pero para registrar eventos en bitacora
    -- se requiere ser más descriptivo con la redacción de los eventos
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    if new.responsable_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_responsable = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.responsable_id);
    else
        SET v_nombre_responsable = "Sin responsable asignado";
    end if;

    if new.sucursal_id is not null then
        -- En caso de tener el id de la sucursal debemos recuperar su nombre
        set v_nombre_sucursal = (SELECT nombre FROM sucursales WHERE id = NEW.sucursal_id);
    else
        SET v_nombre_sucursal = "Sin sucursal asignada";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "areas",
        CONCAT_WS(" ","Se ha insertado una nueva AREA con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "NOMBRE = ", NEW.nombre,
        "DESCRIPCIÓN = ", NEW.descripcion,
        "RESPONSABLE ID = ", v_nombre_responsable,
        "SUCURSAL ID = ",  v_nombre_sucursal,
        "TOTAL EQUIPOS = ", NEW.total_equipos, 
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `areas_AFTER_UPDATE` AFTER UPDATE ON `areas` FOR EACH ROW BEGIN
	 -- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_responsable VARCHAR(100) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_responsable2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_sucursal VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_sucursal2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    -- El estatus de la sucursal se almacena en un dato del tipo BIT, por
    -- cuestiones de memoria, pero para registrar eventos en bitacora
    -- se requiere ser más descriptivo con la redacción de los eventos. 
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    IF NEW.responsable_id IS NOT NULL THEN 
		-- En caso de tener el id del empleado responsable debemos recuperar su nombre
		-- para ingresarlo en la bitacora.
		SET v_nombre_responsable = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = NEW.responsable_id);
    ELSE
		SET v_nombre_responsable = "Sin responsable asignado.";
    END IF;
    
    IF OLD.responsable_id IS NOT NULL THEN 
		-- En caso de tener el id del empleado responsable debemos recuperar su nombre
		-- para ingresarlo en la bitacora.
		SET v_nombre_responsable2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,
		p.segundo_apellido) FROM personas p WHERE id = OLD.responsable_id);
    ELSE
		SET v_nombre_responsable2 = "Sin responsable asignado.";
    END IF;

    IF NEW.sucursal_id IS NOT NULL THEN 
		-- En caso de tener el id de la sucursal debemos recuperar su nombre
		-- para ingresarlo en la bitacora.
		SET v_nombre_sucursal = (SELECT nombre FROM sucursales WHERE id = NEW.sucursal_id);
    ELSE
		SET v_nombre_sucursal = "Sin sucursal asignada.";
    END IF;

    IF OLD.sucursal_id IS NOT NULL THEN 
		-- En caso de tener el id de la sucursal debemos recuperar su nombre
		-- para ingresarlo en la bitacora.
		SET v_nombre_sucursal2 = (SELECT nombre FROM sucursales WHERE id = OLD.sucursal_id);
    ELSE
		SET v_nombre_sucursal2 = "Sin sucursal asignada.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "areas",
        CONCAT_WS(" ","Se han actualizado los datos del área con el ID: ",
        NEW.ID, "con los siguientes datos:",
        "RESPONSABLE = ", v_nombre_responsable2, "cambio a", v_nombre_responsable,
        "SUCURSAL ID =",v_nombre_sucursal2,"cambio a", v_nombre_sucursal,
        "ESTATUS = ", v_cadena_estatus2, "cambio a", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `areas_AFTER_DELETE` AFTER DELETE ON `areas` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "area",
        CONCAT_WS(" ","Se ha eliminado una AREA con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `bitacora`
--

DROP TABLE IF EXISTS `bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bitacora` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Usuario` varchar(50) NOT NULL,
  `Operacion` enum('Create','Read','Update','Delete') NOT NULL,
  `Tabla` varchar(50) NOT NULL,
  `Descripcion` text NOT NULL,
  `Fecha_Hora` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora`
--

LOCK TABLES `bitacora` WRITE;
/*!40000 ALTER TABLE `bitacora` DISABLE KEYS */;
INSERT INTO `bitacora` VALUES (1,'root@localhost','Create','pago','Se ha insertado una nuevo pago con el ID:  8 con los siguientes datos:  MONTO =  100.00 FECHA_PAGO=  2024-04-13 METODO_PAGO =  Tarjeta credito MEMBRESIAS_ID =  B7OFTuJdUSFGp0O1Hr56fY8Kmww2C1d3AL57khqg3ugTDvCz2r Individual Nutriólogo Anual','2024-04-13 15:10:24',_binary ''),(2,'root@localhost','Create','pago','Se ha insertado una nuevo pago con el ID:  9 con los siguientes datos:  MONTO =  100.00 FECHA_PAGO=  2024-04-13 METODO_PAGO =  Tarjeta credito MEMBRESIAS_ID =  3 XgrsWmYN2Q5UgDmSjXPgPor3YFsh0cXb2E9ODHAPoufM9rKrXs Empresarial Nutriólogo Trimestral','2024-04-13 15:15:21',_binary ''),(3,'root@localhost','Create','prestamos','Se ha insertado una nuevo pago con el ID:  1 con los siguientes datos:  EQUIPO_PRESTADO =  Equipo de prueba FECHA_PRESTAMO =  2024-04-13 FECHA_DEVOLUCION =  2024-04-20 ESTADO_PRESTAMO =  activo COMENTARIOS =  Prueba de préstamo MONTO_DEPOSITO =  100.00 MONTO_MULTA =  0.00 ESTADO_PAGO =  pendiente MEMBRESIAS_ID =  1 OZvzjRnkwCwKdNjebfGGkDc5QXfm4g9VdhN67h1kxK7kjAX2ju Individual Coaching Bimestral PERSONAS_ID =  Pedro Guerrero Vázquez','2024-04-13 15:45:17',_binary ''),(4,'root@localhost','Update','pago','Se han actualizado los datos del DETALLES_PEDIDOS con el ID:  9 con los siguientes datos:  MONTO =  100.00 CAMBIO A  100.00 FECHA_PAGO=  2024-04-13 CAMBIO A  2024-04-13 METODO_PAGO =  Tarjeta credito CAMBIO A  Tarjeta debito MEMBRESIAS_ID =  3 XgrsWmYN2Q5UgDmSjXPgPor3YFsh0cXb2E9ODHAPoufM9rKrXs Empresarial Nutriólogo Trimestral CAMBIO A  3 XgrsWmYN2Q5UgDmSjXPgPor3YFsh0cXb2E9ODHAPoufM9rKrXs Empresarial Nutriólogo Trimestral','2024-04-13 17:21:42',_binary ''),(5,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1025 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Estrella PRIMER APELLIDO =  Ortiz SEGUNDO APELLIDO =  Aguilar FECHA NACIMIENTO =  1996-04-20 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2021-01-04 16:06:22 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:05',_binary ''),(6,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1026 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= José PRIMER APELLIDO =  Morales SEGUNDO APELLIDO =  Jiménez FECHA NACIMIENTO =  1996-08-05 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2020-11-21 12:07:03 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:05',_binary ''),(7,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1027 con los siguientes datos:  TITULO CORTESIA =  C. NOMBRE=  Agustin PRIMER APELLIDO =  Gómes SEGUNDO APELLIDO =  Ramos FECHA NACIMIENTO =  1980-02-26 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2024-01-31 08:10:25 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:05',_binary ''),(8,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1028 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= José PRIMER APELLIDO =  Rodríguez SEGUNDO APELLIDO =  Domínguez FECHA NACIMIENTO =  2000-03-06 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2023-01-04 17:21:45 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:05',_binary ''),(9,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1029 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Paula PRIMER APELLIDO =  Castillo SEGUNDO APELLIDO =  Guzmán FECHA NACIMIENTO =  1974-09-09 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2022-07-20 08:31:57 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:05',_binary ''),(10,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1030 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Juan PRIMER APELLIDO =  Pérez SEGUNDO APELLIDO =  Jiménez FECHA NACIMIENTO =  1971-07-23 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2023-07-19 10:10:41 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:05',_binary ''),(11,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1031 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Flor PRIMER APELLIDO =  Soto SEGUNDO APELLIDO =  Ramos FECHA NACIMIENTO =  1968-05-18 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-11-17 10:33:50 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:05',_binary ''),(12,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1032 con los siguientes datos:  TITULO CORTESIA =  Sra. NOMBRE= Jazmin PRIMER APELLIDO =  Sánchez SEGUNDO APELLIDO =  Vázquez FECHA NACIMIENTO =  2005-01-13 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2021-11-27 16:03:47 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:05',_binary ''),(13,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1033 con los siguientes datos:  TITULO CORTESIA =  Med. NOMBRE= Adalid PRIMER APELLIDO =  Morales SEGUNDO APELLIDO =  Rodríguez FECHA NACIMIENTO =  2001-07-20 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2020-05-21 15:44:08 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:05',_binary ''),(14,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1034 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Karla PRIMER APELLIDO =  Bautista SEGUNDO APELLIDO =  Guerrero FECHA NACIMIENTO =  1991-07-21 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2023-12-20 18:31:31 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:05',_binary ''),(15,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1035 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Adalid PRIMER APELLIDO =  Ramos SEGUNDO APELLIDO =  Soto FECHA NACIMIENTO =  1960-05-12 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2023-01-06 08:33:42 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:05',_binary ''),(16,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1036 con los siguientes datos:  TITULO CORTESIA =  Srita NOMBRE= Ana PRIMER APELLIDO =  De la Cruz SEGUNDO APELLIDO =  Cortes FECHA NACIMIENTO =  1993-02-09 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2024-02-18 12:38:57 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:05',_binary ''),(17,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1037 con los siguientes datos:  TITULO CORTESIA =  Mtro. NOMBRE= Yair PRIMER APELLIDO =  Mendoza SEGUNDO APELLIDO =   Rivera FECHA NACIMIENTO =  1993-05-31 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2021-12-16 09:50:01 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:05',_binary ''),(18,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1038 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Bertha PRIMER APELLIDO =  Chávez SEGUNDO APELLIDO =  Álvarez FECHA NACIMIENTO =  1959-06-13 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2024-03-29 16:49:58 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:05',_binary ''),(19,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1039 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Iram PRIMER APELLIDO =  Salazar SEGUNDO APELLIDO =  Castro FECHA NACIMIENTO =  1963-03-21 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2020-07-21 17:53:07 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:05',_binary ''),(20,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1040 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jorge PRIMER APELLIDO =  Sánchez SEGUNDO APELLIDO =  Castillo FECHA NACIMIENTO =  1960-08-18 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2021-01-02 10:09:54 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:05',_binary ''),(21,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1041 con los siguientes datos:  TITULO CORTESIA =  Sgto. NOMBRE= Pedro PRIMER APELLIDO =  Aguilar SEGUNDO APELLIDO =  Ortega FECHA NACIMIENTO =  1962-09-29 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2021-08-29 17:16:58 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:05',_binary ''),(22,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1042 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Daniel PRIMER APELLIDO =  Morales SEGUNDO APELLIDO =  Torres FECHA NACIMIENTO =  2003-10-17 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2023-12-29 08:38:37 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:05',_binary ''),(23,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1043 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Iram PRIMER APELLIDO =  Rodríguez SEGUNDO APELLIDO =  Gutiérrez FECHA NACIMIENTO =  1980-08-22 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2020-02-23 19:35:55 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:05',_binary ''),(24,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1044 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Guadalupe PRIMER APELLIDO =  Chávez SEGUNDO APELLIDO =  Rodríguez FECHA NACIMIENTO =  2005-04-20 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2023-04-27 18:54:02 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:05',_binary ''),(25,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1045 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Hugo PRIMER APELLIDO =  Mendoza SEGUNDO APELLIDO =   González FECHA NACIMIENTO =  1970-03-31 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2022-05-03 10:16:42 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:51',_binary ''),(26,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1046 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Alejandro PRIMER APELLIDO =  Castro SEGUNDO APELLIDO =  López FECHA NACIMIENTO =  1972-04-20 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-11-12 08:39:12 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:51',_binary ''),(27,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1047 con los siguientes datos:  TITULO CORTESIA =  NOMBRE=  Agustin PRIMER APELLIDO =  Torres SEGUNDO APELLIDO =  Pérez FECHA NACIMIENTO =  1988-01-12 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB+ ESTATUS =   FECHA REGISTRO =  2020-06-24 18:01:10 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:51',_binary ''),(28,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1048 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Esmeralda PRIMER APELLIDO =  Vargas SEGUNDO APELLIDO =  Vargas FECHA NACIMIENTO =  1981-12-12 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2021-03-13 19:55:14 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:51',_binary ''),(29,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1049 con los siguientes datos:  TITULO CORTESIA =  Pfra NOMBRE= Valeria PRIMER APELLIDO =  Ramos SEGUNDO APELLIDO =  Ruíz FECHA NACIMIENTO =  1963-03-10 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2023-07-26 14:06:10 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:51',_binary ''),(30,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1050 con los siguientes datos:  TITULO CORTESIA =  Ing. NOMBRE= Jazmin PRIMER APELLIDO =  De la Cruz SEGUNDO APELLIDO =  Castillo FECHA NACIMIENTO =  1961-12-24 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2024-03-12 12:46:06 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:51',_binary ''),(31,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1051 con los siguientes datos:  TITULO CORTESIA =  Mtro. NOMBRE= Gustavo PRIMER APELLIDO =  Torres SEGUNDO APELLIDO =  Estrada FECHA NACIMIENTO =  1989-07-14 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2022-12-31 14:42:36 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:51',_binary ''),(32,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1052 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Maria PRIMER APELLIDO =  Luna SEGUNDO APELLIDO =  Martínez FECHA NACIMIENTO =  1991-01-12 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2022-10-10 18:30:20 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:51',_binary ''),(33,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1053 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Hortencia PRIMER APELLIDO =  García SEGUNDO APELLIDO =  Castillo FECHA NACIMIENTO =  1976-03-20 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2021-05-16 17:23:34 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:51',_binary ''),(34,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1054 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Gerardo PRIMER APELLIDO =  Cruz SEGUNDO APELLIDO =  García FECHA NACIMIENTO =  1986-12-13 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2020-05-09 09:46:49 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:51',_binary ''),(35,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1055 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Aldair PRIMER APELLIDO =   González SEGUNDO APELLIDO =  Chávez FECHA NACIMIENTO =  1989-02-07 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B+ ESTATUS =   FECHA REGISTRO =  2023-01-04 15:01:35 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:51',_binary ''),(36,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1056 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Mario PRIMER APELLIDO =  Bautista SEGUNDO APELLIDO =  Romero FECHA NACIMIENTO =  1993-02-26 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2022-05-13 19:43:16 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:51',_binary ''),(37,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1057 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Yair PRIMER APELLIDO =  Castro SEGUNDO APELLIDO =   González FECHA NACIMIENTO =  1973-09-07 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A- ESTATUS =   FECHA REGISTRO =  2020-12-13 13:21:02 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:51',_binary ''),(38,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1058 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Jorge PRIMER APELLIDO =  Morales SEGUNDO APELLIDO =  Hernández FECHA NACIMIENTO =  1976-07-03 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  AB- ESTATUS =   FECHA REGISTRO =  2021-11-04 08:39:51 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:51',_binary ''),(39,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1059 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Valeria PRIMER APELLIDO =  Gutiérrez SEGUNDO APELLIDO =  Martínez FECHA NACIMIENTO =  1965-04-14 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2023-12-27 11:08:03 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:51',_binary ''),(40,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1060 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Guadalupe PRIMER APELLIDO =  Moreno SEGUNDO APELLIDO =   Rivera FECHA NACIMIENTO =  1985-02-17 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O+ ESTATUS =   FECHA REGISTRO =  2023-03-13 09:28:11 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:51',_binary ''),(41,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1061 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Guadalupe PRIMER APELLIDO =  Cruz SEGUNDO APELLIDO =  Vázquez FECHA NACIMIENTO =  1997-02-13 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2024-01-13 14:29:27 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:51',_binary ''),(42,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1062 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Bertha PRIMER APELLIDO =  Medina SEGUNDO APELLIDO =  Cruz FECHA NACIMIENTO =  2003-05-18 FOTOGRAFIA =  GENERO =  F TIPO SANGRE =  O- ESTATUS =   FECHA REGISTRO =  2023-06-17 11:51:32 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:51',_binary ''),(43,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1063 con los siguientes datos:  TITULO CORTESIA =  Lic. NOMBRE=  Agustin PRIMER APELLIDO =  Chávez SEGUNDO APELLIDO =  Jiménez FECHA NACIMIENTO =  2002-08-02 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  B- ESTATUS =   FECHA REGISTRO =  2022-10-31 18:54:33 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:51',_binary ''),(44,'root@localhost','Create','personas','Se ha insertado una nueva persona con el ID:  1064 con los siguientes datos:  TITULO CORTESIA =  NOMBRE= Federico PRIMER APELLIDO =  García SEGUNDO APELLIDO =  Álvarez FECHA NACIMIENTO =  1985-05-22 FOTOGRAFIA =  GENERO =  M TIPO SANGRE =  A+ ESTATUS =   FECHA REGISTRO =  2023-08-15 19:22:21 FECHA ACTUALIZACIÓN = ','2024-04-18 23:12:51',_binary '');
/*!40000 ALTER TABLE `bitacora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalles_pedidos`
--

DROP TABLE IF EXISTS `detalles_pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalles_pedidos` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Pedido_ID` int unsigned NOT NULL,
  `Producto_ID` int unsigned NOT NULL,
  `Cantidad` int NOT NULL,
  `Total_Parcial` decimal(6,2) NOT NULL,
  `Fecha_Registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Entrega` datetime DEFAULT NULL,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ID`),
  KEY `fk_pedido_1` (`Pedido_ID`),
  KEY `fk_producto_1` (`Producto_ID`),
  CONSTRAINT `fk_pedido_1` FOREIGN KEY (`Pedido_ID`) REFERENCES `pedidos` (`ID`),
  CONSTRAINT `fk_producto_1` FOREIGN KEY (`Producto_ID`) REFERENCES `productos` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalles_pedidos`
--

LOCK TABLES `detalles_pedidos` WRITE;
/*!40000 ALTER TABLE `detalles_pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalles_pedidos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_pedidos_AFTER_INSERT` AFTER INSERT ON `detalles_pedidos` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
    DECLARE v_nombre_pedido varchar(60) default null;
    DECLARE v_nombre_producto varchar(60) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    if new.pedido_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_pedido = (SELECT CONCAT_WS(" ", p.usuario_id, p.total, p.fecha_registro) FROM pedidos p WHERE id = NEW.pedido_id);
    else
        SET v_nombre_pedido = "Sin pedido asignado";
    end if;

    if new.producto_id is not null then
        -- En caso de tener el id de la sucursal debemos recuperar su nombre
        set v_nombre_producto = (SELECT concat_ws(" ", p.nombre, p.marca) FROM productos WHERE id = NEW.producto_id);
    else
        SET v_nombre_producto = "Sin producto asignado";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "detalles_pedidos",
        CONCAT_WS(" ","Se ha insertado una nuevo DETALLE_PEDIDO con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "PEDIDO ID = ", v_nombre_pedido,
        "PRODUCTO ID = ",  v_nombre_producto,
        "CANTIDAD = ", NEW.cantidad,
		"TOTAL PARCIAL = ", NEW.total_parcial,
        "FECHA REGISTRO = ", NEW.fecha_registro,
        "FECHA ENTREGA = ", NEW.fecha_entrega,
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_pedidos_AFTER_UPDATE` AFTER UPDATE ON `detalles_pedidos` FOR EACH ROW BEGIN
		 -- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_pedido VARCHAR(100) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_pedido2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_producto VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_producto2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables 
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    IF NEW.pedido_id IS NOT NULL THEN 
		-- En caso de tener el id del pedido
        set v_nombre_pedido = (SELECT CONCAT_WS(" ", p.usuario_id, p.total, p.fecha_registro) FROM pedidos p WHERE id = NEW.pedido_id);
    ELSE
		SET v_nombre_pedido = "Sin pedido asignado.";
    END IF;
    
    IF OLD.pedido_id IS NOT NULL THEN 
		-- En caso de tener el id del pedido
        set v_nombre_pedido2 = (SELECT CONCAT_WS(" ", p.usuario_id, p.total, p.fecha_registro) FROM pedidos p WHERE id = OLD.pedido_id);
    ELSE
		SET v_nombre_pedido2 = "Sin pedido asignado.";
    END IF;

    IF NEW.producto_id IS NOT NULL THEN 
		-- En caso de tener el id del producto
        SET v_nombre_producto = (SELECT concat_ws(" ", p.nombre, p.marca) FROM productos WHERE id = NEW.producto_id);
    ELSE
		SET v_nombre_producto = "Sin producto asignado.";
    END IF;

    IF OLD.producto_id IS NOT NULL THEN 
		-- En caso de tener el id del producto
        SET v_nombre_producto = (SELECT concat_ws(" ", p.nombre, p.marca) FROM productos WHERE id = OLD.producto_id);
    ELSE
		SET v_nombre_producto2 = "Sin producto asignado.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "detalles_pedidos",
        CONCAT_WS(" ","Se han actualizado los datos del DETALLES_PEDIDOS con el ID: ",NEW.ID, 
        "con los siguientes datos:",
        "PEDIDO ID = ", v_nombre_pedido2, " cambio a ", v_nombre_pedido,
        "PRODUCTO ID =",v_nombre_producto2," cambio a ", v_nombre_producto,
        "CANTIDAD = ", OLD.cantidad, "cambio a ", NEW.cantidad,
        "TOTAL PARCIAL = ", OLD.total_parcial, " cambio a ", NEW.total_parcial,
        "FECHA REGISTRO = ", OLD.fecha_registro, " cambio a ", NEW.fecha_registro,
        "RECHAENTREGA = ", OLD.fecha_entrega, " cambio a ", NEW.fecha_entrega,
        "ESTATUS = ", v_cadena_estatus2, " cambio a ", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_pedidos_AFTER_DELETE` AFTER DELETE ON `detalles_pedidos` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "detalles_pedidos",
        CONCAT_WS(" ","Se ha eliminado una relación DETALLES_PEDIDOS con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `detalles_programas_saludables`
--

DROP TABLE IF EXISTS `detalles_programas_saludables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalles_programas_saludables` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Programa_ID` int unsigned DEFAULT NULL,
  `Rutina_ID` int unsigned DEFAULT NULL,
  `Dieta_ID` int unsigned DEFAULT NULL,
  `Fecha_Inicio` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Fin` datetime NOT NULL,
  `Estatus` enum('Programada','Iniciada','Seguimiento','Suspendida','Finalizada') NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_programa_1` (`Programa_ID`),
  KEY `fk_rutina_1` (`Rutina_ID`),
  KEY `fk_dieta_1` (`Dieta_ID`),
  CONSTRAINT `fk_dieta_1` FOREIGN KEY (`Dieta_ID`) REFERENCES `dietas` (`ID`),
  CONSTRAINT `fk_programa_1` FOREIGN KEY (`Programa_ID`) REFERENCES `programas_saludables` (`ID`),
  CONSTRAINT `fk_rutina_1` FOREIGN KEY (`Rutina_ID`) REFERENCES `rutinas` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalles_programas_saludables`
--

LOCK TABLES `detalles_programas_saludables` WRITE;
/*!40000 ALTER TABLE `detalles_programas_saludables` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalles_programas_saludables` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_programas_saludables_AFTER_INSERT` AFTER INSERT ON `detalles_programas_saludables` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_programa varchar(60) default null;
    DECLARE v_nombre_rutina varchar(60) default null;
    DECLARE v_nombre_dieta varchar(60) default null;

    -- Iniciación de las variables
     if new.programa_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_programa = (SELECT nombre FROM programas_saludables WHERE id = NEW.programa_id);
    else
        SET v_nombre_programa = "Sin programa asignado";
    end if;

    if new.rutina_id is not null then
        -- En caso de tener el id de la rutina
        set v_nombre_rutina = (SELECT resultados_esperados FROM rutinas WHERE id = NEW.rutina_id);
    else
        SET v_nombre_rutina = "Sin rutina asignada";
    end if;

    if new.dieta_id is not null then
        -- En caso de tener el id de la dieta
        set v_nombre_dieta = (SELECT nombre FROM dietas WHERE id = NEW.dieta_id);
    else
        SET v_nombre_dieta = "Sin dieta asignada";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "detalles_programas_saludables",
        CONCAT_WS(" ","Se ha insertado una nueva relación en DETALLES PROGRAMAS SALUDABLES con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "PROGRAMA ID = ", v_nombre_programa,
        "RUTINA ID = ", v_nombre_rutina,
        "DIETA ID = ",  v_nombre_dieta,
        "FECHA INICIO = ", NEW.fecha_inicio, 
        "FECHA FIN = ", NEW.fecha_fin,
        "ESTATUS = ", NEW.estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_programas_saludables_AFTER_UPDATE` AFTER UPDATE ON `detalles_programas_saludables` FOR EACH ROW BEGIN
	 -- Declaración de variables
    DECLARE v_nombre_programa varchar(60) default null;
    DECLARE v_nombre_rutina VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_programa2 varchar(60) default null;
    DECLARE v_nombre_rutina2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_dieta VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_dieta2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    if new.programa_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_programa = (SELECT nombre FROM programas_saludables WHERE id = NEW.programa_id);
    else
        SET v_nombre_programa = "Sin programa asignado";
    end if;
    
    if old.programa_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_programa = (SELECT nombre FROM programas_saludables WHERE id = old.programa_id);
    else
        SET v_nombre_programa = "Sin programa asignado";
    end if;
          
    IF NEW.rutina_id IS NOT NULL THEN 
		-- En caso de tener el id de la rutina
		SET v_nombre_rutina = (SELECT resultados_esperados FROM rutinas WHERE id = NEW.rutina_id);
    ELSE
		SET v_nombre_rutina = "Sin rutina asignada.";
    END IF;
    
    IF OLD.rutina_id IS NOT NULL THEN 
		-- En caso de tener el id de la rutina
		SET v_nombre_rutina2 = (SELECT resultados_esperados FROM rutinas WHERE id = OLD.rutina_id);
    ELSE
		SET v_nombre_rutina2 = "Sin rutina asignada.";
    END IF;

    IF NEW.dieta_id IS NOT NULL THEN 
		-- En caso de tener el id de la dieta
		SET v_nombre_dieta = (SELECT nombre FROM dietas WHERE id = NEW.dieta_id);
    ELSE
		SET v_nombre_dieta = "Sin dieta asignada.";
    END IF;

    IF OLD.dieta_id IS NOT NULL THEN 
		-- En caso de tener el id de la dieta
		SET v_nombre_dieta2 = (SELECT nombre FROM dietas WHERE id = OLD.dieta_id);
    ELSE
		SET v_nombre_dieta2 = "Sin dieta asignada.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "detalles_programas_saludables",
        CONCAT_WS(" ","Se han actualizado los datos de la relación DETALLES PROGRAMAS SALUDABLES con el ID: ",NEW.ID, 
        "con los siguientes datos:",
        "PROGRAMA ID = ", v_nombre_programa2, " cambio a ", v_nombre_programa,
        "RUTINA ID = ", v_nombre_rutina2, " cambio a ", v_nombre_rutina,
        "DIETA ID =",v_nombre_dieta2," cambio a ", v_nombre_dieta,
        "FECHA INICIO = ", OLD.fecha_inicio, " cambio a ", NEW.fecha_inicio,
        "FECHA FIN = ", OLD.fecha_fin, " cambio a ", NEW.fecha_fin,
        "ESTATUS = ", OLD.estatus, " cambio a ", NEW.estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_programas_saludables_AFTER_DELETE` AFTER DELETE ON `detalles_programas_saludables` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "detalles_programas_saludables",
        CONCAT_WS(" ","Se ha eliminado un registro de DETALLES PROGRAMAS SALUDABLES con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `dietas`
--

DROP TABLE IF EXISTS `dietas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dietas` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(300) NOT NULL,
  `Descripccion` text,
  `Objetivo` text,
  `Restricciones` text,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dietas`
--

LOCK TABLES `dietas` WRITE;
/*!40000 ALTER TABLE `dietas` DISABLE KEYS */;
/*!40000 ALTER TABLE `dietas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `dietas_AFTER_INSERT` AFTER INSERT ON `dietas` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
    
    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;
    
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "dietas",
        CONCAT_WS(" ","Se ha insertado una nueva DIETA con el ID: ",NEW.ID, 
        "con los siguientes datos: NOMBRE=", NEW.nombre,
        "DESCRIPCION = ", NEW.descripccion,
        "OBJETIVO = ", NEW.objetivo, 
        "RESTRICCIONES = ", NEW.restricciones,
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `dietas_AFTER_UPDATE` AFTER UPDATE ON `dietas` FOR EACH ROW BEGIN
	 -- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    
	IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
	
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "dietas",
        CONCAT_WS(" ","Se han actualizado los datos de la DIETA con el ID:",NEW.ID,
        "con los siguientes datos: ",
        "NOMBRE = ", OLD.nombre, " cambio a ", NEW.nombre,
        "DESCRIPCION = ", OLD.descripccion,"cambio a ", NEW.descripccion,
        "OBJETIVO = ", OLD.objetivo," cambio a", NEW.objetivo,
        "RESCRICCIONES = ", OLD.restricciones," cambio a ", NEW.restricciones,
        "ESTATUS = ", v_cadena_estatus2, " cambio a ", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `dietas_AFTER_DELETE` AFTER DELETE ON `dietas` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "dietas",
        CONCAT_WS(" ","Se ha eliminado una DIETA con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ejercicios`
--

DROP TABLE IF EXISTS `ejercicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ejercicios` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre_Formal` varchar(80) NOT NULL,
  `Nombre_Comun` varchar(50) NOT NULL,
  `Descripcion` text,
  `Tipo` enum('Aeróbico','Resistencia','Flexibilidad','Fuerza') DEFAULT NULL,
  `Video_Ejemplo` varchar(100) DEFAULT NULL,
  `Consideraciones` text,
  `Dificultad` enum('Básica','Intermedia','Avanzada') DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ejercicios`
--

LOCK TABLES `ejercicios` WRITE;
/*!40000 ALTER TABLE `ejercicios` DISABLE KEYS */;
INSERT INTO `ejercicios` VALUES (91,'Escaladores de montaña','Mountain Climbers','Ejercicio aeróbico de fuerza que involucra diferentes grupos musculares. Los gemelos, el bíceps femoral, los cuádriceps y los glúteos mayores son los músculos que más se fortalecen.','Aeróbico',NULL,'Mantener la estabilidad corporal y la contracción del abdomen es parte de la rutina.','Intermedia'),(92,'Flexiones de brazos con una mano','One-arm push-ups','Ejercicio que trabaja los pectorales, deltoides y tríceps mientras se fortalecen también los músculos del core.','Fuerza',NULL,'Mantener la postura correcta y la alineación de las rodillas es esencial.','Avanzada'),(93,'Saltos de caja','Box Jumps','Ejercicio pliométrico que implica saltar repetidamente sobre una caja o cualquier otra superficie estable y nivelada. Este ejercicio está dirigido a los cuádriceps, los isquiotibiales y los glúteos.','Aeróbico',NULL,'Mantener la postura correcta y la técnica correcta del salto es esencial.','Intermedia'),(94,'Abdominales con rueda','Ab Wheel Rollouts','Ejercicio que permite desarrollar los músculos y fortalecer los ligamentos y tendones de las piernas. Su ejecución de forma regular brinda una serie de beneficios al organismo en general.','Fuerza',NULL,'Mantener la postura correcta y la técnica correcta del movimiento es esencial.','Intermedia'),(95,'Curl de bíceps con mancuernas en banco inclinado','Incline Dumbbell Bicep Curl','Ejercicio que permite levantar menos carga que el convencional, pero se centra en mayor medida en la parte trasera de tus muslos y tus glúteos.','Fuerza',NULL,'Mantener la postura correcta y la técnica correcta del movimiento es esencial.','Intermedia'),(96,'Peso muerto con mancuernas','Dumbbell Deadlift','Ejercicio que permite trabajar los músculos de muslos y glúteos. Este movimiento compuesto involucra los cuádriceps, los glúteos y los isquiotibiales.','Fuerza',NULL,'Mantener la postura correcta y la técnica correcta del movimiento es esencial.','Intermedia'),(97,'Sentadillas con salto y mancuernas','Jump Squats with Dumbbells','Ejercicio pliométrico de alta intensidad excelente para generar una fuerza explosiva, preparar los músculos y articulaciones de la parte inferior del cuerpo, y aumentar la altura de tu salto vertical.','Aeróbico',NULL,'Mantener la postura correcta y la técnica correcta del movimiento es esencial.','Intermedia'),(98,'Press de hombros con mancuernas','Dumbbell Shoulder Press','Ejercicio que permite trabajar los músculos de los hombros. Este movimiento compuesto involucra los deltoides.','Fuerza',NULL,'Mantener la postura correcta y la técnica correcta del movimiento es esencial.','Intermedia'),(99,'Zancadas con mancuernas','Dumbbell Lunges','Ejercicio que permite trabajar los músculos de las piernas y glúteos. Este movimiento compuesto involucra los cuádriceps, los glúteos y los isquiotibiales.','Resistencia',NULL,'Mantener la postura correcta y la técnica correcta del movimiento es esencial.','Intermedia'),(100,'Elevaciones laterales con mancuernas','Dumbbell Lateral Raises','Ejercicio que permite trabajar los músculos de los hombros. Este movimiento compuesto involucra los deltoides.','Resistencia',NULL,'Mantener la postura correcta y la técnica correcta del movimiento es esencial.','Básica');
/*!40000 ALTER TABLE `ejercicios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ejercicios_AFTER_INSERT` AFTER INSERT ON `ejercicios` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "ejercicios",
        CONCAT_WS(" ","Se ha insertado un nuevo ejercicio con el ID: ",
        NEW.ID, "con los siguientes datos: NOMBRE_FORMAL=", NEW.nombre_formal,
        "NOMBRE_COMUN = ", NEW.nombre_comun, "DESCRIPCION = ", NEW.descripcion,
        "TIPO = ", NEW.tipo, "VIDEO_EJEMPLO = ", NEW.video_ejemplo,
        "CONSIDERACIONES = ", NEW.consideraciones, "DIFICULTAD = ", NEW.dificultad),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ejercicios_AFTER_UPDATE` AFTER UPDATE ON `ejercicios` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Update",
        "ejercicios",
        CONCAT_WS(" ","Se han actualizado los datos del ejercicio con el ID: ",
        NEW.ID, "con los siguientes datos:",
        "NOMBRE_FORMAL=", OLD.nombre_formal, " cambio a " ,NEW.nombre_formal,
        "NOMBRE_COMUN = ", OLD.nombre_comun, " cambio a " , NEW.nombre_comun, 
        "DESCRIPCION = ", OLD.descripcion, " cambio a " , NEW.descripcion,
        "TIPO = ",  OLD.tipo, " cambio a " ,NEW.tipo, 
        "VIDEO_EJEMPLO = ", OLD.video_ejemplo, " cambio a " , NEW.video_ejemplo,
        "CONSIDERACIONES = ",  OLD.consideraciones, " cambio a " ,NEW.consideraciones, 
        "DIFICULTAD = ", OLD.dificultad, " cambio a " , NEW.dificultad),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ejercicios_AFTER_DELETE` AFTER DELETE ON `ejercicios` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "ejercicios",
        CONCAT_WS(" ","Se han eliminado un ejercicio con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `Persona_ID` int unsigned NOT NULL,
  `Puesto` varchar(50) NOT NULL,
  `Area` varchar(60) NOT NULL,
  `Numero_Empleado` int unsigned NOT NULL,
  `Sucursal_ID` int unsigned NOT NULL,
  `Fecha_Contratacion` datetime NOT NULL,
  PRIMARY KEY (`Persona_ID`),
  KEY `fk_sucursales_1` (`Sucursal_ID`),
  CONSTRAINT `fk_persona_2` FOREIGN KEY (`Persona_ID`) REFERENCES `personas` (`ID`),
  CONSTRAINT `fk_sucursales_1` FOREIGN KEY (`Sucursal_ID`) REFERENCES `sucursales` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (1,'Directivo','3',1,3,'2020-05-22 13:56:45'),(2,'Administrativo','8',1,2,'2017-02-27 08:58:36'),(3,'Administrativo','2',2,3,'2019-06-21 16:05:20'),(4,'Instructor','3',1,1,'2016-04-22 11:13:35'),(5,'Instructor','4',1,4,'2016-01-30 08:00:02'),(6,'Administrativo','6',2,2,'2019-01-13 14:45:00'),(7,'Instructor','3',2,4,'2022-06-04 18:28:32'),(8,'Administrativo','4',3,4,'2023-05-15 19:33:50'),(9,'Area Medicá','4',3,3,'2024-01-12 19:54:15'),(10,'Area Medicá','4',4,4,'2019-02-09 11:04:54'),(11,'Intendecia','4',5,4,'2019-03-26 17:47:19'),(12,'Directivo','8',3,2,'2019-04-08 15:49:33'),(13,'Administrativo','5',4,3,'2018-03-07 15:16:46'),(14,'Instructor','5',6,4,'2017-12-17 10:03:53'),(15,'Administrativo','7',4,2,'2022-09-14 09:39:17'),(16,'Intendecia','5',5,3,'2016-05-07 09:31:51'),(17,'Administrativo','5',2,1,'2022-11-20 12:48:10'),(18,'Instructor','5',6,3,'2016-12-16 19:57:03'),(19,'Area Medicá','2',7,3,'2015-01-17 10:05:05'),(20,'Area Medicá','1',7,4,'2019-11-08 11:31:16'),(21,'Area Medicá','4',8,4,'2023-08-15 18:03:53'),(22,'Intendecia','2',3,1,'2021-04-20 18:32:53'),(23,'Administrativo','9',5,2,'2019-08-24 17:39:16'),(24,'Administrativo','3',9,4,'2016-11-10 09:50:58'),(25,'Area Medicá','4',8,3,'2021-01-16 09:36:00'),(26,'Directivo','9',6,2,'2022-07-16 14:33:56'),(27,'Area Medicá','7',7,2,'2017-01-17 10:00:40'),(28,'Area Medicá','3',9,3,'2020-10-01 11:15:21'),(29,'Instructor','3',10,4,'2019-07-17 12:38:19'),(30,'Intendecia','5',10,3,'2016-11-22 12:08:03'),(31,'Intendecia','1',11,3,'2017-07-15 17:57:29'),(32,'Instructor','4',11,4,'2017-05-08 09:38:16'),(33,'Intendecia','3',4,1,'2019-02-26 08:46:56'),(34,'Directivo','5',5,1,'2020-09-18 14:57:36'),(35,'Directivo','5',6,1,'2019-07-10 13:50:23'),(36,'Intendecia','3',7,1,'2017-11-14 11:43:11'),(37,'Instructor','3',12,3,'2024-02-06 16:56:07'),(38,'Administrativo','1',13,3,'2017-09-23 14:01:47'),(39,'Administrativo','4',14,3,'2020-10-22 09:20:33'),(40,'Directivo','3',12,4,'2021-01-09 18:06:03'),(41,'Intendecia','4',13,4,'2020-06-06 12:14:38'),(42,'Intendecia','5',8,1,'2015-11-12 11:03:58'),(43,'Administrativo','4',15,3,'2016-05-24 09:19:07'),(44,'Instructor','4',14,4,'2016-06-21 13:58:44'),(45,'Instructor','4',16,3,'2017-04-19 10:17:08'),(46,'Instructor','3',15,4,'2023-09-11 13:08:52'),(47,'Intendecia','4',17,3,'2021-08-01 11:58:13'),(48,'Administrativo','5',16,4,'2023-06-24 17:26:14'),(49,'Intendecia','5',18,3,'2019-06-17 10:49:07'),(50,'Administrativo','4',17,4,'2023-09-07 19:43:18'),(51,'Area Medicá','3',9,1,'2023-12-15 19:33:00'),(52,'Intendecia','4',18,4,'2019-03-16 18:05:45'),(53,'Directivo','9',8,2,'2017-08-07 18:35:21'),(54,'Area Medicá','2',10,1,'2021-05-09 13:03:51'),(55,'Directivo','8',9,2,'2018-05-22 12:48:40'),(56,'Area Medicá','1',19,4,'2021-01-05 19:14:37'),(57,'Administrativo','7',10,2,'2020-12-10 11:09:20'),(58,'Instructor','3',19,3,'2019-04-09 10:10:41'),(59,'Directivo','2',11,1,'2015-04-01 15:33:32'),(60,'Area Medicá','4',12,1,'2015-03-16 16:54:49'),(61,'Intendecia','8',11,2,'2016-09-17 15:25:31'),(62,'Area Medicá','3',13,1,'2023-08-04 13:54:32'),(63,'Administrativo','5',20,3,'2018-03-04 08:01:54'),(64,'Area Medicá','1',21,3,'2023-12-26 17:24:32'),(65,'Administrativo','3',20,4,'2016-12-27 09:41:04'),(66,'Area Medicá','5',21,4,'2019-05-28 14:50:53'),(67,'Directivo','2',22,4,'2016-01-19 09:46:22'),(68,'Intendecia','1',14,1,'2024-01-26 14:49:12'),(69,'Intendecia','3',15,1,'2023-08-06 08:43:22'),(70,'Instructor','1',16,1,'2019-02-19 17:03:49'),(71,'Area Medicá','4',23,4,'2017-08-04 12:51:42'),(72,'Area Medicá','1',22,3,'2021-09-26 18:26:52'),(73,'Administrativo','5',23,3,'2017-04-22 15:08:28'),(74,'Directivo','1',24,3,'2023-12-30 12:41:07'),(75,'Area Medicá','5',25,3,'2019-09-10 17:00:18'),(76,'Administrativo','3',17,1,'2021-06-26 16:04:07'),(77,'Intendecia','7',12,2,'2023-01-29 08:17:28'),(78,'Area Medicá','5',18,1,'2020-02-15 19:44:38'),(79,'Administrativo','1',24,4,'2020-05-24 19:25:34'),(80,'Intendecia','2',19,1,'2019-05-11 09:09:08'),(81,'Area Medicá','3',25,4,'2023-03-14 15:15:49'),(82,'Administrativo','3',26,4,'2018-10-04 08:39:05'),(83,'Administrativo','3',20,1,'2016-12-18 18:54:23'),(84,'Administrativo','5',27,4,'2020-11-08 11:32:04'),(85,'Instructor','5',21,1,'2021-12-12 13:29:22'),(86,'Area Medicá','8',13,2,'2022-09-29 08:58:47'),(87,'Instructor','3',26,3,'2015-07-03 08:50:09'),(88,'Intendecia','8',14,2,'2015-07-13 16:51:01'),(89,'Administrativo','4',27,3,'2016-09-02 10:43:04'),(90,'Area Medicá','2',28,3,'2016-03-31 18:31:00'),(91,'Directivo','5',22,1,'2019-08-14 08:09:50'),(92,'Instructor','8',15,2,'2023-03-27 08:31:19'),(93,'Administrativo','5',29,3,'2017-08-30 16:35:48'),(94,'Directivo','6',16,2,'2020-02-21 12:32:04'),(95,'Administrativo','1',30,3,'2022-07-08 13:52:02'),(96,'Directivo','5',28,4,'2015-07-13 12:06:23'),(97,'Directivo','1',31,3,'2016-09-26 09:52:56'),(98,'Directivo','2',32,3,'2022-09-15 12:16:04'),(99,'Administrativo','6',17,2,'2018-12-26 13:41:17'),(100,'Administrativo','6',18,2,'2022-06-04 09:33:20');
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `empleados_AFTER_INSERT` AFTER INSERT ON `empleados` FOR EACH ROW BEGIN
	 -- Declaración de variables
     DECLARE v_nombre_sucursal varchar(60) default null;
     
     if new.sucursal_id is not null then
        -- En caso de tener el id de la sucursal debemos recuperar su nombre
        set v_nombre_sucursal = (SELECT nombre FROM sucursales WHERE id = NEW.sucursal_id);
    else
        SET v_nombre_sucursal = "Sin sucursal asignada";
    end if;
    
    INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "empleados",
        CONCAT_WS(" ","Se ha insertado una nuevo EMPLEADO con el ID: ",NEW.persona_id, 
        "con los siguientes datos: PUESTO = ", NEW.puesto,
        "AREA=", NEW.area,
        "NUMERO EMPLEADO = ", NEW.numero_empleado,
        "SUCURSAL ID = ", v_nombre_sucursal,
        "FECHA CONTRATACIÓN = ",  NEW.fecha_contratacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `empleados_AFTER_UPDATE` AFTER UPDATE ON `empleados` FOR EACH ROW BEGIN
	-- Declaración de variables
	DECLARE v_nombre_sucursal VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_sucursal2 VARCHAR(60) DEFAULT NULL;
    
    IF NEW.sucursal_id IS NOT NULL THEN 
		-- En caso de tener el id de la sucursal debemos recuperar su nombre
		-- para ingresarlo en la bitacora.
		SET v_nombre_sucursal = (SELECT nombre FROM sucursales WHERE id = NEW.sucursal_id);
    ELSE
		SET v_nombre_sucursal = "Sin sucursal asignada.";
    END IF;

    IF OLD.sucursal_id IS NOT NULL THEN 
		-- En caso de tener el id de la sucursal debemos recuperar su nombre
		-- para ingresarlo en la bitacora.
		SET v_nombre_sucursal2 = (SELECT nombre FROM sucursales WHERE id = OLD.sucursal_id);
    ELSE
		SET v_nombre_sucursal2 = "Sin sucursal asignada.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "empleados",
        CONCAT_WS(" ","Se han actualizado los datos del empleado con el ID: ",
        NEW.persona_id, "con los siguientes datos:",
        "PUESTO = ", OLD.puesto, " cambio a " ,NEW.puesto,
        "AREA = ", OLD.area, " cambio a " , NEW.area, 
        "NUMERO EMPLEADO = ", OLD.numero_empleado, " cambio a " , NEW.numero_empleado,
        "SUCURSAL ID = ", v_nombre_sucursal2 , " cambio a " , v_nombre_sucursal, 
        "FECHA CONTRATACIÓN = ", OLD.fecha_contratacion, " cambio a " , NEW.fecha_contratacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `empleados_AFTER_DELETE` AFTER DELETE ON `empleados` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Delete",
        "empleados",
        CONCAT_WS(" ","Se ha eliminado un EMPLEADO con el ID: ", OLD.persona_id),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `equipos`
--

DROP TABLE IF EXISTS `equipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipos` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(250) NOT NULL,
  `Descripcion` text,
  `Marca` varchar(50) NOT NULL,
  `Modelo` varchar(50) NOT NULL,
  `Especificaciones` text,
  `Fotografia` varchar(100) DEFAULT NULL,
  `Total_Existencia` int unsigned NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipos`
--

LOCK TABLES `equipos` WRITE;
/*!40000 ALTER TABLE `equipos` DISABLE KEYS */;
INSERT INTO `equipos` VALUES (91,'Máquina de remo inclinado','Esta máquina actúa en el sistema muscular y es eficaz para lograr una figura estilizada y dar forma a los músculos','Total Gym','Incline Remo CE','Esta máquina tiene una resistencia regulable y está hecha de acero aleado. Sus dimensiones son 98\" de profundidad, 23.5\" de ancho y 30\" de altura. El peso máximo recomendado es de 400 libras y el peso del artículo es de 98 libras',NULL,1),(92,'Máquina de desarrollo de pantorrilla sentado','Esta máquina está diseñada con el ángulo ideal para brindar máxima tensión en la pantorrilla','SONICO FITNESS','X10','Esta máquina tiene una bocina de carga de la placa y una almohadilla ajustable para el muslo, lo que la hace adaptable para cualquier usuario',NULL,1),(93,'Máquina de abducción de cadera','Esta máquina trabaja los músculos de la abducción de la cadera, fortaleciéndolos y mejorando la movilidad en la zona de los muslos','Total Gym','NP-L1131','Esta máquina trabaja los músculos de la abducción de la cadera, fortaleciéndolos y mejorando la movilidad en la zona de los muslos. Sus dimensiones son 98\" de profundidad, 23.5\" de ancho y 30\" de altura. El peso máximo recomendado es de 400 libras y el peso del artículo es de 98 libras',NULL,1),(94,'Máquina de rotación de tronco','Esta máquina permite la flexión lateral gracias a las articulaciones cartilaginosas entre las vértebras adyacentes en la columna vertebral','TZ','9003','Esta máquina tiene un tamaño de 1360*1206*1680 mm, está hecha de tubo elíptico plano de 150*50*3 mm, tiene placas de peso de 65kg y un peso de la máquina de 205kg',NULL,1),(95,'Máquina de glúteos','Esta máquina está diseñada para trabajar los músculos que giran el muslo hacia fuera, como el glúteo medio, el sartorio y el tensor de la fascia lata','Nautilus','Glute Drive','Esta máquina aísla y fortalece los glúteos mientras mejora la estabilidad del núcleo. Sus dimensiones son 60\" de ancho, 62\" de largo y 35\" de altura. El peso total de la máquina es de 252 libras',NULL,1),(96,'Máquina para isquiotibiales de pie','Esta máquina es un banco con un peso móvil en un extremo. Para trabajar los isquiotibiales, te acuestas boca abajo, sostienes un rodillo pesado con los pies y lo levantas doblando las rodillas','Technogym','Leg Curl','Esta máquina permite entrenar los músculos isquiotibiales de manera segura y efectiva',NULL,1),(97,'Máquina de Pull Over','Esta máquina se enfoca en los músculos de la espalda, los hombros y los brazos, lo que lo convierte en un ejercicio muy completo','JBS FITNESS','Pullover Strength','Esta máquina permite ejercitar el pullover en su máxima contracción. Tiene un asiento regulable en altura y un cinturón para una máxima sujeción. Está disponible para carga olímpica o discos de 28mm',NULL,1),(98,'Máquina de extensión de cadera','Esta máquina permite la extensión de cadera de pie, proporcionando un ángulo diferente de trabajo y permitiendo trabajar ciertas partes de la cadera de forma específica','SportsArt','N961','Esta máquina permite trabajar los glúteos, femorales y flexores de la cadera desde una posición erguida. Sus dimensiones son 150 x 172 x 126 cm',NULL,1),(99,'Máquina de elevación de gemelos, de pie en posición inclinada','Esta máquina permite realizar elevaciones de gemelos de pie. El ejercicio trabaja los músculos del gemelo, especialmente el musculo gastrocnemio, y el soleo en menor medida','Simply Fitness','Elevación de gemelos de pie','Esta máquina permite realizar elevaciones de gemelos de pie. El ejercicio trabaja los músculos del gemelo, especialmente el musculo gastrocnemio, y el soleo en menor medida',NULL,1),(100,'Maquina de flexión lateral de columna vertebral','Esta máquina permite la flexión lateral gracias a las articulaciones cartilaginosas entre las vértebras adyacentes en la columna vertebral, Este sistema convierte tu mesa de operaciones estándar en una mesa especializada para cirugías de columna vertebral con un ajuste fácil y preciso de la cabeza y la columna cervical','Allen Medical','Sistema para columna vertebral Allen','Este sistema convierte tu mesa de operaciones estándar en una mesa especializada para cirugías de columna vertebral con un ajuste fácil y preciso de la cabeza y la columna cervical. El sistema proporciona un excelente acceso al arco en C y al arco en O, por lo tanto, proporciona también los beneficios de la radiolucencia de una mesa independiente para cirugías de columna vertebra',NULL,1);
/*!40000 ALTER TABLE `equipos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `equipos_AFTER_INSERT` AFTER INSERT ON `equipos` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "equipos",
        CONCAT_WS(" ","Se ha insertado un nuevo equipo con el ID: ",NEW.ID, 
        "con los siguientes datos: NOMBRE=", NEW.nombre,
        "DESCRIPCION = ", NEW.descripcion,
        "MARCA = ", NEW.marca,
        "MODELO = ", NEW.modelo, 
        "ESPECIFICACIONES = ", NEW.especificaciones,
        "FOTOGRAFIA = ", NEW.fotografia, 
        "TOTAL_EXISTENCIA = ", NEW.total_existencia),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `equipos_BEFORE_UPDATE` BEFORE UPDATE ON `equipos` FOR EACH ROW BEGIN
INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Update",
        "equipos",
        CONCAT_WS(" ","Se han actualizado los datos del equipo con el ID: ",NEW.ID, 
        "con los siguientes datos:", "NOMBRE=", OLD.nombre, " cambio a " ,NEW.nombre,
        "DESCRIPCION = ", OLD.descripcion, " cambio a " , NEW.descripcion,
        "MARCA = ", OLD.marca, " cambio a " , NEW.marca, 
        "MODELO = ",  OLD.modelo, " cambio a " ,NEW.modelo, 
        "ESPECIFICACIONES = ", OLD.especificaciones, " cambio a " , NEW.especificaciones,
        "FOTOGRAFIA = ",  OLD.fotografia, " cambio a " ,NEW.fotografia, 
        "TOTAL_EXISTENCIA = ", OLD.total_existencia, " cambio a " , NEW.total_existencia),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `equipos_AFTER_DELETE` AFTER DELETE ON `equipos` FOR EACH ROW BEGIN
INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "equipos",
        CONCAT_WS(" ","Se ha eliminado un equipo con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `equipos_existencias`
--

DROP TABLE IF EXISTS `equipos_existencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipos_existencias` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Equipo_ID` int unsigned NOT NULL,
  `Area_ID` int unsigned NOT NULL,
  `Color` varchar(100) DEFAULT NULL,
  `Estatus` enum('Nuevo','Semi-Nuevo','Bueno','Regular','Malo','Baja','Extraviado') NOT NULL,
  `Fecha_Asignacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `fk_equipo_1` (`Equipo_ID`),
  KEY `fk_area_1` (`Area_ID`),
  CONSTRAINT `fk_area_1` FOREIGN KEY (`Area_ID`) REFERENCES `areas` (`ID`),
  CONSTRAINT `fk_equipo_1` FOREIGN KEY (`Equipo_ID`) REFERENCES `equipos` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipos_existencias`
--

LOCK TABLES `equipos_existencias` WRITE;
/*!40000 ALTER TABLE `equipos_existencias` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipos_existencias` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `equipos_existencias_AFTER_INSERT` AFTER INSERT ON `equipos_existencias` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_equipo varchar(60) default null;
    DECLARE v_nombre_area varchar(60) default null;

    -- Iniciación de las variables
    if new.equipo_id is not null then
        -- En caso de tener el id del equipo
        set v_nombre_equipo = (SELECT CONCAT_WS(" ", e.nombre, e.marca, e.modelo) FROM equipos e WHERE id = NEW.equipo_id);
    else
        SET v_nombre_equipo = "Sin equipo asignado";
    end if;

    if new.area_id is not null then
        -- En caso de tener el id del area
        set v_nombre_area = (SELECT nombre FROM areas WHERE id = NEW.area_id);
    else
        SET v_nombre_area = "Sin area asignada";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "equipos_existencias",
        CONCAT_WS(" ","Se ha insertado una nueva relación de EQUIPOS EXISTENCIAS con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "EQUIPO ID = ", v_nombre_equipo,
        "AREA ID = ",  v_nombre_area,
        "COLOR = ", NEW.color, 
        "ESTATUS = ", NEW.estatus,
        "FECHA DE ASIGNACIÓN = ", NEW.fecha_asignacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `equipos_existencias_AFTER_UPDATE` AFTER UPDATE ON `equipos_existencias` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_equipo VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_equipo2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_area VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_area2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    IF NEW.equipo_id IS NOT NULL THEN 
		-- En caso de tener el id del equipo
		SET v_nombre_equipo = (SELECT CONCAT_WS(" ", e.nombre, e.marca, e.modelo) FROM equipos e WHERE id = NEW.equipo_id);
    ELSE
		SET v_nombre_equipo = "Sin equipo asignado.";
    END IF;
    
    IF OLD.equipo_id IS NOT NULL THEN 
		-- En caso de tener el id del equipo
		SET v_nombre_equipo2 =(SELECT CONCAT_WS(" ", e.nombre, e.marca, e.modelo) FROM equipos e WHERE id = OLD.equipo_id);
    ELSE
		SET v_nombre_equipo2 = "Sin equipo asignado.";
    END IF;

    IF NEW.area_id IS NOT NULL THEN 
		-- En caso de tener el id del area
		SET v_nombre_area = (SELECT nombre FROM areas WHERE id = NEW.area_id);
    ELSE
		SET v_nombre_area = "Sin area asignada.";
    END IF;

    IF OLD.area_id IS NOT NULL THEN 
		-- En caso de tener el id del area
		SET v_nombre_area2 = (SELECT nombre FROM areas WHERE id = OLD.area_id);
    ELSE
		SET v_nombre_area2 = "Sin area asignada.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "equipos_exixstencias",
        CONCAT_WS(" ","Se han actualizado los datos de la relación EQUIPOS EXISTENCIAS con el ID: ",NEW.ID, 
        "con los siguientes datos:",
        "EQUIPO ID = ", v_nombre_equipo2, "cambio a", v_nombre_equipo,
        "AREA ID =",v_nombre_area2,"cambio a", v_nombre_area,
        "COLOR = ", OLD.color, "cambio a", NEW.color ,
        "ESTATUS = ", OLD.estatus, "cambio a", NEW.estatus,
        "FECHA DE ASIGNACIÓN = ", OLD.fecha_asignacion , "cambio a", NEW.fecha_asignacion ),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `equipos_existencias_AFTER_DELETE` AFTER DELETE ON `equipos_existencias` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "equipos_existencias",
        CONCAT_WS(" ","Se ha eliminado una relación EUIPOS EXISTENCIAS con los IDs: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `instructores`
--

DROP TABLE IF EXISTS `instructores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructores` (
  `Empleado_ID` int unsigned NOT NULL,
  `Especialidad` varchar(100) DEFAULT NULL,
  `Horario_Disponibilidad` text,
  `Total_Miembros_Atendidos` int unsigned DEFAULT NULL,
  `Valoracion_Miembro` int unsigned DEFAULT '0',
  PRIMARY KEY (`Empleado_ID`),
  CONSTRAINT `fk_empleado_1` FOREIGN KEY (`Empleado_ID`) REFERENCES `empleados` (`Persona_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructores`
--

LOCK TABLES `instructores` WRITE;
/*!40000 ALTER TABLE `instructores` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructores` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `instructores_AFTER_INSERT` AFTER INSERT ON `instructores` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "instructores",
        CONCAT_WS(" ","Se ha insertado un nuevo INSTRUCTOR con el ID: ",NEW.empleado_id, 
        "con los siguientes datos: ESPECIALIDAD=", NEW.especialidad,
        "HORARIO DE DISPONIBILIDAD = ", NEW.horario_disponibilidad, 
        "TOTAL DE MIEMBROS ATENDIDOS = ", NEW.total_miembros_atendidos,
        "VALORACIÓN DE LOS MIEMBROS = ", NEW.valoracion_miembro),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `instructores_AFTER_UPDATE` AFTER UPDATE ON `instructores` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Update",
        "instructores",
        CONCAT_WS(" ","Se han actualizado los datos del INSTRUCTOR con el ID: ",NEW.empleado_id, 
        "con los siguientes datos:",
        "ESPECIALIDAD = ", OLD.especialidad, " cambio a " ,NEW.especialidad,
        "HORARIO DE DISPONIBILIDAD = ", OLD.horario_disponibilidad, " cambio a " , NEW.horario_disponibilidad, 
        "TOTAL DE MIEMBROS ATENDIDOS = ", OLD.total_miembros_atendidos, " cambio a " , NEW.total_miembros_atendidos,
        "VALORACIÓN DE MIEMBRO = ",  OLD.valoracion_miembro, " cambio a " ,NEW.valoracion_miembro),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `instructores_AFTER_DELETE` AFTER DELETE ON `instructores` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "instructores",
        CONCAT_WS(" ","Se ha eliminado un INSTRUCTOR con el ID: ", OLD.empleado_id),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `membresias`
--

DROP TABLE IF EXISTS `membresias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membresias` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Descripción: Identificador único de la membresias.\\nTipo: Numérico (Entero)\\nNaturaleza: Cuantitativo\\nDominio: Números enteros positivos.\\n',
  `Codigo` varchar(50) NOT NULL COMMENT 'Descripción: Código único asignado a la membresía ,\nTipo:Alfanumérico,\nNaturaleza:Cualitativo,\nDominio: cadena de texto de hasta 50 caracteres \n',
  `Tipo` enum('Individual','Familiar','Empresarial') NOT NULL COMMENT 'Descripción: Estado de conexión del usuario (Online, Offline, Banned).\nTipo: Tipo de membresía (individual, familiar o empresarial),\nNaturaleza: Cualitativo\\n\nDominio: (''Individual'', ''Familiar'', ''Empresarial'')',
  `Tipo_Servicios` enum('Basicos','Completa','Coaching','Nutriólogo') NOT NULL COMMENT 'Descripción: Tipo de servicios incluidos en la membresía (básicos, completos, coaching o nutriólogo).\\n\nTipo: Enumerado\\n\nNaturaleza: Cualitativo\\n\nDominio: {''Basicos'', ''Completa'', ''Coaching'', ''Nutriólogo''}',
  `Tipo_Plan` enum('Anual','Semestral','Trimestral','Bimestral','Mensual','Semanal','Diaria') DEFAULT NULL COMMENT 'Descripción: Tipo de plan de pago de la membresía (anual, semestral, trimestral, bimestral, mensual, semanal o diario),\nTipo: Enumerado,\nNaturaleza: cualitativo\nDominio: {''Anual'', ''Semestral'', ''Trimestral'', ''Bimestral'', ''Mensual'', ''Semanal'', ''Diaria''}\n',
  `Nivel` enum('Nuevo','Plata','Oro','Diamante') NOT NULL COMMENT 'Descripción: Nivel de la membresía (nuevo, plata, oro o diamante),\nTipo: Enumerado,\nNaturaleza: Cualitativo\nDominio: {''Nuevo'', ''Plata'', ''Oro'', ''Diamante''}\n',
  `Fecha_Inicio` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Descripción: Fecha de inicio de la membresía\nTipo: Fecha y hora,\nNaturaleza: Cuantitativo,\nDominio: Valores de fecha y hora válidos.\n',
  `Fecha_Fin` datetime NOT NULL COMMENT 'Descripción:Fecha de fin de la membresía.\\n\nTipo: Fecha y hora\\n\nNaturaleza: Cuantitativo\\n\nDominio: Valores de fecha y hora válidos.\n\n',
  `Estatus` bit(1) NOT NULL DEFAULT b'1' COMMENT 'Descripción: Estatus de la membresía,\nTipo: Bit (1 bit)\nNaturaleza: Cualitativo\nDominio: {1 (Activo), 0 (Inactivo)}\n',
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Descripción: Fecha de registro de la membresía.\\n\nTipo: Fecha y hora\\n\nNaturaleza: Cuantitativo\\n\nDominio: Valores de fecha y hora válidos.\n',
  `Fecha_Actualizacion` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Descripción: Fecha de la última actualización de la membresía.\\n\nTipo: Fecha y hora\\n\nNaturaleza: Cuantitativo\\n\nDominio: Valores de fecha y hora válidos.\n',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Codigo` (`Codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Clasificación del Tipo de Tabla: Base \nDescripción de la Tabla:\nLa tabla membresias almacena información detallada sobre las membresías de los usuarios del sistema. Contiene datos como el código de la membresía, el tipo de membresía (individual, familiar o empresarial), el tipo de servicios incluidos (básicos, completos, coaching o nutriólogo), el tipo de plan (anual, semestral, trimestral, bimestral, mensual, semanal o diario), el nivel de la membresía (nuevo, plata, oro o diamante), la fecha de inicio de la membresía, la fecha de fin de la membresía, el estatus de la membresía (activo o inactivo), la fecha de registro de la membresía y la fecha de actualización de la membresía.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membresias`
--

LOCK TABLES `membresias` WRITE;
/*!40000 ALTER TABLE `membresias` DISABLE KEYS */;
INSERT INTO `membresias` VALUES (1,'OZvzjRnkwCwKdNjebfGGkDc5QXfm4g9VdhN67h1kxK7kjAX2ju','Individual','Coaching','Bimestral','Diamante','2023-11-08 12:27:53','2024-01-08 12:27:53',_binary '','2023-11-08 12:27:53',NULL),(2,'B7OFTuJdUSFGp0O1Hr56fY8Kmww2C1d3AL57khqg3ugTDvCz2r','Individual','Nutriólogo','Anual','Diamante','2016-06-02 13:52:45','2017-06-02 13:52:45',_binary '','2016-06-02 13:52:45',NULL),(3,'XgrsWmYN2Q5UgDmSjXPgPor3YFsh0cXb2E9ODHAPoufM9rKrXs','Empresarial','Nutriólogo','Trimestral','Diamante','2020-10-18 19:35:56','2021-01-18 19:35:56',_binary '','2020-10-18 19:35:56',NULL),(4,'jiAZeciQnkxHTne0jA0giHC0aNt0BZbUYb0rePpBM42XFtnq3Y','Individual','Completa','Mensual','Oro','2020-06-10 18:20:24','2020-07-10 18:20:24',_binary '','2020-06-10 18:20:24',NULL),(5,'pF6ysABdkWLZDc83TkUBjIE5wk5u8cCstZyMfSFHth0aPELS4K','Familiar','Basicos','Bimestral','Diamante','2019-03-14 15:54:33','2019-05-14 15:54:33',_binary '','2019-03-14 15:54:33',NULL),(6,'KMEWKVn6pHimWCiCddsCHHmIvlgfuGVAccnkvzjRngel2bMmti','Empresarial','Nutriólogo','Anual','Nuevo','2017-04-28 10:16:58','2018-04-28 10:16:58',_binary '','2017-04-28 10:16:58',NULL),(7,'t8eL9sOJdURzgCjICXVM56eSHRdsG3dTQyewUX6DPhUFEfhEo2','Familiar','Completa','Diaria','Plata','2023-01-24 12:54:16','2023-01-25 12:54:16',_binary '','2023-01-24 12:54:16',NULL),(8,'Bqg3tdDAYaRQCxRGQ9fL57mti1d3DY04ksi7IeZeeqt3RbiXTC','Individual','Nutriólogo','Trimestral','Nuevo','2015-05-01 08:37:26','2015-08-01 08:37:26',_binary '','2015-05-01 08:37:26',NULL),(9,'FO658oyAfwRLgY4t7eK5cK7lnRaeHOYo34dREHwv0vv1C1gepl','Empresarial','Basicos','Bimestral','Plata','2017-08-11 08:30:50','2017-10-11 08:30:50',_binary '','2017-08-11 08:30:50',NULL),(10,'PiXVL3ZNZzSEDgn6oE7BDqbEHANdJ0O4VodTNkgjO641Vy0nTi','Empresarial','Completa','Semanal','Nuevo','2016-11-07 14:38:19','2016-11-14 14:38:19',_binary '','2016-11-07 14:38:19',NULL),(11,'ExK5cIZP9fQsKoJr3XCflXObtOCHEaQJ7qLzy2vsKnE7CKTdqv','Empresarial','Completa','Semestral','Nuevo','2019-09-03 19:18:05','2020-03-03 19:18:05',_binary '','2019-09-03 19:18:05',NULL),(12,'SUUQuSYc7Wo7pIjqePvZtpDTCpcK8tUa768pCRtOBz2uj6ywUY','Individual','Basicos','Semestral','Diamante','2022-07-04 15:51:30','2023-01-04 15:51:30',_binary '','2022-07-04 15:51:30',NULL),(13,'MeMgWVNcCvDHBSDuyl15myITiOapworYB4yw0raxcokutU7T6N','Empresarial','Nutriólogo','Semanal','Nuevo','2016-08-04 16:39:32','2016-08-11 16:39:32',_binary '','2016-08-04 16:39:32',NULL),(14,'JpPVa4Q2E7FWKVm00ZTy4FaPDHASzetFTvNwbninZRiTzdneZh','Empresarial','Completa','Bimestral','Plata','2017-11-20 11:22:01','2018-01-20 11:22:01',_binary '','2017-11-20 11:22:01',NULL),(15,'gTHQ5UjPdBo7oF7AAbaj09I8vai06wiUGGnNS0oVsweBhDlP4T','Familiar','Completa','Semestral','Plata','2019-01-11 14:27:27','2019-07-11 14:27:27',_binary '','2019-01-11 14:27:27',NULL),(16,'Pv3NLqRZp48rQSTMgY5xnktnuk9LpIoMLs0GnOZsntdGOXmYMX','Empresarial','Coaching','Bimestral','Plata','2018-10-21 16:25:04','2018-12-21 16:25:04',_binary '','2018-10-21 16:25:04',NULL),(17,'pg5EZYWKYA1oQ5S6Udk3f4E1bPzpknXCgrqOLoGgftDMWm126p','Individual','Coaching','Semanal','Nuevo','2018-04-12 15:44:23','2018-04-19 15:44:23',_binary '','2018-04-12 15:44:23',NULL),(18,'COeISgGBX1e5Kt79rLu7atT2vrF0029HZRme2wuRRHWBb9apzB','Familiar','Basicos','Trimestral','Diamante','2021-11-21 17:48:54','2022-02-21 17:48:54',_binary '','2021-11-21 17:48:54',NULL),(19,'HgdgHIsaqF2e1r6ePrIikJGcZlLMDQiYYYXQk9Khc71KF7CHFe','Individual','Basicos','Anual','Diamante','2024-02-09 14:46:19','2025-02-09 14:46:19',_binary '','2024-02-09 14:46:19',NULL),(20,'pt8fQuTZglYQhRsG5mxCtwaiZ4lyK2XFusMztFWGC3qVlYQgPm','Individual','Coaching','Trimestral','Plata','2020-02-12 17:32:14','2020-05-12 17:32:14',_binary '','2020-02-12 17:32:14',NULL),(21,'UEwEHxAiJNLsYwFNYvAqmww3Iq0KGd0mP2HqZElIANdFIzHMQQ','Individual','Nutriólogo','Mensual','Diamante','2023-11-29 17:06:00','2023-12-29 17:06:00',_binary '','2023-11-29 17:06:00',NULL),(22,'KihvGUvPAuFSmd0lHsdHP5YySK5dPtVb73Vsu89pxwWaZsi7H9','Individual','Basicos','Mensual','Diamante','2023-04-10 13:56:16','2023-05-10 13:56:16',_binary '','2023-04-10 13:56:16',NULL),(23,'GWFuv2EbXdeuLkmRaj2gb61LLyryuKf3vopUjQj04mBWSx7Wm0','Individual','Completa','Diaria','Oro','2021-08-01 16:54:56','2021-08-02 16:54:56',_binary '','2021-08-01 16:54:56',NULL),(24,'kgm24g6HdZgm14eX8NymbQFP8aqCQonKDUCn38v9bw4MG5oJs7','Individual','Completa','Semestral','Plata','2019-12-31 10:21:21','2020-06-30 10:21:21',_binary '','2019-12-31 10:21:21',NULL),(25,'aFRhPk7ADnYJJvlaPDID3mD6BGEaU3zEAX3nIq2Rex2zL46jef','Individual','Coaching','Bimestral','Nuevo','2023-12-04 10:47:44','2024-02-04 10:47:44',_binary '','2023-12-04 10:47:44',NULL),(26,'IwuRPyjVEwDEixPw6ZEfkSrxngcex2xCtu3NQQEIE6ysCIKBJR','Individual','Basicos','Anual','Diamante','2015-05-10 17:47:14','2016-05-10 17:47:14',_binary '','2015-05-10 17:47:14',NULL),(27,'5UfvMpJpR5OQNqLxppR4LAFzSGNU92KCSvU2s9ovmgfrt4WwJ6','Individual','Nutriólogo','Trimestral','Plata','2017-07-10 13:08:58','2017-10-10 13:08:58',_binary '','2017-07-10 13:08:58',NULL),(28,'Kr0GnSgGAUPmmJxuQKdRDz0gmXJORSPtSYgn6pJr0IAM6cHTl2','Individual','Basicos','Semestral','Diamante','2022-11-11 16:21:18','2023-05-11 16:21:18',_binary '','2022-11-11 16:21:18',NULL),(29,'XVKXyVY3oNOGZRmd0pZKMEWHJxx2APmkzSGLKubqBIMNAy3zIR','Individual','Completa','Anual','Oro','2016-03-07 10:41:01','2017-03-07 10:41:01',_binary '','2016-03-07 10:41:01',NULL),(30,'lNXn238xgILG8CJLCQnjtrJoIs57h5yy6QV7OGYQiWNbx6VkPc','Individual','Completa','Bimestral','Nuevo','2015-07-09 16:04:10','2015-09-09 16:04:10',_binary '','2015-07-09 16:04:10',NULL),(31,'pVqnANcEEhsrRXejQhRsH8zrvcsIdUWXWRsJga0yK20UwTSK6f','Individual','Coaching','Diaria','Plata','2015-10-07 14:05:28','2015-10-08 14:05:28',_binary '','2015-10-07 14:05:28',NULL),(32,'wK9xdvPFQeExK6g1mHsbxacvV7QPEIFd3BRtNAxX8OEPbpwopS','Individual','Coaching','Anual','Oro','2015-04-07 17:01:14','2016-04-07 17:01:14',_binary '','2015-04-07 17:01:14',NULL),(33,'vqBKVn9zsyohfqlsgWTFFlJE19I5klKGcXb4OSTPuWfqpLCLXv','Individual','Basicos','Mensual','Diamante','2023-06-10 14:20:56','2023-07-10 14:20:56',_binary '','2023-06-10 14:20:56',NULL),(34,'gtxgJTfA9ZtsSZlLNGZXM2P4S84UodUVSEzUPqCRrBJQ1BXYXV','Individual','Coaching','Mensual','Oro','2022-02-18 17:14:04','2022-03-18 17:14:04',_binary '','2022-02-18 17:14:04',NULL),(35,'0hlUvMqMEUAem8zuKg4zDtu1D5zAbbooOT2tfOj8LoF9Kidbj2','Individual','Completa','Semestral','Oro','2023-03-07 18:27:05','2023-09-07 18:27:05',_binary '','2023-03-07 18:27:05',NULL),(36,'EEhqic5S5OOCGwAkVClSl6t1KG8FUAa60JF6wk1bRKaArsWlVx','Individual','Coaching','Diaria','Diamante','2017-04-27 11:56:29','2017-04-28 11:56:29',_binary '','2017-04-27 11:56:29',NULL),(37,'mSgINRTSIVuGXLVjMYyRBssWkO3TgEsmq3YKLDSsEUCmVwSOrK','Individual','Nutriólogo','Trimestral','Diamante','2022-12-27 09:05:40','2023-03-27 09:05:40',_binary '','2022-12-27 09:05:40',NULL),(38,'CTCo7rRYhtxiQj4oLBM41UtCIIr4ZLR0sgWXWPj5ucuU2tfRw0','Individual','Completa','Bimestral','Diamante','2020-04-05 11:35:53','2020-06-05 11:35:53',_binary '','2020-04-05 11:35:53',NULL),(39,'B7Mxk5qR0uqDVGHoThHHmHpXyWZbV4yBmXHD5yvSPyiPfL6bDB','Individual','Coaching','Anual','Oro','2022-09-23 17:50:55','2023-09-23 17:50:55',_binary '','2022-09-23 17:50:55',NULL),(40,'6ZDeeszxV3uj4s2NVdkYRooMIdXaXiA2q2TohejTxZkFoVtCFs','Individual','Coaching','Semestral','Plata','2015-03-04 11:10:33','2015-09-04 11:10:33',_binary '','2015-03-04 11:10:33',NULL),(41,'XejRmbTUTHO0BZaOBxW3s8hY4rZC8OEO7cBpdTPqE05qPTX5CO','Familiar','Basicos','Semestral','Oro','2021-04-07 16:51:28','2021-10-07 16:51:28',_binary '','2021-04-07 16:51:28',NULL),(42,'1Iui1gcduNv8btPKg3ugTDwJ4aByX8ODLS82OWfpjjDdbjXSw0','Familiar','Basicos','Bimestral','Oro','2017-04-16 18:35:14','2017-06-16 18:35:14',_binary '','2017-04-16 18:35:14',NULL),(43,'8wduQJ8sS0rbCwJ6kjA1kyOmq0MT7Ueogb70HulhmVA7RV3vlc','Familiar','Completa','Anual','Diamante','2019-03-23 11:01:46','2020-03-23 11:01:46',_binary '','2019-03-23 11:01:46',NULL),(44,'RsFZXQiZ3hekYTxYjC8RUWY3jsmoVpihtzqpNIdUTJYFsgVSBo','Familiar','Completa','Anual','Diamante','2019-01-04 17:56:39','2020-01-04 17:56:39',_binary '','2019-01-04 17:56:39',NULL),(45,'HaI6muouiY19I8wblcXc979pyAhDjHyGIAL2TncUUOlghCekVE','Familiar','Completa','Bimestral','Plata','2018-12-21 16:50:32','2019-02-21 16:50:32',_binary '','2018-12-21 16:50:32',NULL),(46,'rgY4t8hXXVM435fZecgIOU5HhjHxBo9CEo2ZRiWN8j9QJaAuGW','Familiar','Nutriólogo','Mensual','Diamante','2018-12-23 10:36:07','2019-01-23 10:36:07',_binary '','2018-12-23 10:36:07',NULL),(47,'KzEvApg6LubsJjkKInJyx4HkvxcooKyx1wyacuPFTtH25knVuI','Familiar','Coaching','Anual','Nuevo','2016-04-01 14:14:58','2017-04-01 14:14:58',_binary '','2016-04-01 14:14:58',NULL),(48,'tu1GkC4xsEUBfuFRjZ17ztFTvOxgHGmMMABekYUBiFupBNbyac','Familiar','Completa','Bimestral','Oro','2022-05-14 15:00:07','2022-07-14 15:00:07',_binary '','2022-05-14 15:00:07',NULL),(49,'Ov71NU8WiHzNgVRx4LADo7nxAiKORRGSl3e2s9rLt659sOKh9X','Familiar','Basicos','Trimestral','Oro','2021-06-03 14:41:24','2021-09-03 14:41:24',_binary '','2021-06-03 14:41:24',NULL),(50,'2wvWeiLZC6Iga4NPJ9yl2bPArsWlTtGXLXttZuv2Ir3WzZglXJ','Familiar','Nutriólogo','Semanal','Diamante','2021-12-24 13:13:33','2021-12-31 13:13:33',_binary '','2021-12-24 13:13:33',NULL),(51,'iTx1vrJjp35h9U5GaOzndUWWSy951Q9czhEsjd6Vgz1sdHP3LG','Familiar','Basicos','Anual','Plata','2019-07-26 10:00:44','2020-07-26 10:00:44',_binary '','2019-07-26 10:00:44',NULL),(52,'DJKxsG3dW1jvzm5kp31WEsmoR9btMxjXStKlrbDA3tfMbBroE4','Familiar','Completa','Trimestral','Nuevo','2023-02-27 10:11:09','2023-05-27 10:11:09',_binary '','2023-02-27 10:11:09',NULL),(53,'whOcAkSonHmGmJyDsrPMrR1tlkyQv1C09JeZd950JD07yrxoks','Familiar','Basicos','Trimestral','Diamante','2017-05-15 11:40:27','2017-08-15 11:40:27',_binary '','2017-05-15 11:40:27',NULL),(54,'WVQouhTCsrNERlbRJ5g2pWvFQcvU1mKHf8WjJKyx1wuWdfClRi','Familiar','Nutriólogo','Diaria','Plata','2019-05-13 17:11:10','2019-05-14 17:11:10',_binary '','2019-05-13 17:11:10',NULL),(55,'FLQU3vnlBX1d2wuSX8PJaEJHjuu0zRx84VrpKwl9JeZc4JudDx','Familiar','Nutriólogo','Semanal','Diamante','2016-10-14 16:19:06','2016-10-21 16:19:06',_binary '','2016-10-14 16:19:06',NULL),(56,'7YxJ5dPv2Fd5LAFAUL7h4ugRx3InMIikID1d0p0O3Q1ATGLLyu','Familiar','Nutriólogo','Semanal','Diamante','2019-07-10 08:55:02','2019-07-17 08:55:02',_binary '','2019-07-10 08:55:02',NULL),(57,'c3E6yvRLg0e8YuyhLZEgo8xhL0IBRuSTSGLNG29BA8U92JzFAY','Familiar','Coaching','Anual','Diamante','2020-02-20 14:08:12','2021-02-20 14:08:12',_binary '','2020-02-20 14:08:12',NULL),(58,'0lFkFkDb2E6BFxIWz2r8keaalf92KBM7eMfSCvEIFaQI38v62T','Familiar','Basicos','Trimestral','Oro','2023-06-29 16:06:48','2023-09-29 16:06:48',_binary '','2023-06-29 16:06:48',NULL),(59,'n5g6JmyK2YKNJg8RUZd6T7WmZRmbRKbFMUcfHHr55cLbEJHggw','Familiar','Nutriólogo','Semanal','Oro','2020-12-16 16:29:05','2020-12-23 16:29:05',_binary '','2020-12-16 16:29:05',NULL),(60,'P2FglSokurJjnYJJt9mlFhrjgm0ZUBftAy0nSdtH5mzJXBaZsi','Familiar','Coaching','Semestral','Oro','2022-06-11 15:37:07','2022-12-11 15:37:07',_binary '','2022-06-11 15:37:07',NULL),(61,'tcCuCDiyTNjc4KxqyuKjjDegEp7oCSx3E6zz7S3E6wiXUFDaU5','Empresarial','Completa','Mensual','Nuevo','2016-12-03 19:32:20','2017-01-03 19:32:20',_binary '','2016-12-03 19:32:20',NULL),(62,'HbOwagOgSDvEHBTFDc6S7Ytu2GjuzkZUClSk2bOv73XA6Ks0Dc','Empresarial','Nutriólogo','Anual','Plata','2022-05-17 17:23:08','2023-05-17 17:23:08',_binary '','2022-05-17 17:23:08',NULL),(63,'1LHe5JnJvmf90zPsPKhaYlP5ZFmNVfuEPdx5NIdUVRycl6vcuP','Empresarial','Completa','Semanal','Plata','2015-12-19 12:16:47','2015-12-26 12:16:47',_binary '','2015-12-19 12:16:47',NULL),(64,'el29CFusPMpHgeodX7H9GZQgPk8H5jmP60HunnMLt4XySMePqH','Empresarial','Nutriólogo','Semestral','Nuevo','2021-12-05 11:21:06','2022-06-05 11:21:06',_binary '','2021-12-05 11:21:06',NULL),(65,'XgqnANdFKIktqF3ikIDZ6ubqBLXwLdMi6DRqwk7BFvx98gUMbw','Empresarial','Coaching','Anual','Plata','2023-09-15 13:10:49','2024-09-15 13:10:49',_binary '','2023-09-15 13:10:49',NULL),(66,'oBQqCObuT2umlC5yx0p30Uy0nSfAcdvROtWfswfFC4wqwj1cV2','Empresarial','Completa','Trimestral','Diamante','2022-10-27 09:05:56','2023-01-27 09:05:56',_binary '','2022-10-27 09:05:56',NULL),(67,'M548pF7Az8WjJHlzSGJE4oLEWN8gWWQqCN67h2lB0d2yEB2r2U','Empresarial','Coaching','Trimestral','Oro','2018-04-08 14:22:41','2018-07-08 14:22:41',_binary '','2018-04-08 14:22:41',NULL),(68,'pBNcyeryqt7avZsi9QMklJE3ikNXo6nxzhEo21YN4WxTNmnOVd','Empresarial','Basicos','Trimestral','Oro','2023-01-19 13:38:41','2023-04-19 13:38:41',_binary '','2023-01-19 13:38:41',NULL),(69,'tKjlMRW8T1r8ovopVlZVEsntgUL6ePsOI5kp1TplwyfxYgpfZc','Empresarial','Coaching','Anual','Plata','2020-05-26 18:01:36','2021-05-26 18:01:36',_binary '','2020-05-26 18:01:36',NULL),(70,'aTX7IdV1ho4dSJ1VyYc7ZC5CObv0wzhIJuhVM9nteK320WFwCx','Empresarial','Completa','Semanal','Diamante','2020-08-22 14:20:48','2020-08-29 14:20:48',_binary '','2020-08-22 14:20:48',NULL),(71,'Bn4eYbXfph9Vb89lgjJLBHKAKXxOtVbbk6xngdgEwDB8QQHXII','Empresarial','Basicos','Trimestral','Plata','2023-02-23 10:42:14','2023-05-23 10:42:14',_binary '','2023-02-23 10:42:14',NULL),(72,'aTZfiIHlEfesyolwyfxYhuAuH10WHHq0JCXUGHtdGMQUY8LpNH','Empresarial','Coaching','Semestral','Nuevo','2021-07-20 08:51:22','2022-01-20 08:51:22',_binary '','2021-07-20 08:51:22',NULL),(73,'lti4r1NVcgHGmIwrEUAftDJKywWa0yMbzkXO8i3oOQPzpkrcFI','Empresarial','Basicos','Mensual','Oro','2022-10-07 13:17:32','2022-11-07 13:17:32',_binary '','2022-10-07 13:17:32',NULL),(74,'CDhvI24cMllJCUIOU8UbaiZ2dYegAa60IANcDxOqIktoyAfvNu','Empresarial','Basicos','Anual','Diamante','2020-12-05 10:03:19','2021-12-05 10:03:19',_binary '','2020-12-05 10:03:19',NULL),(75,'iWRsG5oJqWpg7LveCqib1BTISevRNpE3jmTpksi6CLYC9U3BOh','Empresarial','Nutriólogo','Diaria','Diamante','2023-04-29 16:20:56','2023-04-30 16:20:56',_binary '','2023-04-29 16:20:56',NULL),(76,'4fZc4MDQk8FVEtrLu9hZ3lARzfwSQBssYrlmNVcfEwCxPxcomB','Empresarial','Basicos','Diaria','Oro','2023-03-06 15:45:44','2023-03-07 15:45:44',_binary '','2023-03-06 15:45:44',NULL),(77,'FZWJR6XrnzGKG9JaFRfIPYmUuGXKS81IvmkyMdNh2lC3s42Vz2','Empresarial','Nutriólogo','Bimestral','Nuevo','2017-03-04 17:23:18','2017-05-04 17:23:18',_binary '','2017-03-04 17:23:18',NULL),(78,'LVn5koZLPSUSHTkXOczesAAb87eK6fURw3HjvApjkIyDyPw70F','Empresarial','Nutriólogo','Trimestral','Oro','2022-07-12 19:58:21','2022-10-12 19:58:21',_binary '','2022-07-12 19:58:21',NULL),(79,'DzX7F028AxTUQw4KAEwCA2q1O0AUPmnNSW8PI7t1D9QMoCSAfu','Empresarial','Coaching','Semanal','Plata','2016-11-16 17:41:57','2016-11-23 17:41:57',_binary '','2016-11-16 17:41:57',NULL),(80,'8Jha0yIWA4BPlc0p1Vy0lKF4oKAEvArpIlB0bTUUMdIYFtkebf','Empresarial','Nutriólogo','Mensual','Plata','2021-02-08 11:20:59','2021-03-08 11:20:59',_binary '','2021-02-08 11:20:59',NULL);
/*!40000 ALTER TABLE `membresias` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `membresias_AFTER_INSERT` AFTER INSERT ON `membresias` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "membresias",
        CONCAT_WS(" ","Se ha insertado una nueva AREA con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "CODIGO = ", NEW.codigo,
        "TIPO = ", NEW.tipo,
        "TIPO SERVICIOS = ", NEW.tipo_servicios,
        "TIPO PLAN = ",  NEW.tipo_plan,
        "NIVEL = ", NEW.nivel, 
        "FECHA INICIO = ", NEW.fecha_inicio,
        "FECHA FIN = ", NEW.fecha_fin,
        "ESTATUS = ", v_cadena_estatus,
        "FECHA REGISTRO = ", NEW.fecha_registro,
        "FECHA ACTUALIZACIÓN = ", NEW.fecha_actualizacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `membresias_AFTER_UPDATE` AFTER UPDATE ON `membresias` FOR EACH ROW BEGIN
	 -- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    
    -- Inicialización de las variables 
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Update",
        "membresias",
        CONCAT_WS(" ","Se han actualizado los datos de la MEMBRESIA con el ID: ",NEW.ID, 
        "con los siguientes datos:",
        "CODIGO = ", OLD.codigo, " cambio a " ,NEW.codigo,
        "TIPO = ",  OLD.tipo, " cambio a " ,NEW.tipo, 
		"TIPO SERVICIOS = ", OLD.tipo_servicios, " cambio a " , NEW.tipo_servicios,
        "TIPO PLAN = ", OLD.tipo_plan, " cambio a " , NEW.tipo_plan, 
        "NIVEL = ", OLD.nivel, " cambio a " , NEW.nivel,
        "FECHA INICIO = ",  OLD.fecha_inicio, " cambio a " ,NEW.fecha_inicio, 
        "FECHA FIN = ", OLD.fecha_fin, " cambio a " , NEW.fecha_fin,
        "ESTATUS = ",  v_cadena_estatus2, " cambio a " ,v_cadena_estatus,
        "FECHA REGISTRO = ",  OLD.fecha_registro, " cambio a " ,NEW.fecha_registro,
        "FECHA ACTUALIZACIÓN = ",  OLD.fecha_actualizacion, " cambio a " ,NEW.fecha_actualizacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `membresias_AFTER_DELETE` AFTER DELETE ON `membresias` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "membresias",
        CONCAT_WS(" ","Se ha eliminado una MEMBRESIA con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `membresias_usuarios`
--

DROP TABLE IF EXISTS `membresias_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membresias_usuarios` (
  `Membresia_ID` int unsigned NOT NULL COMMENT 'Descripción: Identificador único de la membresía,\nTipo: Numérico (Entero sin signo),\nNaturaleza: Cuantitativo,\nDominio: Números enteros positivos\n',
  `Usuarios_ID` int unsigned NOT NULL COMMENT 'Descripción: Identificador único del usuario,\nTipo: Numérico (Entero sin signo),\nNaturaleza: Cuantitativo,\nDominio: Números enteros positivos',
  `Fecha_Ultima_Visita` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Descripción: Fecha y hora de la última visita del usuario con esta membresía,\nTipo: Fecha y Hora,\nNaturaleza: Cuantitativo,\nDominio: Valores de fecha y hora válidos\n',
  `Estatus` bit(1) NOT NULL DEFAULT b'1' COMMENT 'Descripción:Indica si la asignación de la membresía al usuario está activa actualmente,\\nTipo: Bit (1 bit)\\nNaturaleza: Cualitativo\\nDominio: {1 (Activo), 0 (Inactivo)}\\n',
  PRIMARY KEY (`Membresia_ID`,`Usuarios_ID`),
  KEY `fk_usuario_2` (`Usuarios_ID`),
  CONSTRAINT `fk_membresia_ID` FOREIGN KEY (`Membresia_ID`) REFERENCES `membresias` (`ID`),
  CONSTRAINT `fk_usuario_2` FOREIGN KEY (`Usuarios_ID`) REFERENCES `usuarios` (`Persona_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Clasificación del Tipo de Tabla: Derivada,\nDescripción de la Tabla:La tabla membresias_usuarios registra las membresías asignadas a cada usuario del sistema. Contiene datos como el identificador de la membresía, el identificador del usuario, la fecha de la última visita del usuario con esa membresía y el estatus de la asignación (activa o inactiva).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membresias_usuarios`
--

LOCK TABLES `membresias_usuarios` WRITE;
/*!40000 ALTER TABLE `membresias_usuarios` DISABLE KEYS */;
INSERT INTO `membresias_usuarios` VALUES (1,101,'2024-01-07 14:40:26',_binary ''),(2,102,'2023-11-24 17:28:45',_binary ''),(3,103,'2024-01-02 19:26:08',_binary ''),(3,104,'2023-09-09 10:20:40',_binary ''),(3,105,'2023-02-02 13:29:07',_binary ''),(3,106,'2023-09-05 10:20:12',_binary ''),(3,107,'2022-10-08 18:47:22',_binary ''),(3,108,'2023-01-02 10:00:48',_binary ''),(3,109,'2023-12-23 09:11:38',_binary ''),(3,110,'2022-07-06 17:45:20',_binary ''),(3,111,'2020-12-29 10:50:44',_binary ''),(3,112,'2021-03-06 17:05:19',_binary ''),(3,113,'2024-02-24 16:09:22',_binary ''),(3,114,'2023-03-06 10:01:13',_binary ''),(3,115,'2021-07-07 19:02:56',_binary ''),(3,116,'2023-08-20 15:31:29',_binary ''),(3,117,'2020-10-26 19:29:09',_binary ''),(3,118,'2021-11-04 18:58:13',_binary ''),(3,119,'2022-10-02 09:51:22',_binary ''),(3,120,'2023-12-25 12:41:00',_binary ''),(3,121,'2023-11-04 14:19:59',_binary ''),(3,122,'2021-10-22 16:33:25',_binary ''),(3,123,'2024-02-14 19:32:04',_binary ''),(3,124,'2023-10-09 13:02:17',_binary ''),(3,125,'2024-02-13 09:57:29',_binary ''),(3,126,'2023-12-11 13:10:26',_binary ''),(3,127,'2020-12-02 16:49:52',_binary ''),(3,128,'2022-09-02 10:20:17',_binary ''),(4,129,'2021-09-20 08:47:19',_binary ''),(5,130,'2023-02-19 14:47:51',_binary ''),(5,131,'2024-02-02 13:18:14',_binary ''),(5,132,'2021-03-09 12:24:11',_binary ''),(5,133,'2024-01-17 10:48:10',_binary ''),(6,134,'2023-11-29 08:50:05',_binary ''),(6,135,'2023-06-24 09:27:03',_binary ''),(6,136,'2024-01-02 15:05:28',_binary ''),(6,137,'2023-11-15 16:59:18',_binary ''),(6,138,'2022-10-08 17:27:54',_binary ''),(6,139,'2022-05-09 09:00:06',_binary ''),(6,140,'2022-08-06 16:59:22',_binary ''),(6,141,'2024-02-17 19:26:36',_binary ''),(6,142,'2024-01-16 14:50:26',_binary ''),(6,143,'2022-07-12 16:22:26',_binary ''),(6,144,'2024-01-19 19:25:52',_binary ''),(6,145,'2023-12-06 14:48:24',_binary ''),(6,146,'2021-11-24 13:59:53',_binary ''),(6,147,'2024-01-13 10:29:13',_binary ''),(6,148,'2023-07-28 12:56:17',_binary ''),(6,149,'2024-01-08 08:03:43',_binary ''),(6,150,'2024-01-14 15:34:10',_binary ''),(6,151,'2023-08-30 18:35:45',_binary ''),(6,152,'2023-04-16 09:45:25',_binary ''),(6,153,'2024-01-01 12:28:48',_binary ''),(6,154,'2023-07-10 12:20:20',_binary ''),(6,155,'2023-12-21 12:26:31',_binary ''),(6,156,'2023-04-05 17:16:35',_binary ''),(6,157,'2023-08-27 18:09:42',_binary ''),(6,158,'2023-02-19 13:47:50',_binary ''),(6,159,'2022-05-20 17:14:28',_binary ''),(6,160,'2024-01-27 16:55:05',_binary ''),(6,161,'2020-04-02 15:23:12',_binary ''),(6,162,'2024-02-22 15:45:56',_binary ''),(6,163,'2021-12-22 11:51:28',_binary ''),(6,164,'2023-03-02 17:13:22',_binary ''),(6,165,'2022-11-25 08:47:23',_binary ''),(6,166,'2022-09-15 09:46:10',_binary ''),(6,167,'2021-08-27 09:48:41',_binary ''),(6,168,'2024-01-02 18:49:03',_binary ''),(6,169,'2023-04-17 18:22:07',_binary ''),(6,170,'2022-12-21 12:23:56',_binary ''),(6,171,'2023-08-18 17:37:18',_binary ''),(6,172,'2020-10-16 13:01:23',_binary ''),(6,173,'2024-02-20 19:44:13',_binary ''),(7,174,'2023-04-02 13:07:04',_binary ''),(7,175,'2024-02-12 10:26:39',_binary ''),(7,176,'2021-08-08 18:36:48',_binary ''),(7,177,'2023-07-11 18:55:31',_binary ''),(7,178,'2023-08-11 11:11:55',_binary ''),(8,179,'2020-04-28 10:59:41',_binary ''),(9,180,'2023-04-23 12:15:37',_binary ''),(9,181,'2023-08-22 16:43:04',_binary ''),(9,182,'2023-09-19 13:41:03',_binary ''),(9,183,'2022-11-01 13:56:55',_binary ''),(9,184,'2021-07-10 19:18:37',_binary ''),(9,185,'2023-03-21 16:46:08',_binary ''),(9,186,'2024-02-21 13:01:13',_binary ''),(9,187,'2023-12-12 08:36:54',_binary ''),(9,188,'2023-05-02 16:47:16',_binary ''),(9,189,'2024-01-17 16:53:01',_binary ''),(9,190,'2020-09-15 18:21:08',_binary ''),(9,191,'2021-07-17 08:54:33',_binary ''),(9,192,'2023-12-16 19:59:18',_binary ''),(9,193,'2023-11-18 10:09:54',_binary ''),(9,194,'2023-07-06 15:35:14',_binary ''),(9,195,'2020-02-26 16:37:52',_binary ''),(9,196,'2022-11-01 12:17:36',_binary ''),(9,197,'2022-05-18 15:19:36',_binary ''),(9,198,'2021-10-30 13:47:20',_binary ''),(9,199,'2024-01-30 11:21:21',_binary ''),(9,200,'2021-05-04 09:48:36',_binary ''),(9,201,'2024-01-30 11:17:41',_binary ''),(9,202,'2023-01-06 10:15:46',_binary ''),(9,203,'2022-01-06 11:11:22',_binary ''),(9,204,'2023-05-08 10:58:43',_binary ''),(9,205,'2021-04-10 17:20:13',_binary ''),(9,206,'2022-12-09 09:02:35',_binary ''),(9,207,'2023-10-30 13:23:36',_binary ''),(9,208,'2023-05-21 18:54:16',_binary ''),(9,209,'2022-11-02 14:59:46',_binary ''),(9,210,'2023-06-12 18:03:55',_binary ''),(9,211,'2024-01-11 13:50:18',_binary ''),(9,212,'2022-10-07 15:12:53',_binary ''),(9,213,'2022-01-03 13:49:30',_binary ''),(9,214,'2023-12-15 11:04:36',_binary ''),(9,215,'2024-02-06 11:55:38',_binary ''),(9,216,'2022-02-18 13:34:29',_binary ''),(9,217,'2023-05-16 14:16:06',_binary ''),(9,218,'2024-02-03 13:10:44',_binary ''),(10,219,'2023-03-01 15:06:08',_binary ''),(10,220,'2024-01-04 09:15:37',_binary ''),(10,221,'2023-09-05 19:52:34',_binary ''),(10,222,'2023-05-31 15:38:50',_binary ''),(10,223,'2023-01-06 09:43:51',_binary ''),(10,224,'2023-11-18 18:32:45',_binary ''),(10,225,'2022-11-14 11:41:14',_binary ''),(10,226,'2023-03-21 18:20:21',_binary ''),(10,227,'2021-12-23 12:06:33',_binary ''),(10,228,'2024-02-24 18:58:19',_binary ''),(10,229,'2022-11-23 12:02:40',_binary ''),(10,230,'2023-10-13 17:06:56',_binary ''),(10,231,'2023-11-04 17:33:32',_binary ''),(10,232,'2022-10-03 15:52:39',_binary ''),(10,233,'2024-02-10 11:52:19',_binary ''),(10,234,'2022-07-17 08:01:18',_binary ''),(10,235,'2023-05-23 09:14:06',_binary ''),(10,236,'2022-01-21 19:24:34',_binary ''),(10,237,'2023-12-26 13:00:31',_binary ''),(10,238,'2021-10-31 10:02:38',_binary ''),(10,239,'2022-11-29 08:09:23',_binary ''),(10,240,'2022-12-25 17:02:37',_binary ''),(10,241,'2023-11-23 10:17:48',_binary ''),(10,242,'2021-12-30 12:52:53',_binary ''),(10,243,'2023-12-27 19:49:25',_binary ''),(10,244,'2022-07-30 15:23:33',_binary ''),(10,245,'2024-02-16 15:01:43',_binary ''),(10,246,'2024-01-05 08:42:31',_binary ''),(10,247,'2022-06-03 13:49:04',_binary ''),(10,248,'2023-08-21 11:30:34',_binary ''),(10,249,'2023-07-14 17:37:40',_binary ''),(10,250,'2023-08-04 17:57:10',_binary ''),(10,251,'2023-10-08 15:59:45',_binary ''),(10,252,'2024-01-02 19:27:09',_binary ''),(10,253,'2023-12-26 19:25:19',_binary ''),(10,254,'2024-01-14 18:17:21',_binary ''),(10,255,'2023-07-10 19:15:11',_binary ''),(10,256,'2021-12-29 12:46:26',_binary ''),(10,257,'2024-01-06 17:24:15',_binary ''),(10,258,'2024-01-15 09:39:25',_binary ''),(10,259,'2023-01-17 08:22:57',_binary ''),(10,260,'2021-11-09 13:38:04',_binary ''),(10,261,'2023-02-12 08:42:17',_binary ''),(10,262,'2024-01-01 18:26:43',_binary ''),(10,263,'2021-02-11 10:55:29',_binary ''),(11,264,'2023-01-14 10:55:30',_binary ''),(11,265,'2022-04-08 15:04:32',_binary ''),(11,266,'2020-08-04 11:58:11',_binary ''),(11,267,'2022-02-28 17:29:15',_binary ''),(11,268,'2021-11-27 12:48:44',_binary ''),(11,269,'2023-03-20 10:18:00',_binary ''),(11,270,'2022-11-29 15:19:50',_binary ''),(11,271,'2022-11-11 18:57:09',_binary ''),(11,272,'2023-09-15 13:59:28',_binary ''),(11,273,'2021-12-22 13:03:32',_binary ''),(11,274,'2023-12-14 14:33:16',_binary ''),(11,275,'2023-10-03 10:09:49',_binary ''),(11,276,'2023-03-23 08:00:35',_binary ''),(11,277,'2022-09-15 19:16:45',_binary ''),(11,278,'2023-11-24 19:08:50',_binary ''),(11,279,'2021-04-26 10:54:28',_binary ''),(11,280,'2022-12-19 14:52:49',_binary ''),(11,281,'2021-10-27 17:27:24',_binary ''),(12,282,'2023-04-07 16:46:08',_binary ''),(13,283,'2024-01-28 17:16:49',_binary ''),(13,284,'2023-03-05 17:53:12',_binary ''),(13,285,'2023-07-13 15:04:34',_binary ''),(13,286,'2023-12-06 16:47:10',_binary ''),(13,287,'2022-05-21 19:12:20',_binary ''),(13,288,'2023-05-30 17:10:21',_binary ''),(13,289,'2023-09-20 14:10:42',_binary ''),(13,290,'2024-01-19 11:13:28',_binary ''),(13,291,'2023-01-16 13:29:04',_binary ''),(13,292,'2023-04-15 16:14:24',_binary ''),(13,293,'2022-10-10 16:03:49',_binary ''),(13,294,'2021-08-01 14:37:11',_binary ''),(13,295,'2023-08-21 19:21:19',_binary ''),(13,296,'2021-12-04 17:54:25',_binary ''),(13,297,'2023-02-12 17:54:06',_binary ''),(13,298,'2023-02-14 14:44:19',_binary ''),(13,299,'2021-05-29 14:22:10',_binary ''),(13,300,'2023-12-11 11:19:05',_binary ''),(13,301,'2022-08-23 11:30:22',_binary ''),(14,302,'2024-01-22 08:20:40',_binary ''),(14,303,'2021-10-24 08:31:34',_binary ''),(14,304,'2021-09-24 16:59:41',_binary ''),(14,305,'2023-06-06 16:23:59',_binary ''),(14,306,'2023-05-03 16:38:30',_binary ''),(14,307,'2021-12-23 12:49:14',_binary ''),(14,308,'2024-02-21 09:24:00',_binary ''),(14,309,'2021-04-27 15:50:28',_binary ''),(14,310,'2022-06-10 12:37:22',_binary ''),(14,311,'2023-02-24 19:35:54',_binary ''),(14,312,'2024-02-01 13:03:55',_binary ''),(14,313,'2024-01-17 08:07:11',_binary ''),(14,314,'2023-12-08 18:48:55',_binary ''),(14,315,'2023-07-13 18:22:19',_binary ''),(14,316,'2023-05-02 08:09:41',_binary ''),(15,317,'2023-12-03 19:52:50',_binary ''),(15,318,'2023-11-13 14:27:18',_binary ''),(15,319,'2023-12-29 19:45:14',_binary ''),(15,320,'2023-12-04 08:01:36',_binary ''),(16,321,'2024-02-07 12:49:42',_binary ''),(16,322,'2023-10-07 17:40:26',_binary ''),(16,323,'2023-03-09 18:08:50',_binary ''),(16,324,'2023-10-26 08:52:18',_binary ''),(16,325,'2022-05-22 16:02:20',_binary ''),(16,326,'2022-04-05 08:20:42',_binary ''),(16,327,'2024-02-21 16:52:35',_binary ''),(16,328,'2023-08-17 13:22:23',_binary ''),(16,329,'2023-06-15 14:08:04',_binary ''),(16,330,'2023-12-23 18:31:20',_binary ''),(16,331,'2024-02-27 13:38:09',_binary ''),(16,332,'2022-01-17 14:49:21',_binary ''),(16,333,'2023-11-28 09:34:44',_binary ''),(16,334,'2023-03-11 14:59:41',_binary ''),(16,335,'2023-12-13 08:49:20',_binary ''),(16,336,'2022-07-07 18:44:19',_binary ''),(16,337,'2021-12-05 08:23:29',_binary ''),(16,338,'2023-10-08 08:12:15',_binary ''),(16,339,'2022-07-05 16:20:52',_binary ''),(16,340,'2020-12-22 11:16:52',_binary ''),(16,341,'2021-11-17 10:04:46',_binary ''),(16,342,'2022-11-26 13:46:09',_binary ''),(16,343,'2022-01-16 10:52:39',_binary ''),(16,344,'2022-09-01 15:56:05',_binary ''),(16,345,'2022-09-14 18:36:49',_binary ''),(16,346,'2023-06-16 11:19:06',_binary ''),(16,347,'2023-06-02 17:17:08',_binary ''),(16,348,'2023-01-19 10:41:04',_binary ''),(16,349,'2023-06-28 09:04:22',_binary ''),(16,350,'2023-06-21 17:53:33',_binary ''),(16,351,'2023-02-27 13:25:05',_binary ''),(16,352,'2022-05-23 15:28:28',_binary ''),(16,353,'2022-06-21 19:25:13',_binary ''),(16,354,'2021-06-04 19:46:18',_binary ''),(16,355,'2024-01-08 17:18:14',_binary ''),(17,356,'2023-11-17 08:13:41',_binary ''),(18,357,'2022-04-29 19:36:03',_binary ''),(18,358,'2022-10-24 13:07:50',_binary ''),(19,359,'2023-07-18 18:40:39',_binary ''),(20,360,'2023-09-27 17:14:19',_binary ''),(21,361,'2023-08-30 11:14:58',_binary ''),(22,362,'2023-09-07 18:59:00',_binary ''),(23,363,'2022-01-03 13:44:47',_binary ''),(24,364,'2022-11-06 08:17:21',_binary ''),(25,365,'2023-12-27 15:46:24',_binary ''),(26,366,'2022-05-02 09:43:55',_binary ''),(27,367,'2022-08-10 13:41:05',_binary ''),(28,368,'2023-05-03 19:14:49',_binary ''),(29,369,'2022-01-08 18:37:49',_binary ''),(30,370,'2023-08-30 09:45:32',_binary ''),(31,371,'2024-02-11 16:26:21',_binary ''),(32,372,'2021-06-11 09:48:19',_binary ''),(33,373,'2024-02-27 12:38:01',_binary ''),(34,374,'2023-09-11 19:35:16',_binary ''),(35,375,'2024-01-27 15:43:09',_binary ''),(36,376,'2020-12-08 13:03:47',_binary ''),(37,377,'2023-05-09 10:19:55',_binary ''),(38,378,'2024-01-03 14:32:07',_binary ''),(39,379,'2021-07-14 17:03:32',_binary ''),(40,380,'2023-09-30 15:04:57',_binary ''),(41,381,'2023-05-08 11:24:34',_binary ''),(41,382,'2024-02-23 08:53:56',_binary ''),(42,383,'2020-07-25 13:46:22',_binary ''),(42,384,'2023-10-23 12:03:24',_binary ''),(42,385,'2023-12-15 17:33:04',_binary ''),(43,386,'2023-04-28 19:54:09',_binary ''),(43,387,'2024-01-19 14:50:00',_binary ''),(43,388,'2024-02-12 19:08:55',_binary ''),(44,389,'2023-06-28 10:53:09',_binary ''),(44,390,'2024-02-10 10:21:56',_binary ''),(44,391,'2022-12-13 13:21:56',_binary ''),(45,392,'2024-02-22 09:05:05',_binary ''),(45,393,'2023-04-13 11:17:40',_binary ''),(45,394,'2022-12-01 10:30:03',_binary ''),(46,395,'2022-02-14 11:59:03',_binary ''),(47,396,'2024-02-04 14:50:40',_binary ''),(47,397,'2020-09-15 19:43:55',_binary ''),(47,398,'2023-07-28 19:19:55',_binary ''),(47,399,'2022-10-08 15:20:23',_binary ''),(48,400,'2022-08-27 09:10:31',_binary ''),(48,401,'2022-09-22 08:35:50',_binary ''),(48,402,'2021-09-24 12:28:54',_binary ''),(48,403,'2024-01-11 13:52:38',_binary ''),(48,404,'2024-02-12 13:59:53',_binary ''),(49,405,'2023-09-27 12:32:15',_binary ''),(49,406,'2021-05-20 17:36:26',_binary ''),(50,407,'2023-05-01 18:45:53',_binary ''),(50,408,'2022-07-10 17:42:14',_binary ''),(50,409,'2023-05-13 11:17:17',_binary ''),(51,410,'2024-02-14 14:03:05',_binary ''),(51,411,'2024-01-28 14:02:03',_binary ''),(52,412,'2023-07-08 18:11:27',_binary ''),(52,413,'2024-02-22 12:59:35',_binary ''),(53,414,'2023-09-08 11:56:00',_binary ''),(53,415,'2024-02-20 13:49:15',_binary ''),(53,416,'2022-08-31 14:06:59',_binary ''),(53,417,'2020-11-12 10:33:29',_binary ''),(54,418,'2024-01-13 16:59:09',_binary ''),(54,419,'2022-06-16 12:24:00',_binary ''),(54,420,'2021-10-11 16:56:19',_binary ''),(54,421,'2023-01-26 17:19:59',_binary ''),(54,422,'2023-05-13 18:12:27',_binary ''),(55,423,'2023-07-28 13:59:35',_binary ''),(55,424,'2023-04-04 17:38:21',_binary ''),(55,425,'2024-02-04 10:08:57',_binary ''),(56,426,'2023-11-08 11:44:58',_binary ''),(57,427,'2023-12-03 13:44:10',_binary ''),(57,428,'2024-01-11 16:33:28',_binary ''),(57,429,'2023-11-01 17:45:45',_binary ''),(57,430,'2022-12-28 11:17:16',_binary ''),(58,431,'2022-05-02 11:35:40',_binary ''),(58,432,'2023-08-03 09:54:23',_binary ''),(59,433,'2022-10-14 16:24:47',_binary ''),(59,434,'2023-11-21 19:04:26',_binary ''),(59,435,'2021-12-16 19:41:16',_binary ''),(59,436,'2023-10-24 14:47:32',_binary ''),(60,437,'2023-01-09 17:07:28',_binary ''),(60,438,'2023-12-20 14:30:49',_binary ''),(60,439,'2023-03-25 13:39:59',_binary ''),(61,440,'2022-07-29 11:25:50',_binary ''),(61,441,'2023-05-30 19:23:55',_binary ''),(61,442,'2023-04-26 12:55:13',_binary ''),(61,443,'2023-08-18 08:09:52',_binary ''),(61,444,'2023-11-06 18:47:51',_binary ''),(61,445,'2023-11-18 13:46:35',_binary ''),(61,446,'2023-03-26 09:17:06',_binary ''),(61,447,'2022-09-03 16:01:40',_binary ''),(61,448,'2023-05-22 11:28:06',_binary ''),(61,449,'2022-02-20 10:35:51',_binary ''),(61,450,'2020-10-08 17:07:19',_binary ''),(61,451,'2023-06-05 15:21:20',_binary ''),(61,452,'2023-09-27 08:00:12',_binary ''),(61,453,'2022-12-18 13:19:51',_binary ''),(61,454,'2023-04-09 08:26:06',_binary ''),(62,455,'2021-11-03 15:46:43',_binary ''),(62,456,'2024-02-17 09:14:55',_binary ''),(62,457,'2024-02-22 14:33:00',_binary ''),(62,458,'2023-12-06 14:07:03',_binary ''),(62,459,'2021-05-25 17:31:52',_binary ''),(62,460,'2021-09-20 17:54:02',_binary ''),(62,461,'2023-03-06 17:48:03',_binary ''),(62,462,'2020-10-13 12:50:40',_binary ''),(62,463,'2023-05-26 12:02:03',_binary ''),(62,464,'2022-11-07 12:37:15',_binary ''),(62,465,'2023-05-01 10:55:21',_binary ''),(62,466,'2022-05-01 10:11:24',_binary ''),(62,467,'2021-09-10 13:11:29',_binary ''),(62,468,'2023-11-26 19:43:14',_binary ''),(62,469,'2023-04-19 16:09:44',_binary ''),(62,470,'2024-01-23 14:15:44',_binary ''),(62,471,'2024-02-13 15:26:49',_binary ''),(62,472,'2021-06-29 14:15:15',_binary ''),(62,473,'2021-10-19 10:01:13',_binary ''),(62,474,'2021-11-21 15:45:45',_binary ''),(62,475,'2023-12-27 17:29:42',_binary ''),(62,476,'2024-02-08 11:34:59',_binary ''),(62,477,'2023-04-19 13:52:07',_binary ''),(62,478,'2022-04-02 10:33:03',_binary ''),(62,479,'2023-09-14 13:01:22',_binary ''),(62,480,'2022-08-05 09:41:41',_binary ''),(62,481,'2023-10-03 18:50:11',_binary ''),(62,482,'2023-05-03 17:47:51',_binary ''),(62,483,'2023-04-30 13:28:26',_binary ''),(62,484,'2023-12-26 10:46:51',_binary ''),(62,485,'2022-04-28 09:46:54',_binary ''),(62,486,'2021-06-14 10:17:21',_binary ''),(62,487,'2023-08-27 16:38:33',_binary ''),(62,488,'2023-09-10 09:01:17',_binary ''),(62,489,'2022-10-30 13:01:50',_binary ''),(62,490,'2023-09-12 11:50:38',_binary ''),(62,491,'2023-10-21 12:46:59',_binary ''),(62,492,'2023-10-01 11:07:51',_binary ''),(62,493,'2023-09-08 16:12:01',_binary ''),(62,494,'2022-11-11 17:59:36',_binary ''),(63,495,'2024-02-11 13:09:43',_binary ''),(63,496,'2023-11-29 11:03:27',_binary ''),(63,497,'2023-08-30 18:23:38',_binary ''),(63,498,'2023-09-27 11:00:02',_binary ''),(63,499,'2023-12-23 12:28:49',_binary ''),(63,500,'2023-11-21 15:24:58',_binary ''),(63,501,'2023-12-04 11:36:33',_binary ''),(63,502,'2023-08-11 15:51:44',_binary ''),(63,503,'2022-09-18 11:04:20',_binary ''),(63,504,'2023-11-20 09:57:18',_binary ''),(63,505,'2023-05-14 14:04:41',_binary ''),(63,506,'2023-06-27 18:14:03',_binary ''),(63,507,'2023-03-23 19:57:31',_binary ''),(63,508,'2023-12-17 19:49:38',_binary ''),(63,509,'2020-02-16 17:23:11',_binary ''),(63,510,'2023-03-19 19:16:56',_binary ''),(63,511,'2023-02-11 19:00:00',_binary ''),(63,512,'2022-11-26 14:16:41',_binary ''),(63,513,'2023-12-14 10:57:35',_binary ''),(63,514,'2022-03-09 14:07:34',_binary ''),(63,515,'2021-03-05 09:55:15',_binary ''),(63,516,'2024-02-09 12:37:54',_binary ''),(63,517,'2024-02-13 14:32:16',_binary ''),(63,518,'2023-02-02 08:00:12',_binary ''),(63,519,'2022-06-09 17:38:13',_binary ''),(63,520,'2023-03-29 18:10:50',_binary ''),(63,521,'2022-05-17 16:16:30',_binary ''),(63,522,'2024-01-05 14:30:39',_binary ''),(63,523,'2021-01-20 17:13:50',_binary ''),(63,524,'2021-07-21 13:16:32',_binary ''),(63,525,'2022-07-11 13:34:35',_binary ''),(63,526,'2023-02-25 11:42:32',_binary ''),(63,527,'2023-10-27 17:47:46',_binary ''),(63,528,'2024-01-18 09:30:40',_binary ''),(63,529,'2022-08-06 11:10:23',_binary ''),(63,530,'2024-01-12 17:03:38',_binary ''),(63,531,'2023-06-12 12:33:10',_binary ''),(63,532,'2023-11-30 11:16:53',_binary ''),(63,533,'2023-12-21 10:49:09',_binary ''),(63,534,'2023-12-21 15:46:26',_binary ''),(63,535,'2023-05-28 16:37:51',_binary ''),(64,536,'2023-04-21 17:50:18',_binary ''),(64,537,'2024-02-25 18:23:06',_binary ''),(64,538,'2023-10-03 09:35:21',_binary ''),(64,539,'2022-08-26 11:05:16',_binary ''),(64,540,'2023-11-27 17:38:12',_binary ''),(64,541,'2023-09-18 12:12:21',_binary ''),(64,542,'2023-12-21 10:57:14',_binary ''),(64,543,'2022-10-14 12:45:32',_binary ''),(64,544,'2022-09-29 10:08:33',_binary ''),(64,545,'2023-06-20 18:31:05',_binary ''),(64,546,'2023-02-02 16:53:08',_binary ''),(64,547,'2021-02-25 18:23:03',_binary ''),(64,548,'2022-09-08 13:51:41',_binary ''),(64,549,'2023-07-14 12:41:20',_binary ''),(64,550,'2023-06-24 08:47:50',_binary ''),(65,551,'2021-07-14 13:49:01',_binary ''),(65,552,'2022-09-20 15:02:20',_binary ''),(65,553,'2023-09-26 17:35:52',_binary ''),(65,554,'2023-06-28 18:02:16',_binary ''),(65,555,'2023-12-24 19:36:43',_binary ''),(65,556,'2022-07-23 18:05:31',_binary ''),(65,557,'2024-01-14 10:00:24',_binary ''),(65,558,'2024-01-08 09:22:55',_binary ''),(65,559,'2022-09-01 12:41:36',_binary ''),(65,560,'2023-01-13 08:54:44',_binary ''),(65,561,'2023-08-25 14:56:17',_binary ''),(65,562,'2021-06-21 15:49:19',_binary ''),(65,563,'2023-01-11 19:27:32',_binary ''),(65,564,'2023-02-18 16:59:44',_binary ''),(65,565,'2023-11-08 18:55:16',_binary ''),(65,566,'2022-07-17 09:43:53',_binary ''),(65,567,'2023-02-12 14:32:03',_binary ''),(65,568,'2023-11-23 14:16:34',_binary ''),(65,569,'2021-10-15 15:21:14',_binary ''),(65,570,'2023-10-06 17:03:47',_binary ''),(65,571,'2023-01-22 08:42:47',_binary ''),(65,572,'2021-07-16 14:35:57',_binary ''),(65,573,'2023-03-13 11:11:40',_binary ''),(65,574,'2023-05-20 14:26:45',_binary ''),(65,575,'2024-01-26 14:40:05',_binary ''),(65,576,'2024-01-04 09:13:07',_binary ''),(65,577,'2023-08-09 13:09:41',_binary ''),(65,578,'2022-12-05 17:05:56',_binary ''),(65,579,'2023-02-25 10:52:25',_binary ''),(65,580,'2024-01-22 12:27:15',_binary ''),(65,581,'2022-09-29 12:34:28',_binary ''),(65,582,'2021-05-29 10:44:03',_binary ''),(65,583,'2023-02-09 08:44:02',_binary ''),(65,584,'2022-03-24 19:03:22',_binary ''),(65,585,'2021-12-09 10:07:22',_binary ''),(65,586,'2022-04-09 17:50:38',_binary ''),(65,587,'2024-02-18 19:50:10',_binary ''),(65,588,'2024-01-18 13:25:14',_binary ''),(65,589,'2020-07-22 15:42:14',_binary ''),(65,590,'2024-01-27 13:39:14',_binary ''),(65,591,'2020-11-06 18:31:58',_binary ''),(65,592,'2024-01-12 17:42:38',_binary ''),(65,593,'2023-09-28 19:08:25',_binary ''),(65,594,'2023-11-10 15:45:19',_binary ''),(65,595,'2022-05-25 12:01:34',_binary ''),(66,596,'2022-10-16 12:13:53',_binary ''),(66,597,'2023-09-24 10:02:32',_binary ''),(66,598,'2023-09-20 17:32:39',_binary ''),(66,599,'2022-05-07 13:53:53',_binary ''),(66,600,'2021-01-28 11:59:08',_binary ''),(66,601,'2021-10-22 08:23:55',_binary ''),(66,602,'2021-10-23 10:34:28',_binary ''),(66,603,'2023-08-01 14:36:01',_binary ''),(66,604,'2023-07-13 17:01:18',_binary ''),(66,605,'2023-08-24 19:11:28',_binary ''),(66,606,'2021-02-20 14:10:12',_binary ''),(66,607,'2023-09-25 14:45:21',_binary ''),(66,608,'2023-11-03 12:11:33',_binary ''),(66,609,'2024-02-25 15:21:07',_binary ''),(66,610,'2023-11-17 08:02:27',_binary ''),(66,611,'2023-12-01 09:00:35',_binary ''),(66,612,'2022-12-04 15:13:49',_binary ''),(66,613,'2022-06-17 11:24:10',_binary ''),(66,614,'2023-12-04 11:24:09',_binary ''),(66,615,'2023-10-09 15:54:12',_binary ''),(66,616,'2023-07-22 14:22:02',_binary ''),(67,617,'2022-11-30 16:47:12',_binary ''),(67,618,'2022-10-29 10:46:18',_binary ''),(67,619,'2020-11-03 15:52:43',_binary ''),(67,620,'2024-02-26 12:04:59',_binary ''),(67,621,'2023-11-24 08:34:29',_binary ''),(67,622,'2022-07-26 17:27:33',_binary ''),(67,623,'2022-08-11 18:58:18',_binary ''),(67,624,'2024-01-21 09:54:02',_binary ''),(67,625,'2023-06-07 15:50:34',_binary ''),(67,626,'2023-01-02 16:32:39',_binary ''),(67,627,'2023-10-19 10:12:53',_binary ''),(67,628,'2021-11-10 15:24:36',_binary ''),(67,629,'2021-11-20 13:13:25',_binary ''),(67,630,'2024-02-24 10:49:38',_binary ''),(67,631,'2022-11-25 19:46:10',_binary ''),(67,632,'2022-04-02 11:07:01',_binary ''),(67,633,'2022-10-28 11:39:00',_binary ''),(67,634,'2021-03-30 17:02:16',_binary ''),(67,635,'2022-12-12 13:43:56',_binary ''),(67,636,'2022-06-20 09:53:40',_binary ''),(67,637,'2024-02-11 17:02:20',_binary ''),(67,638,'2023-02-07 13:32:32',_binary ''),(67,639,'2023-05-06 10:07:11',_binary ''),(67,640,'2022-01-25 08:54:25',_binary ''),(67,641,'2022-09-05 17:44:52',_binary ''),(67,642,'2022-02-07 09:37:25',_binary ''),(67,643,'2023-10-12 16:48:09',_binary ''),(67,644,'2023-09-20 08:13:23',_binary ''),(67,645,'2023-06-14 14:59:16',_binary ''),(67,646,'2023-01-13 19:10:17',_binary ''),(67,647,'2023-05-16 13:36:58',_binary ''),(67,648,'2023-12-30 19:33:27',_binary ''),(67,649,'2024-02-03 15:23:18',_binary ''),(67,650,'2023-11-15 08:17:40',_binary ''),(67,651,'2022-05-27 11:38:48',_binary ''),(67,652,'2023-03-30 17:21:47',_binary ''),(67,653,'2022-12-17 08:20:47',_binary ''),(67,654,'2023-03-09 14:52:18',_binary ''),(67,655,'2023-05-03 17:50:49',_binary ''),(67,656,'2023-07-07 17:46:44',_binary ''),(67,657,'2023-08-08 10:47:34',_binary ''),(68,658,'2023-08-30 16:26:42',_binary ''),(68,659,'2023-02-25 19:13:51',_binary ''),(68,660,'2023-01-15 10:47:51',_binary ''),(68,661,'2023-10-24 14:55:12',_binary ''),(68,662,'2023-08-21 10:17:52',_binary ''),(68,663,'2023-12-01 09:03:04',_binary ''),(68,664,'2023-11-30 18:17:47',_binary ''),(68,665,'2024-02-09 12:29:46',_binary ''),(68,666,'2020-12-01 10:03:28',_binary ''),(68,667,'2022-04-24 18:57:45',_binary ''),(68,668,'2023-11-21 19:37:47',_binary ''),(68,669,'2023-08-12 19:23:45',_binary ''),(68,670,'2021-07-12 08:55:56',_binary ''),(68,671,'2023-12-24 10:41:06',_binary ''),(68,672,'2021-12-26 10:15:59',_binary ''),(68,673,'2023-11-19 18:40:21',_binary ''),(68,674,'2022-09-20 18:28:14',_binary ''),(68,675,'2023-06-16 10:04:45',_binary ''),(68,676,'2023-11-24 11:44:32',_binary ''),(68,677,'2023-07-15 15:12:33',_binary ''),(68,678,'2023-11-26 17:01:17',_binary ''),(68,679,'2022-10-27 14:08:34',_binary ''),(68,680,'2022-12-15 12:22:03',_binary ''),(68,681,'2022-10-30 17:48:21',_binary ''),(68,682,'2022-11-04 13:40:57',_binary ''),(68,683,'2021-03-04 17:48:24',_binary ''),(68,684,'2022-06-21 11:54:36',_binary ''),(68,685,'2022-04-02 12:39:31',_binary ''),(69,686,'2021-03-24 09:50:21',_binary ''),(69,687,'2023-09-04 14:06:08',_binary ''),(69,688,'2022-05-31 09:31:06',_binary ''),(69,689,'2023-06-30 15:58:58',_binary ''),(69,690,'2023-10-05 10:21:05',_binary ''),(69,691,'2023-01-30 16:29:25',_binary ''),(69,692,'2023-04-03 18:56:45',_binary ''),(69,693,'2022-06-04 19:57:18',_binary ''),(69,694,'2022-04-22 18:55:53',_binary ''),(69,695,'2023-05-14 09:37:40',_binary ''),(69,696,'2022-01-03 11:04:09',_binary ''),(69,697,'2023-09-22 15:34:35',_binary ''),(69,698,'2023-12-27 18:58:53',_binary ''),(69,699,'2023-01-07 16:40:43',_binary ''),(69,700,'2024-02-20 14:13:41',_binary ''),(69,701,'2023-09-23 17:12:33',_binary ''),(69,702,'2021-05-06 16:34:05',_binary ''),(69,703,'2023-10-22 08:38:37',_binary ''),(69,704,'2022-09-28 08:17:55',_binary ''),(69,705,'2023-10-02 19:33:53',_binary ''),(69,706,'2023-12-03 12:31:53',_binary ''),(69,707,'2023-08-20 16:58:59',_binary ''),(69,708,'2023-03-20 08:44:06',_binary ''),(69,709,'2024-01-24 12:11:41',_binary ''),(69,710,'2023-11-23 13:32:13',_binary ''),(69,711,'2024-02-16 18:51:08',_binary ''),(69,712,'2023-02-25 16:36:05',_binary ''),(70,713,'2022-07-28 12:42:56',_binary ''),(70,714,'2023-05-02 18:42:52',_binary ''),(70,715,'2023-11-26 18:34:02',_binary ''),(70,716,'2022-07-02 14:09:16',_binary ''),(70,717,'2023-02-14 18:59:02',_binary ''),(70,718,'2022-07-15 08:53:28',_binary ''),(70,719,'2022-06-15 18:24:01',_binary ''),(70,720,'2023-08-29 09:57:07',_binary ''),(70,721,'2024-02-17 12:59:17',_binary ''),(70,722,'2023-12-31 09:30:07',_binary ''),(70,723,'2022-10-17 17:57:59',_binary ''),(70,724,'2023-09-14 17:14:25',_binary ''),(70,725,'2023-12-09 09:27:13',_binary ''),(70,726,'2024-02-05 14:36:36',_binary ''),(70,727,'2022-04-13 18:34:45',_binary ''),(71,728,'2024-01-02 13:04:11',_binary ''),(71,729,'2022-06-21 08:36:42',_binary ''),(71,730,'2020-07-01 18:33:32',_binary ''),(71,731,'2023-01-23 09:06:13',_binary ''),(71,732,'2023-02-21 12:58:54',_binary ''),(71,733,'2024-01-23 12:16:21',_binary ''),(71,734,'2023-07-15 10:37:28',_binary ''),(71,735,'2022-08-02 17:04:27',_binary ''),(71,736,'2023-01-12 18:42:50',_binary ''),(71,737,'2023-11-24 10:23:27',_binary ''),(71,738,'2023-03-21 11:21:55',_binary ''),(71,739,'2023-12-02 16:34:02',_binary ''),(71,740,'2023-12-18 14:01:55',_binary ''),(71,741,'2022-11-06 15:37:19',_binary ''),(71,742,'2023-06-04 11:40:58',_binary ''),(71,743,'2023-10-20 14:18:07',_binary ''),(71,744,'2022-12-16 11:20:04',_binary ''),(71,745,'2023-03-12 17:34:42',_binary ''),(71,746,'2022-02-16 09:05:02',_binary ''),(71,747,'2020-11-07 16:33:49',_binary ''),(71,748,'2022-11-26 12:53:34',_binary ''),(71,749,'2022-11-11 14:29:15',_binary ''),(71,750,'2023-12-07 15:04:25',_binary ''),(71,751,'2023-08-03 14:51:23',_binary ''),(71,752,'2023-06-22 12:44:21',_binary ''),(71,753,'2022-09-15 12:12:03',_binary ''),(71,754,'2022-10-19 09:17:16',_binary ''),(71,755,'2023-07-16 13:36:32',_binary ''),(71,756,'2020-11-27 09:14:17',_binary ''),(71,757,'2023-06-24 09:51:28',_binary ''),(71,758,'2023-05-27 10:16:53',_binary ''),(71,759,'2020-06-21 11:13:08',_binary ''),(71,760,'2023-05-18 09:34:02',_binary ''),(71,761,'2022-01-10 19:55:45',_binary ''),(71,762,'2023-07-19 16:32:15',_binary ''),(71,763,'2022-10-02 19:19:18',_binary ''),(71,764,'2021-05-14 09:28:47',_binary ''),(71,765,'2022-10-25 13:04:19',_binary ''),(71,766,'2023-02-02 12:13:48',_binary ''),(71,767,'2023-04-27 08:34:47',_binary ''),(71,768,'2023-04-05 19:40:59',_binary ''),(71,769,'2021-07-27 15:22:26',_binary ''),(71,770,'2023-04-13 10:50:42',_binary ''),(72,771,'2023-10-10 12:05:22',_binary ''),(72,772,'2024-02-23 10:10:39',_binary ''),(72,773,'2023-12-18 18:49:12',_binary ''),(72,774,'2024-02-01 17:10:27',_binary ''),(72,775,'2021-11-23 18:55:42',_binary ''),(72,776,'2023-05-06 18:58:45',_binary ''),(72,777,'2023-03-09 18:20:41',_binary ''),(72,778,'2022-06-11 11:25:25',_binary ''),(72,779,'2023-12-25 17:30:16',_binary ''),(72,780,'2020-12-19 09:51:28',_binary ''),(73,781,'2023-03-24 19:31:02',_binary ''),(73,782,'2023-01-15 14:30:15',_binary ''),(73,783,'2024-02-19 13:57:13',_binary ''),(73,784,'2024-01-07 13:36:40',_binary ''),(73,785,'2023-10-15 11:29:45',_binary ''),(73,786,'2022-07-02 17:10:46',_binary ''),(73,787,'2023-06-25 18:38:21',_binary ''),(73,788,'2023-11-13 15:23:11',_binary ''),(73,789,'2022-11-29 13:42:43',_binary ''),(73,790,'2023-06-29 13:35:37',_binary ''),(73,791,'2023-09-07 13:54:29',_binary ''),(74,792,'2023-12-16 19:54:11',_binary ''),(74,793,'2022-04-21 14:12:46',_binary ''),(74,794,'2021-10-23 18:35:33',_binary ''),(74,795,'2024-02-24 11:39:04',_binary ''),(74,796,'2023-11-24 18:56:37',_binary ''),(74,797,'2022-01-19 09:53:54',_binary ''),(74,798,'2024-01-21 14:12:47',_binary ''),(74,799,'2024-01-23 08:26:25',_binary ''),(74,800,'2022-10-22 16:00:38',_binary ''),(74,801,'2020-08-19 16:35:52',_binary ''),(74,802,'2023-11-12 13:23:16',_binary ''),(74,803,'2023-10-27 08:14:48',_binary ''),(74,804,'2023-12-09 08:18:41',_binary ''),(74,805,'2022-05-11 18:42:15',_binary ''),(74,806,'2022-09-16 13:16:50',_binary ''),(74,807,'2023-08-27 17:36:11',_binary ''),(74,808,'2023-09-20 10:16:26',_binary ''),(74,809,'2022-06-24 15:28:08',_binary ''),(74,810,'2023-08-26 16:04:42',_binary ''),(74,811,'2023-12-15 13:55:32',_binary ''),(74,812,'2023-08-03 08:18:34',_binary ''),(74,813,'2024-01-10 16:59:50',_binary ''),(74,814,'2024-01-09 10:17:26',_binary ''),(74,815,'2024-01-16 17:20:47',_binary ''),(74,816,'2024-01-18 14:25:27',_binary ''),(74,817,'2024-02-24 19:08:39',_binary ''),(74,818,'2024-02-24 08:42:05',_binary ''),(74,819,'2022-03-28 13:50:20',_binary ''),(74,820,'2024-02-27 17:02:31',_binary ''),(74,821,'2023-06-10 13:54:59',_binary ''),(74,822,'2023-07-25 14:01:34',_binary ''),(74,823,'2023-10-25 10:01:01',_binary ''),(74,824,'2023-12-17 18:02:18',_binary ''),(74,825,'2022-09-27 13:50:03',_binary ''),(74,826,'2023-11-16 14:23:01',_binary ''),(74,827,'2021-07-18 16:12:39',_binary ''),(74,828,'2023-01-07 12:43:00',_binary ''),(74,829,'2023-07-13 16:13:06',_binary ''),(74,830,'2021-08-13 08:08:10',_binary ''),(74,831,'2023-10-28 12:57:37',_binary ''),(75,832,'2022-11-06 14:32:57',_binary ''),(75,833,'2024-02-02 11:36:36',_binary ''),(75,834,'2022-11-26 11:37:26',_binary ''),(75,835,'2024-02-09 09:25:09',_binary ''),(75,836,'2024-02-22 10:15:40',_binary ''),(75,837,'2021-03-17 18:43:00',_binary ''),(75,838,'2023-04-28 19:08:42',_binary ''),(75,839,'2022-09-24 13:00:16',_binary ''),(75,840,'2023-07-14 17:22:53',_binary ''),(75,841,'2023-06-14 17:36:20',_binary ''),(75,842,'2024-01-30 13:00:07',_binary ''),(75,843,'2021-09-17 17:09:27',_binary ''),(75,844,'2022-06-15 13:16:44',_binary ''),(75,845,'2024-01-15 11:04:54',_binary ''),(75,846,'2022-05-29 10:35:23',_binary ''),(75,847,'2023-08-27 10:00:52',_binary ''),(75,848,'2021-08-26 19:48:22',_binary ''),(75,849,'2021-12-30 19:55:26',_binary ''),(75,850,'2022-03-10 13:14:11',_binary ''),(75,851,'2023-08-26 18:51:19',_binary ''),(75,852,'2023-09-12 09:42:32',_binary ''),(75,853,'2022-08-08 19:06:36',_binary ''),(75,854,'2023-05-23 19:23:11',_binary ''),(75,855,'2022-06-04 15:17:55',_binary ''),(75,856,'2022-05-25 10:26:44',_binary ''),(75,857,'2020-08-17 18:46:20',_binary ''),(75,858,'2021-06-17 13:22:18',_binary ''),(75,859,'2023-07-30 15:53:53',_binary ''),(75,860,'2021-01-23 09:11:13',_binary ''),(75,861,'2024-01-08 18:25:36',_binary ''),(75,862,'2022-06-14 19:50:26',_binary ''),(75,863,'2024-02-10 11:51:29',_binary ''),(75,864,'2024-02-27 19:07:18',_binary ''),(75,865,'2023-12-31 11:39:51',_binary ''),(75,866,'2023-08-28 16:20:15',_binary ''),(76,867,'2021-09-20 13:46:06',_binary ''),(76,868,'2024-01-27 15:01:47',_binary ''),(76,869,'2021-11-03 13:25:32',_binary ''),(76,870,'2023-11-30 17:00:20',_binary ''),(76,871,'2021-04-11 16:10:15',_binary ''),(76,872,'2022-06-02 15:36:48',_binary ''),(76,873,'2023-12-15 19:18:40',_binary ''),(76,874,'2024-02-27 17:12:35',_binary ''),(76,875,'2021-10-25 09:22:53',_binary ''),(76,876,'2022-03-23 19:53:49',_binary ''),(76,877,'2022-10-24 13:24:49',_binary ''),(76,878,'2023-04-14 15:30:54',_binary ''),(76,879,'2022-08-29 11:42:16',_binary ''),(76,880,'2023-06-27 11:48:05',_binary ''),(76,881,'2023-07-18 11:03:34',_binary ''),(76,882,'2021-01-22 19:51:06',_binary ''),(76,883,'2023-04-13 15:10:06',_binary ''),(76,884,'2022-07-21 12:44:54',_binary ''),(76,885,'2024-01-03 08:24:12',_binary ''),(76,886,'2022-01-28 12:49:38',_binary ''),(76,887,'2023-02-19 17:19:55',_binary ''),(76,888,'2023-06-01 14:38:37',_binary ''),(76,889,'2023-05-28 10:57:34',_binary ''),(76,890,'2023-12-10 18:43:30',_binary ''),(76,891,'2021-06-05 15:33:44',_binary ''),(77,892,'2023-03-17 11:39:42',_binary ''),(77,893,'2021-10-06 10:33:49',_binary ''),(77,894,'2024-01-10 16:41:26',_binary ''),(77,895,'2022-11-14 18:11:54',_binary ''),(77,896,'2021-07-01 11:52:03',_binary ''),(77,897,'2022-09-26 18:58:01',_binary ''),(77,898,'2023-08-29 13:33:39',_binary ''),(77,899,'2024-01-13 11:40:55',_binary ''),(77,900,'2022-09-07 09:07:46',_binary ''),(77,901,'2024-02-09 16:24:10',_binary ''),(77,902,'2024-02-19 17:55:40',_binary ''),(77,903,'2022-02-12 17:36:49',_binary ''),(78,904,'2020-07-10 11:28:33',_binary ''),(78,905,'2022-10-09 10:58:01',_binary ''),(78,906,'2022-02-23 12:49:05',_binary ''),(78,907,'2023-07-16 09:57:43',_binary ''),(78,908,'2024-01-26 18:17:56',_binary ''),(78,909,'2022-09-18 16:36:18',_binary ''),(78,910,'2022-11-06 14:34:44',_binary ''),(78,911,'2024-02-24 19:32:29',_binary ''),(78,912,'2023-11-18 08:30:05',_binary ''),(78,913,'2023-07-29 08:41:17',_binary ''),(78,914,'2020-01-15 19:18:34',_binary ''),(78,915,'2022-12-24 18:06:44',_binary ''),(78,916,'2023-04-01 11:38:18',_binary ''),(78,917,'2022-04-06 12:59:06',_binary ''),(78,918,'2023-08-14 08:56:05',_binary ''),(78,919,'2022-01-21 10:25:46',_binary ''),(78,920,'2023-01-25 16:14:11',_binary ''),(78,921,'2023-05-24 15:09:38',_binary ''),(78,922,'2023-06-05 08:22:31',_binary ''),(78,923,'2023-01-06 15:11:23',_binary ''),(78,924,'2023-10-27 11:08:58',_binary ''),(78,925,'2021-03-28 14:25:05',_binary ''),(78,926,'2023-06-04 08:21:47',_binary ''),(78,927,'2024-02-19 19:28:05',_binary ''),(78,928,'2024-02-16 18:06:06',_binary ''),(78,929,'2023-11-20 08:17:58',_binary ''),(78,930,'2023-06-18 14:50:38',_binary ''),(78,931,'2023-08-03 19:02:49',_binary ''),(78,932,'2024-01-12 09:19:59',_binary ''),(78,933,'2022-05-28 10:39:16',_binary ''),(78,934,'2023-06-23 08:16:46',_binary ''),(78,935,'2024-02-19 11:57:34',_binary ''),(78,936,'2022-04-18 19:55:46',_binary ''),(78,937,'2022-03-03 13:25:27',_binary ''),(78,938,'2024-02-15 15:51:11',_binary ''),(78,939,'2022-05-19 18:48:12',_binary ''),(78,940,'2024-01-15 12:10:39',_binary ''),(79,941,'2023-08-16 12:11:48',_binary ''),(79,942,'2022-09-03 12:18:39',_binary ''),(79,943,'2022-02-14 14:54:51',_binary ''),(79,944,'2021-09-09 09:55:11',_binary ''),(79,945,'2022-08-03 13:18:45',_binary ''),(79,946,'2022-11-17 18:16:52',_binary ''),(79,947,'2021-11-13 10:07:56',_binary ''),(79,948,'2023-08-08 10:39:08',_binary ''),(79,949,'2020-07-25 13:15:14',_binary ''),(79,950,'2024-02-19 16:58:43',_binary ''),(79,951,'2023-06-27 12:18:10',_binary ''),(79,952,'2023-12-12 16:58:43',_binary ''),(79,953,'2023-05-23 08:50:57',_binary ''),(79,954,'2023-08-17 12:34:14',_binary ''),(79,955,'2023-01-17 10:11:17',_binary ''),(79,956,'2021-09-08 18:39:02',_binary ''),(79,957,'2024-02-07 09:50:17',_binary ''),(79,958,'2023-09-06 12:35:31',_binary ''),(79,959,'2023-06-01 16:28:02',_binary ''),(79,960,'2023-04-10 13:03:54',_binary ''),(79,961,'2023-11-25 11:02:10',_binary ''),(79,962,'2023-04-13 18:08:39',_binary ''),(79,963,'2022-06-08 09:35:54',_binary ''),(79,964,'2024-02-18 14:10:24',_binary ''),(79,965,'2024-02-24 11:11:26',_binary ''),(79,966,'2022-10-11 19:50:30',_binary ''),(79,967,'2023-04-07 12:38:59',_binary ''),(79,968,'2023-12-29 12:21:58',_binary ''),(79,969,'2022-11-21 13:50:46',_binary ''),(79,970,'2023-03-16 13:22:47',_binary ''),(79,971,'2023-03-21 18:24:56',_binary ''),(79,972,'2022-10-03 16:47:12',_binary ''),(79,973,'2022-02-23 09:36:26',_binary ''),(79,974,'2023-02-06 19:31:22',_binary ''),(79,975,'2022-02-11 16:38:26',_binary ''),(79,976,'2023-03-20 09:59:11',_binary ''),(79,977,'2023-10-30 11:05:00',_binary ''),(80,978,'2022-06-07 08:26:26',_binary ''),(80,979,'2023-12-30 17:23:24',_binary ''),(80,980,'2023-10-11 18:44:14',_binary ''),(80,981,'2020-12-10 11:15:04',_binary ''),(80,982,'2023-09-28 14:32:57',_binary ''),(80,983,'2023-03-04 16:44:16',_binary ''),(80,984,'2022-12-27 19:53:34',_binary ''),(80,985,'2021-10-18 17:08:32',_binary ''),(80,986,'2022-06-25 17:02:06',_binary ''),(80,987,'2023-05-14 09:23:56',_binary ''),(80,988,'2024-02-15 13:25:37',_binary ''),(80,989,'2020-06-24 16:51:43',_binary ''),(80,990,'2023-12-22 14:49:56',_binary ''),(80,991,'2023-04-12 13:19:57',_binary ''),(80,992,'2023-11-13 14:23:58',_binary ''),(80,993,'2023-08-31 18:45:04',_binary ''),(80,994,'2023-09-30 11:37:55',_binary ''),(80,995,'2023-02-12 19:50:31',_binary ''),(80,996,'2023-11-09 12:41:18',_binary ''),(80,997,'2023-05-30 16:43:08',_binary ''),(80,998,'2023-11-20 15:38:05',_binary ''),(80,999,'2022-12-23 12:47:47',_binary ''),(80,1000,'2022-10-19 10:39:34',_binary ''),(80,1001,'2022-10-14 12:20:56',_binary ''),(80,1002,'2023-11-09 11:01:33',_binary ''),(80,1003,'2023-05-10 09:08:03',_binary ''),(80,1004,'2023-04-23 17:09:51',_binary ''),(80,1005,'2022-03-22 12:41:35',_binary ''),(80,1006,'2021-01-16 13:02:15',_binary ''),(80,1007,'2022-06-10 18:56:57',_binary ''),(80,1008,'2023-06-12 17:20:13',_binary ''),(80,1009,'2023-09-18 09:34:51',_binary ''),(80,1010,'2023-11-08 14:51:34',_binary ''),(80,1011,'2023-09-27 12:57:35',_binary ''),(80,1012,'2023-10-16 12:35:40',_binary ''),(80,1013,'2023-10-22 14:10:20',_binary ''),(80,1014,'2023-06-09 16:31:43',_binary ''),(80,1015,'2024-01-15 17:39:21',_binary ''),(80,1016,'2023-03-18 10:57:13',_binary ''),(80,1017,'2022-01-28 12:37:51',_binary ''),(80,1018,'2023-10-04 14:46:37',_binary ''),(80,1019,'2020-10-25 15:30:13',_binary ''),(80,1020,'2024-01-22 17:48:17',_binary ''),(80,1021,'2023-10-21 16:12:08',_binary ''),(80,1022,'2023-04-01 11:02:47',_binary ''),(80,1023,'2024-02-16 14:15:10',_binary ''),(80,1024,'2023-07-12 08:41:12',_binary '');
/*!40000 ALTER TABLE `membresias_usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `membresias_usuarios_AFTER_INSERT` AFTER INSERT ON `membresias_usuarios` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
    DECLARE v_nombre_membresia varchar(60) default null;
    DECLARE v_nombre_usuario varchar(60) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    if new.membresia_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_membresia = (SELECT codigo FROM membresias WHERE id = NEW.membresia_id);
    else
        SET v_nombre_membresia = "Sin membresia asignado";
    end if;

    if new.usuarios_id is not null then
        -- En caso de tener el id de la sucursal debemos recuperar su nombre
        set v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.usuarios_id);
    else
        SET v_nombre_usuario = "Sin usuario asignado";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "membresias",
        CONCAT_WS(" ","Se ha insertado una nueva AREA con los IDs: Membresia - ", NEW.membresia_id, ", Usuario - ", NEW.usuarios_id, 
        "con los siguientes datos: ",
        "MEMBRESIA ID = ", v_nombre_membresia,
        "USUARIO ID = ",  v_nombre_usuario,
        "FECHA ULTIMA VISITA = ", NEW.fecha_ultima_visita, 
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `membresias_usuarios_AFTER_UPDATE` AFTER UPDATE ON `membresias_usuarios` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_membresia VARCHAR(100) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_membresia2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_usuario VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_usuario2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    IF NEW.membresia_id IS NOT NULL THEN 
		-- En caso de tener el id de la membresia
		SET v_nombre_membresia =  (SELECT codigo FROM membresias WHERE id = NEW.membresia_id);
    ELSE
		SET v_nombre_membresia = "Sin membresia asignada.";
    END IF;
    
    IF OLD.membresia_id IS NOT NULL THEN 
		-- En caso de tener el id de la membresia
		SET v_nombre_membresia2 =  (SELECT codigo FROM membresias WHERE id = OLD.membresia_id);
    ELSE
		SET v_nombre_membresia2 = "Sin membresia asignada.";
    END IF;

    IF NEW.usuarios_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario =  (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.usuarios_id);
    ELSE
		SET v_nombre_usuario = "Sin usuario asignada.";
    END IF;

    IF OLD.usuarios_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario2 =  (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = OLD.usuarios_id);
    ELSE
		SET v_nombre_usuario2 = "Sin usuario asignada.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "membresias_usuarios",
        CONCAT_WS(" ","Se han actualizado los datos del área con los IDs: Membresia - ", OLD.membresia_id, ", Usuario - ", OLD.usuarios_id,
		"con los siguientes datos:",
        "MEMBRESIA ID = ", v_nombre_membresia2, " cambio a ", v_nombre_membresia,
        "USUARIOS ID =",v_nombre_usuario2," cambio a ", v_nombre_usuario,
        "FECHA ULTIMA VISITA =",OLD.fecha_ultima_visita," cambio a ", NEW.fecha_ultima_visita,
        "ESTATUS = ", v_cadena_estatus2, " cambio a ", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `membresias_usuarios_AFTER_DELETE` AFTER DELETE ON `membresias_usuarios` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
		USER(),
		"Delete",
		"membresias_usuarios",
		CONCAT_WS(" ","Se ha eliminado una relación MEMBRESIAS USUARIOS con los IDs: Membresia - ", OLD.membresia_id, ", Usuario - ", OLD.usuarios_id),
		now(),
		DEFAULT
	);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `miembros`
--

DROP TABLE IF EXISTS `miembros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `miembros` (
  `Persona_ID` int unsigned NOT NULL COMMENT 'Descripción: Identificador único de la persona,\nTipo: Numérico (Entero sin signo), \nNaturaleza: Cuantitativo, \nDominio: Números enteros positivos\n',
  `Tipo` enum('Frecuente','Ocasional','Nuevo','Esporádico','Una sola visita') NOT NULL COMMENT 'Descripción:Tipo de cliente (frecuente, ocasional, nuevo, esporádico o una sola visita),\\nTipo: Enumerado,\\nNaturaleza: Cualitativo\\nDominio: {''Frecuente'', ''Ocasional'', ''Nuevo'', ''Esporádico'', ''Una sola visita''}\\n',
  `Membresia_Activa` bit(1) NOT NULL DEFAULT b'1' COMMENT 'Descripción: Indica si el cliente tiene una membresía activa actualmente,\\nTipo: Bit (1 bit)\\nNaturaleza: Cualitativo\\nDominio: {1 (Activo), 0 (Inactivo)}\\n',
  `Antiguedad` varchar(80) NOT NULL COMMENT 'Descripción: Antigüedad del cliente en el programa de membresías,\\nTipo:Alfanumérico (máximo 80 caracteres), \\nNaturaleza: Cualitativo\\nDominio: cadena de texto de hasta 50 caracteres\\n',
  PRIMARY KEY (`Persona_ID`),
  CONSTRAINT `fk_persona_1` FOREIGN KEY (`Persona_ID`) REFERENCES `personas` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Clasificación del Tipo de Tabla: Derivada\nDescripción de la Tabla: La tabla miembros almacena información adicional sobre los clientes del sistema que tienen una membresía activa. Contiene datos como el ID de la persona, el tipo de cliente (frecuente, ocasional, nuevo, esporádico o una sola visita), si tiene una membresía activa actualmente, y la antigüedad del cliente en el programa de membresías.\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `miembros`
--

LOCK TABLES `miembros` WRITE;
/*!40000 ALTER TABLE `miembros` DISABLE KEYS */;
INSERT INTO `miembros` VALUES (101,'Frecuente',_binary '','Miembro regular con  1 años,  1 meses,  3 semanas y  0 dias'),(102,'Nuevo',_binary '','Miembro regular con  1 años,  7 meses,  4 semanas y  4 dias'),(103,'Ocasional',_binary '','Miembro nuevo con  0 años,  10 meses,  3 semanas y  5 dias'),(104,'Ocasional',_binary '','Miembro regular con  1 años,  1 meses,  0 semanas y  0 dias'),(105,'Frecuente',_binary '','Miembro regular con  1 años,  8 meses,  0 semanas y  2 dias'),(106,'Nuevo',_binary '','Miembro nuevo con  0 años,  11 meses,  3 semanas y  4 dias'),(107,'Una sola visita',_binary '','Miembro regular con  1 años,  8 meses,  3 semanas y  6 dias'),(108,'Nuevo',_binary '','Miembro regular con  2 años,  0 meses,  4 semanas y  2 dias'),(109,'Frecuente',_binary '','Miembro regular con  1 años,  0 meses,  3 semanas y  4 dias'),(110,'Nuevo',_binary '','Miembro regular con  2 años,  0 meses,  1 semanas y  6 dias'),(111,'Una sola visita',_binary '','Miembro regular con  3 años,  5 meses,  1 semanas y  4 dias'),(112,'Esporádico',_binary '','Miembro regular con  3 años,  0 meses,  2 semanas y  4 dias'),(113,'Ocasional',_binary '','Miembro nuevo con  0 años,  0 meses,  1 semanas y  4 dias'),(114,'Una sola visita',_binary '','Miembro regular con  2 años,  10 meses,  4 semanas y  0 dias'),(115,'Nuevo',_binary '','Miembro regular con  2 años,  8 meses,  3 semanas y  3 dias'),(116,'Frecuente',_binary '','Miembro nuevo con  0 años,  9 meses,  1 semanas y  3 dias'),(117,'Esporádico',_binary '','Miembro regular con  3 años,  4 meses,  3 semanas y  0 dias'),(118,'Nuevo',_binary '','Miembro regular con  3 años,  5 meses,  4 semanas y  2 dias'),(119,'Frecuente',_binary '','Miembro regular con  3 años,  2 meses,  3 semanas y  6 dias'),(120,'Frecuente',_binary '','Miembro nuevo con  0 años,  2 meses,  3 semanas y  2 dias'),(121,'Ocasional',_binary '','Miembro regular con  1 años,  7 meses,  3 semanas y  1 dias'),(122,'Nuevo',_binary '','Miembro regular con  3 años,  6 meses,  1 semanas y  0 dias'),(123,'Frecuente',_binary '','Miembro nuevo con  0 años,  3 meses,  4 semanas y  6 dias'),(124,'Nuevo',_binary '','Miembro regular con  3 años,  8 meses,  3 semanas y  5 dias'),(125,'Frecuente',_binary '','Miembro nuevo con  0 años,  5 meses,  4 semanas y  1 dias'),(126,'Nuevo',_binary '','Miembro regular con  1 años,  9 meses,  2 semanas y  2 dias'),(127,'Frecuente',_binary '','Miembro antiguo con  4 años,  0 meses,  1 semanas y  6 dias'),(128,'Una sola visita',_binary '','Miembro regular con  1 años,  5 meses,  4 semanas y  4 dias'),(129,'Una sola visita',_binary '','Miembro regular con  2 años,  9 meses,  2 semanas y  1 dias'),(130,'Ocasional',_binary '','Miembro regular con  2 años,  0 meses,  2 semanas y  4 dias'),(131,'Esporádico',_binary '','Miembro nuevo con  0 años,  4 meses,  1 semanas y  1 dias'),(132,'Nuevo',_binary '','Miembro regular con  3 años,  3 meses,  4 semanas y  0 dias'),(133,'Una sola visita',_binary '','Miembro nuevo con  0 años,  5 meses,  1 semanas y  3 dias'),(134,'Frecuente',_binary '','Miembro regular con  1 años,  1 meses,  2 semanas y  2 dias'),(135,'Una sola visita',_binary '','Miembro regular con  1 años,  6 meses,  3 semanas y  5 dias'),(136,'Ocasional',_binary '','Miembro regular con  1 años,  2 meses,  3 semanas y  3 dias'),(137,'Esporádico',_binary '','Miembro nuevo con  0 años,  3 meses,  2 semanas y  2 dias'),(138,'Frecuente',_binary '','Miembro regular con  1 años,  10 meses,  1 semanas y  4 dias'),(139,'Esporádico',_binary '','Miembro antiguo con  4 años,  1 meses,  3 semanas y  4 dias'),(140,'Frecuente',_binary '','Miembro regular con  3 años,  4 meses,  3 semanas y  4 dias'),(141,'Una sola visita',_binary '','Miembro nuevo con  0 años,  7 meses,  1 semanas y  1 dias'),(142,'Una sola visita',_binary '','Miembro regular con  2 años,  4 meses,  3 semanas y  3 dias'),(143,'Ocasional',_binary '','Miembro regular con  2 años,  6 meses,  3 semanas y  2 dias'),(144,'Una sola visita',_binary '','Miembro regular con  1 años,  8 meses,  0 semanas y  2 dias'),(145,'Esporádico',_binary '','Miembro nuevo con  0 años,  10 meses,  2 semanas y  6 dias'),(146,'Esporádico',_binary '','Miembro regular con  3 años,  2 meses,  2 semanas y  0 dias'),(147,'Frecuente',_binary '','Miembro regular con  3 años,  9 meses,  1 semanas y  4 dias'),(148,'Esporádico',_binary '','Miembro regular con  3 años,  1 meses,  2 semanas y  1 dias'),(149,'Nuevo',_binary '','Miembro nuevo con  0 años,  10 meses,  1 semanas y  5 dias'),(150,'Nuevo',_binary '','Miembro regular con  1 años,  0 meses,  1 semanas y  2 dias'),(151,'Ocasional',_binary '','Miembro nuevo con  0 años,  5 meses,  4 semanas y  2 dias'),(152,'Una sola visita',_binary '','Miembro regular con  1 años,  2 meses,  3 semanas y  3 dias'),(153,'Frecuente',_binary '','Miembro nuevo con  0 años,  2 meses,  2 semanas y  2 dias'),(154,'Nuevo',_binary '','Miembro regular con  2 años,  10 meses,  4 semanas y  6 dias'),(155,'Esporádico',_binary '','Miembro nuevo con  0 años,  3 meses,  3 semanas y  1 dias'),(156,'Esporádico',_binary '','Miembro regular con  3 años,  6 meses,  0 semanas y  1 dias'),(157,'Una sola visita',_binary '','Miembro nuevo con  0 años,  10 meses,  4 semanas y  1 dias'),(158,'Ocasional',_binary '','Miembro regular con  3 años,  8 meses,  1 semanas y  3 dias'),(159,'Una sola visita',_binary '','Miembro regular con  2 años,  6 meses,  3 semanas y  2 dias'),(160,'Una sola visita',_binary '','Miembro regular con  1 años,  4 meses,  0 semanas y  2 dias'),(161,'Una sola visita',_binary '','Miembro antiguo con  4 años,  0 meses,  1 semanas y  1 dias'),(162,'Esporádico',_binary '','Miembro nuevo con  0 años,  0 meses,  1 semanas y  6 dias'),(163,'Nuevo',_binary '','Miembro regular con  2 años,  3 meses,  3 semanas y  0 dias'),(164,'Una sola visita',_binary '','Miembro regular con  2 años,  10 meses,  4 semanas y  4 dias'),(165,'Esporádico',_binary '','Miembro regular con  2 años,  8 meses,  2 semanas y  2 dias'),(166,'Nuevo',_binary '','Miembro regular con  1 años,  7 meses,  1 semanas y  1 dias'),(167,'Esporádico',_binary '','Miembro regular con  3 años,  8 meses,  2 semanas y  4 dias'),(168,'Una sola visita',_binary '','Miembro regular con  1 años,  0 meses,  0 semanas y  3 dias'),(169,'Frecuente',_binary '','Miembro regular con  1 años,  6 meses,  1 semanas y  1 dias'),(170,'Una sola visita',_binary '','Miembro regular con  3 años,  5 meses,  3 semanas y  6 dias'),(171,'Frecuente',_binary '','Miembro regular con  1 años,  6 meses,  4 semanas y  2 dias'),(172,'Frecuente',_binary '','Miembro regular con  3 años,  4 meses,  3 semanas y  3 dias'),(173,'Frecuente',_binary '','Miembro nuevo con  0 años,  3 meses,  2 semanas y  5 dias'),(174,'Una sola visita',_binary '','Miembro regular con  3 años,  6 meses,  1 semanas y  3 dias'),(175,'Frecuente',_binary '','Miembro regular con  3 años,  3 meses,  1 semanas y  2 dias'),(176,'Frecuente',_binary '','Miembro regular con  2 años,  11 meses,  0 semanas y  2 dias'),(177,'Una sola visita',_binary '','Miembro regular con  1 años,  5 meses,  1 semanas y  4 dias'),(178,'Una sola visita',_binary '','Miembro regular con  3 años,  5 meses,  0 semanas y  3 dias'),(179,'Frecuente',_binary '','Miembro antiguo con  4 años,  0 meses,  1 semanas y  5 dias'),(180,'Esporádico',_binary '','Miembro regular con  1 años,  4 meses,  0 semanas y  2 dias'),(181,'Ocasional',_binary '','Miembro regular con  2 años,  4 meses,  1 semanas y  1 dias'),(182,'Esporádico',_binary '','Miembro regular con  3 años,  6 meses,  3 semanas y  3 dias'),(183,'Ocasional',_binary '','Miembro regular con  2 años,  0 meses,  4 semanas y  5 dias'),(184,'Frecuente',_binary '','Miembro regular con  3 años,  3 meses,  2 semanas y  4 dias'),(185,'Esporádico',_binary '','Miembro regular con  1 años,  4 meses,  4 semanas y  1 dias'),(186,'Frecuente',_binary '','Miembro regular con  1 años,  5 meses,  3 semanas y  0 dias'),(187,'Una sola visita',_binary '','Miembro nuevo con  0 años,  4 meses,  2 semanas y  0 dias'),(188,'Nuevo',_binary '','Miembro regular con  2 años,  10 meses,  1 semanas y  0 dias'),(189,'Frecuente',_binary '','Miembro nuevo con  0 años,  3 meses,  0 semanas y  3 dias'),(190,'Frecuente',_binary '','Miembro regular con  3 años,  8 meses,  4 semanas y  6 dias'),(191,'Ocasional',_binary '','Miembro antiguo con  4 años,  0 meses,  1 semanas y  0 dias'),(192,'Ocasional',_binary '','Miembro regular con  2 años,  6 meses,  2 semanas y  6 dias'),(193,'Nuevo',_binary '','Miembro regular con  1 años,  5 meses,  3 semanas y  5 dias'),(194,'Esporádico',_binary '','Miembro regular con  3 años,  9 meses,  1 semanas y  5 dias'),(195,'Nuevo',_binary '','Miembro antiguo con  4 años,  0 meses,  4 semanas y  5 dias'),(196,'Frecuente',_binary '','Miembro regular con  3 años,  0 meses,  3 semanas y  5 dias'),(197,'Nuevo',_binary '','Miembro regular con  2 años,  3 meses,  1 semanas y  5 dias'),(198,'Ocasional',_binary '','Miembro regular con  2 años,  5 meses,  1 semanas y  2 dias'),(199,'Una sola visita',_binary '','Miembro nuevo con  0 años,  4 meses,  3 semanas y  3 dias'),(200,'Esporádico',_binary '','Miembro regular con  2 años,  10 meses,  3 semanas y  4 dias'),(201,'Nuevo',_binary '','Miembro regular con  2 años,  8 meses,  2 semanas y  2 dias'),(202,'Una sola visita',_binary '','Miembro regular con  3 años,  7 meses,  0 semanas y  2 dias'),(203,'Ocasional',_binary '','Miembro regular con  3 años,  2 meses,  2 semanas y  0 dias'),(204,'Frecuente',_binary '','Miembro regular con  2 años,  11 meses,  3 semanas y  4 dias'),(205,'Una sola visita',_binary '','Miembro regular con  2 años,  10 meses,  4 semanas y  6 dias'),(206,'Nuevo',_binary '','Miembro regular con  3 años,  6 meses,  0 semanas y  3 dias'),(207,'Frecuente',_binary '','Miembro regular con  1 años,  1 meses,  3 semanas y  1 dias'),(208,'Frecuente',_binary '','Miembro regular con  3 años,  9 meses,  3 semanas y  0 dias'),(209,'Frecuente',_binary '','Miembro regular con  1 años,  9 meses,  3 semanas y  1 dias'),(210,'Una sola visita',_binary '','Miembro regular con  3 años,  5 meses,  2 semanas y  4 dias'),(211,'Nuevo',_binary '','Miembro regular con  3 años,  4 meses,  0 semanas y  1 dias'),(212,'Nuevo',_binary '','Miembro regular con  1 años,  8 meses,  3 semanas y  3 dias'),(213,'Frecuente',_binary '','Miembro regular con  2 años,  5 meses,  0 semanas y  1 dias'),(214,'Una sola visita',_binary '','Miembro nuevo con  0 años,  11 meses,  2 semanas y  1 dias'),(215,'Frecuente',_binary '','Miembro nuevo con  0 años,  0 meses,  3 semanas y  3 dias'),(216,'Frecuente',_binary '','Miembro regular con  3 años,  4 meses,  4 semanas y  4 dias'),(217,'Nuevo',_binary '','Miembro nuevo con  0 años,  9 meses,  4 semanas y  5 dias'),(218,'Frecuente',_binary '','Miembro nuevo con  0 años,  2 meses,  1 semanas y  1 dias'),(219,'Esporádico',_binary '','Miembro regular con  3 años,  11 meses,  1 semanas y  4 dias'),(220,'Frecuente',_binary '','Miembro nuevo con  0 años,  9 meses,  1 semanas y  1 dias'),(221,'Frecuente',_binary '','Miembro regular con  1 años,  2 meses,  2 semanas y  3 dias'),(222,'Frecuente',_binary '','Miembro regular con  2 años,  6 meses,  1 semanas y  1 dias'),(223,'Esporádico',_binary '','Miembro regular con  1 años,  8 meses,  3 semanas y  1 dias'),(224,'Una sola visita',_binary '','Miembro nuevo con  0 años,  6 meses,  3 semanas y  6 dias'),(225,'Frecuente',_binary '','Miembro regular con  1 años,  6 meses,  1 semanas y  3 dias'),(226,'Una sola visita',_binary '','Miembro regular con  1 años,  0 meses,  3 semanas y  5 dias'),(227,'Ocasional',_binary '','Miembro regular con  3 años,  10 meses,  2 semanas y  0 dias'),(228,'Nuevo',_binary '','Miembro regular con  3 años,  6 meses,  2 semanas y  2 dias'),(229,'Frecuente',_binary '','Miembro regular con  1 años,  6 meses,  2 semanas y  6 dias'),(230,'Ocasional',_binary '','Miembro regular con  2 años,  1 meses,  1 semanas y  1 dias'),(231,'Nuevo',_binary '','Miembro nuevo con  0 años,  6 meses,  4 semanas y  2 dias'),(232,'Esporádico',_binary '','Miembro regular con  2 años,  10 meses,  3 semanas y  1 dias'),(233,'Esporádico',_binary '','Miembro regular con  2 años,  0 meses,  1 semanas y  2 dias'),(234,'Esporádico',_binary '','Miembro regular con  2 años,  11 meses,  3 semanas y  3 dias'),(235,'Frecuente',_binary '','Miembro nuevo con  0 años,  10 meses,  3 semanas y  0 dias'),(236,'Frecuente',_binary '','Miembro regular con  2 años,  7 meses,  3 semanas y  1 dias'),(237,'Esporádico',_binary '','Miembro nuevo con  0 años,  11 meses,  3 semanas y  2 dias'),(238,'Esporádico',_binary '','Miembro regular con  2 años,  4 meses,  2 semanas y  2 dias'),(239,'Nuevo',_binary '','Miembro regular con  2 años,  5 meses,  3 semanas y  3 dias'),(240,'Una sola visita',_binary '','Miembro regular con  3 años,  4 meses,  1 semanas y  4 dias'),(241,'Una sola visita',_binary '','Miembro nuevo con  0 años,  3 meses,  1 semanas y  6 dias'),(242,'Frecuente',_binary '','Miembro regular con  3 años,  3 meses,  1 semanas y  0 dias'),(243,'Ocasional',_binary '','Miembro regular con  1 años,  1 meses,  2 semanas y  5 dias'),(244,'Ocasional',_binary '','Miembro regular con  3 años,  8 meses,  2 semanas y  3 dias'),(245,'Frecuente',_binary '','Miembro regular con  1 años,  0 meses,  4 semanas y  1 dias'),(246,'Nuevo',_binary '','Miembro regular con  1 años,  11 meses,  0 semanas y  2 dias'),(247,'Frecuente',_binary '','Miembro regular con  1 años,  11 meses,  2 semanas y  3 dias'),(248,'Esporádico',_binary '','Miembro regular con  1 años,  2 meses,  1 semanas y  0 dias'),(249,'Una sola visita',_binary '','Miembro nuevo con  0 años,  7 meses,  3 semanas y  6 dias'),(250,'Frecuente',_binary '','Miembro regular con  1 años,  10 meses,  0 semanas y  0 dias'),(251,'Una sola visita',_binary '','Miembro regular con  2 años,  5 meses,  2 semanas y  2 dias'),(252,'Frecuente',_binary '','Miembro nuevo con  0 años,  4 meses,  0 semanas y  2 dias'),(253,'Una sola visita',_binary '','Miembro regular con  3 años,  1 meses,  1 semanas y  5 dias'),(254,'Ocasional',_binary '','Miembro nuevo con  0 años,  2 meses,  1 semanas y  5 dias'),(255,'Frecuente',_binary '','Miembro regular con  1 años,  5 meses,  2 semanas y  4 dias'),(256,'Nuevo',_binary '','Miembro regular con  2 años,  7 meses,  3 semanas y  2 dias'),(257,'Ocasional',_binary '','Miembro regular con  1 años,  4 meses,  4 semanas y  5 dias'),(258,'Frecuente',_binary '','Miembro nuevo con  0 años,  9 meses,  3 semanas y  3 dias'),(259,'Frecuente',_binary '','Miembro regular con  3 años,  5 meses,  3 semanas y  2 dias'),(260,'Ocasional',_binary '','Miembro regular con  2 años,  4 meses,  4 semanas y  2 dias'),(261,'Nuevo',_binary '','Miembro regular con  2 años,  6 meses,  3 semanas y  0 dias'),(262,'Esporádico',_binary '','Miembro regular con  1 años,  0 meses,  4 semanas y  0 dias'),(263,'Frecuente',_binary '','Miembro regular con  3 años,  1 meses,  3 semanas y  4 dias'),(264,'Frecuente',_binary '','Miembro regular con  1 años,  2 meses,  1 semanas y  4 dias'),(265,'Ocasional',_binary '','Miembro antiguo con  4 años,  0 meses,  2 semanas y  3 dias'),(266,'Nuevo',_binary '','Miembro regular con  3 años,  7 meses,  4 semanas y  1 dias'),(267,'Frecuente',_binary '','Miembro regular con  2 años,  8 meses,  4 semanas y  4 dias'),(268,'Nuevo',_binary '','Miembro regular con  2 años,  9 meses,  1 semanas y  6 dias'),(269,'Frecuente',_binary '','Miembro regular con  2 años,  5 meses,  4 semanas y  4 dias'),(270,'Nuevo',_binary '','Miembro regular con  2 años,  6 meses,  2 semanas y  4 dias'),(271,'Ocasional',_binary '','Miembro regular con  2 años,  3 meses,  4 semanas y  0 dias'),(272,'Una sola visita',_binary '','Miembro regular con  3 años,  10 meses,  3 semanas y  1 dias'),(273,'Una sola visita',_binary '','Miembro regular con  2 años,  4 meses,  1 semanas y  2 dias'),(274,'Frecuente',_binary '','Miembro regular con  1 años,  10 meses,  4 semanas y  0 dias'),(275,'Frecuente',_binary '','Miembro nuevo con  0 años,  11 meses,  1 semanas y  2 dias'),(276,'Nuevo',_binary '','Miembro regular con  1 años,  11 meses,  4 semanas y  5 dias'),(277,'Ocasional',_binary '','Miembro regular con  1 años,  8 meses,  0 semanas y  3 dias'),(278,'Ocasional',_binary '','Miembro nuevo con  0 años,  5 meses,  4 semanas y  6 dias'),(279,'Nuevo',_binary '','Miembro regular con  3 años,  7 meses,  1 semanas y  2 dias'),(280,'Una sola visita',_binary '','Miembro regular con  3 años,  8 meses,  3 semanas y  5 dias'),(281,'Frecuente',_binary '','Miembro regular con  3 años,  2 meses,  1 semanas y  1 dias'),(282,'Frecuente',_binary '','Miembro regular con  1 años,  8 meses,  4 semanas y  6 dias'),(283,'Nuevo',_binary '','Miembro nuevo con  0 años,  1 meses,  3 semanas y  0 dias'),(284,'Una sola visita',_binary '','Miembro regular con  3 años,  11 meses,  2 semanas y  6 dias'),(285,'Esporádico',_binary '','Miembro regular con  2 años,  3 meses,  3 semanas y  4 dias'),(286,'Una sola visita',_binary '','Miembro regular con  3 años,  11 meses,  4 semanas y  2 dias'),(287,'Frecuente',_binary '','Miembro regular con  2 años,  1 meses,  2 semanas y  1 dias'),(288,'Una sola visita',_binary '','Miembro regular con  1 años,  1 meses,  0 semanas y  1 dias'),(289,'Frecuente',_binary '','Miembro nuevo con  0 años,  6 meses,  0 semanas y  0 dias'),(290,'Nuevo',_binary '','Miembro regular con  2 años,  1 meses,  0 semanas y  2 dias'),(291,'Esporádico',_binary '','Miembro regular con  1 años,  5 meses,  0 semanas y  0 dias'),(292,'Frecuente',_binary '','Miembro regular con  3 años,  6 meses,  1 semanas y  5 dias'),(293,'Una sola visita',_binary '','Miembro regular con  2 años,  6 meses,  2 semanas y  0 dias'),(294,'Nuevo',_binary '','Miembro regular con  2 años,  9 meses,  4 semanas y  4 dias'),(295,'Frecuente',_binary '','Miembro regular con  1 años,  1 meses,  3 semanas y  3 dias'),(296,'Frecuente',_binary '','Miembro regular con  3 años,  3 meses,  3 semanas y  3 dias'),(297,'Nuevo',_binary '','Miembro regular con  2 años,  3 meses,  3 semanas y  3 dias'),(298,'Esporádico',_binary '','Miembro regular con  1 años,  0 meses,  3 semanas y  5 dias'),(299,'Esporádico',_binary '','Miembro regular con  3 años,  10 meses,  0 semanas y  3 dias'),(300,'Frecuente',_binary '','Miembro nuevo con  0 años,  11 meses,  3 semanas y  4 dias'),(301,'Nuevo',_binary '','Miembro regular con  2 años,  2 meses,  2 semanas y  5 dias'),(302,'Esporádico',_binary '','Miembro nuevo con  0 años,  6 meses,  0 semanas y  2 dias'),(303,'Una sola visita',_binary '','Miembro antiguo con  4 años,  0 meses,  4 semanas y  6 dias'),(304,'Ocasional',_binary '','Miembro regular con  2 años,  10 meses,  1 semanas y  0 dias'),(305,'Nuevo',_binary '','Miembro regular con  1 años,  1 meses,  3 semanas y  4 dias'),(306,'Frecuente',_binary '','Miembro regular con  1 años,  8 meses,  2 semanas y  2 dias'),(307,'Nuevo',_binary '','Miembro regular con  2 años,  7 meses,  3 semanas y  6 dias'),(308,'Una sola visita',_binary '','Miembro nuevo con  0 años,  2 meses,  0 semanas y  1 dias'),(309,'Esporádico',_binary '','Miembro regular con  3 años,  6 meses,  2 semanas y  2 dias'),(310,'Ocasional',_binary '','Miembro regular con  3 años,  7 meses,  4 semanas y  0 dias'),(311,'Frecuente',_binary '','Miembro regular con  2 años,  5 meses,  2 semanas y  3 dias'),(312,'Una sola visita',_binary '','Miembro nuevo con  0 años,  2 meses,  4 semanas y  2 dias'),(313,'Ocasional',_binary '','Miembro regular con  1 años,  4 meses,  1 semanas y  4 dias'),(314,'Nuevo',_binary '','Miembro nuevo con  0 años,  3 meses,  4 semanas y  4 dias'),(315,'Esporádico',_binary '','Miembro antiguo con  4 años,  1 meses,  2 semanas y  1 dias'),(316,'Nuevo',_binary '','Miembro nuevo con  1 años,  0 meses,  0 semanas y  0 dias'),(317,'Nuevo',_binary '','Miembro nuevo con  0 años,  5 meses,  2 semanas y  6 dias'),(318,'Una sola visita',_binary '','Miembro nuevo con  0 años,  9 meses,  1 semanas y  0 dias'),(319,'Frecuente',_binary '','Miembro regular con  2 años,  4 meses,  3 semanas y  6 dias'),(320,'Nuevo',_binary '','Miembro regular con  1 años,  2 meses,  4 semanas y  5 dias'),(321,'Ocasional',_binary '','Miembro nuevo con  0 años,  9 meses,  1 semanas y  3 dias'),(322,'Una sola visita',_binary '','Miembro regular con  1 años,  4 meses,  0 semanas y  2 dias'),(323,'Frecuente',_binary '','Miembro regular con  3 años,  5 meses,  0 semanas y  1 dias'),(324,'Una sola visita',_binary '','Miembro regular con  2 años,  0 meses,  2 semanas y  2 dias'),(325,'Ocasional',_binary '','Miembro regular con  1 años,  9 meses,  2 semanas y  3 dias'),(326,'Esporádico',_binary '','Miembro regular con  3 años,  7 meses,  1 semanas y  3 dias'),(327,'Una sola visita',_binary '','Miembro nuevo con  0 años,  2 meses,  2 semanas y  5 dias'),(328,'Esporádico',_binary '','Miembro regular con  3 años,  3 meses,  4 semanas y  2 dias'),(329,'Una sola visita',_binary '','Miembro nuevo con  0 años,  10 meses,  3 semanas y  6 dias'),(330,'Nuevo',_binary '','Miembro nuevo con  0 años,  3 meses,  0 semanas y  3 dias'),(331,'Ocasional',_binary '','Miembro nuevo con  0 años,  1 meses,  1 semanas y  5 dias'),(332,'Una sola visita',_binary '','Miembro regular con  3 años,  1 meses,  0 semanas y  3 dias'),(333,'Una sola visita',_binary '','Miembro nuevo con  0 años,  7 meses,  1 semanas y  5 dias'),(334,'Frecuente',_binary '','Miembro regular con  1 años,  3 meses,  1 semanas y  2 dias'),(335,'Ocasional',_binary '','Miembro nuevo con  0 años,  7 meses,  2 semanas y  4 dias'),(336,'Ocasional',_binary '','Miembro regular con  2 años,  7 meses,  4 semanas y  4 dias'),(337,'Una sola visita',_binary '','Miembro regular con  2 años,  5 meses,  1 semanas y  6 dias'),(338,'Ocasional',_binary '','Miembro nuevo con  0 años,  6 meses,  0 semanas y  1 dias'),(339,'Ocasional',_binary '','Miembro regular con  2 años,  7 meses,  0 semanas y  1 dias'),(340,'Frecuente',_binary '','Miembro regular con  3 años,  6 meses,  3 semanas y  3 dias'),(341,'Esporádico',_binary '','Miembro regular con  3 años,  10 meses,  0 semanas y  3 dias'),(342,'Ocasional',_binary '','Miembro regular con  1 años,  3 meses,  1 semanas y  5 dias'),(343,'Frecuente',_binary '','Miembro regular con  3 años,  2 meses,  1 semanas y  6 dias'),(344,'Una sola visita',_binary '','Miembro regular con  1 años,  8 meses,  1 semanas y  6 dias'),(345,'Ocasional',_binary '','Miembro regular con  2 años,  3 meses,  4 semanas y  5 dias'),(346,'Ocasional',_binary '','Miembro regular con  2 años,  5 meses,  1 semanas y  4 dias'),(347,'Esporádico',_binary '','Miembro regular con  2 años,  10 meses,  4 semanas y  5 dias'),(348,'Ocasional',_binary '','Miembro regular con  2 años,  8 meses,  2 semanas y  2 dias'),(349,'Ocasional',_binary '','Miembro regular con  2 años,  5 meses,  4 semanas y  4 dias'),(350,'Una sola visita',_binary '','Miembro regular con  2 años,  8 meses,  3 semanas y  4 dias'),(351,'Frecuente',_binary '','Miembro regular con  3 años,  4 meses,  1 semanas y  3 dias'),(352,'Ocasional',_binary '','Miembro regular con  2 años,  4 meses,  0 semanas y  0 dias'),(353,'Esporádico',_binary '','Miembro regular con  2 años,  7 meses,  3 semanas y  2 dias'),(354,'Nuevo',_binary '','Miembro regular con  3 años,  2 meses,  4 semanas y  5 dias'),(355,'Frecuente',_binary '','Miembro regular con  1 años,  10 meses,  1 semanas y  1 dias'),(356,'Ocasional',_binary '','Miembro antiguo con  4 años,  1 meses,  3 semanas y  4 dias'),(357,'Ocasional',_binary '','Miembro regular con  2 años,  2 meses,  2 semanas y  0 dias'),(358,'Esporádico',_binary '','Miembro regular con  2 años,  6 meses,  4 semanas y  6 dias'),(359,'Una sola visita',_binary '','Miembro regular con  3 años,  8 meses,  1 semanas y  4 dias'),(360,'Esporádico',_binary '','Miembro regular con  1 años,  6 meses,  3 semanas y  5 dias'),(361,'Una sola visita',_binary '','Miembro regular con  2 años,  4 meses,  0 semanas y  2 dias'),(362,'Ocasional',_binary '','Miembro nuevo con  0 años,  10 meses,  1 semanas y  4 dias'),(363,'Una sola visita',_binary '','Miembro antiguo con  4 años,  0 meses,  4 semanas y  5 dias'),(364,'Frecuente',_binary '','Miembro regular con  1 años,  11 meses,  0 semanas y  0 dias'),(365,'Esporádico',_binary '','Miembro nuevo con  0 años,  11 meses,  0 semanas y  0 dias'),(366,'Frecuente',_binary '','Miembro antiguo con  4 años,  1 meses,  1 semanas y  4 dias'),(367,'Una sola visita',_binary '','Miembro regular con  3 años,  0 meses,  2 semanas y  5 dias'),(368,'Una sola visita',_binary '','Miembro regular con  2 años,  2 meses,  0 semanas y  3 dias'),(369,'Ocasional',_binary '','Miembro regular con  2 años,  1 meses,  4 semanas y  0 dias'),(370,'Frecuente',_binary '','Miembro regular con  1 años,  1 meses,  3 semanas y  3 dias'),(371,'Nuevo',_binary '','Miembro antiguo con  4 años,  0 meses,  4 semanas y  4 dias'),(372,'Una sola visita',_binary '','Miembro regular con  3 años,  9 meses,  2 semanas y  0 dias'),(373,'Una sola visita',_binary '','Miembro nuevo con  0 años,  1 meses,  2 semanas y  5 dias'),(374,'Nuevo',_binary '','Miembro regular con  2 años,  3 meses,  3 semanas y  0 dias'),(375,'Esporádico',_binary '','Miembro nuevo con  0 años,  6 meses,  2 semanas y  5 dias'),(376,'Una sola visita',_binary '','Miembro regular con  3 años,  6 meses,  1 semanas y  1 dias'),(377,'Esporádico',_binary '','Miembro nuevo con  0 años,  10 meses,  1 semanas y  6 dias'),(378,'Una sola visita',_binary '','Miembro nuevo con  0 años,  2 meses,  2 semanas y  1 dias'),(379,'Frecuente',_binary '','Miembro regular con  3 años,  3 meses,  3 semanas y  6 dias'),(380,'Una sola visita',_binary '','Miembro nuevo con  0 años,  7 meses,  4 semanas y  5 dias'),(381,'Ocasional',_binary '','Miembro regular con  1 años,  3 meses,  3 semanas y  1 dias'),(382,'Nuevo',_binary '','Miembro nuevo con  0 años,  2 meses,  2 semanas y  0 dias'),(383,'Frecuente',_binary '','Miembro regular con  3 años,  10 meses,  1 semanas y  2 dias'),(384,'Ocasional',_binary '','Miembro nuevo con  0 años,  4 meses,  3 semanas y  2 dias'),(385,'Frecuente',_binary '','Miembro regular con  2 años,  9 meses,  4 semanas y  1 dias'),(386,'Una sola visita',_binary '','Miembro regular con  2 años,  11 meses,  0 semanas y  3 dias'),(387,'Frecuente',_binary '','Miembro regular con  1 años,  3 meses,  0 semanas y  0 dias'),(388,'Nuevo',_binary '','Miembro nuevo con  0 años,  1 meses,  4 semanas y  4 dias'),(389,'Frecuente',_binary '','Miembro nuevo con  0 años,  8 meses,  1 semanas y  4 dias'),(390,'Frecuente',_binary '','Miembro regular con  1 años,  1 meses,  3 semanas y  5 dias'),(391,'Ocasional',_binary '','Miembro regular con  3 años,  2 meses,  1 semanas y  2 dias'),(392,'Nuevo',_binary '','Miembro regular con  3 años,  5 meses,  4 semanas y  2 dias'),(393,'Frecuente',_binary '','Miembro regular con  3 años,  3 meses,  3 semanas y  1 dias'),(394,'Una sola visita',_binary '','Miembro antiguo con  4 años,  0 meses,  3 semanas y  5 dias'),(395,'Frecuente',_binary '','Miembro regular con  2 años,  5 meses,  3 semanas y  1 dias'),(396,'Una sola visita',_binary '','Miembro regular con  2 años,  3 meses,  4 semanas y  1 dias'),(397,'Nuevo',_binary '','Miembro antiguo con  4 años,  0 meses,  3 semanas y  5 dias'),(398,'Nuevo',_binary '','Miembro nuevo con  0 años,  7 meses,  3 semanas y  1 dias'),(399,'Nuevo',_binary '','Miembro regular con  2 años,  9 meses,  0 semanas y  2 dias'),(400,'Una sola visita',_binary '','Miembro regular con  3 años,  0 meses,  3 semanas y  0 dias'),(401,'Nuevo',_binary '','Miembro regular con  3 años,  6 meses,  4 semanas y  6 dias'),(402,'Esporádico',_binary '','Miembro regular con  3 años,  10 meses,  4 semanas y  6 dias'),(403,'Una sola visita',_binary '','Miembro nuevo con  0 años,  9 meses,  1 semanas y  5 dias'),(404,'Nuevo',_binary '','Miembro regular con  1 años,  7 meses,  0 semanas y  2 dias'),(405,'Esporádico',_binary '','Miembro nuevo con  0 años,  5 meses,  2 semanas y  1 dias'),(406,'Frecuente',_binary '','Miembro regular con  3 años,  9 meses,  4 semanas y  5 dias'),(407,'Ocasional',_binary '','Miembro regular con  2 años,  9 meses,  4 semanas y  5 dias'),(408,'Esporádico',_binary '','Miembro regular con  1 años,  9 meses,  3 semanas y  3 dias'),(409,'Frecuente',_binary '','Miembro regular con  1 años,  5 meses,  2 semanas y  4 dias'),(410,'Esporádico',_binary '','Miembro nuevo con  0 años,  6 meses,  4 semanas y  4 dias'),(411,'Una sola visita',_binary '','Miembro nuevo con  0 años,  2 meses,  0 semanas y  0 dias'),(412,'Ocasional',_binary '','Miembro nuevo con  0 años,  11 meses,  3 semanas y  0 dias'),(413,'Esporádico',_binary '','Miembro nuevo con  0 años,  0 meses,  3 semanas y  1 dias'),(414,'Ocasional',_binary '','Miembro regular con  1 años,  10 meses,  2 semanas y  4 dias'),(415,'Nuevo',_binary '','Miembro antiguo con  4 años,  1 meses,  1 semanas y  2 dias'),(416,'Ocasional',_binary '','Miembro regular con  2 años,  5 meses,  1 semanas y  1 dias'),(417,'Nuevo',_binary '','Miembro antiguo con  4 años,  0 meses,  2 semanas y  3 dias'),(418,'Ocasional',_binary '','Miembro nuevo con  0 años,  7 meses,  2 semanas y  1 dias'),(419,'Nuevo',_binary '','Miembro regular con  3 años,  2 meses,  4 semanas y  1 dias'),(420,'Esporádico',_binary '','Miembro regular con  3 años,  6 meses,  1 semanas y  5 dias'),(421,'Esporádico',_binary '','Miembro regular con  3 años,  10 meses,  4 semanas y  2 dias'),(422,'Esporádico',_binary '','Miembro regular con  1 años,  8 meses,  4 semanas y  0 dias'),(423,'Nuevo',_binary '','Miembro regular con  1 años,  10 meses,  4 semanas y  6 dias'),(424,'Una sola visita',_binary '','Miembro regular con  3 años,  3 meses,  0 semanas y  2 dias'),(425,'Nuevo',_binary '','Miembro nuevo con  0 años,  3 meses,  3 semanas y  5 dias'),(426,'Una sola visita',_binary '','Miembro regular con  2 años,  6 meses,  1 semanas y  5 dias'),(427,'Nuevo',_binary '','Miembro nuevo con  0 años,  3 meses,  4 semanas y  6 dias'),(428,'Esporádico',_binary '','Miembro regular con  3 años,  0 meses,  2 semanas y  6 dias'),(429,'Ocasional',_binary '','Miembro regular con  3 años,  9 meses,  1 semanas y  6 dias'),(430,'Ocasional',_binary '','Miembro regular con  1 años,  10 meses,  2 semanas y  4 dias'),(431,'Una sola visita',_binary '','Miembro regular con  2 años,  4 meses,  1 semanas y  3 dias'),(432,'Esporádico',_binary '','Miembro regular con  1 años,  11 meses,  4 semanas y  2 dias'),(433,'Esporádico',_binary '','Miembro regular con  3 años,  2 meses,  1 semanas y  3 dias'),(434,'Una sola visita',_binary '','Miembro regular con  3 años,  1 meses,  4 semanas y  1 dias'),(435,'Frecuente',_binary '','Miembro regular con  3 años,  0 meses,  0 semanas y  3 dias'),(436,'Frecuente',_binary '','Miembro nuevo con  0 años,  5 meses,  2 semanas y  2 dias'),(437,'Frecuente',_binary '','Miembro regular con  2 años,  9 meses,  2 semanas y  6 dias'),(438,'Frecuente',_binary '','Miembro nuevo con  0 años,  4 meses,  4 semanas y  2 dias'),(439,'Frecuente',_binary '','Miembro regular con  3 años,  8 meses,  2 semanas y  0 dias'),(440,'Esporádico',_binary '','Miembro regular con  3 años,  7 meses,  4 semanas y  5 dias'),(441,'Nuevo',_binary '','Miembro regular con  3 años,  4 meses,  3 semanas y  3 dias'),(442,'Nuevo',_binary '','Miembro regular con  1 años,  0 meses,  0 semanas y  3 dias'),(443,'Nuevo',_binary '','Miembro regular con  3 años,  0 meses,  0 semanas y  0 dias'),(444,'Esporádico',_binary '','Miembro antiguo con  4 años,  0 meses,  0 semanas y  2 dias'),(445,'Ocasional',_binary '','Miembro regular con  1 años,  0 meses,  1 semanas y  5 dias'),(446,'Nuevo',_binary '','Miembro regular con  2 años,  10 meses,  3 semanas y  5 dias'),(447,'Nuevo',_binary '','Miembro regular con  3 años,  10 meses,  0 semanas y  1 dias'),(448,'Ocasional',_binary '','Miembro nuevo con  0 años,  9 meses,  4 semanas y  5 dias'),(449,'Esporádico',_binary '','Miembro regular con  3 años,  9 meses,  0 semanas y  2 dias'),(450,'Esporádico',_binary '','Miembro regular con  3 años,  5 meses,  2 semanas y  6 dias'),(451,'Esporádico',_binary '','Miembro antiguo con  4 años,  0 meses,  3 semanas y  6 dias'),(452,'Una sola visita',_binary '','Miembro regular con  1 años,  3 meses,  3 semanas y  2 dias'),(453,'Esporádico',_binary '','Miembro regular con  2 años,  3 meses,  1 semanas y  0 dias'),(454,'Una sola visita',_binary '','Miembro nuevo con  0 años,  11 meses,  2 semanas y  4 dias'),(455,'Ocasional',_binary '','Miembro regular con  3 años,  5 meses,  4 semanas y  6 dias'),(456,'Ocasional',_binary '','Miembro nuevo con  0 años,  1 meses,  1 semanas y  1 dias'),(457,'Ocasional',_binary '','Miembro nuevo con  0 años,  1 meses,  1 semanas y  4 dias'),(458,'Nuevo',_binary '','Miembro nuevo con  0 años,  8 meses,  1 semanas y  3 dias'),(459,'Nuevo',_binary '','Miembro regular con  3 años,  1 meses,  4 semanas y  4 dias'),(460,'Ocasional',_binary '','Miembro regular con  3 años,  5 meses,  0 semanas y  2 dias'),(461,'Ocasional',_binary '','Miembro regular con  2 años,  6 meses,  1 semanas y  5 dias'),(462,'Nuevo',_binary '','Miembro antiguo con  4 años,  0 meses,  2 semanas y  1 dias'),(463,'Ocasional',_binary '','Miembro regular con  3 años,  6 meses,  3 semanas y  6 dias'),(464,'Una sola visita',_binary '','Miembro regular con  1 años,  4 meses,  1 semanas y  1 dias'),(465,'Frecuente',_binary '','Miembro regular con  2 años,  10 meses,  2 semanas y  6 dias'),(466,'Nuevo',_binary '','Miembro regular con  2 años,  2 meses,  1 semanas y  5 dias'),(467,'Ocasional',_binary '','Miembro regular con  3 años,  6 meses,  0 semanas y  2 dias'),(468,'Una sola visita',_binary '','Miembro nuevo con  0 años,  3 meses,  0 semanas y  3 dias'),(469,'Nuevo',_binary '','Miembro regular con  2 años,  6 meses,  1 semanas y  0 dias'),(470,'Nuevo',_binary '','Miembro nuevo con  0 años,  3 meses,  3 semanas y  3 dias'),(471,'Nuevo',_binary '','Miembro nuevo con  0 años,  4 meses,  0 semanas y  3 dias'),(472,'Esporádico',_binary '','Miembro regular con  3 años,  10 meses,  1 semanas y  0 dias'),(473,'Frecuente',_binary '','Miembro regular con  3 años,  1 meses,  2 semanas y  3 dias'),(474,'Ocasional',_binary '','Miembro regular con  3 años,  3 meses,  3 semanas y  4 dias'),(475,'Frecuente',_binary '','Miembro regular con  2 años,  9 meses,  2 semanas y  5 dias'),(476,'Frecuente',_binary '','Miembro nuevo con  0 años,  2 meses,  3 semanas y  5 dias'),(477,'Ocasional',_binary '','Miembro regular con  2 años,  10 meses,  0 semanas y  1 dias'),(478,'Una sola visita',_binary '','Miembro regular con  3 años,  1 meses,  3 semanas y  4 dias'),(479,'Frecuente',_binary '','Miembro nuevo con  0 años,  7 meses,  4 semanas y  4 dias'),(480,'Una sola visita',_binary '','Miembro regular con  3 años,  8 meses,  0 semanas y  1 dias'),(481,'Frecuente',_binary '','Miembro nuevo con  0 años,  9 meses,  0 semanas y  1 dias'),(482,'Esporádico',_binary '','Miembro nuevo con  0 años,  11 meses,  2 semanas y  0 dias'),(483,'Frecuente',_binary '','Miembro regular con  3 años,  2 meses,  3 semanas y  6 dias'),(484,'Nuevo',_binary '','Miembro nuevo con  0 años,  4 meses,  2 semanas y  2 dias'),(485,'Nuevo',_binary '','Miembro regular con  3 años,  0 meses,  4 semanas y  4 dias'),(486,'Ocasional',_binary '','Miembro regular con  3 años,  7 meses,  1 semanas y  6 dias'),(487,'Esporádico',_binary '','Miembro nuevo con  0 años,  8 meses,  1 semanas y  0 dias'),(488,'Frecuente',_binary '','Miembro nuevo con  0 años,  6 meses,  0 semanas y  2 dias'),(489,'Ocasional',_binary '','Miembro regular con  1 años,  9 meses,  3 semanas y  0 dias'),(490,'Nuevo',_binary '','Miembro regular con  1 años,  5 meses,  4 semanas y  4 dias'),(491,'Ocasional',_binary '','Miembro regular con  3 años,  3 meses,  0 semanas y  1 dias'),(492,'Frecuente',_binary '','Miembro regular con  1 años,  7 meses,  1 semanas y  3 dias'),(493,'Frecuente',_binary '','Miembro nuevo con  0 años,  10 meses,  1 semanas y  4 dias'),(494,'Nuevo',_binary '','Miembro regular con  3 años,  0 meses,  1 semanas y  0 dias'),(495,'Nuevo',_binary '','Miembro nuevo con  0 años,  4 meses,  1 semanas y  6 dias'),(496,'Frecuente',_binary '','Miembro nuevo con  0 años,  11 meses,  3 semanas y  5 dias'),(497,'Una sola visita',_binary '','Miembro regular con  2 años,  10 meses,  1 semanas y  6 dias'),(498,'Frecuente',_binary '','Miembro regular con  1 años,  5 meses,  2 semanas y  4 dias'),(499,'Una sola visita',_binary '','Miembro nuevo con  0 años,  6 meses,  0 semanas y  2 dias'),(500,'Esporádico',_binary '','Miembro nuevo con  0 años,  5 meses,  3 semanas y  6 dias'),(501,'Nuevo',_binary '','Miembro nuevo con  0 años,  7 meses,  3 semanas y  1 dias'),(502,'Una sola visita',_binary '','Miembro regular con  3 años,  1 meses,  0 semanas y  1 dias'),(503,'Ocasional',_binary '','Miembro regular con  1 años,  5 meses,  2 semanas y  1 dias'),(504,'Ocasional',_binary '','Miembro regular con  1 años,  5 meses,  0 semanas y  0 dias'),(505,'Ocasional',_binary '','Miembro regular con  3 años,  4 meses,  0 semanas y  3 dias'),(506,'Frecuente',_binary '','Miembro regular con  1 años,  0 meses,  2 semanas y  1 dias'),(507,'Nuevo',_binary '','Miembro regular con  1 años,  1 meses,  2 semanas y  4 dias'),(508,'Ocasional',_binary '','Miembro regular con  1 años,  5 meses,  0 semanas y  0 dias'),(509,'Una sola visita',_binary '','Miembro antiguo con  4 años,  0 meses,  4 semanas y  0 dias'),(510,'Esporádico',_binary '','Miembro regular con  2 años,  8 meses,  4 semanas y  2 dias'),(511,'Nuevo',_binary '','Miembro regular con  1 años,  1 meses,  1 semanas y  0 dias'),(512,'Esporádico',_binary '','Miembro regular con  3 años,  3 meses,  3 semanas y  2 dias'),(513,'Frecuente',_binary '','Miembro nuevo con  0 años,  4 meses,  0 semanas y  1 dias'),(514,'Nuevo',_binary '','Miembro regular con  3 años,  0 meses,  1 semanas y  3 dias'),(515,'Ocasional',_binary '','Miembro regular con  3 años,  5 meses,  3 semanas y  1 dias'),(516,'Ocasional',_binary '','Miembro nuevo con  0 años,  4 meses,  1 semanas y  4 dias'),(517,'Ocasional',_binary '','Miembro nuevo con  0 años,  2 meses,  1 semanas y  4 dias'),(518,'Frecuente',_binary '','Miembro regular con  2 años,  11 meses,  3 semanas y  5 dias'),(519,'Nuevo',_binary '','Miembro regular con  3 años,  4 meses,  0 semanas y  1 dias'),(520,'Frecuente',_binary '','Miembro nuevo con  0 años,  11 meses,  3 semanas y  3 dias'),(521,'Nuevo',_binary '','Miembro regular con  2 años,  8 meses,  3 semanas y  6 dias'),(522,'Frecuente',_binary '','Miembro nuevo con  0 años,  3 meses,  3 semanas y  0 dias'),(523,'Ocasional',_binary '','Miembro regular con  3 años,  9 meses,  3 semanas y  2 dias'),(524,'Esporádico',_binary '','Miembro regular con  3 años,  1 meses,  2 semanas y  0 dias'),(525,'Frecuente',_binary '','Miembro regular con  1 años,  9 meses,  0 semanas y  3 dias'),(526,'Ocasional',_binary '','Miembro regular con  3 años,  8 meses,  0 semanas y  0 dias'),(527,'Ocasional',_binary '','Miembro nuevo con  0 años,  9 meses,  1 semanas y  1 dias'),(528,'Una sola visita',_binary '','Miembro regular con  1 años,  1 meses,  2 semanas y  1 dias'),(529,'Nuevo',_binary '','Miembro regular con  3 años,  9 meses,  3 semanas y  2 dias'),(530,'Una sola visita',_binary '','Miembro regular con  2 años,  10 meses,  1 semanas y  3 dias'),(531,'Frecuente',_binary '','Miembro regular con  1 años,  10 meses,  3 semanas y  3 dias'),(532,'Nuevo',_binary '','Miembro nuevo con  0 años,  8 meses,  2 semanas y  4 dias'),(533,'Nuevo',_binary '','Miembro regular con  1 años,  3 meses,  4 semanas y  2 dias'),(534,'Frecuente',_binary '','Miembro nuevo con  0 años,  7 meses,  3 semanas y  5 dias'),(535,'Ocasional',_binary '','Miembro nuevo con  0 años,  10 meses,  0 semanas y  3 dias'),(536,'Nuevo',_binary '','Miembro regular con  1 años,  0 meses,  2 semanas y  2 dias'),(537,'Ocasional',_binary '','Miembro nuevo con  0 años,  6 meses,  0 semanas y  0 dias'),(538,'Esporádico',_binary '','Miembro nuevo con  0 años,  6 meses,  4 semanas y  2 dias'),(539,'Nuevo',_binary '','Miembro regular con  3 años,  11 meses,  4 semanas y  5 dias'),(540,'Esporádico',_binary '','Miembro nuevo con  0 años,  11 meses,  3 semanas y  1 dias'),(541,'Nuevo',_binary '','Miembro nuevo con  0 años,  8 meses,  3 semanas y  6 dias'),(542,'Esporádico',_binary '','Miembro regular con  1 años,  5 meses,  4 semanas y  4 dias'),(543,'Esporádico',_binary '','Miembro regular con  2 años,  3 meses,  3 semanas y  6 dias'),(544,'Esporádico',_binary '','Miembro regular con  1 años,  6 meses,  2 semanas y  6 dias'),(545,'Esporádico',_binary '','Miembro regular con  1 años,  6 meses,  0 semanas y  2 dias'),(546,'Ocasional',_binary '','Miembro regular con  1 años,  3 meses,  0 semanas y  2 dias'),(547,'Frecuente',_binary '','Miembro regular con  3 años,  2 meses,  2 semanas y  6 dias'),(548,'Una sola visita',_binary '','Miembro regular con  1 años,  9 meses,  0 semanas y  1 dias'),(549,'Una sola visita',_binary '','Miembro nuevo con  1 años,  0 meses,  0 semanas y  0 dias'),(550,'Esporádico',_binary '','Miembro nuevo con  0 años,  10 meses,  3 semanas y  6 dias'),(551,'Una sola visita',_binary '','Miembro regular con  3 años,  2 meses,  3 semanas y  2 dias'),(552,'Frecuente',_binary '','Miembro regular con  1 años,  11 meses,  2 semanas y  4 dias'),(553,'Nuevo',_binary '','Miembro nuevo con  0 años,  9 meses,  3 semanas y  4 dias'),(554,'Una sola visita',_binary '','Miembro regular con  2 años,  8 meses,  3 semanas y  4 dias'),(555,'Ocasional',_binary '','Miembro nuevo con  0 años,  2 meses,  2 semanas y  0 dias'),(556,'Frecuente',_binary '','Miembro regular con  1 años,  7 meses,  1 semanas y  2 dias'),(557,'Ocasional',_binary '','Miembro nuevo con  0 años,  9 meses,  0 semanas y  1 dias'),(558,'Esporádico',_binary '','Miembro regular con  3 años,  0 meses,  1 semanas y  5 dias'),(559,'Esporádico',_binary '','Miembro regular con  1 años,  7 meses,  3 semanas y  3 dias'),(560,'Ocasional',_binary '','Miembro regular con  3 años,  3 meses,  4 semanas y  4 dias'),(561,'Una sola visita',_binary '','Miembro regular con  1 años,  5 meses,  2 semanas y  6 dias'),(562,'Ocasional',_binary '','Miembro regular con  3 años,  11 meses,  2 semanas y  1 dias'),(563,'Ocasional',_binary '','Miembro regular con  2 años,  3 meses,  4 semanas y  5 dias'),(564,'Esporádico',_binary '','Miembro regular con  1 años,  6 meses,  1 semanas y  4 dias'),(565,'Nuevo',_binary '','Miembro regular con  1 años,  0 meses,  2 semanas y  2 dias'),(566,'Esporádico',_binary '','Miembro regular con  2 años,  6 meses,  1 semanas y  1 dias'),(567,'Esporádico',_binary '','Miembro regular con  3 años,  3 meses,  3 semanas y  1 dias'),(568,'Frecuente',_binary '','Miembro nuevo con  0 años,  6 meses,  1 semanas y  2 dias'),(569,'Una sola visita',_binary '','Miembro regular con  2 años,  6 meses,  1 semanas y  5 dias'),(570,'Ocasional',_binary '','Miembro nuevo con  0 años,  5 meses,  2 semanas y  4 dias'),(571,'Ocasional',_binary '','Miembro regular con  1 años,  1 meses,  2 semanas y  5 dias'),(572,'Frecuente',_binary '','Miembro regular con  3 años,  4 meses,  4 semanas y  5 dias'),(573,'Frecuente',_binary '','Miembro regular con  1 años,  0 meses,  4 semanas y  6 dias'),(574,'Nuevo',_binary '','Miembro regular con  1 años,  4 meses,  1 semanas y  4 dias'),(575,'Una sola visita',_binary '','Miembro regular con  2 años,  9 meses,  1 semanas y  5 dias'),(576,'Una sola visita',_binary '','Miembro nuevo con  0 años,  11 meses,  3 semanas y  2 dias'),(577,'Nuevo',_binary '','Miembro regular con  1 años,  2 meses,  3 semanas y  0 dias'),(578,'Nuevo',_binary '','Miembro regular con  2 años,  0 meses,  3 semanas y  5 dias'),(579,'Nuevo',_binary '','Miembro regular con  1 años,  3 meses,  4 semanas y  6 dias'),(580,'Una sola visita',_binary '','Miembro regular con  2 años,  9 meses,  3 semanas y  0 dias'),(581,'Frecuente',_binary '','Miembro regular con  3 años,  5 meses,  1 semanas y  2 dias'),(582,'Nuevo',_binary '','Miembro regular con  3 años,  5 meses,  1 semanas y  6 dias'),(583,'Frecuente',_binary '','Miembro regular con  1 años,  1 meses,  1 semanas y  2 dias'),(584,'Nuevo',_binary '','Miembro regular con  2 años,  0 meses,  2 semanas y  2 dias'),(585,'Ocasional',_binary '','Miembro regular con  2 años,  8 meses,  4 semanas y  6 dias'),(586,'Nuevo',_binary '','Miembro regular con  2 años,  4 meses,  3 semanas y  1 dias'),(587,'Una sola visita',_binary '','Miembro regular con  1 años,  5 meses,  0 semanas y  3 dias'),(588,'Esporádico',_binary '','Miembro nuevo con  0 años,  8 meses,  1 semanas y  2 dias'),(589,'Una sola visita',_binary '','Miembro antiguo con  4 años,  0 meses,  1 semanas y  3 dias'),(590,'Nuevo',_binary '','Miembro regular con  2 años,  5 meses,  1 semanas y  4 dias'),(591,'Frecuente',_binary '','Miembro regular con  3 años,  6 meses,  3 semanas y  4 dias'),(592,'Esporádico',_binary '','Miembro nuevo con  0 años,  6 meses,  4 semanas y  6 dias'),(593,'Frecuente',_binary '','Miembro regular con  2 años,  3 meses,  0 semanas y  1 dias'),(594,'Frecuente',_binary '','Miembro nuevo con  0 años,  3 meses,  4 semanas y  4 dias'),(595,'Esporádico',_binary '','Miembro regular con  2 años,  7 meses,  4 semanas y  1 dias'),(596,'Ocasional',_binary '','Miembro regular con  2 años,  9 meses,  3 semanas y  4 dias'),(597,'Una sola visita',_binary '','Miembro regular con  1 años,  3 meses,  2 semanas y  3 dias'),(598,'Nuevo',_binary '','Miembro regular con  2 años,  8 meses,  1 semanas y  0 dias'),(599,'Esporádico',_binary '','Miembro regular con  2 años,  5 meses,  1 semanas y  0 dias'),(600,'Una sola visita',_binary '','Miembro antiguo con  4 años,  0 meses,  1 semanas y  5 dias'),(601,'Ocasional',_binary '','Miembro regular con  3 años,  4 meses,  2 semanas y  4 dias'),(602,'Nuevo',_binary '','Miembro regular con  2 años,  10 meses,  3 semanas y  6 dias'),(603,'Ocasional',_binary '','Miembro regular con  2 años,  10 meses,  0 semanas y  1 dias'),(604,'Esporádico',_binary '','Miembro regular con  2 años,  0 meses,  2 semanas y  0 dias'),(605,'Nuevo',_binary '','Miembro nuevo con  0 años,  6 meses,  3 semanas y  4 dias'),(606,'Nuevo',_binary '','Miembro regular con  3 años,  1 meses,  4 semanas y  6 dias'),(607,'Esporádico',_binary '','Miembro nuevo con  0 años,  8 meses,  2 semanas y  5 dias'),(608,'Una sola visita',_binary '','Miembro nuevo con  0 años,  9 meses,  0 semanas y  3 dias'),(609,'Ocasional',_binary '','Miembro nuevo con  0 años,  0 meses,  1 semanas y  6 dias'),(610,'Una sola visita',_binary '','Miembro nuevo con  0 años,  5 meses,  2 semanas y  5 dias'),(611,'Frecuente',_binary '','Miembro nuevo con  0 años,  5 meses,  0 semanas y  2 dias'),(612,'Frecuente',_binary '','Miembro regular con  3 años,  3 meses,  4 semanas y  6 dias'),(613,'Frecuente',_binary '','Miembro regular con  1 años,  10 meses,  1 semanas y  6 dias'),(614,'Esporádico',_binary '','Miembro nuevo con  0 años,  3 meses,  3 semanas y  1 dias'),(615,'Frecuente',_binary '','Miembro regular con  1 años,  7 meses,  1 semanas y  6 dias'),(616,'Frecuente',_binary '','Miembro regular con  1 años,  3 meses,  1 semanas y  1 dias'),(617,'Esporádico',_binary '','Miembro regular con  3 años,  6 meses,  2 semanas y  2 dias'),(618,'Esporádico',_binary '','Miembro regular con  2 años,  6 meses,  1 semanas y  2 dias'),(619,'Una sola visita',_binary '','Miembro regular con  3 años,  7 meses,  4 semanas y  1 dias'),(620,'Esporádico',_binary '','Miembro regular con  1 años,  2 meses,  3 semanas y  4 dias'),(621,'Una sola visita',_binary '','Miembro nuevo con  0 años,  3 meses,  2 semanas y  3 dias'),(622,'Una sola visita',_binary '','Miembro regular con  1 años,  7 meses,  2 semanas y  1 dias'),(623,'Ocasional',_binary '','Miembro regular con  2 años,  7 meses,  4 semanas y  2 dias'),(624,'Nuevo',_binary '','Miembro nuevo con  0 años,  5 meses,  2 semanas y  6 dias'),(625,'Frecuente',_binary '','Miembro regular con  1 años,  2 meses,  1 semanas y  5 dias'),(626,'Esporádico',_binary '','Miembro regular con  2 años,  11 meses,  4 semanas y  5 dias'),(627,'Ocasional',_binary '','Miembro regular con  2 años,  8 meses,  4 semanas y  5 dias'),(628,'Esporádico',_binary '','Miembro regular con  2 años,  8 meses,  2 semanas y  6 dias'),(629,'Una sola visita',_binary '','Miembro regular con  2 años,  6 meses,  1 semanas y  3 dias'),(630,'Ocasional',_binary '','Miembro nuevo con  0 años,  5 meses,  3 semanas y  3 dias'),(631,'Esporádico',_binary '','Miembro regular con  2 años,  2 meses,  1 semanas y  6 dias'),(632,'Una sola visita',_binary '','Miembro regular con  2 años,  1 meses,  3 semanas y  5 dias'),(633,'Frecuente',_binary '','Miembro regular con  1 años,  6 meses,  0 semanas y  3 dias'),(634,'Frecuente',_binary '','Miembro regular con  3 años,  8 meses,  2 semanas y  2 dias'),(635,'Nuevo',_binary '','Miembro regular con  1 años,  9 meses,  2 semanas y  5 dias'),(636,'Ocasional',_binary '','Miembro regular con  3 años,  6 meses,  4 semanas y  4 dias'),(637,'Una sola visita',_binary '','Miembro regular con  2 años,  6 meses,  3 semanas y  0 dias'),(638,'Ocasional',_binary '','Miembro regular con  1 años,  7 meses,  2 semanas y  1 dias'),(639,'Frecuente',_binary '','Miembro regular con  2 años,  0 meses,  4 semanas y  6 dias'),(640,'Ocasional',_binary '','Miembro regular con  2 años,  1 meses,  4 semanas y  6 dias'),(641,'Ocasional',_binary '','Miembro regular con  3 años,  10 meses,  3 semanas y  5 dias'),(642,'Ocasional',_binary '','Miembro regular con  3 años,  9 meses,  0 semanas y  2 dias'),(643,'Frecuente',_binary '','Miembro nuevo con  0 años,  9 meses,  2 semanas y  4 dias'),(644,'Nuevo',_binary '','Miembro regular con  2 años,  11 meses,  0 semanas y  2 dias'),(645,'Una sola visita',_binary '','Miembro regular con  1 años,  0 meses,  4 semanas y  2 dias'),(646,'Una sola visita',_binary '','Miembro regular con  2 años,  10 meses,  3 semanas y  3 dias'),(647,'Ocasional',_binary '','Miembro nuevo con  0 años,  9 meses,  2 semanas y  6 dias'),(648,'Frecuente',_binary '','Miembro regular con  2 años,  6 meses,  1 semanas y  6 dias'),(649,'Frecuente',_binary '','Miembro regular con  3 años,  7 meses,  0 semanas y  3 dias'),(650,'Ocasional',_binary '','Miembro nuevo con  0 años,  4 meses,  3 semanas y  5 dias'),(651,'Una sola visita',_binary '','Miembro regular con  2 años,  1 meses,  2 semanas y  1 dias'),(652,'Nuevo',_binary '','Miembro regular con  1 años,  0 meses,  3 semanas y  3 dias'),(653,'Ocasional',_binary '','Miembro regular con  3 años,  2 meses,  1 semanas y  2 dias'),(654,'Esporádico',_binary '','Miembro regular con  3 años,  9 meses,  1 semanas y  2 dias'),(655,'Una sola visita',_binary '','Miembro nuevo con  0 años,  10 meses,  1 semanas y  2 dias'),(656,'Una sola visita',_binary '','Miembro regular con  2 años,  2 meses,  3 semanas y  4 dias'),(657,'Frecuente',_binary '','Miembro nuevo con  0 años,  10 meses,  3 semanas y  0 dias'),(658,'Frecuente',_binary '','Miembro nuevo con  0 años,  11 meses,  0 semanas y  2 dias'),(659,'Frecuente',_binary '','Miembro regular con  1 años,  3 meses,  0 semanas y  1 dias'),(660,'Una sola visita',_binary '','Miembro regular con  1 años,  11 meses,  1 semanas y  2 dias'),(661,'Frecuente',_binary '','Miembro nuevo con  0 años,  10 meses,  2 semanas y  1 dias'),(662,'Nuevo',_binary '','Miembro regular con  3 años,  3 meses,  2 semanas y  5 dias'),(663,'Una sola visita',_binary '','Miembro regular con  1 años,  3 meses,  3 semanas y  0 dias'),(664,'Ocasional',_binary '','Miembro nuevo con  0 años,  9 meses,  1 semanas y  1 dias'),(665,'Frecuente',_binary '','Miembro nuevo con  0 años,  7 meses,  0 semanas y  2 dias'),(666,'Nuevo',_binary '','Miembro regular con  3 años,  7 meses,  4 semanas y  5 dias'),(667,'Una sola visita',_binary '','Miembro regular con  2 años,  3 meses,  4 semanas y  4 dias'),(668,'Nuevo',_binary '','Miembro regular con  1 años,  2 meses,  1 semanas y  3 dias'),(669,'Nuevo',_binary '','Miembro nuevo con  0 años,  7 meses,  0 semanas y  3 dias'),(670,'Frecuente',_binary '','Miembro regular con  2 años,  10 meses,  2 semanas y  0 dias'),(671,'Una sola visita',_binary '','Miembro nuevo con  0 años,  7 meses,  4 semanas y  2 dias'),(672,'Frecuente',_binary '','Miembro regular con  3 años,  0 meses,  2 semanas y  4 dias'),(673,'Nuevo',_binary '','Miembro nuevo con  0 años,  10 meses,  1 semanas y  1 dias'),(674,'Una sola visita',_binary '','Miembro regular con  2 años,  8 meses,  3 semanas y  1 dias'),(675,'Frecuente',_binary '','Miembro regular con  1 años,  9 meses,  3 semanas y  4 dias'),(676,'Ocasional',_binary '','Miembro nuevo con  0 años,  3 meses,  2 semanas y  0 dias'),(677,'Una sola visita',_binary '','Miembro nuevo con  0 años,  7 meses,  3 semanas y  5 dias'),(678,'Frecuente',_binary '','Miembro nuevo con  0 años,  6 meses,  3 semanas y  3 dias'),(679,'Frecuente',_binary '','Miembro regular con  1 años,  6 meses,  2 semanas y  4 dias'),(680,'Una sola visita',_binary '','Miembro regular con  3 años,  3 meses,  4 semanas y  5 dias'),(681,'Frecuente',_binary '','Miembro regular con  3 años,  8 meses,  1 semanas y  1 dias'),(682,'Nuevo',_binary '','Miembro regular con  3 años,  9 meses,  1 semanas y  0 dias'),(683,'Nuevo',_binary '','Miembro regular con  3 años,  8 meses,  1 semanas y  6 dias'),(684,'Esporádico',_binary '','Miembro regular con  2 años,  4 meses,  0 semanas y  2 dias'),(685,'Nuevo',_binary '','Miembro regular con  3 años,  7 meses,  2 semanas y  1 dias'),(686,'Una sola visita',_binary '','Miembro regular con  3 años,  11 meses,  1 semanas y  6 dias'),(687,'Nuevo',_binary '','Miembro regular con  1 años,  7 meses,  3 semanas y  1 dias'),(688,'Ocasional',_binary '','Miembro regular con  3 años,  0 meses,  4 semanas y  1 dias'),(689,'Frecuente',_binary '','Miembro regular con  2 años,  3 meses,  4 semanas y  4 dias'),(690,'Ocasional',_binary '','Miembro nuevo con  0 años,  6 meses,  0 semanas y  0 dias'),(691,'Nuevo',_binary '','Miembro regular con  3 años,  1 meses,  2 semanas y  4 dias'),(692,'Frecuente',_binary '','Miembro regular con  1 años,  0 meses,  2 semanas y  4 dias'),(693,'Una sola visita',_binary '','Miembro regular con  2 años,  7 meses,  0 semanas y  3 dias'),(694,'Frecuente',_binary '','Miembro regular con  3 años,  7 meses,  3 semanas y  4 dias'),(695,'Esporádico',_binary '','Miembro regular con  2 años,  3 meses,  1 semanas y  5 dias'),(696,'Una sola visita',_binary '','Miembro regular con  3 años,  9 meses,  1 semanas y  6 dias'),(697,'Esporádico',_binary '','Miembro nuevo con  0 años,  9 meses,  3 semanas y  0 dias'),(698,'Frecuente',_binary '','Miembro nuevo con  0 años,  10 meses,  1 semanas y  5 dias'),(699,'Una sola visita',_binary '','Miembro regular con  2 años,  7 meses,  1 semanas y  5 dias'),(700,'Una sola visita',_binary '','Miembro nuevo con  0 años,  1 meses,  4 semanas y  6 dias'),(701,'Frecuente',_binary '','Miembro regular con  3 años,  7 meses,  0 semanas y  2 dias'),(702,'Una sola visita',_binary '','Miembro regular con  3 años,  7 meses,  2 semanas y  5 dias'),(703,'Ocasional',_binary '','Miembro regular con  1 años,  1 meses,  2 semanas y  1 dias'),(704,'Una sola visita',_binary '','Miembro regular con  1 años,  5 meses,  3 semanas y  2 dias'),(705,'Frecuente',_binary '','Miembro regular con  3 años,  8 meses,  4 semanas y  5 dias'),(706,'Frecuente',_binary '','Miembro nuevo con  0 años,  6 meses,  2 semanas y  0 dias'),(707,'Esporádico',_binary '','Miembro regular con  1 años,  8 meses,  4 semanas y  6 dias'),(708,'Ocasional',_binary '','Miembro regular con  3 años,  0 meses,  1 semanas y  5 dias'),(709,'Ocasional',_binary '','Miembro nuevo con  0 años,  5 meses,  2 semanas y  1 dias'),(710,'Esporádico',_binary '','Miembro regular con  2 años,  3 meses,  4 semanas y  4 dias'),(711,'Esporádico',_binary '','Miembro nuevo con  0 años,  4 meses,  3 semanas y  3 dias'),(712,'Nuevo',_binary '','Miembro regular con  3 años,  5 meses,  2 semanas y  5 dias'),(713,'Esporádico',_binary '','Miembro regular con  2 años,  8 meses,  3 semanas y  4 dias'),(714,'Nuevo',_binary '','Miembro regular con  1 años,  3 meses,  1 semanas y  0 dias'),(715,'Nuevo',_binary '','Miembro nuevo con  0 años,  8 meses,  2 semanas y  2 dias'),(716,'Ocasional',_binary '','Miembro regular con  1 años,  9 meses,  3 semanas y  2 dias'),(717,'Esporádico',_binary '','Miembro regular con  2 años,  7 meses,  2 semanas y  0 dias'),(718,'Ocasional',_binary '','Miembro regular con  1 años,  8 meses,  1 semanas y  2 dias'),(719,'Esporádico',_binary '','Miembro regular con  3 años,  8 meses,  3 semanas y  6 dias'),(720,'Esporádico',_binary '','Miembro nuevo con  0 años,  9 meses,  2 semanas y  3 dias'),(721,'Frecuente',_binary '','Miembro regular con  1 años,  5 meses,  2 semanas y  4 dias'),(722,'Frecuente',_binary '','Miembro regular con  1 años,  1 meses,  2 semanas y  1 dias'),(723,'Frecuente',_binary '','Miembro antiguo con  4 años,  0 meses,  3 semanas y  3 dias'),(724,'Frecuente',_binary '','Miembro regular con  1 años,  1 meses,  1 semanas y  5 dias'),(725,'Frecuente',_binary '','Miembro regular con  1 años,  6 meses,  4 semanas y  0 dias'),(726,'Frecuente',_binary '','Miembro nuevo con  0 años,  7 meses,  2 semanas y  4 dias'),(727,'Ocasional',_binary '','Miembro regular con  1 años,  11 meses,  1 semanas y  3 dias'),(728,'Una sola visita',_binary '','Miembro nuevo con  0 años,  1 meses,  4 semanas y  2 dias'),(729,'Frecuente',_binary '','Miembro regular con  1 años,  8 meses,  3 semanas y  0 dias'),(730,'Ocasional',_binary '','Miembro regular con  3 años,  10 meses,  3 semanas y  0 dias'),(731,'Esporádico',_binary '','Miembro regular con  2 años,  6 meses,  3 semanas y  3 dias'),(732,'Una sola visita',_binary '','Miembro regular con  1 años,  1 meses,  1 semanas y  5 dias'),(733,'Ocasional',_binary '','Miembro nuevo con  0 años,  6 meses,  2 semanas y  1 dias'),(734,'Esporádico',_binary '','Miembro regular con  1 años,  1 meses,  1 semanas y  2 dias'),(735,'Esporádico',_binary '','Miembro regular con  2 años,  6 meses,  0 semanas y  3 dias'),(736,'Nuevo',_binary '','Miembro regular con  3 años,  6 meses,  2 semanas y  0 dias'),(737,'Nuevo',_binary '','Miembro regular con  1 años,  8 meses,  2 semanas y  0 dias'),(738,'Nuevo',_binary '','Miembro regular con  2 años,  8 meses,  2 semanas y  3 dias'),(739,'Una sola visita',_binary '','Miembro regular con  3 años,  0 meses,  3 semanas y  3 dias'),(740,'Esporádico',_binary '','Miembro regular con  2 años,  1 meses,  4 semanas y  4 dias'),(741,'Frecuente',_binary '','Miembro regular con  1 años,  11 meses,  2 semanas y  0 dias'),(742,'Frecuente',_binary '','Miembro nuevo con  0 años,  10 meses,  0 semanas y  0 dias'),(743,'Ocasional',_binary '','Miembro nuevo con  0 años,  7 meses,  1 semanas y  6 dias'),(744,'Frecuente',_binary '','Miembro regular con  1 años,  4 meses,  2 semanas y  6 dias'),(745,'Una sola visita',_binary '','Miembro regular con  3 años,  3 meses,  2 semanas y  4 dias'),(746,'Ocasional',_binary '','Miembro regular con  3 años,  5 meses,  3 semanas y  5 dias'),(747,'Ocasional',_binary '','Miembro regular con  3 años,  7 meses,  2 semanas y  0 dias'),(748,'Frecuente',_binary '','Miembro regular con  3 años,  3 meses,  0 semanas y  1 dias'),(749,'Frecuente',_binary '','Miembro regular con  1 años,  7 meses,  2 semanas y  0 dias'),(750,'Nuevo',_binary '','Miembro regular con  1 años,  4 meses,  3 semanas y  1 dias'),(751,'Una sola visita',_binary '','Miembro regular con  1 años,  9 meses,  2 semanas y  5 dias'),(752,'Esporádico',_binary '','Miembro regular con  1 años,  2 meses,  3 semanas y  6 dias'),(753,'Ocasional',_binary '','Miembro regular con  1 años,  8 meses,  2 semanas y  2 dias'),(754,'Esporádico',_binary '','Miembro regular con  3 años,  3 meses,  1 semanas y  2 dias'),(755,'Esporádico',_binary '','Miembro regular con  1 años,  4 meses,  2 semanas y  5 dias'),(756,'Una sola visita',_binary '','Miembro antiguo con  4 años,  1 meses,  3 semanas y  3 dias'),(757,'Nuevo',_binary '','Miembro regular con  2 años,  5 meses,  3 semanas y  6 dias'),(758,'Nuevo',_binary '','Miembro regular con  3 años,  9 meses,  2 semanas y  5 dias'),(759,'Ocasional',_binary '','Miembro regular con  3 años,  10 meses,  1 semanas y  5 dias'),(760,'Ocasional',_binary '','Miembro regular con  3 años,  1 meses,  3 semanas y  6 dias'),(761,'Frecuente',_binary '','Miembro regular con  2 años,  11 meses,  3 semanas y  6 dias'),(762,'Frecuente',_binary '','Miembro regular con  2 años,  11 meses,  2 semanas y  2 dias'),(763,'Esporádico',_binary '','Miembro regular con  2 años,  0 meses,  4 semanas y  5 dias'),(764,'Ocasional',_binary '','Miembro regular con  3 años,  0 meses,  1 semanas y  4 dias'),(765,'Nuevo',_binary '','Miembro regular con  1 años,  7 meses,  2 semanas y  6 dias'),(766,'Esporádico',_binary '','Miembro regular con  3 años,  6 meses,  2 semanas y  0 dias'),(767,'Nuevo',_binary '','Miembro regular con  1 años,  1 meses,  2 semanas y  1 dias'),(768,'Esporádico',_binary '','Miembro regular con  2 años,  11 meses,  3 semanas y  0 dias'),(769,'Nuevo',_binary '','Miembro regular con  3 años,  1 meses,  4 semanas y  2 dias'),(770,'Frecuente',_binary '','Miembro regular con  2 años,  8 meses,  4 semanas y  5 dias'),(771,'Nuevo',_binary '','Miembro nuevo con  0 años,  4 meses,  4 semanas y  0 dias'),(772,'Ocasional',_binary '','Miembro nuevo con  0 años,  1 meses,  0 semanas y  0 dias'),(773,'Una sola visita',_binary '','Miembro nuevo con  0 años,  5 meses,  1 semanas y  0 dias'),(774,'Frecuente',_binary '','Miembro nuevo con  0 años,  8 meses,  3 semanas y  3 dias'),(775,'Frecuente',_binary '','Miembro regular con  2 años,  8 meses,  1 semanas y  3 dias'),(776,'Nuevo',_binary '','Miembro regular con  2 años,  8 meses,  3 semanas y  0 dias'),(777,'Frecuente',_binary '','Miembro antiguo con  4 años,  0 meses,  3 semanas y  0 dias'),(778,'Ocasional',_binary '','Miembro regular con  1 años,  10 meses,  1 semanas y  4 dias'),(779,'Nuevo',_binary '','Miembro regular con  1 años,  0 meses,  3 semanas y  1 dias'),(780,'Esporádico',_binary '','Miembro regular con  3 años,  3 meses,  1 semanas y  0 dias'),(781,'Nuevo',_binary '','Miembro regular con  3 años,  11 meses,  4 semanas y  4 dias'),(782,'Ocasional',_binary '','Miembro regular con  2 años,  0 meses,  3 semanas y  1 dias'),(783,'Nuevo',_binary '','Miembro regular con  3 años,  8 meses,  3 semanas y  0 dias'),(784,'Una sola visita',_binary '','Miembro nuevo con  0 años,  9 meses,  2 semanas y  0 dias'),(785,'Una sola visita',_binary '','Miembro nuevo con  0 años,  5 meses,  1 semanas y  0 dias'),(786,'Frecuente',_binary '','Miembro regular con  3 años,  8 meses,  1 semanas y  3 dias'),(787,'Esporádico',_binary '','Miembro nuevo con  0 años,  10 meses,  3 semanas y  1 dias'),(788,'Nuevo',_binary '','Miembro nuevo con  0 años,  4 meses,  2 semanas y  5 dias'),(789,'Frecuente',_binary '','Miembro regular con  2 años,  1 meses,  1 semanas y  6 dias'),(790,'Ocasional',_binary '','Miembro regular con  1 años,  0 meses,  2 semanas y  4 dias'),(791,'Una sola visita',_binary '','Miembro regular con  3 años,  8 meses,  4 semanas y  4 dias'),(792,'Frecuente',_binary '','Miembro nuevo con  0 años,  3 meses,  1 semanas y  6 dias'),(793,'Frecuente',_binary '','Miembro regular con  2 años,  1 meses,  3 semanas y  3 dias'),(794,'Nuevo',_binary '','Miembro regular con  3 años,  4 meses,  1 semanas y  2 dias'),(795,'Nuevo',_binary '','Miembro nuevo con  0 años,  5 meses,  2 semanas y  3 dias'),(796,'Ocasional',_binary '','Miembro regular con  1 años,  2 meses,  2 semanas y  5 dias'),(797,'Nuevo',_binary '','Miembro regular con  2 años,  4 meses,  0 semanas y  0 dias'),(798,'Nuevo',_binary '','Miembro nuevo con  0 años,  3 meses,  3 semanas y  1 dias'),(799,'Frecuente',_binary '','Miembro nuevo con  0 años,  3 meses,  3 semanas y  6 dias'),(800,'Una sola visita',_binary '','Miembro regular con  2 años,  6 meses,  2 semanas y  4 dias'),(801,'Ocasional',_binary '','Miembro regular con  3 años,  10 meses,  2 semanas y  2 dias'),(802,'Nuevo',_binary '','Miembro regular con  3 años,  5 meses,  2 semanas y  0 dias'),(803,'Nuevo',_binary '','Miembro regular con  2 años,  0 meses,  4 semanas y  6 dias'),(804,'Una sola visita',_binary '','Miembro nuevo con  0 años,  9 meses,  1 semanas y  0 dias'),(805,'Ocasional',_binary '','Miembro regular con  2 años,  10 meses,  2 semanas y  6 dias'),(806,'Una sola visita',_binary '','Miembro regular con  1 años,  6 meses,  3 semanas y  2 dias'),(807,'Nuevo',_binary '','Miembro regular con  3 años,  7 meses,  1 semanas y  1 dias'),(808,'Frecuente',_binary '','Miembro nuevo con  0 años,  7 meses,  2 semanas y  4 dias'),(809,'Esporádico',_binary '','Miembro regular con  3 años,  0 meses,  0 semanas y  2 dias'),(810,'Una sola visita',_binary '','Miembro regular con  2 años,  6 meses,  1 semanas y  0 dias'),(811,'Esporádico',_binary '','Miembro regular con  1 años,  10 meses,  3 semanas y  1 dias'),(812,'Ocasional',_binary '','Miembro nuevo con  0 años,  9 meses,  2 semanas y  4 dias'),(813,'Ocasional',_binary '','Miembro nuevo con  0 años,  1 meses,  3 semanas y  3 dias'),(814,'Una sola visita',_binary '','Miembro nuevo con  0 años,  4 meses,  4 semanas y  5 dias'),(815,'Nuevo',_binary '','Miembro nuevo con  0 años,  7 meses,  2 semanas y  4 dias'),(816,'Frecuente',_binary '','Miembro nuevo con  0 años,  10 meses,  4 semanas y  4 dias'),(817,'Esporádico',_binary '','Miembro regular con  1 años,  11 meses,  2 semanas y  3 dias'),(818,'Ocasional',_binary '','Miembro regular con  1 años,  8 meses,  1 semanas y  2 dias'),(819,'Frecuente',_binary '','Miembro regular con  3 años,  6 meses,  3 semanas y  2 dias'),(820,'Una sola visita',_binary '','Miembro nuevo con  0 años,  2 meses,  0 semanas y  2 dias'),(821,'Frecuente',_binary '','Miembro regular con  1 años,  3 meses,  0 semanas y  1 dias'),(822,'Ocasional',_binary '','Miembro regular con  2 años,  2 meses,  0 semanas y  3 dias'),(823,'Ocasional',_binary '','Miembro regular con  2 años,  9 meses,  0 semanas y  2 dias'),(824,'Esporádico',_binary '','Miembro regular con  1 años,  1 meses,  2 semanas y  6 dias'),(825,'Esporádico',_binary '','Miembro regular con  3 años,  3 meses,  0 semanas y  2 dias'),(826,'Frecuente',_binary '','Miembro regular con  1 años,  7 meses,  3 semanas y  4 dias'),(827,'Frecuente',_binary '','Miembro regular con  2 años,  10 meses,  0 semanas y  3 dias'),(828,'Una sola visita',_binary '','Miembro antiguo con  4 años,  0 meses,  3 semanas y  1 dias'),(829,'Frecuente',_binary '','Miembro regular con  1 años,  0 meses,  3 semanas y  1 dias'),(830,'Una sola visita',_binary '','Miembro regular con  2 años,  8 meses,  1 semanas y  0 dias'),(831,'Esporádico',_binary '','Miembro regular con  1 años,  5 meses,  0 semanas y  2 dias'),(832,'Frecuente',_binary '','Miembro regular con  1 años,  7 meses,  0 semanas y  1 dias'),(833,'Esporádico',_binary '','Miembro regular con  1 años,  2 meses,  1 semanas y  0 dias'),(834,'Esporádico',_binary '','Miembro regular con  3 años,  0 meses,  1 semanas y  0 dias'),(835,'Nuevo',_binary '','Miembro nuevo con  0 años,  2 meses,  0 semanas y  2 dias'),(836,'Frecuente',_binary '','Miembro nuevo con  0 años,  3 meses,  3 semanas y  2 dias'),(837,'Esporádico',_binary '','Miembro regular con  3 años,  10 meses,  2 semanas y  2 dias'),(838,'Nuevo',_binary '','Miembro nuevo con  0 años,  10 meses,  1 semanas y  0 dias'),(839,'Frecuente',_binary '','Miembro antiguo con  4 años,  1 meses,  4 semanas y  5 dias'),(840,'Nuevo',_binary '','Miembro regular con  3 años,  4 meses,  2 semanas y  3 dias'),(841,'Esporádico',_binary '','Miembro regular con  1 años,  2 meses,  4 semanas y  4 dias'),(842,'Nuevo',_binary '','Miembro nuevo con  0 años,  8 meses,  2 semanas y  3 dias'),(843,'Una sola visita',_binary '','Miembro regular con  3 años,  5 meses,  4 semanas y  6 dias'),(844,'Ocasional',_binary '','Miembro regular con  2 años,  5 meses,  3 semanas y  4 dias'),(845,'Esporádico',_binary '','Miembro regular con  1 años,  0 meses,  3 semanas y  5 dias'),(846,'Nuevo',_binary '','Miembro regular con  3 años,  9 meses,  3 semanas y  0 dias'),(847,'Ocasional',_binary '','Miembro regular con  3 años,  1 meses,  4 semanas y  5 dias'),(848,'Esporádico',_binary '','Miembro regular con  2 años,  7 meses,  3 semanas y  3 dias'),(849,'Esporádico',_binary '','Miembro regular con  3 años,  9 meses,  3 semanas y  0 dias'),(850,'Nuevo',_binary '','Miembro regular con  2 años,  6 meses,  2 semanas y  4 dias'),(851,'Nuevo',_binary '','Miembro regular con  1 años,  7 meses,  2 semanas y  0 dias'),(852,'Esporádico',_binary '','Miembro nuevo con  0 años,  8 meses,  0 semanas y  1 dias'),(853,'Ocasional',_binary '','Miembro regular con  2 años,  11 meses,  2 semanas y  4 dias'),(854,'Nuevo',_binary '','Miembro nuevo con  0 años,  10 meses,  1 semanas y  1 dias'),(855,'Una sola visita',_binary '','Miembro regular con  2 años,  11 meses,  2 semanas y  6 dias'),(856,'Esporádico',_binary '','Miembro regular con  2 años,  0 meses,  2 semanas y  5 dias'),(857,'Frecuente',_binary '','Miembro antiguo con  4 años,  0 meses,  1 semanas y  3 dias'),(858,'Una sola visita',_binary '','Miembro regular con  3 años,  0 meses,  3 semanas y  0 dias'),(859,'Frecuente',_binary '','Miembro regular con  2 años,  3 meses,  0 semanas y  2 dias'),(860,'Nuevo',_binary '','Miembro regular con  3 años,  1 meses,  4 semanas y  0 dias'),(861,'Una sola visita',_binary '','Miembro nuevo con  0 años,  9 meses,  2 semanas y  6 dias'),(862,'Frecuente',_binary '','Miembro regular con  2 años,  4 meses,  0 semanas y  0 dias'),(863,'Esporádico',_binary '','Miembro regular con  2 años,  9 meses,  0 semanas y  1 dias'),(864,'Ocasional',_binary '','Miembro nuevo con  0 años,  0 meses,  0 semanas y  3 dias'),(865,'Una sola visita',_binary '','Miembro regular con  1 años,  2 meses,  2 semanas y  2 dias'),(866,'Ocasional',_binary '','Miembro nuevo con  0 años,  9 meses,  4 semanas y  5 dias'),(867,'Una sola visita',_binary '','Miembro regular con  3 años,  0 meses,  1 semanas y  3 dias'),(868,'Frecuente',_binary '','Miembro regular con  2 años,  2 meses,  2 semanas y  5 dias'),(869,'Una sola visita',_binary '','Miembro regular con  2 años,  6 meses,  4 semanas y  2 dias'),(870,'Frecuente',_binary '','Miembro regular con  2 años,  0 meses,  4 semanas y  2 dias'),(871,'Frecuente',_binary '','Miembro regular con  3 años,  1 meses,  1 semanas y  2 dias'),(872,'Una sola visita',_binary '','Miembro regular con  1 años,  11 meses,  2 semanas y  3 dias'),(873,'Nuevo',_binary '','Miembro nuevo con  0 años,  2 meses,  2 semanas y  1 dias'),(874,'Una sola visita',_binary '','Miembro nuevo con  0 años,  0 meses,  4 semanas y  1 dias'),(875,'Ocasional',_binary '','Miembro regular con  3 años,  11 meses,  0 semanas y  3 dias'),(876,'Nuevo',_binary '','Miembro regular con  3 años,  10 meses,  0 semanas y  2 dias'),(877,'Ocasional',_binary '','Miembro regular con  3 años,  10 meses,  1 semanas y  3 dias'),(878,'Una sola visita',_binary '','Miembro regular con  3 años,  1 meses,  3 semanas y  2 dias'),(879,'Esporádico',_binary '','Miembro regular con  3 años,  7 meses,  0 semanas y  2 dias'),(880,'Ocasional',_binary '','Miembro regular con  2 años,  8 meses,  1 semanas y  0 dias'),(881,'Esporádico',_binary '','Miembro nuevo con  0 años,  9 meses,  1 semanas y  0 dias'),(882,'Esporádico',_binary '','Miembro regular con  3 años,  3 meses,  2 semanas y  6 dias'),(883,'Frecuente',_binary '','Miembro regular con  1 años,  2 meses,  1 semanas y  1 dias'),(884,'Esporádico',_binary '','Miembro regular con  1 años,  9 meses,  3 semanas y  5 dias'),(885,'Nuevo',_binary '','Miembro regular con  1 años,  6 meses,  0 semanas y  2 dias'),(886,'Una sola visita',_binary '','Miembro regular con  3 años,  3 meses,  4 semanas y  4 dias'),(887,'Frecuente',_binary '','Miembro regular con  2 años,  8 meses,  2 semanas y  1 dias'),(888,'Nuevo',_binary '','Miembro regular con  2 años,  10 meses,  4 semanas y  0 dias'),(889,'Frecuente',_binary '','Miembro regular con  1 años,  2 meses,  3 semanas y  3 dias'),(890,'Una sola visita',_binary '','Miembro regular con  1 años,  9 meses,  1 semanas y  1 dias'),(891,'Frecuente',_binary '','Miembro antiguo con  4 años,  0 meses,  1 semanas y  4 dias'),(892,'Esporádico',_binary '','Miembro regular con  2 años,  6 meses,  1 semanas y  1 dias'),(893,'Nuevo',_binary '','Miembro regular con  2 años,  10 meses,  3 semanas y  0 dias'),(894,'Esporádico',_binary '','Miembro regular con  3 años,  10 meses,  1 semanas y  5 dias'),(895,'Ocasional',_binary '','Miembro regular con  3 años,  8 meses,  1 semanas y  4 dias'),(896,'Frecuente',_binary '','Miembro regular con  3 años,  3 meses,  3 semanas y  4 dias'),(897,'Una sola visita',_binary '','Miembro regular con  1 años,  9 meses,  3 semanas y  5 dias'),(898,'Esporádico',_binary '','Miembro nuevo con  0 años,  7 meses,  1 semanas y  0 dias'),(899,'Esporádico',_binary '','Miembro regular con  3 años,  10 meses,  1 semanas y  2 dias'),(900,'Una sola visita',_binary '','Miembro regular con  3 años,  3 meses,  1 semanas y  5 dias'),(901,'Nuevo',_binary '','Miembro nuevo con  0 años,  1 meses,  3 semanas y  3 dias'),(902,'Ocasional',_binary '','Miembro nuevo con  0 años,  8 meses,  3 semanas y  5 dias'),(903,'Una sola visita',_binary '','Miembro regular con  2 años,  2 meses,  0 semanas y  3 dias'),(904,'Ocasional',_binary '','Miembro regular con  3 años,  8 meses,  3 semanas y  2 dias'),(905,'Una sola visita',_binary '','Miembro regular con  2 años,  6 meses,  3 semanas y  4 dias'),(906,'Esporádico',_binary '','Miembro regular con  2 años,  3 meses,  3 semanas y  2 dias'),(907,'Una sola visita',_binary '','Miembro regular con  1 años,  7 meses,  2 semanas y  1 dias'),(908,'Frecuente',_binary '','Miembro nuevo con  0 años,  1 meses,  0 semanas y  3 dias'),(909,'Una sola visita',_binary '','Miembro regular con  3 años,  0 meses,  3 semanas y  3 dias'),(910,'Esporádico',_binary '','Miembro antiguo con  4 años,  1 meses,  4 semanas y  4 dias'),(911,'Una sola visita',_binary '','Miembro regular con  2 años,  5 meses,  2 semanas y  3 dias'),(912,'Una sola visita',_binary '','Miembro regular con  1 años,  2 meses,  4 semanas y  5 dias'),(913,'Una sola visita',_binary '','Miembro regular con  2 años,  7 meses,  4 semanas y  2 dias'),(914,'Esporádico',_binary '','Miembro antiguo con  4 años,  1 meses,  3 semanas y  1 dias'),(915,'Ocasional',_binary '','Miembro regular con  1 años,  7 meses,  3 semanas y  3 dias'),(916,'Ocasional',_binary '','Miembro regular con  3 años,  4 meses,  2 semanas y  2 dias'),(917,'Esporádico',_binary '','Miembro regular con  3 años,  8 meses,  2 semanas y  1 dias'),(918,'Una sola visita',_binary '','Miembro regular con  3 años,  0 meses,  2 semanas y  1 dias'),(919,'Ocasional',_binary '','Miembro regular con  2 años,  9 meses,  3 semanas y  2 dias'),(920,'Una sola visita',_binary '','Miembro regular con  1 años,  3 meses,  3 semanas y  2 dias'),(921,'Frecuente',_binary '','Miembro regular con  2 años,  2 meses,  1 semanas y  3 dias'),(922,'Nuevo',_binary '','Miembro regular con  1 años,  8 meses,  2 semanas y  3 dias'),(923,'Ocasional',_binary '','Miembro regular con  2 años,  5 meses,  2 semanas y  0 dias'),(924,'Una sola visita',_binary '','Miembro nuevo con  0 años,  4 meses,  3 semanas y  0 dias'),(925,'Frecuente',_binary '','Miembro regular con  3 años,  6 meses,  1 semanas y  4 dias'),(926,'Frecuente',_binary '','Miembro regular con  2 años,  2 meses,  2 semanas y  6 dias'),(927,'Una sola visita',_binary '','Miembro nuevo con  0 años,  8 meses,  4 semanas y  1 dias'),(928,'Ocasional',_binary '','Miembro regular con  2 años,  5 meses,  1 semanas y  0 dias'),(929,'Nuevo',_binary '','Miembro regular con  2 años,  4 meses,  1 semanas y  6 dias'),(930,'Nuevo',_binary '','Miembro regular con  3 años,  4 meses,  2 semanas y  5 dias'),(931,'Esporádico',_binary '','Miembro nuevo con  0 años,  9 meses,  2 semanas y  5 dias'),(932,'Esporádico',_binary '','Miembro nuevo con  0 años,  4 meses,  0 semanas y  3 dias'),(933,'Ocasional',_binary '','Miembro regular con  2 años,  4 meses,  4 semanas y  4 dias'),(934,'Una sola visita',_binary '','Miembro regular con  2 años,  8 meses,  1 semanas y  4 dias'),(935,'Esporádico',_binary '','Miembro nuevo con  0 años,  9 meses,  3 semanas y  2 dias'),(936,'Ocasional',_binary '','Miembro regular con  2 años,  5 meses,  3 semanas y  4 dias'),(937,'Ocasional',_binary '','Miembro regular con  2 años,  11 meses,  0 semanas y  1 dias'),(938,'Nuevo',_binary '','Miembro nuevo con  0 años,  7 meses,  0 semanas y  3 dias'),(939,'Nuevo',_binary '','Miembro regular con  2 años,  7 meses,  2 semanas y  4 dias'),(940,'Una sola visita',_binary '','Miembro regular con  1 años,  9 meses,  1 semanas y  2 dias'),(941,'Ocasional',_binary '','Miembro regular con  2 años,  7 meses,  2 semanas y  4 dias'),(942,'Nuevo',_binary '','Miembro regular con  1 años,  7 meses,  2 semanas y  3 dias'),(943,'Frecuente',_binary '','Miembro regular con  2 años,  7 meses,  3 semanas y  2 dias'),(944,'Una sola visita',_binary '','Miembro regular con  3 años,  7 meses,  4 semanas y  2 dias'),(945,'Esporádico',_binary '','Miembro regular con  3 años,  2 meses,  1 semanas y  1 dias'),(946,'Nuevo',_binary '','Miembro regular con  3 años,  0 meses,  2 semanas y  4 dias'),(947,'Una sola visita',_binary '','Miembro regular con  3 años,  6 meses,  1 semanas y  0 dias'),(948,'Nuevo',_binary '','Miembro regular con  1 años,  3 meses,  1 semanas y  6 dias'),(949,'Esporádico',_binary '','Miembro antiguo con  4 años,  1 meses,  2 semanas y  2 dias'),(950,'Una sola visita',_binary '','Miembro regular con  1 años,  1 meses,  1 semanas y  0 dias'),(951,'Nuevo',_binary '','Miembro nuevo con  0 años,  8 meses,  3 semanas y  0 dias'),(952,'Una sola visita',_binary '','Miembro regular con  3 años,  4 meses,  2 semanas y  0 dias'),(953,'Esporádico',_binary '','Miembro regular con  1 años,  9 meses,  0 semanas y  1 dias'),(954,'Nuevo',_binary '','Miembro regular con  2 años,  5 meses,  3 semanas y  6 dias'),(955,'Frecuente',_binary '','Miembro regular con  1 años,  5 meses,  4 semanas y  6 dias'),(956,'Esporádico',_binary '','Miembro regular con  3 años,  4 meses,  3 semanas y  0 dias'),(957,'Una sola visita',_binary '','Miembro regular con  2 años,  0 meses,  0 semanas y  2 dias'),(958,'Una sola visita',_binary '','Miembro regular con  1 años,  6 meses,  4 semanas y  1 dias'),(959,'Esporádico',_binary '','Miembro regular con  1 años,  9 meses,  4 semanas y  4 dias'),(960,'Esporádico',_binary '','Miembro regular con  1 años,  7 meses,  1 semanas y  4 dias'),(961,'Nuevo',_binary '','Miembro regular con  3 años,  10 meses,  0 semanas y  0 dias'),(962,'Ocasional',_binary '','Miembro regular con  2 años,  3 meses,  3 semanas y  2 dias'),(963,'Frecuente',_binary '','Miembro regular con  3 años,  8 meses,  2 semanas y  2 dias'),(964,'Frecuente',_binary '','Miembro nuevo con  0 años,  1 meses,  4 semanas y  1 dias'),(965,'Frecuente',_binary '','Miembro nuevo con  0 años,  0 meses,  1 semanas y  4 dias'),(966,'Ocasional',_binary '','Miembro regular con  1 años,  8 meses,  2 semanas y  5 dias'),(967,'Frecuente',_binary '','Miembro regular con  1 años,  2 meses,  4 semanas y  2 dias'),(968,'Frecuente',_binary '','Miembro nuevo con  0 años,  2 meses,  2 semanas y  3 dias'),(969,'Nuevo',_binary '','Miembro regular con  1 años,  9 meses,  1 semanas y  5 dias'),(970,'Una sola visita',_binary '','Miembro regular con  1 años,  1 meses,  0 semanas y  2 dias'),(971,'Esporádico',_binary '','Miembro regular con  2 años,  1 meses,  2 semanas y  0 dias'),(972,'Esporádico',_binary '','Miembro regular con  3 años,  11 meses,  1 semanas y  3 dias'),(973,'Esporádico',_binary '','Miembro regular con  2 años,  11 meses,  3 semanas y  5 dias'),(974,'Esporádico',_binary '','Miembro regular con  1 años,  8 meses,  3 semanas y  1 dias'),(975,'Nuevo',_binary '','Miembro regular con  2 años,  0 meses,  4 semanas y  4 dias'),(976,'Ocasional',_binary '','Miembro regular con  1 años,  11 meses,  2 semanas y  4 dias'),(977,'Nuevo',_binary '','Miembro nuevo con  0 años,  5 meses,  1 semanas y  0 dias'),(978,'Frecuente',_binary '','Miembro regular con  1 años,  9 meses,  2 semanas y  6 dias'),(979,'Una sola visita',_binary '','Miembro nuevo con  0 años,  6 meses,  2 semanas y  5 dias'),(980,'Una sola visita',_binary '','Miembro nuevo con  0 años,  5 meses,  3 semanas y  3 dias'),(981,'Frecuente',_binary '','Miembro regular con  3 años,  4 meses,  4 semanas y  2 dias'),(982,'Frecuente',_binary '','Miembro nuevo con  0 años,  6 meses,  0 semanas y  3 dias'),(983,'Una sola visita',_binary '','Miembro regular con  2 años,  3 meses,  2 semanas y  6 dias'),(984,'Frecuente',_binary '','Miembro regular con  1 años,  7 meses,  2 semanas y  4 dias'),(985,'Esporádico',_binary '','Miembro regular con  3 años,  7 meses,  2 semanas y  0 dias'),(986,'Esporádico',_binary '','Miembro regular con  1 años,  8 meses,  1 semanas y  4 dias'),(987,'Nuevo',_binary '','Miembro regular con  2 años,  10 meses,  2 semanas y  5 dias'),(988,'Esporádico',_binary '','Miembro nuevo con  0 años,  0 meses,  3 semanas y  3 dias'),(989,'Nuevo',_binary '','Miembro regular con  3 años,  10 meses,  1 semanas y  4 dias'),(990,'Nuevo',_binary '','Miembro nuevo con  0 años,  9 meses,  2 semanas y  1 dias'),(991,'Frecuente',_binary '','Miembro regular con  1 años,  4 meses,  4 semanas y  1 dias'),(992,'Frecuente',_binary '','Miembro regular con  2 años,  2 meses,  2 semanas y  4 dias'),(993,'Una sola visita',_binary '','Miembro regular con  3 años,  6 meses,  4 semanas y  4 dias'),(994,'Ocasional',_binary '','Miembro nuevo con  0 años,  5 meses,  1 semanas y  5 dias'),(995,'Nuevo',_binary '','Miembro regular con  1 años,  10 meses,  3 semanas y  5 dias'),(996,'Esporádico',_binary '','Miembro nuevo con  0 años,  6 meses,  2 semanas y  6 dias'),(997,'Ocasional',_binary '','Miembro regular con  3 años,  9 meses,  3 semanas y  2 dias'),(998,'Ocasional',_binary '','Miembro regular con  3 años,  10 meses,  1 semanas y  3 dias'),(999,'Ocasional',_binary '','Miembro regular con  2 años,  8 meses,  0 semanas y  0 dias'),(1000,'Frecuente',_binary '','Miembro antiguo con  4 años,  0 meses,  3 semanas y  6 dias'),(1001,'Una sola visita',_binary '','Miembro regular con  3 años,  8 meses,  4 semanas y  2 dias'),(1002,'Esporádico',_binary '','Miembro nuevo con  0 años,  7 meses,  1 semanas y  5 dias'),(1003,'Una sola visita',_binary '','Miembro regular con  1 años,  8 meses,  1 semanas y  0 dias'),(1004,'Una sola visita',_binary '','Miembro regular con  2 años,  3 meses,  4 semanas y  5 dias'),(1005,'Una sola visita',_binary '','Miembro regular con  3 años,  1 meses,  3 semanas y  0 dias'),(1006,'Esporádico',_binary '','Miembro regular con  3 años,  6 meses,  0 semanas y  3 dias'),(1007,'Una sola visita',_binary '','Miembro regular con  3 años,  9 meses,  1 semanas y  4 dias'),(1008,'Esporádico',_binary '','Miembro regular con  1 años,  1 meses,  3 semanas y  0 dias'),(1009,'Frecuente',_binary '','Miembro regular con  3 años,  10 meses,  4 semanas y  6 dias'),(1010,'Frecuente',_binary '','Miembro regular con  3 años,  4 meses,  3 semanas y  0 dias'),(1011,'Nuevo',_binary '','Miembro regular con  3 años,  1 meses,  1 semanas y  2 dias'),(1012,'Ocasional',_binary '','Miembro regular con  3 años,  9 meses,  0 semanas y  3 dias'),(1013,'Frecuente',_binary '','Miembro nuevo con  0 años,  7 meses,  4 semanas y  1 dias'),(1014,'Frecuente',_binary '','Miembro regular con  3 años,  6 meses,  2 semanas y  6 dias'),(1015,'Nuevo',_binary '','Miembro nuevo con  0 años,  2 meses,  4 semanas y  4 dias'),(1016,'Una sola visita',_binary '','Miembro regular con  1 años,  8 meses,  2 semanas y  5 dias'),(1017,'Ocasional',_binary '','Miembro regular con  2 años,  7 meses,  0 semanas y  0 dias'),(1018,'Ocasional',_binary '','Miembro nuevo con  0 años,  5 meses,  4 semanas y  0 dias'),(1019,'Una sola visita',_binary '','Miembro regular con  3 años,  8 meses,  2 semanas y  6 dias'),(1020,'Ocasional',_binary '','Miembro nuevo con  0 años,  11 meses,  3 semanas y  0 dias'),(1021,'Frecuente',_binary '','Miembro regular con  1 años,  6 meses,  1 semanas y  2 dias'),(1022,'Frecuente',_binary '','Miembro regular con  3 años,  4 meses,  2 semanas y  6 dias'),(1023,'Esporádico',_binary '','Miembro nuevo con  0 años,  11 meses,  0 semanas y  2 dias'),(1024,'Esporádico',_binary '','Miembro regular con  1 años,  3 meses,  3 semanas y  5 dias');
/*!40000 ALTER TABLE `miembros` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `miembros_AFTER_INSERT` AFTER INSERT ON `miembros` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
	-- Iniciación de las variables
    IF new.membresia_activa = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;
    
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "miembros",
        CONCAT_WS(" ","Se ha insertado un nuevo MIEMBRO con el ID: ",NEW.persona_id, 
        "con los siguientes datos: TIPO = ", NEW.tipo,
        "MEMBRESIA ACTIVA = ", v_cadena_estatus,
        "ANTIGUEDAD = ", NEW.antiguedad),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `miembros_AFTER_UPDATE` AFTER UPDATE ON `miembros` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    
    -- Inicialización de las variables
    IF NEW.membresia_activa = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.membresia_activa = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "miembros",
        CONCAT_WS(" ","Se han actualizado los datos del MIEMBRO con el ID: ",
        NEW.persona_id, "con los siguientes datos:",
        "TIPO = ", OLD.tipo, "cambio a", NEW.tipo,
        "MEMBRESIA ACTIVA =",v_cadena_estatus2,"cambio a", v_cadena_estatus,
        "ANTIGUEDAD = ", OLD.antiguedad, "cambio a", NEW.antiguedad),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `miembros_AFTER_DELETE` AFTER DELETE ON `miembros` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "miembros",
        CONCAT_WS(" ","Se ha eliminado el MIEMBRO con el ID: ", OLD.persona_id),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pagos`
--

DROP TABLE IF EXISTS `pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagos` (
  `ID_Pago` int NOT NULL AUTO_INCREMENT,
  `Monto` decimal(10,2) DEFAULT NULL,
  `Fecha_Pago` date DEFAULT NULL,
  `Metodo_Pago` varchar(50) DEFAULT NULL,
  `Estado_Pago` varchar(50) DEFAULT NULL,
  `membresias_ID` int unsigned NOT NULL,
  PRIMARY KEY (`ID_Pago`),
  KEY `fk_pagos_membresias1_idx` (`membresias_ID`),
  CONSTRAINT `fk_pagos_membresias1` FOREIGN KEY (`membresias_ID`) REFERENCES `membresias` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagos`
--

LOCK TABLES `pagos` WRITE;
/*!40000 ALTER TABLE `pagos` DISABLE KEYS */;
INSERT INTO `pagos` VALUES (7,100.00,'2024-04-13','Tarjeta credito','Pagado',1),(8,100.00,'2024-04-13','Tarjeta credito','Pagado',2),(9,100.00,'2024-04-13','Tarjeta debito','Pagado',3);
/*!40000 ALTER TABLE `pagos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pagos_AFTER_INSERT` AFTER INSERT ON `pagos` FOR EACH ROW BEGIN
  -- Declaración de variables
    DECLARE v_membresia varchar(100) default null;
    
    if new.membresias_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_membresia = (SELECT CONCAT_WS(" ", m.id ,m.codigo, m.tipo, m.tipo_servicios, m.tipo_plan) FROM membresias m WHERE id = NEW.membresias_id);
    else
        SET v_membresia = "Sin membresia asignada";
    end if;
    
    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "pago",
        CONCAT_WS(" ","Se ha insertado una nuevo pago con el ID: ",NEW.ID_Pago, 
        "con los siguientes datos: ",
        "MONTO = ", NEW.monto,
        "FECHA_PAGO= ", NEW.fecha_pago,
        "METODO_PAGO = ", NEW.metodo_pago,
        "MEMBRESIAS_ID = ", v_membresia),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pagos_AFTER_UPDATE` AFTER UPDATE ON `pagos` FOR EACH ROW BEGIN
  -- Declaración de variables
    DECLARE v_membresia varchar(100) default null;
    DECLARE v_membresia2 varchar(100) default null;
    
    if new.membresias_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_membresia = (SELECT CONCAT_WS(" ", m.id ,m.codigo, m.tipo, m.tipo_servicios, m.tipo_plan) FROM membresias m WHERE id = NEW.membresias_id);
    else
        SET v_membresia = "Sin membresia asignada.";
    end if;
    
    IF OLD.membresias_id IS NOT NULL THEN 
		-- En caso de tener el id del pedido
        set v_membresia2 = (SELECT CONCAT_WS(" ", m.id ,m.codigo, m.tipo, m.tipo_servicios, m.tipo_plan) FROM membresias m WHERE id = OLD.membresias_id);
    ELSE
		SET v_membresia2 = "membresia asignada.";
    END IF;
    
        
    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "pago",
        CONCAT_WS(" ","Se han actualizado los datos del DETALLES_PEDIDOS con el ID: ",NEW.ID_Pago, 
        "con los siguientes datos: ",
        "MONTO = ", OLD.monto, "CAMBIO A ", NEW.monto,
        "FECHA_PAGO= ", OLD.fecha_pago, "CAMBIO A ", NEW.fecha_pago,
        "METODO_PAGO = ", OLD.metodo_pago, "CAMBIO A ", NEW.metodo_pago,
        "MEMBRESIAS_ID = ", v_membresia2 , "CAMBIO A ", v_membresia),
        NOW(),
        DEFAULT
    );

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pagos_AFTER_DELETE` AFTER DELETE ON `pagos` FOR EACH ROW BEGIN
INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Delete",
        "pagos",
        CONCAT_WS(" ","Se ha eliminado un PAGO con el ID: ", OLD.id_pago),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Usuario_ID` int unsigned NOT NULL,
  `Total` decimal(6,2) NOT NULL,
  `Fecha_Registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ID`),
  KEY `fk_usuario_3` (`Usuario_ID`),
  CONSTRAINT `fk_usuario_3` FOREIGN KEY (`Usuario_ID`) REFERENCES `usuarios` (`Persona_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pedidos_AFTER_INSERT` AFTER INSERT ON `pedidos` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_usuario varchar(60) default null;
     DECLARE v_cadena_estatus varchar(15) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;
    
    if new.usuario_id is not null then
        -- En caso de tener el id del usuario debemos recuperar su nombre
        set v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.usuario_id);
    else
        SET v_nombre_usuario = "Sin usuario asignado";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "pedidos",
        CONCAT_WS(" ","Se ha insertado un nuevo PEDIDO con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "USUARIO ID = ", v_nombre_usuario,
        "TOTAL = ", NEW.total, 
        "FECHA REGISTRO = ",  NEW.fecha_registro,
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pedidos_AFTER_UPDATE` AFTER UPDATE ON `pedidos` FOR EACH ROW BEGIN
	 -- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_usuario VARCHAR(100) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_usuario2 VARCHAR(100) DEFAULT NULL;

    -- Inicialización de las variables
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    IF NEW.usuario_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = NEW.usuario_id);
    ELSE
		SET v_nombre_usuario = "Sin usuario asignado.";
    END IF;
    
    IF OLD.usuario_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,
		p.segundo_apellido) FROM personas p WHERE id = OLD.usuario_id);
    ELSE
		SET v_nombre_usuario2 = "Sin usuario asignado.";
    END IF;

    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "pedidos",
        CONCAT_WS(" ","Se han actualizado los datos del PEDIDO con el ID: ", NEW.ID,
        "con los siguientes datos:",
        "USUARIO ID = ", v_nombre_usuario2, "cambio a", v_nombre_usuario,
        "TOTAL =",OLD.total,"cambio a", NEW.total,
        "FECHA DE REGISTRO =",OLD.fecha_registro,"cambio a", NEW.fecha_registro,
        "ESTATUS = ", v_cadena_estatus2, "cambio a", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pedidos_AFTER_DELETE` AFTER DELETE ON `pedidos` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "pedidos",
        CONCAT_WS(" ","Se ha eliminado un PEDIDO con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `personas`
--

DROP TABLE IF EXISTS `personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personas` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Titulo_Cortesia` varchar(20) DEFAULT NULL,
  `Nombre` varchar(80) NOT NULL,
  `Primer_Apellido` varchar(80) NOT NULL,
  `Segundo_Apellido` varchar(80) NOT NULL,
  `Fecha_Nacimiento` date NOT NULL,
  `Fotografia` varchar(100) DEFAULT NULL,
  `Genero` enum('M','F','N/B') DEFAULT NULL,
  `Tipo_Sangre` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL,
  `Estatus` bit(1) DEFAULT b'1',
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1065 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personas`
--

LOCK TABLES `personas` WRITE;
/*!40000 ALTER TABLE `personas` DISABLE KEYS */;
INSERT INTO `personas` VALUES (1,NULL,'Pedro','Guerrero','Vázquez','1990-02-17',NULL,'M','B+',_binary '','2023-02-12 17:07:56',NULL),(2,NULL,'Ricardo','Guerrero','Guerrero','1998-10-10',NULL,'M','B+',_binary '','2020-05-16 14:28:45',NULL),(3,NULL,' Agustin','López','Luna','1962-10-02',NULL,'M','O+',_binary '','2023-02-21 12:41:07',NULL),(4,NULL,'Lucía','Chávez','Mendoza','1974-03-12',NULL,'F','B+',_binary '','2022-10-31 13:18:54',NULL),(5,NULL,'Luz','Vázquez','Cortés','1963-05-20',NULL,'F','AB+',_binary '','2021-01-14 16:55:43',NULL),(6,NULL,'Ricardo','Ruíz','Reyes','1972-02-26',NULL,'M','B-',_binary '','2022-05-02 12:42:22',NULL),(7,NULL,'Carmen','Castillo','Ruíz','1982-02-19',NULL,'F','A-',_binary '','2021-12-22 18:09:30',NULL),(8,NULL,'Mario','Martínez','Guerrero','1981-07-13',NULL,'M','AB+',_binary '','2021-01-24 16:28:46',NULL),(9,'Joven','José','Castro','Moreno','1972-10-15',NULL,'M','O-',_binary '','2023-12-26 18:58:25',NULL),(10,'Sr.','Edgar','García','López','1971-09-15',NULL,'M','A+',_binary '','2022-03-19 13:47:10',NULL),(11,NULL,'Flor','Cortes','Ramos','1984-12-16',NULL,'F','O+',_binary '','2020-10-22 16:30:26',NULL),(12,NULL,'Marco','Soto','Guerrero','1988-06-04',NULL,'M','B+',_binary '','2021-12-08 14:54:10',NULL),(13,NULL,'Ricardo','Bautista','Ramírez','2006-02-12',NULL,'M','B+',_binary '','2022-06-17 08:56:16',NULL),(14,NULL,'Jorge','Cruz','De la Cruz','1976-03-11',NULL,'M','B-',_binary '','2023-09-28 11:58:49',NULL),(15,NULL,'Lorena','Morales','Cortes','1974-03-13',NULL,'F','O-',_binary '','2022-06-11 10:47:47',NULL),(16,'Med.','Edgar','Velázquez','Guzmán','1980-02-08',NULL,'M','O-',_binary '','2020-07-11 19:51:42',NULL),(17,'Med.','Ameli','Cortés','Pérez','1993-02-27',NULL,'F','A+',_binary '','2022-01-12 09:12:19',NULL),(18,NULL,'Suri','Jiménez','Bautista','1999-12-21',NULL,'F','B+',_binary '','2020-03-29 12:16:37',NULL),(19,NULL,'Jazmin','Gutiérrez','Gutiérrez','1996-10-23',NULL,'F','AB-',_binary '','2021-01-06 09:06:17',NULL),(20,NULL,'Suri','Medina','Ortega','1975-04-05',NULL,'F','A+',_binary '','2020-03-14 10:38:55',NULL),(21,NULL,'Paula','Cortés','Cruz','1959-08-02',NULL,'F','B-',_binary '','2021-07-19 13:04:43',NULL),(22,NULL,'Adan','De la Cruz','Jiménez','1964-11-16',NULL,'M','AB-',_binary '','2020-03-25 10:48:03',NULL),(23,NULL,'Pedro','Aguilar','Salazar','2000-12-28',NULL,'M','O+',_binary '','2021-10-10 16:53:39',NULL),(24,NULL,'Samuel','Castillo',' Rivera','1982-11-30',NULL,'M','AB-',_binary '','2023-05-07 08:48:24',NULL),(25,'Joven','Alejandro','Hernández','Juárez','1962-07-08',NULL,'M','B-',_binary '','2020-11-25 15:35:09',NULL),(26,NULL,'Pedro','Castillo','López','2002-03-16',NULL,'M','A-',_binary '','2021-05-20 08:59:11',NULL),(27,NULL,'Monica','Cortes','López','1993-10-11',NULL,'F','B+',_binary '','2022-05-06 17:42:32',NULL),(28,'Sr.','Carlos','Juárez','Juárez','1968-07-28',NULL,'M','A-',_binary '','2020-07-06 10:22:18',NULL),(29,NULL,'Carmen','García','Ramírez','1996-10-24',NULL,'F','B+',_binary '','2021-01-20 12:01:01',NULL),(30,NULL,'Daniel','Velázquez','Salazar','2003-02-21',NULL,'M','O-',_binary '','2020-10-20 08:25:11',NULL),(31,'Ing.','Daniel','Herrera','Mendoza','1960-10-17',NULL,'M','O-',_binary '','2022-05-27 08:57:47',NULL),(32,NULL,'Adan','Aguilar','Álvarez','1974-02-19',NULL,'M','O-',_binary '','2023-10-31 16:26:43',NULL),(33,NULL,'Marco','Medina','Torres','1986-12-09',NULL,'M','O+',_binary '','2022-08-30 15:09:22',NULL),(34,NULL,'Ana','Mendoza','Morales','1959-10-08',NULL,'F','B+',_binary '','2022-06-20 19:52:39',NULL),(35,'C.P.','Hugo','Soto','Guerrero','1989-10-21',NULL,'M','B+',_binary '','2024-02-01 17:34:55',NULL),(36,NULL,'José','Díaz','Velázquez','1998-12-15',NULL,'M','O+',_binary '','2021-06-03 13:18:08',NULL),(37,NULL,'Jorge','Aguilar','Ortega','1961-11-24',NULL,'M','AB-',_binary '','2020-12-05 08:59:16',NULL),(38,NULL,'Alejandro','Díaz','Jiménez','1984-05-09',NULL,'M','AB+',_binary '','2022-04-09 18:31:54',NULL),(39,NULL,'Maria','Ramos','Guerrero','1989-08-16',NULL,'F','B-',_binary '','2020-09-23 15:49:15',NULL),(40,NULL,'Flor','Soto','Domínguez','1974-03-29',NULL,'F','AB+',_binary '','2023-11-09 19:07:08',NULL),(41,NULL,'Hortencia','Contreras','Aguilar','1993-09-14',NULL,'F','A-',_binary '','2020-01-27 12:53:09',NULL),(42,NULL,'Diana','Juárez','Castro','1995-05-31',NULL,'F','AB+',_binary '','2022-02-24 19:18:26',NULL),(43,NULL,'Juan','Juárez','Guerrero','1994-05-07',NULL,'M','O+',_binary '','2020-09-07 10:47:28',NULL),(44,'Mtro.','Adan','Chávez','Ramírez','1966-12-08',NULL,'M','B+',_binary '','2024-01-08 19:36:29',NULL),(45,'C.','Lorena','Ortega','Jiménez','2004-11-24',NULL,'F','AB-',_binary '','2023-09-28 11:20:01',NULL),(46,'Med.','Mario','Aguilar','Cortés','1983-08-28',NULL,'M','AB+',_binary '','2022-04-06 18:44:26',NULL),(47,NULL,'Pedro','Guerrero','Vázquez','1987-12-17',NULL,'M','A-',_binary '','2023-11-24 11:11:37',NULL),(48,NULL,'Daniel','Moreno','Díaz','1976-10-03',NULL,'M','AB-',_binary '','2022-08-31 19:41:48',NULL),(49,'Sgto.','Iram','Sánchez','Gutiérrez','1979-04-10',NULL,'M','O-',_binary '','2021-10-24 12:34:21',NULL),(50,NULL,'Suri','Reyes','Santiago','1987-04-08',NULL,'F','A-',_binary '','2021-07-16 10:21:41',NULL),(51,'Joven','Hugo','Soto','Guerrero','1988-10-27',NULL,'M','B+',_binary '','2022-10-03 13:05:53',NULL),(52,NULL,'Paula','Martínez','Moreno','1968-10-08',NULL,'F','AB+',_binary '','2021-06-19 19:58:02',NULL),(53,NULL,'Estrella','Jiménez','Ramos','1970-11-14',NULL,'F','B+',_binary '','2023-03-05 19:08:42',NULL),(54,NULL,'Pedro','Martínez','Guerrero','1980-12-31',NULL,'M','B-',_binary '','2020-04-04 18:27:27',NULL),(55,'Mtra','Valeria','Castro','Vargas','1984-07-21',NULL,'F','B-',_binary '','2022-03-11 12:37:17',NULL),(56,NULL,'José','Chávez','Contreras','1974-04-17',NULL,'M','A-',_binary '','2023-03-18 13:16:05',NULL),(57,NULL,'Monica','López','Gutiérrez','1989-01-21',NULL,'F','O-',_binary '','2023-09-15 15:28:13',NULL),(58,NULL,'Alejandro','Juárez','Juárez','1968-07-23',NULL,'M','A-',_binary '','2020-07-08 10:26:04',NULL),(59,NULL,'Jesus','Gutiérrez','Ortiz','1964-04-22',NULL,'M','A-',_binary '','2022-08-15 15:00:03',NULL),(60,'Ing.','Fernando','Gutiérrez','Rodríguez','1987-03-17',NULL,'M','B-',_binary '','2022-04-02 12:14:12',NULL),(61,NULL,'Pedro','Aguilar','Luna','2005-09-11',NULL,'M','A-',_binary '','2021-01-22 15:21:43',NULL),(62,NULL,'Diana','De la Cruz','Ramos','1997-08-30',NULL,'F','A+',_binary '','2023-04-23 18:38:32',NULL),(63,NULL,'Sofia',' González','De la Cruz','1994-10-14',NULL,'F','A-',_binary '','2020-03-25 14:25:52',NULL),(64,NULL,'Alondra','Gutiérrez','Medina','1975-12-18',NULL,'F','AB-',_binary '','2020-08-13 18:02:42',NULL),(65,NULL,'Brenda','López','Pérez','1977-11-20',NULL,'F','AB+',_binary '','2022-12-09 17:50:43',NULL),(66,'Sra.','Hortencia','Herrera','Velázquez','1999-08-27',NULL,'F','O+',_binary '','2022-06-24 14:26:19',NULL),(67,NULL,'Jesus','Gutiérrez','Ruíz','1998-12-17',NULL,'M','O-',_binary '','2020-09-14 09:00:39',NULL),(68,NULL,'Diana','Velázquez','Ortiz','2003-09-29',NULL,'F','A-',_binary '','2021-05-11 08:00:15',NULL),(69,NULL,'Estrella','Gómes','Cortes','1977-11-01',NULL,'F','B+',_binary '','2020-12-31 12:28:31',NULL),(70,NULL,'Iram','Pérez','Gómes','2000-08-01',NULL,'M','AB+',_binary '','2020-05-21 18:38:56',NULL),(71,NULL,'Esmeralda','Vázquez','Ortiz','1981-05-11',NULL,'F','O-',_binary '','2020-11-15 11:44:07',NULL),(72,'C.P.','Luz','Cortés','Méndez','2003-01-02',NULL,'F','O+',_binary '','2021-06-17 12:00:52',NULL),(73,'Sr.','Yair','Bautista','Morales','1978-08-25',NULL,'M','B+',_binary '','2020-03-28 14:26:39',NULL),(74,NULL,'Fernando','Juárez','Reyes','1990-01-01',NULL,'M','B+',_binary '','2022-03-24 17:52:31',NULL),(75,'Dra.','Brenda','Bautista','Moreno','1985-02-16',NULL,'F','A-',_binary '','2022-06-21 11:08:13',NULL),(76,NULL,'Jazmin','Cortés','Díaz','2002-01-17',NULL,'F','B+',_binary '','2023-12-16 17:44:17',NULL),(77,NULL,'Alejandro','Cortes',' Rivera','1976-01-16',NULL,'M','O-',_binary '','2022-12-07 16:12:53',NULL),(78,NULL,'Pedro','Méndez','Ortiz','1987-05-28',NULL,'M','AB+',_binary '','2020-04-18 16:07:32',NULL),(79,NULL,'Juan','Salazar','Soto','1982-10-02',NULL,'M','B-',_binary '','2022-11-26 10:26:59',NULL),(80,NULL,'Maximiliano','Romero','Ortega','1999-03-05',NULL,'M','B-',_binary '','2023-08-18 19:37:17',NULL),(81,'C.','Paola','Reyes','Gutiérrez','1959-07-07',NULL,'F','O-',_binary '','2022-02-28 18:28:23',NULL),(82,NULL,'Bertha','Ruíz','Guzmán','1984-12-22',NULL,'F','B-',_binary '','2021-11-23 08:41:01',NULL),(83,'Ing.','Gerardo','Morales','Torres','2003-03-01',NULL,'M','AB+',_binary '','2023-07-22 16:56:43',NULL),(84,NULL,'Suri','Juárez','Ortiz','1981-04-11',NULL,'F','O-',_binary '','2020-08-18 08:40:24',NULL),(85,NULL,'Flor','Gómes','Salazar','1981-01-14',NULL,'F','AB-',_binary '','2021-07-29 15:58:31',NULL),(86,'Mtra','Paula','Morales','Juárez','1975-04-07',NULL,'F','O+',_binary '','2024-01-06 13:29:18',NULL),(87,NULL,'Samuel','Aguilar','Jiménez','1971-04-17',NULL,'M','B+',_binary '','2023-04-07 08:06:47',NULL),(88,'Sra.','Paula','Moreno','Domínguez','2000-12-30',NULL,'F','B+',_binary '','2020-01-03 08:50:09',NULL),(89,NULL,'Ricardo','Rodríguez','Estrada','1971-03-26',NULL,'M','B-',_binary '','2022-03-02 10:58:56',NULL),(90,NULL,'Jesus','Juárez','Herrera','1983-03-23',NULL,'M','B-',_binary '','2023-04-17 15:10:45',NULL),(91,NULL,'Gustavo','Ramos','Jiménez','1991-05-12',NULL,'M','B+',_binary '','2023-09-30 12:35:13',NULL),(92,NULL,'Lorena','Ortega','Vázquez','1995-09-20',NULL,'F','O-',_binary '','2021-10-03 11:47:40',NULL),(93,NULL,'Iram','Álvarez','Torres','2008-02-08',NULL,'M','A+',_binary '','2020-07-22 15:04:56',NULL),(94,NULL,'Federico','Ramírez','Vázquez','1997-11-06',NULL,'M','A-',_binary '','2021-08-17 14:01:10',NULL),(95,'C.P.','Estrella','Castillo','Ramos','1991-01-27',NULL,'F','B-',_binary '','2023-11-05 13:58:07',NULL),(96,NULL,'Gustavo','García','Torres','1988-09-16',NULL,'M','O-',_binary '','2020-09-25 18:41:24',NULL),(97,NULL,'Paola','Moreno','Reyes','1961-03-05',NULL,'F','B+',_binary '','2022-03-09 15:39:23',NULL),(98,NULL,'Alondra',' González','Torres','1975-12-15',NULL,'F','AB-',_binary '','2022-10-04 09:13:50',NULL),(99,NULL,'Gustavo','Medina','Medina','1976-06-07',NULL,'M','AB-',_binary '','2021-11-10 09:36:46',NULL),(100,'Mtra','Paula','Romero','Santiago','2003-08-19',NULL,'F','O+',_binary '','2022-07-06 13:04:19',NULL),(101,NULL,'Estrella','Chávez','Cortés','1966-09-21',NULL,'F','O+',_binary '','2023-01-06 09:21:24',NULL),(102,NULL,'Gustavo','Vázquez','Domínguez','1977-06-24',NULL,'M','O-',_binary '','2022-07-02 10:05:27',NULL),(103,NULL,'Fernando','Ortiz','Moreno','2007-07-16',NULL,'M','AB+',_binary '','2023-04-08 11:22:21',NULL),(104,NULL,'Luz','Herrera','Soto','2007-06-04',NULL,'F','O-',_binary '','2023-01-27 18:31:28',NULL),(105,NULL,'Daniel','Castro','Juárez','2002-11-27',NULL,'M','AB-',_binary '','2022-06-25 08:13:13',NULL),(106,NULL,'Gerardo','Morales','Torres','2005-08-09',NULL,'M','AB-',_binary '','2023-03-09 15:57:54',NULL),(107,NULL,'Marco','Pérez','Castillo','1965-12-17',NULL,'M','A-',_binary '','2022-06-07 11:53:30',NULL),(108,NULL,'Dulce','García','De la Cruz','1999-12-16',NULL,'F','O+',_binary '','2022-01-28 09:11:20',NULL),(109,'Ing.','Luz','Bautista','Mendoza','1970-02-08',NULL,'F','O-',_binary '','2023-02-09 09:01:44',NULL),(110,NULL,'Suri','Cruz','Mendoza','1980-06-05',NULL,'F','O-',_binary '','2022-02-21 16:14:07',NULL),(111,'Joven','Fernando','Castro','Salazar','1963-02-06',NULL,'M','O-',_binary '','2020-09-23 10:44:15',NULL),(112,'C.','Pedro','Estrada','Torres','2002-01-17',NULL,'M','B-',_binary '','2021-02-16 10:38:50',NULL),(113,NULL,'Valeria','Pérez','Salazar','1998-01-01',NULL,'F','B-',_binary '','2024-02-23 14:42:46',NULL),(114,NULL,'Lucía','Jiménez','López','1979-12-31',NULL,'F','O-',_binary '','2021-03-30 17:01:19',NULL),(115,NULL,'Federico',' Rivera','Mendoza','1973-11-13',NULL,'M','A-',_binary '','2021-06-03 19:34:16',NULL),(116,NULL,'Edgar','Hernández','Estrada','1987-05-01',NULL,'M','A+',_binary '','2023-05-17 16:49:42',NULL),(117,NULL,'Jazmin','Guzmán','Gómes','2002-08-15',NULL,'F','O+',_binary '','2020-10-06 15:20:41',NULL),(118,NULL,'Brenda','Sánchez','Juárez','1986-06-25',NULL,'F','O-',_binary '','2020-08-28 18:42:33',NULL),(119,'Joven','Daniel','López','Ortiz','2008-01-05',NULL,'M','AB-',_binary '','2020-12-07 10:19:21',NULL),(120,NULL,'Adalid',' Rivera','De la Cruz','1967-06-01',NULL,'M','B-',_binary '','2023-12-04 10:58:15',NULL),(121,NULL,'Carlos','Ortiz','Velázquez','1983-12-07',NULL,'M','A-',_binary '','2022-07-05 12:07:09',NULL),(122,NULL,'Ameli','Estrada','Cortés','1963-01-13',NULL,'F','B-',_binary '','2020-08-20 11:58:13',NULL),(123,NULL,'Flor','Juárez','Vargas','1996-07-01',NULL,'F','AB-',_binary '','2023-10-31 16:10:11',NULL),(124,NULL,'Hortencia','Cortés','Cruz','1961-03-16',NULL,'F','AB-',_binary '','2020-06-08 15:03:13',NULL),(125,NULL,'Alondra','Castro','Gutiérrez','1996-01-28',NULL,'F','AB-',_binary '','2023-08-29 14:11:21',NULL),(126,NULL,'Suri','Luna','Herrera','1998-05-08',NULL,'F','O-',_binary '','2022-05-11 18:16:17',NULL),(127,NULL,'Hortencia','Rodríguez','Cortés','1982-11-03',NULL,'F','B-',_binary '','2020-02-21 16:08:12',NULL),(128,NULL,'Yair','Jiménez','López','1978-05-25',NULL,'M','O+',_binary '','2022-09-02 19:02:25',NULL),(129,'Sra.','Jazmin','Ramírez','Mendoza','1987-04-07',NULL,'F','AB+',_binary '','2021-05-12 17:41:33',NULL),(130,NULL,'Fernando','Romero','De la Cruz','1979-12-29',NULL,'M','O+',_binary '','2022-02-16 11:26:47',NULL),(131,'Ing.','Alejandro','Ramos','Herrera','1983-09-12',NULL,'M','B-',_binary '','2023-10-19 09:23:58',NULL),(132,NULL,'Suri','Martínez','De la Cruz','1997-01-13',NULL,'F','AB+',_binary '','2020-10-30 13:50:48',NULL),(133,NULL,'Alondra','Castro','Díaz','1990-10-02',NULL,'F','A-',_binary '','2023-09-17 19:34:25',NULL),(134,NULL,'Adan','Guzmán','Martínez','1960-03-07',NULL,'M','O-',_binary '','2023-01-11 17:12:06',NULL),(135,NULL,'Jorge','Domínguez','Cortés','2004-02-03',NULL,'M','AB-',_binary '','2022-08-08 09:14:53',NULL),(136,NULL,'Juan','Gómes','Cortés','1968-10-01',NULL,'M','A+',_binary '','2022-12-03 12:04:27',NULL),(137,NULL,' Agustin','Ortega','De la Cruz','1974-01-06',NULL,'M','A-',_binary '','2023-11-11 09:41:05',NULL),(138,NULL,'Adan','Sánchez','Rodríguez','1966-09-08',NULL,'M','B-',_binary '','2022-04-23 14:48:35',NULL),(139,NULL,'Maximiliano','Ortiz','Romero','1967-01-03',NULL,'M','B+',_binary '','2020-01-09 09:37:59',NULL),(140,NULL,'Estrella','De la Cruz','Rodríguez','1972-11-22',NULL,'F','A+',_binary '','2020-10-09 18:57:57',NULL),(141,NULL,'Valeria','Guzmán','Hernández','1997-01-11',NULL,'F','O+',_binary '','2023-07-19 17:07:23',NULL),(142,NULL,'Jazmin','Ruíz','Ortiz','1961-08-26',NULL,'F','O-',_binary '','2021-10-03 12:23:56',NULL),(143,NULL,'Carlos','Gómes',' Rivera','1973-01-07',NULL,'M','AB-',_binary '','2021-08-04 19:42:01',NULL),(144,NULL,'Adalid','Jiménez','Gutiérrez','2006-06-15',NULL,'M','AB-',_binary '','2022-06-25 18:38:58',NULL),(145,NULL,'Sofia','Rodríguez','Pérez','1964-05-20',NULL,'F','A-',_binary '','2023-04-14 11:23:33',NULL),(146,NULL,'José','De la Cruz','Guerrero','1970-02-13',NULL,'M','B-',_binary '','2020-12-13 08:03:01',NULL),(147,NULL,'Luz','Medina',' González','1977-11-09',NULL,'F','AB-',_binary '','2020-05-23 14:20:26',NULL),(148,'Dra.','Flor','García','Contreras','2004-04-30',NULL,'F','A-',_binary '','2021-01-12 15:36:19',NULL),(149,NULL,'Carlos','Ramos','Medina','1986-01-28',NULL,'M','AB-',_binary '','2023-04-22 18:54:02',NULL),(150,NULL,' Agustin','Castillo','Luna','1998-03-14',NULL,'M','B-',_binary '','2023-02-18 13:45:33',NULL),(151,NULL,'Jazmin','Mendoza','Méndez','1983-08-26',NULL,'F','O-',_binary '','2023-08-28 17:13:35',NULL),(152,NULL,'Maximiliano','Guzmán','Soto','1993-11-08',NULL,'M','AB+',_binary '','2022-12-03 17:48:44',NULL),(153,NULL,'Daniel','Cruz','Cortés','1973-08-30',NULL,'M','AB+',_binary '','2023-12-11 08:29:25',NULL),(154,'Tnte.',' Agustin','Castro','Bautista','1991-10-13',NULL,'M','B-',_binary '','2021-03-31 09:27:49',NULL),(155,NULL,'Dulce','Mendoza',' Rivera','1996-09-12',NULL,'F','A+',_binary '','2023-11-05 13:51:48',NULL),(156,'Mtra','Carmen','Juárez','Bautista','2007-02-17',NULL,'F','A+',_binary '','2020-08-26 16:43:35',NULL),(157,NULL,'Gustavo','Sánchez','Martínez','1995-10-12',NULL,'M','AB+',_binary '','2023-03-29 08:59:40',NULL),(158,NULL,'Brenda','Vargas','Aguilar','2004-10-29',NULL,'F','B-',_binary '','2020-06-17 12:55:59',NULL),(159,NULL,'Mario',' Rivera','Guzmán','2004-11-05',NULL,'M','B-',_binary '','2021-08-04 15:16:21',NULL),(160,NULL,'Maria','Ortega','Gómes','1983-11-22',NULL,'F','O+',_binary '','2022-10-25 18:26:04',NULL),(161,NULL,'Diana','Castro','Sánchez','1988-10-08',NULL,'F','AB+',_binary '','2020-02-19 13:27:06',NULL),(162,'Mtra','Luz','Chávez','Romero','1998-03-14',NULL,'F','B-',_binary '','2024-02-21 14:33:13',NULL),(163,NULL,'Brenda','Ramos','Cortés','2006-01-04',NULL,'F','O+',_binary '','2021-11-06 15:37:50',NULL),(164,NULL,'Flor','Pérez','Morales','2006-04-15',NULL,'F','A+',_binary '','2021-04-02 12:44:39',NULL),(165,'Ing.','Alondra',' González','Díaz','1980-04-22',NULL,'F','A-',_binary '','2021-06-11 12:13:43',NULL),(166,NULL,'Lorena','Domínguez',' González','1985-12-07',NULL,'F','B-',_binary '','2022-07-19 16:31:41',NULL),(167,NULL,'Marco','Vargas','Méndez','1989-02-05',NULL,'M','B-',_binary '','2020-06-16 12:37:23',NULL),(168,NULL,'Guadalupe','Santiago','Castro','2002-05-03',NULL,'F','B+',_binary '','2023-02-24 19:20:44',NULL),(169,'Lic.','Monica','Ortiz','Vázquez','1960-12-24',NULL,'F','B+',_binary '','2022-08-19 09:24:56',NULL),(170,NULL,'Carlos','Herrera','Bautista','1993-05-21',NULL,'M','AB-',_binary '','2020-09-07 18:25:39',NULL),(171,'Mtro.','Maximiliano','Guerrero','Contreras','1974-05-05',NULL,'M','A+',_binary '','2022-07-28 17:09:17',NULL),(172,NULL,'Ricardo','Mendoza','Ruíz','1992-05-22',NULL,'M','A-',_binary '','2020-10-03 10:08:53',NULL),(173,'Ing.','Gustavo','Pérez','Castro','1971-09-13',NULL,'M','A-',_binary '','2023-11-15 10:49:31',NULL),(174,NULL,'Ameli','García','Mendoza','1960-02-20',NULL,'F','O+',_binary '','2020-08-17 10:44:32',NULL),(175,NULL,'Flor','Gutiérrez','Álvarez','1983-09-27',NULL,'F','O-',_binary '','2020-11-18 10:46:46',NULL),(176,NULL,'Pedro','Contreras','De la Cruz','1984-02-04',NULL,'M','A-',_binary '','2021-03-25 19:49:48',NULL),(177,NULL,'Jazmin','Domínguez','Guzmán','1999-05-09',NULL,'F','O+',_binary '','2022-09-23 17:42:19',NULL),(178,NULL,'Flor','Chávez','Castillo','1998-06-10',NULL,'F','AB+',_binary '','2020-09-24 11:58:21',NULL),(179,NULL,'Esmeralda','Morales','Vázquez','1990-09-29',NULL,'F','B-',_binary '','2020-02-22 19:55:02',NULL),(180,NULL,'Gustavo','Castillo','Herrera','2002-12-31',NULL,'M','B-',_binary '','2022-10-25 19:37:43',NULL),(181,NULL,'Gustavo','Pérez','Castro','1967-12-02',NULL,'M','O+',_binary '','2021-10-19 17:23:28',NULL),(182,NULL,'Lucía','Mendoza','Medina','1966-08-10',NULL,'F','AB-',_binary '','2020-08-03 14:35:49',NULL),(183,NULL,'Samuel','Vázquez','Romero','1995-01-26',NULL,'M','A-',_binary '','2022-02-01 09:04:21',NULL),(184,NULL,'Iram','Cortes','Medina','1998-03-08',NULL,'M','O-',_binary '','2020-11-16 11:33:18',NULL),(185,NULL,'Karla','Guerrero','Ramos','1979-03-23',NULL,'F','A-',_binary '','2022-09-29 17:12:31',NULL),(186,'Lic.','Jesus','Guzmán','Ortiz','2006-09-23',NULL,'M','AB+',_binary '','2022-09-06 16:16:47',NULL),(187,NULL,'Estrella','Mendoza','Ramírez','1988-11-06',NULL,'F','AB+',_binary '','2023-10-13 18:55:11',NULL),(188,NULL,'Sofia','Herrera','Medina','1983-02-03',NULL,'F','B+',_binary '','2021-04-20 13:59:05',NULL),(189,NULL,'Flor',' González','Pérez','1971-08-04',NULL,'F','O-',_binary '','2023-11-24 18:24:44',NULL),(190,NULL,'José','Ramírez','Bautista','1968-08-07',NULL,'M','A-',_binary '','2020-05-31 09:05:31',NULL),(191,NULL,'Hortencia','Reyes','Ortega','1984-02-27',NULL,'F','O-',_binary '','2020-02-20 13:07:07',NULL),(192,NULL,'Jesus','Velázquez','Méndez','1978-02-08',NULL,'M','B+',_binary '','2021-08-14 08:12:15',NULL),(193,'Joven','Samuel','Estrada','Guzmán','2005-06-17',NULL,'M','B-',_binary '','2022-09-08 16:53:54',NULL),(194,NULL,'Lucía','Sánchez','Reyes','1960-05-09',NULL,'F','A-',_binary '','2020-05-22 17:13:23',NULL),(195,NULL,'Aldair','Salazar','Reyes','2006-10-16',NULL,'M','O-',_binary '','2020-02-01 09:41:22',NULL),(196,NULL,'Gerardo','Estrada','Medina','1994-02-24',NULL,'M','B-',_binary '','2021-02-08 18:37:37',NULL),(197,NULL,'Esmeralda','López','Ruíz','1995-07-15',NULL,'F','AB+',_binary '','2021-11-22 15:59:20',NULL),(198,NULL,'Jazmin','Hernández',' Rivera','2004-07-03',NULL,'F','O+',_binary '','2021-09-18 14:36:18',NULL),(199,NULL,'Paula','Morales','Domínguez','1980-05-23',NULL,'F','A-',_binary '','2023-10-03 17:31:33',NULL),(200,'Sgto.','Marco','Vázquez','Vázquez','1984-03-26',NULL,'M','O+',_binary '','2021-04-09 10:40:34',NULL),(201,NULL,'Monica','Vázquez','Torres','1999-11-26',NULL,'F','A-',_binary '','2021-06-11 10:45:48',NULL),(202,NULL,'Hortencia','Domínguez','Domínguez','1974-06-02',NULL,'F','AB+',_binary '','2020-07-25 18:03:49',NULL),(203,NULL,'Brenda','Martínez','Hernández','2002-03-22',NULL,'F','B+',_binary '','2020-12-13 08:18:32',NULL),(204,NULL,'Pedro','Ruíz','Guzmán','1984-08-02',NULL,'M','B+',_binary '','2021-03-09 11:51:39',NULL),(205,NULL,'Luz','De la Cruz','Medina','1962-09-21',NULL,'F','B+',_binary '','2021-03-31 15:02:46',NULL),(206,NULL,'Hugo','Santiago','Ortiz','1990-06-07',NULL,'M','O+',_binary '','2020-08-24 12:01:58',NULL),(207,'Med.','Mario','Gómes','Bautista','1961-04-09',NULL,'M','B+',_binary '','2023-01-05 14:07:54',NULL),(208,'C.','Sofia','Santiago','Cortés','1964-10-06',NULL,'F','AB-',_binary '','2020-05-06 12:19:59',NULL),(209,'Med.','Maria','García','Cortés','1994-12-17',NULL,'F','O+',_binary '','2022-05-05 14:45:01',NULL),(210,NULL,'Mario','Pérez','Torres','1972-06-20',NULL,'M','B-',_binary '','2020-09-16 15:58:09',NULL),(211,NULL,'Fernando','Juárez','Torres','1999-09-03',NULL,'M','A-',_binary '','2020-10-26 14:56:33',NULL),(212,NULL,'Lorena','De la Cruz','Luna','2004-08-27',NULL,'F','A+',_binary '','2022-06-03 16:17:24',NULL),(213,NULL,'Gustavo','Jiménez','Velázquez','2003-07-22',NULL,'M','A-',_binary '','2021-09-26 12:53:11',NULL),(214,NULL,'Hortencia','Romero','Bautista','1970-03-15',NULL,'F','B+',_binary '','2023-03-12 19:40:52',NULL),(215,NULL,'Pedro','Chávez','Romero','2003-01-26',NULL,'M','O-',_binary '','2024-02-03 09:24:07',NULL),(216,NULL,'Iram','Juárez','Domínguez','1978-10-16',NULL,'M','A+',_binary '','2020-10-02 16:08:01',NULL),(217,'Lic.','Pedro','Cruz','Domínguez','1991-06-24',NULL,'M','B+',_binary '','2023-05-01 19:13:43',NULL),(218,NULL,'Adalid','Guerrero','Moreno','1988-02-11',NULL,'M','AB+',_binary '','2023-12-19 09:35:28',NULL),(219,'Med.','Hugo','Soto','Ortega','1979-08-04',NULL,'M','B-',_binary '','2020-03-23 18:39:03',NULL),(220,NULL,'Luz','Salazar','Contreras','1985-08-17',NULL,'F','B+',_binary '','2023-05-19 10:27:32',NULL),(221,'Med.','Alondra','Romero','Romero','1960-02-20',NULL,'F','AB+',_binary '','2022-12-10 18:31:18',NULL),(222,NULL,'Mario','Ortega','Hernández','1980-03-20',NULL,'M','A-',_binary '','2021-08-19 14:38:47',NULL),(223,NULL,'Edgar','Chávez','Herrera','1991-11-14',NULL,'M','B+',_binary '','2022-06-05 19:36:16',NULL),(224,'Sr.','Fernando','Hernández','Aguilar','1961-10-17',NULL,'M','A+',_binary '','2023-08-07 11:44:36',NULL),(225,NULL,' Agustin','Guerrero',' González','1992-06-11',NULL,'M','A-',_binary '','2022-08-17 17:04:31',NULL),(226,NULL,'Dulce','Guzmán','Díaz','1983-09-22',NULL,'F','B-',_binary '','2023-02-08 12:35:48',NULL),(227,NULL,'Jazmin','Mendoza',' Rivera','1992-04-07',NULL,'F','AB+',_binary '','2020-04-13 13:48:07',NULL),(228,NULL,'Karla','Méndez','Ortega','1992-12-02',NULL,'F','O+',_binary '','2020-08-11 10:29:24',NULL),(229,'C.','Federico','Bautista','Pérez','1995-09-16',NULL,'M','B+',_binary '','2022-08-14 08:20:53',NULL),(230,NULL,'Gustavo','López','Juárez','2000-12-10',NULL,'M','B-',_binary '','2022-01-19 10:49:36',NULL),(231,NULL,'Diana','Juárez','Domínguez','1978-04-14',NULL,'F','A+',_binary '','2023-07-28 11:18:00',NULL),(232,NULL,'Samuel','Torres','De la Cruz','2006-03-28',NULL,'M','B-',_binary '','2021-04-05 10:28:07',NULL),(233,NULL,'Yair','Chávez','Jiménez','2002-01-18',NULL,'M','B-',_binary '','2022-02-18 11:23:29',NULL),(234,NULL,'Iram','Gómes','Velázquez','1967-08-28',NULL,'M','AB+',_binary '','2021-03-03 16:43:17',NULL),(235,'C.','Ana','Martínez','Ortiz','1964-11-18',NULL,'F','A-',_binary '','2023-04-06 10:53:41',NULL),(236,'Tnte.','Ricardo','Castro','Soto','1997-05-30',NULL,'M','O-',_binary '','2021-07-05 19:53:33',NULL),(237,NULL,'Sofia','Reyes','Luna','1980-07-19',NULL,'F','AB+',_binary '','2023-03-04 19:38:30',NULL),(238,NULL,'Maximiliano','Jiménez','Velázquez','2005-12-24',NULL,'M','B-',_binary '','2021-10-11 17:07:25',NULL),(239,NULL,'Sofia','Mendoza','Méndez','1982-09-27',NULL,'F','O+',_binary '','2021-09-03 16:28:25',NULL),(240,NULL,'Gustavo','Gutiérrez','Soto','1999-01-09',NULL,'M','A-',_binary '','2020-10-23 15:08:32',NULL),(241,NULL,'Karla','Sánchez','Luna','2001-01-08',NULL,'F','AB-',_binary '','2023-11-21 14:54:52',NULL),(242,NULL,'Daniel','Rodríguez','Herrera','2006-05-15',NULL,'M','O+',_binary '','2020-11-20 15:15:11',NULL),(243,NULL,'Maximiliano','Cruz','Morales','1991-05-13',NULL,'M','AB+',_binary '','2023-01-15 08:23:20',NULL),(244,NULL,'Carmen','Velázquez','Contreras','1995-03-22',NULL,'F','B+',_binary '','2020-06-10 16:55:01',NULL),(245,NULL,'Luz','Luna','Santiago','2004-01-03',NULL,'F','O-',_binary '','2023-01-29 08:06:07',NULL),(246,NULL,'Ameli','Rodríguez','García','1994-08-11',NULL,'F','AB+',_binary '','2022-03-25 08:40:07',NULL),(247,NULL,'Brenda','Santiago','Gómes','1983-11-10',NULL,'F','O+',_binary '','2022-03-10 10:30:34',NULL),(248,NULL,'Hugo','Ramírez','Salazar','1988-05-06',NULL,'M','AB+',_binary '','2022-12-20 08:50:48',NULL),(249,'Lic.','Lucía','Díaz','Vázquez','1974-09-27',NULL,'F','O+',_binary '','2023-07-07 19:20:34',NULL),(250,'Sgto.','Pedro','Juárez','Velázquez','1959-05-19',NULL,'M','AB-',_binary '','2022-04-27 15:46:20',NULL),(251,NULL,'Marco','Vargas',' Rivera','1995-03-11',NULL,'M','O-',_binary '','2021-09-11 11:15:16',NULL),(252,'Ing.','Paola','Velázquez','De la Cruz','1987-05-10',NULL,'F','AB+',_binary '','2023-10-25 08:00:45',NULL),(253,NULL,'Ana','Velázquez','Martínez','2006-02-04',NULL,'F','AB-',_binary '','2021-01-22 12:46:16',NULL),(254,NULL,'Gustavo','Hernández','Cortes','1959-03-08',NULL,'M','B-',_binary '','2023-12-22 15:15:16',NULL),(255,NULL,'Alejandro','Moreno','Estrada','1971-08-31',NULL,'M','B-',_binary '','2022-09-16 17:40:05',NULL),(256,'Mtro.','Daniel','Medina','Castillo','1978-06-27',NULL,'M','AB+',_binary '','2021-07-04 11:25:30',NULL),(257,NULL,'Carmen','Medina','Ortiz','1966-08-05',NULL,'F','B-',_binary '','2022-10-01 08:26:57',NULL),(258,NULL,'Iram','Cruz','Ramos','1988-11-04',NULL,'M','A+',_binary '','2023-05-03 15:40:55',NULL),(259,'Ing.','Paola','Cortés','Vargas','1994-11-19',NULL,'F','B-',_binary '','2020-09-04 12:51:17',NULL),(260,NULL,' Agustin','Ortiz','Guzmán','1978-06-19',NULL,'M','AB-',_binary '','2021-09-28 19:12:10',NULL),(261,NULL,'Mario','De la Cruz','Herrera','2006-12-02',NULL,'M','O+',_binary '','2021-08-06 12:02:11',NULL),(262,NULL,'Fernando','Morales','Chávez','1961-10-02',NULL,'M','AB+',_binary '','2023-01-30 19:35:34',NULL),(263,NULL,'Gerardo','De la Cruz','García','1998-11-24',NULL,'M','O-',_binary '','2021-01-09 13:05:20',NULL),(264,'C.P.','Flor','Torres','Gutiérrez','2002-05-27',NULL,'F','B+',_binary '','2022-12-23 17:07:55',NULL),(265,NULL,'Esmeralda','Juárez','Sánchez','2004-05-25',NULL,'F','A-',_binary '','2020-02-10 15:52:09',NULL),(266,NULL,'Dulce','Gómes','Velázquez','1964-10-29',NULL,'F','B+',_binary '','2020-06-29 16:34:22',NULL),(267,NULL,'Estrella',' González','Juárez','1998-02-02',NULL,'F','A-',_binary '','2021-06-02 11:15:30',NULL),(268,NULL,' Agustin','Vázquez','Vargas','1999-08-14',NULL,'M','O-',_binary '','2021-05-21 17:22:20',NULL),(269,NULL,'Karla','Moreno','Romero','1963-06-02',NULL,'F','O-',_binary '','2021-09-02 10:32:43',NULL),(270,NULL,'Maximiliano','Martínez','Álvarez','1984-05-29',NULL,'M','O-',_binary '','2021-08-16 19:54:47',NULL),(271,NULL,'Luz','Martínez','Luna','1966-06-05',NULL,'F','A-',_binary '','2021-10-30 16:01:02',NULL),(272,NULL,'Samuel','Gutiérrez','López','1968-02-11',NULL,'M','AB-',_binary '','2020-04-05 09:46:22',NULL),(273,NULL,'Gerardo','Sánchez','Santiago','1961-03-14',NULL,'M','AB+',_binary '','2021-10-18 15:31:49',NULL),(274,'Tnte.','Iram','Castillo','Cruz','1982-05-27',NULL,'M','O+',_binary '','2022-03-30 11:51:17',NULL),(275,NULL,'Hugo','Castillo','Aguilar','1995-08-14',NULL,'M','B-',_binary '','2023-03-18 15:53:59',NULL),(276,NULL,'Adan','Torres',' González','1981-02-22',NULL,'M','O-',_binary '','2022-03-01 16:11:49',NULL),(277,'C.P.','Edgar','Ramos','López','1983-03-01',NULL,'M','A-',_binary '','2022-06-24 12:06:16',NULL),(278,NULL,'Edgar','Romero','Aguilar','1991-02-27',NULL,'M','O-',_binary '','2023-08-31 14:00:57',NULL),(279,NULL,'Marco',' González','Mendoza','1997-11-09',NULL,'M','AB-',_binary '','2020-07-18 14:40:50',NULL),(280,'Sra.','Jazmin','Aguilar','Ramos','2000-03-22',NULL,'F','B+',_binary '','2020-06-08 14:38:45',NULL),(281,NULL,'Lucía','Ramírez','Castillo','2002-08-03',NULL,'F','O-',_binary '','2020-12-19 10:43:47',NULL),(282,'Joven','Iram','Vázquez','Cortés','1961-09-11',NULL,'M','B+',_binary '','2022-05-31 18:19:58',NULL),(283,NULL,'Maximiliano','Ramos','Aguilar','1971-01-13',NULL,'M','O-',_binary '','2024-01-06 08:08:43',NULL),(284,NULL,'Gerardo',' González','Ramos','2000-03-16',NULL,'M','B+',_binary '','2020-03-14 11:39:19',NULL),(285,NULL,'Valeria','Romero','De la Cruz','1979-12-06',NULL,'F','AB-',_binary '','2021-11-09 08:01:33',NULL),(286,'Ing.','Gustavo','Bautista','Martínez','1978-11-15',NULL,'M','O+',_binary '','2020-02-29 15:46:15',NULL),(287,NULL,'Edgar','Castillo','Gutiérrez','1979-06-12',NULL,'M','O-',_binary '','2022-01-12 15:15:06',NULL),(288,'Mtra','Monica','Morales','Jiménez','1998-01-11',NULL,'F','A+',_binary '','2023-01-26 15:27:34',NULL),(289,'C.','Daniel','Moreno','Gutiérrez','1982-08-30',NULL,'M','B+',_binary '','2023-08-27 15:12:45',NULL),(290,NULL,'Fernando','Hernández','Reyes','1981-04-08',NULL,'M','B+',_binary '','2022-01-25 12:31:11',NULL),(291,NULL,'Monica','Moreno','Díaz','1976-11-05',NULL,'F','AB-',_binary '','2022-09-27 08:35:39',NULL),(292,NULL,'Jorge','García','Guerrero','1981-01-26',NULL,'M','B-',_binary '','2020-08-22 11:16:27',NULL),(293,NULL,'Bertha','Mendoza','Guzmán','1985-01-31',NULL,'F','B-',_binary '','2021-08-13 17:06:41',NULL),(294,NULL,'Esmeralda','Juárez','Rodríguez','2000-02-08',NULL,'F','O+',_binary '','2021-05-02 11:41:51',NULL),(295,NULL,'Ana','Medina','Castro','1982-05-22',NULL,'F','A-',_binary '','2023-01-03 19:09:07',NULL),(296,NULL,'Karla','Hernández','Pérez','1985-07-07',NULL,'F','B+',_binary '','2020-11-03 19:04:39',NULL),(297,NULL,'Bertha','Álvarez','Ruíz','1980-03-02',NULL,'F','O-',_binary '','2021-11-03 12:31:09',NULL),(298,NULL,'Adan','Castillo','Guerrero','1962-04-12',NULL,'M','AB+',_binary '','2023-02-08 19:39:37',NULL),(299,'C.P.','Carlos','Ruíz','Moreno','1968-05-19',NULL,'M','AB+',_binary '','2020-04-24 17:30:18',NULL),(300,NULL,'Paula','Herrera','Juárez','1961-02-13',NULL,'F','B-',_binary '','2023-03-09 16:22:45',NULL),(301,NULL,'Karla','Castro','Vargas','1982-02-16',NULL,'F','A-',_binary '','2021-12-15 17:53:44',NULL),(302,NULL,'Paula','Guerrero','Guerrero','1998-02-18',NULL,'F','B+',_binary '','2023-08-25 15:32:33',NULL),(303,NULL,'Valeria','Sánchez','Bautista','1975-09-02',NULL,'F','O+',_binary '','2020-01-31 16:10:42',NULL),(304,NULL,'Carlos','Contreras',' Rivera','1981-07-19',NULL,'M','AB+',_binary '','2021-04-20 19:28:23',NULL),(305,NULL,'José','Castillo','Aguilar','1995-06-17',NULL,'M','B-',_binary '','2023-01-09 13:36:14',NULL),(306,'Dra.','Brenda','Santiago','Gómes','1981-04-24',NULL,'F','AB+',_binary '','2022-06-11 10:03:33',NULL),(307,'Sr.','Mario','Contreras','Vargas','1970-12-17',NULL,'M','A+',_binary '','2021-07-07 17:15:07',NULL),(308,NULL,'Carmen','Estrada','Domínguez','1980-10-10',NULL,'F','B+',_binary '','2023-12-26 08:16:16',NULL),(309,'Srita','Ameli','Moreno','Vargas','1973-01-20',NULL,'F','A-',_binary '','2020-08-11 09:37:43',NULL),(310,NULL,'Dulce','Sánchez','Reyes','1960-02-20',NULL,'F','A-',_binary '','2020-06-30 18:39:38',NULL),(311,NULL,'Suri','Vázquez','Velázquez','1963-09-04',NULL,'F','A-',_binary '','2021-09-10 15:30:43',NULL),(312,NULL,'Lucía','Herrera','Estrada','1990-02-26',NULL,'F','B+',_binary '','2023-11-28 15:10:07',NULL),(313,NULL,'Adalid','Cruz','De la Cruz','1975-10-06',NULL,'M','B+',_binary '','2022-10-23 12:21:35',NULL),(314,NULL,'Daniel','Álvarez','Herrera','1994-07-05',NULL,'M','AB+',_binary '','2023-11-02 17:07:05',NULL),(315,'Med.','Gustavo','Ortiz','Álvarez','1974-11-16',NULL,'M','O-',_binary '','2020-01-12 08:40:35',NULL),(316,NULL,'Fernando','Hernández','Ruíz','2002-10-10',NULL,'M','B+',_binary '','2023-02-27 19:16:52',NULL),(317,NULL,'Jorge','Mendoza','Contreras','2001-10-20',NULL,'M','O-',_binary '','2023-09-14 16:59:50',NULL),(318,NULL,'Federico','Martínez','Ramos','1962-03-16',NULL,'M','B-',_binary '','2023-05-20 18:23:43',NULL),(319,NULL,'Carmen','Contreras','Martínez','1999-10-02',NULL,'F','O-',_binary '','2021-10-07 10:08:40',NULL),(320,NULL,'Jazmin','Moreno','Estrada','1969-07-04',NULL,'F','B+',_binary '','2022-12-01 16:28:38',NULL),(321,'Med.','Daniel','Morales','Díaz','1959-05-06',NULL,'M','O-',_binary '','2023-05-17 09:57:17',NULL),(322,NULL,'Lucía','Gutiérrez','Díaz','1992-07-26',NULL,'F','B+',_binary '','2022-10-25 12:13:02',NULL),(323,'Sra.','Guadalupe','Luna','Mendoza','1986-11-28',NULL,'F','AB+',_binary '','2020-09-26 09:57:04',NULL),(324,NULL,'Federico',' González','Salazar','2003-11-26',NULL,'M','A+',_binary '','2022-02-11 12:43:23',NULL),(325,'Sra.','Estrella','Bautista','Ortega','1985-01-14',NULL,'F','A+',_binary '','2022-05-10 16:53:31',NULL),(326,NULL,'Jorge','Romero','Vázquez','1999-09-15',NULL,'M','B+',_binary '','2020-07-17 16:13:21',NULL),(327,NULL,'Adalid','Medina','Torres','1987-10-09',NULL,'M','O-',_binary '','2023-12-15 19:12:05',NULL),(328,NULL,'Pedro','Cortés','Romero','1989-11-04',NULL,'M','AB+',_binary '','2020-10-28 09:45:44',NULL),(329,NULL,'Edgar','Ramírez','Contreras','1985-11-15',NULL,'M','B+',_binary '','2023-04-07 08:53:24',NULL),(330,'Mtro.',' Agustin','Cortés','Gómes','1973-08-26',NULL,'M','O+',_binary '','2023-11-24 12:41:37',NULL),(331,NULL,'Juan','Ramos','Santiago','1989-02-20',NULL,'M','B+',_binary '','2024-01-22 17:31:34',NULL),(332,NULL,'Iram','Méndez','Gutiérrez','1967-06-04',NULL,'M','O+',_binary '','2021-01-24 08:16:51',NULL),(333,NULL,'Pedro','Gutiérrez','Moreno','1972-05-26',NULL,'M','O-',_binary '','2023-07-22 13:40:56',NULL),(334,'C.','Bertha','Luna','Cortés','1973-02-08',NULL,'F','AB+',_binary '','2022-11-18 19:14:21',NULL),(335,'Ing.','Adalid','Medina','Torres','1987-10-09',NULL,'M','O-',_binary '','2023-07-16 13:54:51',NULL),(336,NULL,'Guadalupe','Jiménez','Velázquez','2003-03-12',NULL,'F','A-',_binary '','2021-07-02 10:02:49',NULL),(337,NULL,'Dulce','Vázquez','Bautista','2005-03-16',NULL,'F','O+',_binary '','2021-09-21 14:22:06',NULL),(338,NULL,'Ameli','Castillo','Luna','1996-01-13',NULL,'F','A-',_binary '','2023-08-26 16:29:00',NULL),(339,NULL,'Maximiliano','Ortega','Chávez','1972-05-29',NULL,'M','AB-',_binary '','2021-07-26 19:38:59',NULL),(340,NULL,'Daniel','Álvarez','Velázquez','1972-01-06',NULL,'M','O-',_binary '','2020-08-03 17:01:44',NULL),(341,NULL,'Sofia','Salazar','Chávez','1978-05-24',NULL,'F','B+',_binary '','2020-04-24 15:30:03',NULL),(342,NULL,'Lucía','Vázquez','Soto','1962-04-14',NULL,'F','B-',_binary '','2022-11-22 12:09:35',NULL),(343,NULL,'Carlos','Martínez','Salazar','2004-12-29',NULL,'M','A-',_binary '','2020-12-21 14:32:20',NULL),(344,NULL,'Luz','Santiago',' González','1999-04-23',NULL,'F','O+',_binary '','2022-06-21 14:29:09',NULL),(345,NULL,'Marco','Santiago','Gutiérrez','1968-01-09',NULL,'M','O+',_binary '','2021-11-01 17:47:19',NULL),(346,NULL,'Gerardo','Ruíz','Hernández','2002-08-12',NULL,'M','B-',_binary '','2021-09-23 17:59:53',NULL),(347,NULL,'Adalid','Luna','Cruz','1977-03-17',NULL,'M','B+',_binary '','2021-04-01 15:54:13',NULL),(348,NULL,'Juan','Gutiérrez','Medina','1973-12-25',NULL,'M','B-',_binary '','2021-06-11 12:36:51',NULL),(349,'Med.','Adan','Luna','Castro','2005-10-22',NULL,'M','AB-',_binary '','2021-09-02 08:39:55',NULL),(350,NULL,' Agustin','Cruz','Ruíz','1977-03-13',NULL,'M','AB-',_binary '','2021-06-09 15:54:11',NULL),(351,NULL,'Mario','Estrada','Ortiz','1978-11-02',NULL,'M','AB-',_binary '','2020-10-17 19:01:55',NULL),(352,NULL,'Bertha','Castillo','Cruz','1984-05-20',NULL,'F','O-',_binary '','2021-10-27 10:25:18',NULL),(353,'Joven','Ricardo','Morales',' Rivera','1968-08-21',NULL,'M','A-',_binary '','2021-07-04 10:56:17',NULL),(354,NULL,'Maximiliano','Velázquez','Hernández','1998-01-15',NULL,'M','O-',_binary '','2020-12-01 12:08:14',NULL),(355,NULL,'Hortencia','Cortes','Ruíz','1973-02-08',NULL,'F','B+',_binary '','2022-04-19 19:02:30',NULL),(356,NULL,'Lucía',' González','Martínez','2007-11-30',NULL,'F','O+',_binary '','2020-01-09 15:37:10',NULL),(357,NULL,' Agustin','Ramos','Domínguez','1977-06-28',NULL,'M','O-',_binary '','2021-12-13 15:05:27',NULL),(358,NULL,'Brenda','Estrada','Castillo','1992-03-15',NULL,'F','O-',_binary '','2021-07-31 11:06:10',NULL),(359,NULL,'Bertha','Cruz','Ramos','1986-11-12',NULL,'F','O-',_binary '','2020-06-23 16:15:54',NULL),(360,'C.P.','Ana','Contreras','Reyes','2008-01-10',NULL,'F','A+',_binary '','2022-08-08 17:05:54',NULL),(361,'Pfra','Lorena','Ortiz','Ramírez','1983-10-16',NULL,'F','O-',_binary '','2021-10-25 10:36:15',NULL),(362,NULL,'Samuel','Ortiz','Castillo','1963-12-09',NULL,'M','A+',_binary '','2023-04-23 19:06:42',NULL),(363,NULL,'Daniel','Moreno','Ortiz','2001-03-15',NULL,'M','O-',_binary '','2020-02-01 12:08:45',NULL),(364,'C.P.','Luz','Pérez','Cruz','1991-04-01',NULL,'F','AB-',_binary '','2022-03-27 15:03:01',NULL),(365,NULL,'Hortencia','Gómes','Chávez','1966-08-06',NULL,'F','A+',_binary '','2023-03-27 16:59:14',NULL),(366,NULL,'Hortencia','Estrada','Soto','1967-09-05',NULL,'F','O-',_binary '','2020-01-23 12:14:15',NULL),(367,NULL,'Lorena','Gutiérrez','Vargas','1986-04-23',NULL,'F','AB+',_binary '','2021-02-15 15:07:02',NULL),(368,NULL,'Alejandro','Sánchez','Mendoza','1987-03-30',NULL,'M','AB-',_binary '','2021-12-24 13:33:52',NULL),(369,NULL,'Monica','Cortes','Hernández','1978-01-27',NULL,'F','O-',_binary '','2021-12-30 15:24:55',NULL),(370,NULL,'Samuel','Ramírez','López','1998-06-06',NULL,'M','O+',_binary '','2023-01-03 09:40:52',NULL),(371,NULL,'Lucía','Hernández','Álvarez','1990-04-01',NULL,'F','AB+',_binary '','2020-02-02 12:13:05',NULL),(372,'Dra.','Paola','Contreras','Estrada','1967-12-04',NULL,'F','A+',_binary '','2020-05-13 08:46:02',NULL),(373,NULL,'Jorge','Ruíz','Guzmán','1988-12-09',NULL,'M','O+',_binary '','2024-01-15 14:57:36',NULL),(374,NULL,'Brenda','Álvarez','Álvarez','1959-11-30',NULL,'F','B-',_binary '','2021-11-06 16:43:56',NULL),(375,NULL,'Paola','García','López','1972-03-25',NULL,'F','A-',_binary '','2023-08-15 19:24:23',NULL),(376,NULL,' Agustin','Díaz','Morales','1970-03-23',NULL,'M','B+',_binary '','2020-08-19 15:58:40',NULL),(377,NULL,'Edgar','Vázquez','Cruz','1967-05-08',NULL,'M','B+',_binary '','2023-04-21 10:20:08',NULL),(378,NULL,'Valeria','Hernández','Cortes','1961-12-05',NULL,'F','AB+',_binary '','2023-12-12 18:28:21',NULL),(379,NULL,' Agustin','Soto','Moreno','1977-07-03',NULL,'M','B-',_binary '','2020-11-07 15:32:50',NULL),(380,NULL,'Valeria','Cortés','Soto','1963-01-22',NULL,'F','B-',_binary '','2023-07-01 19:28:44',NULL),(381,NULL,'Paula','Álvarez','Cortés','1973-01-21',NULL,'F','AB+',_binary '','2022-11-05 18:48:24',NULL),(382,NULL,'Jazmin','Contreras','Moreno','2003-05-24',NULL,'F','A-',_binary '','2023-12-13 12:14:49',NULL),(383,NULL,'Maximiliano','Guerrero','Salazar','1980-05-11',NULL,'M','AB-',_binary '','2020-04-18 12:00:46',NULL),(384,NULL,'Samuel','Reyes','Medina','1988-12-10',NULL,'M','O-',_binary '','2023-10-04 16:10:55',NULL),(385,NULL,'Jorge','López','Cortes','1997-12-09',NULL,'M','B+',_binary '','2021-04-29 14:56:40',NULL),(386,NULL,'Flor','Gutiérrez','Aguilar','1963-04-02',NULL,'F','A+',_binary '','2021-03-24 09:47:43',NULL),(387,'Ing.','Ricardo','Salazar','Romero','1962-05-08',NULL,'M','O+',_binary '','2022-11-27 09:54:03',NULL),(388,NULL,'Jazmin',' González','Cortés','1989-07-25',NULL,'F','A-',_binary '','2024-01-02 11:49:20',NULL),(389,NULL,'Suri','Gutiérrez','Jiménez','1980-02-03',NULL,'F','A-',_binary '','2023-06-23 14:05:00',NULL),(390,NULL,'Mario','Castro','Morales','1967-02-04',NULL,'M','A+',_binary '','2023-01-08 14:02:58',NULL),(391,NULL,'Flor','Reyes','Rodríguez','1994-12-27',NULL,'F','B+',_binary '','2020-12-18 11:39:17',NULL),(392,NULL,'Carlos','Cortés','Díaz','2000-01-13',NULL,'M','A-',_binary '','2020-08-28 12:43:40',NULL),(393,'Sra.','Valeria','Torres','Luna','1974-12-08',NULL,'F','A+',_binary '','2020-11-05 19:00:51',NULL),(394,'C.P.','Bertha','Méndez','Romero','2002-10-11',NULL,'F','O-',_binary '','2020-02-08 11:42:33',NULL),(395,NULL,'Paula','Medina','De la Cruz','1999-07-24',NULL,'F','O+',_binary '','2021-09-05 16:18:58',NULL),(396,NULL,'Alejandro','Vázquez','Estrada','2000-01-22',NULL,'M','B-',_binary '','2021-10-29 08:22:35',NULL),(397,NULL,'Luz','Álvarez','Jiménez','2007-06-28',NULL,'F','O-',_binary '','2020-02-08 09:37:00',NULL),(398,NULL,'Mario','Soto','Herrera','1976-07-29',NULL,'M','O+',_binary '','2023-07-05 18:27:16',NULL),(399,NULL,'Hugo','Estrada','Herrera','1984-04-29',NULL,'M','AB+',_binary '','2021-05-25 19:27:17',NULL),(400,NULL,'Mario','Sánchez','Ruíz','1983-09-24',NULL,'M','B+',_binary '','2021-02-06 11:09:26',NULL),(401,NULL,'Karla','López','Méndez','1984-07-31',NULL,'F','O-',_binary '','2020-07-31 18:35:28',NULL),(402,'Med.','Adalid','Cruz','Contreras','1981-12-12',NULL,'M','O-',_binary '','2020-03-31 15:29:26',NULL),(403,NULL,'Adan','Ortiz','Ramos','1997-07-10',NULL,'M','A+',_binary '','2023-05-22 19:41:45',NULL),(404,NULL,'Maria','Moreno','Morales','1997-07-18',NULL,'F','A-',_binary '','2022-07-25 14:01:07',NULL),(405,NULL,'Suri','Santiago','Ortega','1992-05-10',NULL,'F','O+',_binary '','2023-09-12 09:06:28',NULL),(406,NULL,'Ameli','Castro','Luna','1967-12-24',NULL,'F','B+',_binary '','2020-05-01 13:07:13',NULL),(407,'C.','Alejandro','Cruz','Ortiz','1995-04-11',NULL,'M','B+',_binary '','2021-05-01 16:11:28',NULL),(408,'Med.','Carmen','Álvarez',' Rivera','1975-05-17',NULL,'F','O-',_binary '','2022-05-03 08:54:21',NULL),(409,NULL,'Ana','Torres','Contreras','1965-09-14',NULL,'F','A-',_binary '','2022-09-16 15:30:31',NULL),(410,NULL,'Yair','Díaz','Vázquez','1974-07-01',NULL,'M','O+',_binary '','2023-08-02 08:21:29',NULL),(411,'Med.','Hugo','Hernández','López','1974-11-27',NULL,'M','B-',_binary '','2023-12-27 15:40:46',NULL),(412,NULL,'Monica','Vargas','Castro','1975-09-04',NULL,'F','AB+',_binary '','2023-03-06 09:52:02',NULL),(413,NULL,'Paola','Bautista','Domínguez','1978-05-21',NULL,'F','A+',_binary '','2024-02-05 17:57:13',NULL),(414,NULL,'Jesus','Reyes','Martínez','1977-07-02',NULL,'M','AB-',_binary '','2022-04-16 14:34:41',NULL),(415,NULL,'Lorena','Castro','Castillo','1975-10-10',NULL,'F','A-',_binary '','2020-01-18 13:16:21',NULL),(416,NULL,'Iram','Guzmán','Mendoza','1995-11-16',NULL,'M','AB+',_binary '','2021-09-19 13:38:35',NULL),(417,NULL,'Brenda','Gutiérrez','Ramos','1960-02-01',NULL,'F','A-',_binary '','2020-02-10 13:48:17',NULL),(418,NULL,'Adalid','Bautista','Herrera','1983-06-26',NULL,'M','B-',_binary '','2023-07-12 18:04:51',NULL),(419,NULL,'Carlos','Torres','Morales','1969-12-30',NULL,'M','B-',_binary '','2020-11-29 19:37:02',NULL),(420,NULL,'Hugo','Romero','Aguilar','1991-10-30',NULL,'M','A+',_binary '','2020-08-22 16:08:55',NULL),(421,NULL,'Yair','Cortes','Chávez','1969-05-06',NULL,'M','B+',_binary '','2020-03-28 11:21:02',NULL),(422,NULL,'Alejandro','Cruz','Castillo','2001-02-26',NULL,'M','O+',_binary '','2022-05-30 12:54:10',NULL),(423,NULL,'Valeria','Medina','Castro','1981-12-10',NULL,'F','A-',_binary '','2022-03-31 09:41:13',NULL),(424,NULL,'Paula','Díaz','Cortés','1998-08-06',NULL,'F','A-',_binary '','2020-11-25 16:28:05',NULL),(425,NULL,'Alondra','Pérez','Moreno','1961-07-27',NULL,'F','O+',_binary '','2023-11-08 10:16:04',NULL),(426,NULL,'Hortencia','Vargas','Bautista','1989-10-23',NULL,'F','B+',_binary '','2021-08-22 10:30:55',NULL),(427,NULL,'Ana','Ramos','Gutiérrez','2004-06-06',NULL,'F','AB+',_binary '','2023-10-31 19:53:00',NULL),(428,NULL,'Jorge','Gómes','Guerrero','2001-05-10',NULL,'M','AB+',_binary '','2021-02-14 15:40:52',NULL),(429,NULL,'Flor','Cruz','Ramos','1986-11-20',NULL,'F','O-',_binary '','2020-05-21 15:04:44',NULL),(430,'Dra.','Diana','Mendoza','Vargas','1980-06-29',NULL,'F','O-',_binary '','2022-04-16 18:04:11',NULL),(431,NULL,'Gustavo','Morales','Mendoza','1976-04-07',NULL,'M','B-',_binary '','2021-10-17 16:02:54',NULL),(432,'Lic.','Samuel','Moreno','Castillo','1960-12-04',NULL,'M','AB-',_binary '','2022-02-28 13:03:12',NULL),(433,NULL,'Jorge','Martínez','Martínez','1963-09-20',NULL,'M','B+',_binary '','2020-12-17 11:00:45',NULL),(434,NULL,'Dulce','Ortega','Cortés','1967-04-14',NULL,'F','O-',_binary '','2020-12-29 12:15:32',NULL),(435,NULL,'Iram','Soto',' Rivera','2005-12-09',NULL,'M','A+',_binary '','2021-02-24 11:36:25',NULL),(436,NULL,'Brenda','Torres','Aguilar','1966-06-13',NULL,'F','B-',_binary '','2023-09-11 08:29:29',NULL),(437,NULL,'Lorena',' González','Ruíz','1993-01-17',NULL,'F','B+',_binary '','2021-05-14 17:38:24',NULL),(438,NULL,'Jorge',' Rivera','Vargas','2003-08-15',NULL,'M','B+',_binary '','2023-09-28 14:18:26',NULL),(439,NULL,'Aldair','Hernández','Cruz','2005-12-19',NULL,'M','A-',_binary '','2020-06-13 19:28:52',NULL),(440,'Lic.','José','Bautista','Contreras','1968-07-11',NULL,'M','AB+',_binary '','2020-07-01 19:48:34',NULL),(441,NULL,'Carmen','Romero','Álvarez','1963-10-24',NULL,'F','O-',_binary '','2020-10-03 10:45:06',NULL),(442,'Dra.','Paula','Velázquez','Pérez','1973-08-10',NULL,'F','A-',_binary '','2023-02-24 12:49:10',NULL),(443,NULL,'Luz','Guzmán','Aguilar','2003-02-09',NULL,'F','A-',_binary '','2021-02-27 17:45:22',NULL),(444,NULL,'Sofia','Aguilar','Domínguez','2002-12-16',NULL,'F','AB+',_binary '','2020-02-25 14:36:30',NULL),(445,NULL,'Lorena','Mendoza','Estrada','1980-10-03',NULL,'F','B-',_binary '','2023-02-22 14:23:39',NULL),(446,NULL,'Valeria','Torres','Guzmán','1998-04-28',NULL,'F','AB-',_binary '','2021-04-08 11:38:20',NULL),(447,'Sr.','Federico','Velázquez','Reyes','1967-01-01',NULL,'M','O-',_binary '','2020-04-26 15:47:25',NULL),(448,NULL,'Federico','Pérez','Cortés','1982-01-12',NULL,'M','B-',_binary '','2023-05-01 16:12:05',NULL),(449,NULL,'Flor','Vargas','Vázquez','1968-06-06',NULL,'F','A-',_binary '','2020-05-25 08:59:09',NULL),(450,NULL,'Maximiliano','Estrada','Guerrero','1996-11-18',NULL,'M','A+',_binary '','2020-09-14 14:43:15',NULL),(451,NULL,'Alondra','López','Gómes','2004-09-12',NULL,'F','O-',_binary '','2020-02-07 10:50:13',NULL),(452,'Ing.','Pedro','Rodríguez','Mendoza','1992-05-29',NULL,'M','A-',_binary '','2022-11-04 19:51:01',NULL),(453,NULL,'Pedro','Gómes','Ortega','1989-01-11',NULL,'M','B-',_binary '','2021-11-20 18:47:24',NULL),(454,NULL,'Hortencia','Hernández','Ortiz','1966-09-02',NULL,'F','B-',_binary '','2023-03-16 14:10:54',NULL),(455,'Lic.','Aldair','Velázquez','Martínez','2005-12-01',NULL,'M','AB+',_binary '','2020-08-31 19:51:54',NULL),(456,NULL,'Gustavo','Rodríguez','Estrada','1970-01-21',NULL,'M','B+',_binary '','2024-01-19 18:36:36',NULL),(457,NULL,'Maria','Ortega','Sánchez','1966-08-02',NULL,'F','B+',_binary '','2024-01-23 08:17:22',NULL),(458,NULL,'Ana','De la Cruz','Cruz','1987-08-04',NULL,'F','B+',_binary '','2023-06-17 10:36:04',NULL),(459,'Mtra','Brenda','Salazar','Santiago','2007-04-28',NULL,'F','A-',_binary '','2021-01-02 13:56:58',NULL),(460,NULL,'Gustavo','Vargas','Salazar','2007-08-01',NULL,'M','B-',_binary '','2020-09-25 15:11:43',NULL),(461,NULL,'Mario','Soto','Ramos','1970-02-15',NULL,'M','A-',_binary '','2021-08-22 11:59:53',NULL),(462,NULL,'Alejandro','Salazar','Ramos','1993-10-03',NULL,'M','AB-',_binary '','2020-02-12 11:02:03',NULL),(463,NULL,'Daniel','Ramos','Ramírez','2007-08-22',NULL,'M','B-',_binary '','2020-08-07 13:28:29',NULL),(464,NULL,'Hugo','Herrera','Torres','1989-07-15',NULL,'M','A+',_binary '','2022-10-19 08:34:00',NULL),(465,NULL,'Ana','Gutiérrez','García','1960-08-02',NULL,'F','A+',_binary '','2021-04-14 11:40:29',NULL),(466,NULL,'Jorge','Cruz','De la Cruz','1975-03-29',NULL,'M','B+',_binary '','2021-12-22 14:00:14',NULL),(467,NULL,'Maria','Castro','Jiménez','1981-02-12',NULL,'F','B+',_binary '','2020-08-25 18:33:35',NULL),(468,'Sr.','Ricardo','Herrera','Guzmán','1995-03-17',NULL,'M','B-',_binary '','2023-11-24 12:46:59',NULL),(469,'Tnte.','Daniel','Castro',' Rivera','1999-10-08',NULL,'M','B-',_binary '','2021-08-20 18:03:19',NULL),(470,'Lic.','Jorge','Ortiz','García','1997-12-02',NULL,'M','O+',_binary '','2023-11-03 08:27:32',NULL),(471,NULL,'Fernando','Mendoza','Gutiérrez','1986-08-12',NULL,'M','AB-',_binary '','2023-10-24 13:06:07',NULL),(472,NULL,'Bertha','Juárez','Vargas','2001-09-01',NULL,'F','A-',_binary '','2020-04-20 19:30:35',NULL),(473,NULL,'Juan','Martínez','Soto','1999-07-06',NULL,'M','A-',_binary '','2021-01-10 17:40:20',NULL),(474,NULL,'Diana','Gómes','Velázquez','1964-12-28',NULL,'F','B+',_binary '','2020-11-09 09:07:45',NULL),(475,NULL,'Ana','Cortés','Pérez','1990-06-04',NULL,'F','O+',_binary '','2021-05-15 09:13:30',NULL),(476,NULL,'Alejandro','Soto',' Rivera','2005-05-25',NULL,'M','O-',_binary '','2023-12-08 18:23:12',NULL),(477,'Mtra','Diana','Díaz','Mendoza','1960-07-12',NULL,'F','O-',_binary '','2021-04-26 19:19:05',NULL),(478,NULL,'Hugo','Ruíz','Estrada','1981-11-19',NULL,'M','AB+',_binary '','2021-01-09 15:47:14',NULL),(479,NULL,'Hugo','Castro','Moreno','1972-08-06',NULL,'M','O-',_binary '','2023-07-02 12:54:25',NULL),(480,NULL,'Jesus','Estrada','Morales','1983-05-30',NULL,'M','AB-',_binary '','2020-06-26 13:05:26',NULL),(481,NULL,'Luz','Ortega','Rodríguez','1960-12-18',NULL,'F','O+',_binary '','2023-05-26 16:46:11',NULL),(482,NULL,'Hortencia','Torres','Martínez','1969-01-06',NULL,'F','O+',_binary '','2023-03-13 10:38:13',NULL),(483,NULL,'Ana','Álvarez','Ortega','1995-01-31',NULL,'F','A+',_binary '','2020-12-07 18:25:50',NULL),(484,NULL,'Juan','Gómes','Soto','1972-02-03',NULL,'M','B+',_binary '','2023-10-11 14:15:05',NULL),(485,NULL,'Karla','Sánchez','Salazar','1994-01-28',NULL,'F','A+',_binary '','2021-02-02 08:50:46',NULL),(486,NULL,'Ameli','Jiménez','Estrada','1992-07-28',NULL,'F','AB-',_binary '','2020-07-21 17:05:57',NULL),(487,NULL,'Lorena','Martínez','Gómes','2006-06-22',NULL,'F','A-',_binary '','2023-06-20 16:45:03',NULL),(488,NULL,'Esmeralda','Velázquez','Soto','1989-10-02',NULL,'F','A-',_binary '','2023-08-25 19:14:30',NULL),(489,NULL,'Gerardo','Torres','Vargas','1991-08-13',NULL,'M','A+',_binary '','2022-05-06 13:52:22',NULL),(490,'Sr.','Gerardo','Hernández','Cortes','2007-09-01',NULL,'M','B+',_binary '','2022-09-02 10:54:46',NULL),(491,NULL,'Ameli','Castillo','Contreras','1989-02-24',NULL,'F','AB+',_binary '','2020-11-26 11:03:45',NULL),(492,NULL,'Juan',' González','Reyes','1967-11-20',NULL,'M','A+',_binary '','2022-07-17 19:38:00',NULL),(493,NULL,'Esmeralda','Reyes','Álvarez','1998-11-11',NULL,'F','B-',_binary '','2023-04-23 15:41:54',NULL),(494,NULL,'Mario','Medina','Rodríguez','1986-01-23',NULL,'M','B-',_binary '','2021-02-20 10:36:33',NULL),(495,NULL,'Sofia','Aguilar','Ramos','1999-11-19',NULL,'F','B+',_binary '','2023-10-21 16:44:50',NULL),(496,NULL,'Yair','Gómes','Ramos','1981-12-21',NULL,'M','B-',_binary '','2023-03-08 14:20:51',NULL),(497,NULL,'Hortencia','Santiago','Salazar','1980-10-27',NULL,'F','AB-',_binary '','2021-04-21 12:36:51',NULL),(498,NULL,'Valeria','Gutiérrez','Soto','2000-04-19',NULL,'F','A-',_binary '','2022-09-16 14:39:25',NULL),(499,NULL,'Lucía','Méndez','Gómes','1984-06-05',NULL,'F','O-',_binary '','2023-08-25 16:47:05',NULL),(500,NULL,'Iram','Álvarez','Gutiérrez','1971-04-28',NULL,'M','A-',_binary '','2023-09-07 08:37:12',NULL),(501,'Tnte.','Gustavo','Hernández','Cortes','2007-12-14',NULL,'M','B+',_binary '','2023-07-05 09:25:44',NULL),(502,'Med.','José','Salazar','López','2004-09-17',NULL,'M','B-',_binary '','2021-01-26 08:44:18',NULL),(503,'Tnte.','Jorge','Ortiz','García','1999-09-01',NULL,'M','A+',_binary '','2022-09-12 09:59:59',NULL),(504,NULL,'Carmen','Hernández','García','1968-08-15',NULL,'F','O+',_binary '','2022-09-27 17:00:13',NULL),(505,NULL,'Pedro','Vázquez','Soto','1968-05-16',NULL,'M','O-',_binary '','2020-10-24 09:28:34',NULL),(506,NULL,'Flor','Romero','Vázquez','1998-10-29',NULL,'F','A-',_binary '','2023-02-12 08:28:55',NULL),(507,NULL,'Ana','Luna','Aguilar','1988-07-05',NULL,'F','AB-',_binary '','2023-01-16 14:30:02',NULL),(508,NULL,'Valeria','Pérez','Herrera','1963-03-11',NULL,'F','B-',_binary '','2022-09-27 09:48:44',NULL),(509,NULL,'Lucía','Herrera','Ortega','1974-11-04',NULL,'F','O-',_binary '','2020-01-30 09:17:53',NULL),(510,'Ing.','Luz','Ortega','Martínez','1993-01-27',NULL,'F','B+',_binary '','2021-05-28 18:06:06',NULL),(511,NULL,'Karla','Ramos','Gómes','1973-01-04',NULL,'F','AB-',_binary '','2023-01-20 14:15:12',NULL),(512,NULL,'Ricardo','Castro','Bautista','1989-03-24',NULL,'M','A-',_binary '','2020-11-04 12:40:42',NULL),(513,'C.P.','Karla','Contreras','Cruz','1985-06-09',NULL,'F','A+',_binary '','2023-10-26 11:16:54',NULL),(514,NULL,'Jesus','Guzmán','Aguilar','2000-07-23',NULL,'M','O-',_binary '','2021-02-17 13:43:27',NULL),(515,'Lic.','Federico','Guerrero','Estrada','2003-09-24',NULL,'M','O+',_binary '','2020-09-05 13:48:19',NULL),(516,NULL,'Paola','Reyes','Reyes','1986-04-10',NULL,'F','O-',_binary '','2023-10-23 18:01:08',NULL),(517,NULL,'Iram','Medina','Cruz','2000-12-09',NULL,'M','AB-',_binary '','2023-12-23 16:04:13',NULL),(518,NULL,'Mario','Vázquez','Sánchez','2004-11-21',NULL,'M','A-',_binary '','2021-03-08 17:16:33',NULL),(519,NULL,'Jazmin','Gómes','Herrera','1990-08-21',NULL,'F','A-',_binary '','2020-10-26 11:43:28',NULL),(520,NULL,'Gerardo','Medina','Moreno','1971-10-25',NULL,'M','O-',_binary '','2023-03-03 09:03:26',NULL),(521,NULL,'Sofia','Cruz','Díaz','1966-11-18',NULL,'F','O+',_binary '','2021-06-07 13:11:25',NULL),(522,NULL,'Jazmin','Ruíz','Castillo','1973-04-09',NULL,'F','O-',_binary '','2023-11-06 17:02:45',NULL),(523,NULL,'Maria','Mendoza','Bautista','1981-12-14',NULL,'F','B-',_binary '','2020-05-04 19:03:43',NULL),(524,'Srita','Flor','Torres','Gutiérrez','1998-07-17',NULL,'F','O-',_binary '','2021-01-13 13:22:48',NULL),(525,'Med.','Esmeralda','Álvarez','Ramos','1988-03-30',NULL,'F','A+',_binary '','2022-05-24 15:57:55',NULL),(526,'Sgto.','Aldair','Pérez','De la Cruz','1988-01-06',NULL,'M','AB+',_binary '','2020-06-27 18:17:38',NULL),(527,NULL,'Adan','Jiménez','Bautista','1999-06-01',NULL,'M','B+',_binary '','2023-05-19 11:33:45',NULL),(528,NULL,'Daniel','Domínguez','Ruíz','2007-03-26',NULL,'M','AB-',_binary '','2023-01-12 13:18:31',NULL),(529,NULL,'Adalid','Chávez','Vargas','2005-12-11',NULL,'M','AB+',_binary '','2020-05-04 15:42:20',NULL),(530,NULL,'Edgar',' González','Aguilar','2000-11-10',NULL,'M','O-',_binary '','2021-04-17 15:38:25',NULL),(531,NULL,'Bertha','Rodríguez','Mendoza','1989-04-30',NULL,'F','O-',_binary '','2022-04-03 08:56:15',NULL),(532,NULL,'Lucía','Salazar','Vargas','1967-09-20',NULL,'F','AB-',_binary '','2023-06-16 09:42:19',NULL),(533,NULL,'Gerardo','Ruíz','Rodríguez','1983-01-08',NULL,'M','A+',_binary '','2022-10-28 11:45:04',NULL),(534,NULL,'Ana','Ortiz','Ortiz','2005-04-21',NULL,'F','B+',_binary '','2023-07-08 10:43:13',NULL),(535,NULL,'Sofia','García',' Rivera','2000-06-29',NULL,'F','B-',_binary '','2023-04-24 15:02:00',NULL),(536,NULL,'Estrella','Reyes',' Rivera','1965-04-11',NULL,'F','O+',_binary '','2023-02-11 11:13:59',NULL),(537,NULL,'Alondra','Gutiérrez','Castro','1977-11-12',NULL,'F','O+',_binary '','2023-08-27 19:44:37',NULL),(538,NULL,'Maximiliano','Soto','Morales','1974-01-31',NULL,'M','O+',_binary '','2023-07-28 08:22:50',NULL),(539,NULL,'Sofia',' Rivera','Ruíz','1967-11-16',NULL,'F','AB-',_binary '','2020-03-01 08:39:50',NULL),(540,NULL,'Iram','Ortega','García','1984-01-19',NULL,'M','B-',_binary '','2023-03-05 13:19:08',NULL),(541,NULL,'Adan',' González','Velázquez','1988-12-30',NULL,'M','AB-',_binary '','2023-06-07 19:13:28',NULL),(542,NULL,'Diana','Mendoza','Castro','1972-12-07',NULL,'F','B+',_binary '','2022-09-02 11:49:11',NULL),(543,NULL,'Monica','Pérez','Chávez','1985-12-09',NULL,'F','A+',_binary '','2021-11-07 10:07:28',NULL),(544,NULL,'Paola','Herrera','Torres','1986-11-06',NULL,'F','O+',_binary '','2022-08-14 14:39:04',NULL),(545,NULL,'Hugo','Jiménez','Castillo','1986-01-04',NULL,'M','B+',_binary '','2022-08-25 13:00:02',NULL),(546,'C.','Juan','Méndez','Domínguez','1986-09-29',NULL,'M','O-',_binary '','2022-11-25 18:15:09',NULL),(547,'Tnte.','Iram','Méndez','Aguilar','1982-11-11',NULL,'M','A-',_binary '','2020-12-14 16:52:07',NULL),(548,'C.P.','Aldair','Torres','Vargas','1991-07-03',NULL,'M','A+',_binary '','2022-05-26 14:35:53',NULL),(549,NULL,'Lorena','Torres',' Rivera','2007-04-17',NULL,'F','A-',_binary '','2023-02-27 12:29:05',NULL),(550,NULL,'Jorge','Velázquez','Ramos','1999-11-12',NULL,'M','B+',_binary '','2023-04-07 09:54:01',NULL),(551,NULL,'José','Moreno','Ruíz','1983-08-06',NULL,'M','B+',_binary '','2020-12-04 08:59:53',NULL),(552,NULL,'Hortencia','Luna','Ramos','1990-07-15',NULL,'F','B+',_binary '','2022-03-16 17:22:59',NULL),(553,NULL,'Federico','Vázquez','Velázquez','1962-05-25',NULL,'M','A+',_binary '','2023-05-09 08:20:21',NULL),(554,NULL,'Juan','Luna','Pérez','2005-08-13',NULL,'M','B-',_binary '','2021-06-09 13:00:11',NULL),(555,'Srita','Paola','Martínez','Rodríguez','1983-04-05',NULL,'F','A+',_binary '','2023-12-13 13:54:54',NULL),(556,NULL,'Esmeralda','Méndez','Salazar','1981-05-05',NULL,'F','O+',_binary '','2022-07-18 16:08:05',NULL),(557,NULL,'Adan','Velázquez','Cruz','1989-06-21',NULL,'M','AB+',_binary '','2023-05-26 13:46:52',NULL),(558,'Mtra','Luz','Romero','Cortes','1984-05-30',NULL,'F','O-',_binary '','2021-02-22 13:49:49',NULL),(559,NULL,'Dulce','Luna','De la Cruz','1977-09-17',NULL,'F','AB+',_binary '','2022-07-03 12:23:54',NULL),(560,'Med.','Monica','Santiago','Romero','2001-02-16',NULL,'F','O+',_binary '','2020-11-02 16:58:06',NULL),(561,NULL,'Hortencia','García','Chávez','1995-04-15',NULL,'F','O-',_binary '','2022-09-14 11:59:00',NULL),(562,NULL,'Mario','Guerrero','Vázquez','1990-09-26',NULL,'M','B-',_binary '','2020-03-12 08:33:30',NULL),(563,NULL,'Lucía','Martínez','Contreras','2002-08-27',NULL,'F','A+',_binary '','2021-11-01 09:43:19',NULL),(564,NULL,'Paula','Reyes','Herrera','1985-05-15',NULL,'F','AB-',_binary '','2022-08-23 10:48:54',NULL),(565,NULL,'Dulce','Gómes','Contreras','1974-05-05',NULL,'F','A-',_binary '','2023-02-11 12:03:39',NULL),(566,NULL,'Brenda','Gutiérrez','Méndez','1991-10-14',NULL,'F','AB-',_binary '','2021-08-19 19:09:03',NULL),(567,NULL,'Ameli','Aguilar','Aguilar','2003-01-09',NULL,'F','A-',_binary '','2020-11-05 13:49:41',NULL),(568,NULL,'Bertha','Ramos','Luna','1975-12-13',NULL,'F','A-',_binary '','2023-08-18 17:51:47',NULL),(569,NULL,'Lucía','Moreno','Luna','1999-04-02',NULL,'F','AB+',_binary '','2021-08-22 11:10:21',NULL),(570,NULL,'Iram','Hernández','Herrera','1974-07-14',NULL,'M','AB+',_binary '','2023-09-16 17:05:24',NULL),(571,NULL,'Edgar','Ruíz','Ortega','1967-08-01',NULL,'M','A-',_binary '','2023-01-15 18:53:57',NULL),(572,'C.','Samuel','Reyes','Ramos','1971-08-05',NULL,'M','B-',_binary '','2020-10-01 16:51:45',NULL),(573,NULL,'Lucía','Morales','Salazar','1977-03-18',NULL,'F','B+',_binary '','2023-01-31 15:12:29',NULL),(574,NULL,'José','Ruíz','García','2006-04-04',NULL,'M','AB-',_binary '','2022-10-23 10:54:23',NULL),(575,NULL,'Estrella','Sánchez','Luna','1999-06-27',NULL,'F','AB+',_binary '','2021-05-22 19:52:42',NULL),(576,NULL,'Bertha','Gutiérrez','Chávez','1997-12-28',NULL,'F','A-',_binary '','2023-03-04 09:32:13',NULL),(577,NULL,'Diana','Álvarez','Gómes','1988-07-10',NULL,'F','B+',_binary '','2022-12-06 15:27:34',NULL),(578,NULL,'Suri','Cortes','Álvarez','2006-09-02',NULL,'F','B+',_binary '','2022-02-08 16:11:14',NULL),(579,NULL,'Lucía','Mendoza',' Rivera','1996-04-07',NULL,'F','O-',_binary '','2022-10-31 13:12:12',NULL),(580,NULL,'Lorena','Guzmán','Domínguez','1959-03-01',NULL,'F','A+',_binary '','2021-05-06 13:05:43',NULL),(581,NULL,'Valeria','Contreras','Vázquez','2004-02-22',NULL,'F','O+',_binary '','2020-09-18 14:03:23',NULL),(582,NULL,'Federico','Moreno','Guzmán','1975-10-25',NULL,'M','B-',_binary '','2020-09-21 14:39:24',NULL),(583,'Joven','Jorge','Martínez','Soto','1998-02-03',NULL,'M','A+',_binary '','2023-01-18 15:07:35',NULL),(584,NULL,'Federico','Ramírez','Cruz','1982-05-06',NULL,'M','O+',_binary '','2022-02-11 10:13:29',NULL),(585,NULL,'Lorena','Aguilar','Ramírez','1985-08-28',NULL,'F','A-',_binary '','2021-05-31 09:28:08',NULL),(586,'Tnte.','Gerardo','Reyes','Castillo','1987-07-05',NULL,'M','B-',_binary '','2021-10-05 17:52:31',NULL),(587,NULL,'Paola','Martínez','Martínez','1964-05-19',NULL,'F','B-',_binary '','2022-09-24 09:10:45',NULL),(588,NULL,'Alondra','Vázquez','Morales','1980-05-23',NULL,'F','B-',_binary '','2023-06-18 18:34:51',NULL),(589,NULL,'Hortencia','López','De la Cruz','1994-05-22',NULL,'F','A-',_binary '','2020-02-17 13:19:40',NULL),(590,NULL,'Ana','Torres','Guerrero','1985-11-24',NULL,'F','A+',_binary '','2021-09-23 08:33:17',NULL),(591,NULL,'Federico','Soto','Díaz','1995-05-06',NULL,'M','AB-',_binary '','2020-08-09 16:33:04',NULL),(592,NULL,'Carmen','Cortes','Martínez','1986-12-27',NULL,'F','AB-',_binary '','2023-07-31 09:58:02',NULL),(593,'Joven','Yair','Ramos','Herrera','1982-10-08',NULL,'M','B-',_binary '','2021-11-26 09:46:25',NULL),(594,'Lic.','Juan','Guerrero','Mendoza','1975-02-16',NULL,'M','B-',_binary '','2023-11-02 13:40:52',NULL),(595,'Mtra','Lorena','Sánchez','Castro','1963-10-09',NULL,'F','B+',_binary '','2021-06-29 17:43:56',NULL),(596,'Sr.','Jesus','López','Guerrero','1974-05-21',NULL,'M','O+',_binary '','2021-05-09 08:53:08',NULL),(597,'Pfra','Esmeralda','Bautista','Salazar','1975-04-17',NULL,'F','A-',_binary '','2022-11-10 08:23:02',NULL),(598,NULL,'Flor','Hernández','Domínguez','1973-01-25',NULL,'F','B-',_binary '','2021-06-20 13:19:31',NULL),(599,NULL,'Federico','Reyes','Ortega','1982-06-25',NULL,'M','O+',_binary '','2021-09-20 17:09:58',NULL),(600,NULL,'Paola','Aguilar','Martínez','2002-12-18',NULL,'F','B+',_binary '','2020-02-22 09:42:20',NULL),(601,NULL,'Mario','Méndez','Méndez','1962-04-06',NULL,'M','AB-',_binary '','2020-10-16 19:06:07',NULL),(602,'Lic.','José','Bautista','Vargas','1997-04-18',NULL,'M','AB-',_binary '','2021-04-07 12:04:50',NULL),(603,NULL,'Maria','Ruíz','Salazar','2007-10-28',NULL,'F','B-',_binary '','2021-04-26 10:29:30',NULL),(604,'C.P.','Ameli','Domínguez','Álvarez','1993-07-05',NULL,'F','O-',_binary '','2022-02-13 17:23:34',NULL),(605,'Med.','Valeria','Gutiérrez','Soto','2000-12-23',NULL,'F','B+',_binary '','2023-08-09 13:43:05',NULL),(606,NULL,'Gerardo','Hernández','Cruz','2003-10-05',NULL,'M','O-',_binary '','2020-12-31 10:38:35',NULL),(607,NULL,'Hortencia','Bautista','Ramírez','2006-06-13',NULL,'F','B+',_binary '','2023-06-15 09:25:04',NULL),(608,NULL,'Adan','Méndez','Ramírez','1969-01-28',NULL,'M','B-',_binary '','2023-05-24 15:30:27',NULL),(609,NULL,'Suri',' González','Estrada','1979-03-09',NULL,'F','A-',_binary '','2024-02-21 10:56:43',NULL),(610,NULL,'Ana','Castro','Contreras','2003-12-16',NULL,'F','A-',_binary '','2023-09-15 08:54:35',NULL),(611,NULL,'Marco','Moreno','Vázquez','2006-01-08',NULL,'M','O-',_binary '','2023-09-25 15:32:16',NULL),(612,NULL,'Esmeralda','Soto','Soto','1959-05-24',NULL,'F','A+',_binary '','2020-10-31 18:27:50',NULL),(613,NULL,'Lorena','Pérez','Aguilar','1999-03-28',NULL,'F','O+',_binary '','2022-04-21 12:22:31',NULL),(614,NULL,'Jorge','Herrera','Cruz','2005-08-13',NULL,'M','A-',_binary '','2023-11-05 09:55:43',NULL),(615,NULL,'Ameli','Juárez','Reyes','1992-10-09',NULL,'F','AB+',_binary '','2022-07-21 13:35:31',NULL),(616,'Sr.','Gerardo','Martínez','Díaz','1987-12-30',NULL,'M','O-',_binary '','2022-11-19 17:30:44',NULL),(617,NULL,'Paola','Domínguez','Ramírez','2003-01-16',NULL,'F','O-',_binary '','2020-08-11 18:01:28',NULL),(618,NULL,'Jazmin','Reyes','Soto','1964-06-08',NULL,'F','AB+',_binary '','2021-08-18 11:57:26',NULL),(619,NULL,'Jazmin','Castillo','Guerrero','1963-01-25',NULL,'F','AB-',_binary '','2020-06-29 14:56:14',NULL),(620,'Mtro.','Aldair','Hernández','Sánchez','1994-08-21',NULL,'M','A-',_binary '','2022-12-09 08:04:55',NULL),(621,NULL,'Dulce','Rodríguez','Sánchez','1977-04-29',NULL,'F','B-',_binary '','2023-11-10 12:58:15',NULL),(622,'C.','Gustavo',' Rivera','Morales','1982-05-14',NULL,'M','AB+',_binary '','2022-07-12 10:40:18',NULL),(623,NULL,'Hugo','Bautista','Velázquez','2005-07-12',NULL,'M','B-',_binary '','2021-06-28 13:41:44',NULL),(624,NULL,' Agustin','Moreno','Salazar','1995-06-05',NULL,'M','A-',_binary '','2023-09-14 17:24:50',NULL),(625,NULL,'Flor','Jiménez','Cruz','1960-05-25',NULL,'F','AB+',_binary '','2022-12-22 18:48:38',NULL),(626,NULL,'Ameli','Gómes',' Rivera','1970-08-04',NULL,'F','B-',_binary '','2021-03-01 10:32:14',NULL),(627,NULL,'Pedro','Gómes','Ortega','1991-04-08',NULL,'M','AB-',_binary '','2021-06-01 16:38:02',NULL),(628,'Ing.','Jesus','Cruz','Juárez','1980-01-07',NULL,'M','B+',_binary '','2021-06-14 17:14:48',NULL),(629,NULL,'Alondra','Bautista','Méndez','2002-08-20',NULL,'F','O+',_binary '','2021-08-17 14:18:31',NULL),(630,'C.','Valeria','Romero','Velázquez','1973-06-15',NULL,'F','A-',_binary '','2023-09-03 19:31:43',NULL),(631,NULL,'Esmeralda','Estrada','Domínguez','1981-12-12',NULL,'F','B+',_binary '','2021-12-21 10:59:50',NULL),(632,NULL,' Agustin','Mendoza','Álvarez','1980-05-16',NULL,'M','AB+',_binary '','2022-01-08 17:07:11',NULL),(633,'Ing.','Esmeralda','Vázquez','Ruíz','1966-11-11',NULL,'F','AB+',_binary '','2022-08-24 11:48:16',NULL),(634,NULL,'José','Hernández','Sánchez','1990-10-28',NULL,'M','O+',_binary '','2020-06-11 09:17:58',NULL),(635,NULL,'Maximiliano','Ortega','Domínguez','1991-01-20',NULL,'M','B+',_binary '','2022-05-15 19:14:05',NULL),(636,NULL,'Lorena','Pérez','Castillo','1967-03-29',NULL,'F','B+',_binary '','2020-08-02 16:41:49',NULL),(637,NULL,'Jesus','Méndez','Díaz','1967-07-13',NULL,'M','O+',_binary '','2021-08-06 14:59:21',NULL),(638,NULL,'Suri','Castro','Cortés','1995-02-26',NULL,'F','O+',_binary '','2022-07-12 17:01:41',NULL),(639,NULL,'Jazmin','Álvarez','Morales','1988-05-15',NULL,'F','B+',_binary '','2022-01-31 16:48:20',NULL),(640,NULL,'Dulce','Medina','Cortés','1999-08-10',NULL,'F','A-',_binary '','2021-12-31 17:56:53',NULL),(641,'Tnte.','José','López','Jiménez','1976-05-29',NULL,'M','O+',_binary '','2020-04-08 18:13:07',NULL),(642,NULL,'José','Aguilar','Cortes','1997-11-21',NULL,'M','B+',_binary '','2020-05-25 15:10:10',NULL),(643,'Sra.','Alondra','Santiago','Morales','1986-11-19',NULL,'F','A+',_binary '','2023-05-16 16:58:10',NULL),(644,NULL,'Juan','Martínez','García','1960-12-13',NULL,'M','A+',_binary '','2021-03-25 10:49:32',NULL),(645,NULL,'Karla','Méndez','Santiago','1994-09-01',NULL,'F','O-',_binary '','2023-01-28 16:59:13',NULL),(646,NULL,'Juan','Morales','Hernández','1975-12-24',NULL,'M','AB-',_binary '','2021-04-03 14:07:56',NULL),(647,NULL,'Valeria','Velázquez',' González','1963-09-08',NULL,'F','A-',_binary '','2023-05-14 12:43:33',NULL),(648,'Lic.','Brenda','Castro','Gutiérrez','1994-08-22',NULL,'F','AB+',_binary '','2021-08-21 13:10:22',NULL),(649,'Med.','Sofia','Estrada','Pérez','1994-01-06',NULL,'F','B+',_binary '','2020-07-24 18:58:41',NULL),(650,NULL,'Luz','Vázquez','Sánchez','2004-01-30',NULL,'F','A-',_binary '','2023-10-08 09:39:10',NULL),(651,NULL,'Ana','Soto','Pérez','1988-05-14',NULL,'F','AB-',_binary '','2022-01-12 13:44:26',NULL),(652,'Lic.','Jesus','Velázquez','Moreno','1963-04-30',NULL,'M','O-',_binary '','2023-02-03 16:36:58',NULL),(653,'Med.','Ameli','Herrera','Medina','1980-05-12',NULL,'F','A+',_binary '','2020-12-18 18:05:47',NULL),(654,NULL,'Brenda','Morales','Bautista','1959-11-06',NULL,'F','A-',_binary '','2020-05-18 17:19:07',NULL),(655,NULL,'Yair','Ortiz','Castro','1969-02-14',NULL,'M','O-',_binary '','2023-04-18 11:49:52',NULL),(656,NULL,'Estrella','Santiago',' Rivera','1975-08-18',NULL,'F','O-',_binary '','2021-12-09 15:46:04',NULL),(657,NULL,'Luz','Domínguez','Hernández','1963-05-28',NULL,'F','B-',_binary '','2023-04-06 16:21:27',NULL),(658,'C.P.','Ameli','Chávez','Gómes','1979-10-11',NULL,'F','B-',_binary '','2023-03-25 15:55:27',NULL),(659,NULL,'Fernando','Reyes','De la Cruz','1960-02-23',NULL,'M','O+',_binary '','2022-11-26 10:48:42',NULL),(660,NULL,'Lorena','Santiago','Jiménez','2004-04-28',NULL,'F','AB-',_binary '','2022-03-18 16:08:48',NULL),(661,NULL,'Daniel','Velázquez','Santiago','1966-01-02',NULL,'M','A+',_binary '','2023-04-12 17:48:26',NULL),(662,NULL,'Estrella','Martínez','Ruíz','1999-05-03',NULL,'F','O-',_binary '','2020-11-15 10:59:49',NULL),(663,NULL,'Diana','Torres','Jiménez','1986-09-27',NULL,'F','O+',_binary '','2022-11-06 17:36:07',NULL),(664,NULL,'Ricardo','De la Cruz','Morales','2002-10-20',NULL,'M','AB-',_binary '','2023-05-19 19:39:35',NULL),(665,NULL,'Aldair','Cruz','Pérez','1960-07-11',NULL,'M','O+',_binary '','2023-07-25 19:03:03',NULL),(666,NULL,'Samuel','Ruíz','Cortes','1999-08-16',NULL,'M','AB+',_binary '','2020-07-01 08:30:42',NULL),(667,'Mtra','Brenda','Chávez','Juárez','1975-11-22',NULL,'F','O-',_binary '','2021-11-02 14:21:49',NULL),(668,'Mtro.','Juan','Ramírez','Herrera','2001-04-01',NULL,'M','B+',_binary '','2022-12-17 17:26:42',NULL),(669,NULL,'Monica','Moreno','Torres','1969-07-22',NULL,'F','A+',_binary '','2023-07-24 19:49:22',NULL),(670,NULL,'Samuel','Castro','Velázquez','1991-12-14',NULL,'M','A+',_binary '','2021-04-13 12:13:24',NULL),(671,NULL,'Dulce','Herrera','Estrada','1989-09-25',NULL,'F','B+',_binary '','2023-06-28 10:02:12',NULL),(672,NULL,'Lorena',' González','Castillo','1964-09-03',NULL,'F','A+',_binary '','2021-02-16 19:53:55',NULL),(673,NULL,'Jesus','Ramos','Castro','1993-09-12',NULL,'M','B-',_binary '','2023-04-19 17:51:25',NULL),(674,NULL,'Hortencia','López','Salazar','2003-02-17',NULL,'F','A+',_binary '','2021-06-05 16:21:19',NULL),(675,'C.P.','Hortencia','Hernández','Aguilar','1965-11-27',NULL,'F','B-',_binary '','2022-05-09 15:41:59',NULL),(676,NULL,'Jesus',' González',' González','1968-12-21',NULL,'M','AB-',_binary '','2023-11-13 14:22:38',NULL),(677,NULL,'Paula','Soto','Cruz','2007-06-29',NULL,'F','B+',_binary '','2023-07-08 09:44:59',NULL),(678,NULL,'Ana','Ramos','Díaz','2001-08-05',NULL,'F','B+',_binary '','2023-08-03 13:14:24',NULL),(679,NULL,'Yair','Vázquez','Santiago','1990-05-16',NULL,'M','AB+',_binary '','2022-08-16 15:32:57',NULL),(680,NULL,'Aldair','Velázquez','Cortés','1985-04-16',NULL,'M','O+',_binary '','2020-11-01 16:42:20',NULL),(681,NULL,'Juan','Bautista','Romero','1994-05-15',NULL,'M','A+',_binary '','2020-06-19 12:48:22',NULL),(682,NULL,'Federico','García',' Rivera','2003-10-26',NULL,'M','O+',_binary '','2020-05-20 09:59:19',NULL),(683,NULL,'Lorena','López','Torres','1981-09-29',NULL,'F','B+',_binary '','2020-06-21 16:02:44',NULL),(684,'Ing.','Iram','Guerrero','Morales','1981-08-19',NULL,'M','AB+',_binary '','2021-10-25 13:56:58',NULL),(685,NULL,'Estrella','Romero','Vargas','1963-07-14',NULL,'F','B+',_binary '','2020-07-12 17:34:58',NULL),(686,NULL,'Jorge','Gómes','Estrada','1959-04-17',NULL,'M','A-',_binary '','2020-03-21 15:32:58',NULL),(687,NULL,'Estrella','Ramírez','Cortés','1977-06-04',NULL,'F','O-',_binary '','2022-07-05 10:12:56',NULL),(688,NULL,'Diana','Mendoza','Herrera','1964-04-21',NULL,'F','AB+',_binary '','2021-01-29 17:02:25',NULL),(689,NULL,'Adalid','Méndez','Ramos','1983-07-04',NULL,'M','AB+',_binary '','2021-11-02 13:25:10',NULL),(690,NULL,'Maximiliano','Velázquez','García','2002-06-02',NULL,'M','B+',_binary '','2023-08-27 13:42:26',NULL),(691,'Lic.','Guadalupe','Estrada','Ortega','1984-01-07',NULL,'F','O-',_binary '','2021-01-16 12:42:10',NULL),(692,NULL,'Samuel','Chávez','García','1979-05-29',NULL,'M','O-',_binary '','2023-02-16 17:11:31',NULL),(693,NULL,'Carlos','Herrera','Salazar','1965-02-25',NULL,'M','A-',_binary '','2021-07-24 13:11:44',NULL),(694,NULL,'Monica','Cruz','Bautista','1971-05-25',NULL,'F','B+',_binary '','2020-07-09 14:02:07',NULL),(695,NULL,'Jorge','Sánchez','Juárez','1987-02-20',NULL,'M','A+',_binary '','2021-11-22 10:06:36',NULL),(696,NULL,'Karla','Aguilar','Torres','1974-09-18',NULL,'F','AB+',_binary '','2020-05-21 15:39:01',NULL),(697,'Sra.','Paola','Cortes','Guerrero','2007-03-09',NULL,'F','A-',_binary '','2023-05-06 14:53:22',NULL),(698,NULL,'Juan','Ortega','Sánchez','1965-10-05',NULL,'M','A-',_binary '','2023-04-22 11:03:57',NULL),(699,'Sr.','Aldair','Chávez','Soto','1968-05-05',NULL,'M','O-',_binary '','2021-07-22 18:53:37',NULL),(700,NULL,'Hortencia','Guerrero','Bautista','1959-08-15',NULL,'F','A-',_binary '','2023-12-31 10:34:11',NULL),(701,NULL,'Monica','Ortega','Reyes','2000-02-20',NULL,'F','B+',_binary '','2020-07-25 16:19:08',NULL),(702,NULL,'Maria','Guerrero','Reyes','1995-12-13',NULL,'F','O-',_binary '','2020-07-15 08:13:28',NULL),(703,NULL,'Adalid','Medina','Reyes','1977-03-09',NULL,'M','O-',_binary '','2023-01-12 16:56:35',NULL),(704,NULL,'Lorena','Soto','Ortega','1976-03-05',NULL,'F','A-',_binary '','2022-09-04 17:39:48',NULL),(705,NULL,'Gerardo','Mendoza','Rodríguez','1979-05-10',NULL,'M','AB-',_binary '','2020-06-01 14:00:11',NULL),(706,NULL,'Maria',' González','Díaz','1981-08-26',NULL,'F','A-',_binary '','2023-08-13 15:11:37',NULL),(707,NULL,'Esmeralda','Castro','Medina','1972-03-09',NULL,'F','B+',_binary '','2022-05-31 08:52:55',NULL),(708,NULL,'Lucía','Morales','Velázquez','1962-12-08',NULL,'F','A+',_binary '','2021-02-22 08:51:55',NULL),(709,'Sr.','Yair','Estrada','Ramírez','1962-05-02',NULL,'M','O+',_binary '','2023-09-12 19:55:54',NULL),(710,NULL,'Alondra','Juárez','Soto','1964-03-30',NULL,'F','AB+',_binary '','2021-11-02 14:42:13',NULL),(711,NULL,'Marco','Sánchez','Herrera','2006-02-26',NULL,'M','O+',_binary '','2023-10-03 10:58:21',NULL),(712,'Sr.','Jesus','Estrada','Vázquez','1986-06-13',NULL,'M','O-',_binary '','2020-09-15 19:21:43',NULL),(713,NULL,'Flor','López','López','1967-01-10',NULL,'F','AB+',_binary '','2021-06-09 08:24:46',NULL),(714,NULL,'Lorena','Castillo','Ortiz','1998-02-23',NULL,'F','AB+',_binary '','2022-11-20 15:28:31',NULL),(715,NULL,'Flor','Vázquez','Guerrero','1998-04-27',NULL,'F','A-',_binary '','2023-06-11 12:50:00',NULL),(716,NULL,'Mario','De la Cruz','Medina','1960-11-10',NULL,'M','A-',_binary '','2022-05-04 12:57:15',NULL),(717,NULL,'Jazmin','Contreras','Méndez','1978-09-07',NULL,'F','B+',_binary '','2021-07-13 18:51:17',NULL),(718,'Lic.','Hortencia','Herrera','Medina','1981-04-22',NULL,'F','A-',_binary '','2022-06-18 12:41:14',NULL),(719,NULL,'Carlos','Castro','García','1962-12-09',NULL,'M','B+',_binary '','2020-06-07 16:38:38',NULL),(720,NULL,'Valeria','García','Díaz','1990-04-15',NULL,'F','A-',_binary '','2023-05-10 15:16:46',NULL),(721,NULL,'José','Santiago','Aguilar','1983-11-22',NULL,'M','A-',_binary '','2022-09-16 14:41:29',NULL),(722,NULL,'Bertha','Luna','García','1985-12-31',NULL,'F','AB-',_binary '','2023-01-12 15:26:50',NULL),(723,NULL,'José','Méndez','Castro','2005-05-05',NULL,'M','AB+',_binary '','2020-02-03 12:49:01',NULL),(724,NULL,'Adalid','Domínguez','Ramírez','2001-12-24',NULL,'M','O+',_binary '','2023-01-22 08:46:38',NULL),(725,'C.','Daniel','Morales','Díaz','2007-12-12',NULL,'M','O-',_binary '','2022-07-30 12:00:40',NULL),(726,NULL,'Diana',' González','López','1963-08-25',NULL,'F','A-',_binary '','2023-07-16 14:57:24',NULL),(727,NULL,'Esmeralda','Medina','Romero','1981-09-26',NULL,'F','O+',_binary '','2022-03-17 11:40:19',NULL),(728,NULL,'Monica','Morales','Vázquez','1988-04-16',NULL,'F','A-',_binary '','2023-12-28 12:13:19',NULL),(729,NULL,'Mario','Hernández','Velázquez','1999-06-06',NULL,'M','O+',_binary '','2022-06-06 13:52:56',NULL),(730,NULL,'Iram','Jiménez','Ramírez','2005-02-02',NULL,'M','A-',_binary '','2020-04-06 17:30:19',NULL),(731,NULL,'Monica','Moreno','Díaz','1978-08-23',NULL,'F','O-',_binary '','2021-08-03 09:59:47',NULL),(732,NULL,'Maria','Guzmán','Chávez','1988-12-07',NULL,'F','B+',_binary '','2023-01-22 16:55:20',NULL),(733,NULL,' Agustin','Méndez','Reyes','1994-12-29',NULL,'M','O+',_binary '','2023-08-12 18:53:08',NULL),(734,NULL,'José','García','Ramírez','1997-09-25',NULL,'M','B-',_binary '','2023-01-18 12:54:16',NULL),(735,'Pfra','Bertha','Moreno','Soto','1988-12-26',NULL,'F','A+',_binary '','2021-08-24 18:10:17',NULL),(736,'Tnte.','Pedro','Ruíz','Juárez','2002-01-09',NULL,'M','AB+',_binary '','2020-08-13 08:56:43',NULL),(737,NULL,'Sofia','Salazar','Chávez','1977-05-08',NULL,'F','A-',_binary '','2022-06-13 14:16:50',NULL),(738,NULL,'Valeria','Velázquez','Soto','1990-10-01',NULL,'F','B+',_binary '','2021-06-10 19:33:33',NULL),(739,NULL,' Agustin','Castillo','Soto','1981-09-16',NULL,'M','B+',_binary '','2021-02-03 11:57:08',NULL),(740,NULL,'Ameli','Sánchez',' González','2007-07-13',NULL,'F','AB-',_binary '','2022-01-02 12:08:03',NULL),(741,NULL,'Jazmin','Reyes','Santiago','1987-09-24',NULL,'F','B+',_binary '','2022-03-13 18:30:41',NULL),(742,NULL,'Fernando','Ortiz','Moreno','1961-02-15',NULL,'M','O+',_binary '','2023-04-27 15:40:54',NULL),(743,NULL,'Bertha','Medina','Cruz','2003-01-29',NULL,'F','O-',_binary '','2023-07-21 14:32:31',NULL),(744,NULL,'Esmeralda','Martínez','Jiménez','1977-05-14',NULL,'F','O-',_binary '','2022-10-14 13:43:26',NULL),(745,NULL,'José','Cruz','Ortega','2000-01-04',NULL,'M','AB+',_binary '','2020-11-16 13:07:56',NULL),(746,NULL,'Alejandro','López','Cortés','1989-10-06',NULL,'M','A-',_binary '','2020-09-08 10:26:31',NULL),(747,NULL,'Yair','López','De la Cruz','1996-12-30',NULL,'M','B-',_binary '','2020-07-13 10:05:26',NULL),(748,NULL,'Monica','Castillo','Ruíz','1983-10-05',NULL,'F','B+',_binary '','2020-11-26 08:37:32',NULL),(749,NULL,'Aldair','Ramos','Gómes','1972-08-28',NULL,'M','AB-',_binary '','2022-07-13 19:47:47',NULL),(750,NULL,'Lucía','Castillo','Cortés','1979-10-07',NULL,'F','A-',_binary '','2022-10-05 17:10:44',NULL),(751,NULL,'Ameli','Rodríguez','Guerrero','1966-01-09',NULL,'F','O-',_binary '','2022-05-15 18:16:11',NULL),(752,NULL,'José','Vázquez','Torres','2003-03-21',NULL,'M','B-',_binary '','2022-12-07 09:00:28',NULL),(753,'Sgto.',' Agustin','Bautista','Cortes','1969-12-15',NULL,'M','B-',_binary '','2022-06-11 15:03:56',NULL),(754,NULL,'Adalid',' Rivera','Guzmán','1960-04-26',NULL,'M','O+',_binary '','2020-11-18 13:53:01',NULL),(755,NULL,'Luz','Velázquez','Chávez','1983-11-26',NULL,'F','O+',_binary '','2022-10-15 18:04:38',NULL),(756,'Mtro.','Maximiliano','Hernández','Vázquez','1977-04-23',NULL,'M','A+',_binary '','2020-01-03 19:16:59',NULL),(757,'Joven','Carlos','Jiménez','Sánchez','2000-12-22',NULL,'M','O+',_binary '','2021-09-07 15:45:54',NULL),(758,NULL,'Paola','Santiago','Mendoza','1977-09-10',NULL,'F','AB-',_binary '','2020-05-15 14:09:07',NULL),(759,'Sgto.','Edgar','Ortiz','Rodríguez','1974-11-24',NULL,'M','A-',_binary '','2020-04-22 16:57:26',NULL),(760,NULL,'Hortencia','Vargas','García','2005-03-06',NULL,'F','AB+',_binary '','2021-01-07 12:39:59',NULL),(761,NULL,'Karla','García','Reyes','1976-04-14',NULL,'F','O+',_binary '','2021-03-07 17:51:30',NULL),(762,NULL,'Bertha','Gómes','Luna','1985-11-08',NULL,'F','A-',_binary '','2021-03-11 18:34:32',NULL),(763,NULL,'José','Vargas','Medina','1972-03-10',NULL,'M','B+',_binary '','2022-02-01 16:46:31',NULL),(764,NULL,'Adalid',' Rivera','De la Cruz','1968-05-03',NULL,'M','AB+',_binary '','2021-02-23 16:07:11',NULL),(765,NULL,'Jazmin','Ortega','Salazar','1988-06-22',NULL,'F','B-',_binary '','2022-07-14 15:14:57',NULL),(766,NULL,'Maria','Gutiérrez','Vargas','1986-03-30',NULL,'F','AB+',_binary '','2020-08-13 08:41:36',NULL),(767,NULL,'Ricardo','Santiago','Guzmán','1963-07-19',NULL,'M','A-',_binary '','2023-01-12 08:33:04',NULL),(768,NULL,'Sofia','Sánchez','Sánchez','1976-01-29',NULL,'F','B+',_binary '','2021-03-06 15:30:11',NULL),(769,NULL,'Gerardo','Cruz','López','1997-10-05',NULL,'M','AB-',_binary '','2020-12-28 08:22:05',NULL),(770,NULL,'Gerardo','Moreno','Castillo','1960-09-02',NULL,'M','AB-',_binary '','2021-06-01 15:43:37',NULL),(771,NULL,'Carmen','Soto','Guerrero','1989-07-31',NULL,'F','B+',_binary '','2023-09-30 13:22:29',NULL),(772,NULL,'Estrella','Herrera','Romero','1984-12-04',NULL,'F','A+',_binary '','2024-01-27 14:45:29',NULL),(773,'Lic.','Monica','Gutiérrez','Guerrero','1980-06-05',NULL,'F','B-',_binary '','2023-09-20 09:50:30',NULL),(774,NULL,'Sofia','Herrera','Contreras','1961-05-01',NULL,'F','O+',_binary '','2023-06-03 16:51:55',NULL),(775,NULL,'Adalid','Contreras','Ortega','2004-07-27',NULL,'M','A+',_binary '','2021-06-17 16:07:39',NULL),(776,NULL,'Jazmin','Estrada','Rodríguez','1999-09-07',NULL,'F','O+',_binary '','2021-06-06 13:06:17',NULL),(777,NULL,'Alondra','Guerrero','Castillo','1993-06-10',NULL,'F','A+',_binary '','2020-02-06 08:32:51',NULL),(778,NULL,'Esmeralda','Guzmán','Guzmán','1985-08-26',NULL,'F','B-',_binary '','2022-04-23 13:39:03',NULL),(779,'Tnte.','Federico','Sánchez','Cruz','1982-10-08',NULL,'M','O+',_binary '','2023-02-05 10:31:35',NULL),(780,NULL,'Aldair','Morales','Ruíz','1968-01-30',NULL,'M','O+',_binary '','2020-11-20 17:44:28',NULL),(781,NULL,'Monica',' Rivera','Santiago','1995-12-23',NULL,'F','A+',_binary '','2020-03-02 08:18:29',NULL),(782,NULL,'Dulce','Salazar','Guzmán','1971-10-20',NULL,'F','A+',_binary '','2022-02-05 12:15:50',NULL),(783,'Sr.','Fernando','López','Domínguez','1963-08-03',NULL,'M','B-',_binary '','2020-06-06 09:06:55',NULL),(784,'Lic.','Estrella','Cortes','Cruz','1974-01-02',NULL,'F','O-',_binary '','2023-05-13 10:33:01',NULL),(785,NULL,' Agustin','Cortes','Álvarez','2007-07-06',NULL,'M','B+',_binary '','2023-09-20 12:19:13',NULL),(786,'Tnte.','Hugo','Gutiérrez','Salazar','1960-02-24',NULL,'M','AB-',_binary '','2020-06-17 15:48:52',NULL),(787,NULL,'Aldair','Gutiérrez','Soto','2000-11-21',NULL,'M','B+',_binary '','2023-04-05 09:23:12',NULL),(788,NULL,'Brenda','Reyes','Morales','1976-03-08',NULL,'F','O-',_binary '','2023-10-15 14:59:21',NULL),(789,NULL,'Samuel','Chávez','Hernández','1973-09-10',NULL,'M','B-',_binary '','2022-01-21 08:30:44',NULL),(790,NULL,'Carlos','Santiago','Martínez','1987-01-30',NULL,'M','AB-',_binary '','2023-02-16 16:12:39',NULL),(791,NULL,'Diana','Guzmán','Gutiérrez','1989-09-29',NULL,'F','O-',_binary '','2020-06-02 14:15:32',NULL),(792,'Ing.','Lorena',' Rivera','Ortega','1988-05-15',NULL,'F','B+',_binary '','2023-11-21 15:42:09',NULL),(793,'Joven','Carlos','Ortiz','Guzmán','1978-07-28',NULL,'M','AB-',_binary '','2022-01-03 10:31:31',NULL),(794,NULL,'Adan','Mendoza','Gutiérrez','1992-02-29',NULL,'M','A-',_binary '','2020-10-18 10:46:23',NULL),(795,NULL,'Maria','Aguilar','Cortés','1986-10-21',NULL,'F','O-',_binary '','2023-09-10 16:16:57',NULL),(796,NULL,'Jesus',' González','Pérez','1973-08-15',NULL,'M','A+',_binary '','2022-12-15 10:21:46',NULL),(797,NULL,'Sofia','Ruíz','Mendoza','2003-01-20',NULL,'F','A-',_binary '','2021-10-27 14:11:34',NULL),(798,NULL,'Jesus','Luna','Santiago','2002-01-23',NULL,'M','AB-',_binary '','2023-11-05 13:53:48',NULL),(799,NULL,'Flor','López','Estrada','1983-08-02',NULL,'F','AB-',_binary '','2023-11-07 14:55:19',NULL),(800,NULL,'Federico','Rodríguez','López','2004-06-22',NULL,'M','B-',_binary '','2021-08-16 15:51:56',NULL),(801,NULL,'Sofia','Domínguez','Chávez','2005-02-27',NULL,'F','O-',_binary '','2020-04-11 12:51:57',NULL),(802,NULL,'Fernando','Romero','Luna','1994-11-08',NULL,'M','A+',_binary '','2020-09-13 15:35:15',NULL),(803,'Tnte.',' Agustin',' Rivera','Ruíz','1969-01-24',NULL,'M','O+',_binary '','2022-01-31 08:29:40',NULL),(804,NULL,'Paola','Méndez',' Rivera','1973-12-13',NULL,'F','AB-',_binary '','2023-05-20 18:01:49',NULL),(805,NULL,' Agustin',' Rivera','Mendoza','1971-04-13',NULL,'M','A+',_binary '','2021-04-14 14:09:29',NULL),(806,'Mtro.','Edgar','Reyes','Gutiérrez','1959-10-28',NULL,'M','O-',_binary '','2022-08-04 11:48:59',NULL),(807,NULL,'Suri','Ramos','Ramos','1971-08-27',NULL,'F','B-',_binary '','2020-07-19 14:15:43',NULL),(808,NULL,'Ricardo','Jiménez','Luna','1976-02-15',NULL,'M','A-',_binary '','2023-07-16 16:38:45',NULL),(809,NULL,'Estrella','Guzmán','Luna','2005-08-28',NULL,'F','A-',_binary '','2021-02-25 16:33:34',NULL),(810,'C.','Guadalupe','Ortega','Álvarez','1962-03-20',NULL,'F','AB-',_binary '','2021-08-20 17:49:21',NULL),(811,NULL,'Aldair','Gutiérrez','López','1969-04-15',NULL,'M','O+',_binary '','2022-04-05 10:37:16',NULL),(812,NULL,'Edgar','Díaz','Castro','1984-12-23',NULL,'M','B-',_binary '','2023-05-16 15:25:32',NULL),(813,NULL,'Jorge','Martínez','García','1960-01-09',NULL,'M','A+',_binary '','2024-01-03 17:41:33',NULL),(814,NULL,'Brenda','Velázquez','Juárez','1997-06-08',NULL,'F','A+',_binary '','2023-10-01 12:18:52',NULL),(815,'Mtra','Hortencia','Domínguez','Domínguez','1973-12-22',NULL,'F','AB+',_binary '','2023-07-16 15:11:48',NULL),(816,NULL,'Maximiliano','López','Domínguez','1960-05-19',NULL,'M','A-',_binary '','2023-04-02 12:43:58',NULL),(817,NULL,'Paola','Castro','Romero','1979-08-08',NULL,'F','AB+',_binary '','2022-03-10 19:35:20',NULL),(818,NULL,'Karla','Luna','Torres','1965-01-13',NULL,'F','AB+',_binary '','2022-06-18 10:17:06',NULL),(819,NULL,'Estrella','Reyes','Chávez','2004-12-05',NULL,'F','O-',_binary '','2020-08-04 16:57:08',NULL),(820,NULL,'Diana','López','Cortés','1989-03-26',NULL,'F','A-',_binary '','2023-12-25 11:41:02',NULL),(821,NULL,'Maximiliano','Contreras','Vázquez','2005-05-30',NULL,'M','O-',_binary '','2022-11-26 17:17:13',NULL),(822,NULL,'Bertha','Álvarez','Gutiérrez','1970-01-19',NULL,'F','A+',_binary '','2021-12-24 11:33:34',NULL),(823,'Dra.','Valeria','Cortés','Martínez','1977-05-02',NULL,'F','AB-',_binary '','2021-05-25 15:20:01',NULL),(824,NULL,'Alejandro','Morales','Salazar','1977-04-24',NULL,'M','B+',_binary '','2023-01-14 14:34:26',NULL),(825,'Med.','Hugo','Pérez','Moreno','1962-04-12',NULL,'M','O-',_binary '','2020-11-25 13:17:33',NULL),(826,NULL,'Lorena','Díaz','Juárez','1960-12-29',NULL,'F','B+',_binary '','2022-07-09 19:58:33',NULL),(827,NULL,'Estrella','Moreno','Ortiz','2001-11-08',NULL,'F','O-',_binary '','2021-04-24 15:26:28',NULL),(828,NULL,'Diana',' Rivera','Romero','1998-07-22',NULL,'F','B-',_binary '','2020-02-05 15:51:51',NULL),(829,NULL,'Brenda','Pérez','Torres','1976-07-20',NULL,'F','O+',_binary '','2023-02-05 13:14:56',NULL),(830,NULL,'Jesus','Gómes','Medina','1996-03-05',NULL,'M','AB-',_binary '','2021-06-20 15:07:05',NULL),(831,NULL,'Federico','Soto','Gutiérrez','2004-05-05',NULL,'M','B-',_binary '','2022-09-25 17:59:57',NULL),(832,NULL,'Yair','Ramírez','Mendoza','1982-12-18',NULL,'M','A-',_binary '','2022-07-26 13:17:39',NULL),(833,NULL,'Jesus','García','Guzmán','1989-12-10',NULL,'M','O-',_binary '','2022-12-20 17:44:08',NULL),(834,NULL,'Jesus','Cortes','Juárez','1980-01-31',NULL,'M','B+',_binary '','2021-02-20 13:16:02',NULL),(835,NULL,'Marco','Velázquez','Castro','1971-07-29',NULL,'M','A-',_binary '','2023-12-25 12:17:02',NULL),(836,NULL,'Monica','De la Cruz','Soto','1987-08-20',NULL,'F','O-',_binary '','2023-11-04 17:50:46',NULL),(837,NULL,' Agustin','Díaz','Cortes','1959-07-15',NULL,'M','B-',_binary '','2020-04-11 08:58:02',NULL),(838,'C.','Esmeralda','Juárez','Pérez','1991-01-17',NULL,'F','O-',_binary '','2023-04-20 09:26:23',NULL),(839,'C.','Pedro','Bautista','Aguilar','1975-12-01',NULL,'M','B-',_binary '','2020-01-01 17:26:01',NULL),(840,NULL,'Adalid','García',' González','1976-01-09',NULL,'M','B-',_binary '','2020-10-10 15:12:58',NULL),(841,NULL,'Jesus','De la Cruz','Domínguez','2000-01-09',NULL,'M','A-',_binary '','2022-12-02 17:26:31',NULL),(842,'C.P.','Suri','Díaz','Cortes','1961-07-09',NULL,'F','AB+',_binary '','2023-06-10 12:13:45',NULL),(843,NULL,'Bertha','Salazar','Santiago','2007-04-26',NULL,'F','A-',_binary '','2020-08-31 09:37:31',NULL),(844,NULL,'Flor','Castro','Ramírez','1997-03-12',NULL,'F','B+',_binary '','2021-09-09 19:53:24',NULL),(845,'Sgto.','Alejandro','Vargas','Reyes','1970-05-08',NULL,'M','B+',_binary '','2023-02-08 18:30:29',NULL),(846,NULL,'Dulce','Vázquez','Santiago','1991-06-28',NULL,'F','AB+',_binary '','2020-05-06 14:57:12',NULL),(847,NULL,'Luz','López',' González','1969-03-22',NULL,'F','O+',_binary '','2021-01-01 18:42:28',NULL),(848,'Mtra','Esmeralda','Cortés','Bautista','1998-03-30',NULL,'F','A-',_binary '','2021-07-03 12:17:19',NULL),(849,NULL,'Jazmin','Cortes','Romero','2005-07-30',NULL,'F','A-',_binary '','2020-05-06 18:21:05',NULL),(850,NULL,'Valeria','Díaz','Luna','1970-09-12',NULL,'F','AB+',_binary '','2021-08-16 09:08:14',NULL),(851,NULL,'Esmeralda','Castro',' Rivera','2000-08-07',NULL,'F','B-',_binary '','2022-07-13 17:04:42',NULL),(852,NULL,'Lorena','Gutiérrez','Salazar','1962-03-07',NULL,'F','O+',_binary '','2023-06-26 17:17:50',NULL),(853,NULL,'Luz','Romero','Jiménez','2008-01-24',NULL,'F','A+',_binary '','2021-03-16 11:21:47',NULL),(854,NULL,'Sofia','Rodríguez','Hernández','1992-05-26',NULL,'F','B+',_binary '','2023-04-19 18:24:50',NULL),(855,NULL,'Suri','Santiago','Cortés','1967-10-18',NULL,'F','O-',_binary '','2021-03-14 14:37:33',NULL),(856,'C.','Marco','Castillo','Gutiérrez','1974-07-20',NULL,'M','B-',_binary '','2022-02-15 08:59:32',NULL),(857,NULL,'Ameli','Ortiz',' Rivera','1990-02-02',NULL,'F','B-',_binary '','2020-02-17 08:01:31',NULL),(858,NULL,'Jorge','Ortiz','Martínez','2003-11-25',NULL,'M','B-',_binary '','2021-02-06 09:27:56',NULL),(859,'Lic.','Valeria','Domínguez','Romero','1985-11-08',NULL,'F','A-',_binary '','2021-11-25 15:34:04',NULL),(860,NULL,'Monica','Guzmán','Medina','1971-11-27',NULL,'F','A-',_binary '','2020-12-30 15:03:24',NULL),(861,NULL,'Karla','Chávez','Estrada','2007-11-15',NULL,'F','A-',_binary '','2023-05-14 14:51:01',NULL),(862,NULL,'Flor','Hernández','Herrera','1976-01-24',NULL,'F','AB-',_binary '','2021-10-27 09:17:16',NULL),(863,NULL,'Brenda','Guerrero','Reyes','1993-12-30',NULL,'F','AB-',_binary '','2021-05-26 15:13:37',NULL),(864,NULL,'Jazmin','Gutiérrez','Ruíz','1998-10-17',NULL,'F','O-',_binary '','2024-02-24 11:59:47',NULL),(865,NULL,'Valeria','Herrera','Juárez','1961-04-03',NULL,'F','B+',_binary '','2022-12-11 13:15:13',NULL),(866,NULL,'Ana','Ruíz',' González','1975-05-03',NULL,'F','B+',_binary '','2023-05-01 19:08:46',NULL),(867,NULL,'Luz','Estrada','Ruíz','1966-03-12',NULL,'F','AB+',_binary '','2021-02-17 16:51:39',NULL),(868,NULL,'Maria','Bautista','Romero','1992-08-06',NULL,'F','O-',_binary '','2021-12-15 15:42:29',NULL),(869,NULL,'Fernando','Vargas','Bautista','1984-12-09',NULL,'M','O+',_binary '','2021-07-28 14:11:48',NULL),(870,NULL,'Gustavo','Martínez','Aguilar','1961-05-31',NULL,'M','O-',_binary '','2022-01-28 16:34:07',NULL),(871,NULL,'Maximiliano','Ramos','Ruíz','1963-12-19',NULL,'M','B+',_binary '','2021-01-18 12:00:30',NULL),(872,NULL,'Jazmin','Hernández','Álvarez','1991-07-22',NULL,'F','AB-',_binary '','2022-03-10 14:17:43',NULL),(873,'Srita','Esmeralda','Juárez','Martínez','1980-12-04',NULL,'F','A+',_binary '','2023-12-12 14:54:21',NULL),(874,'Lic.','Flor','Vargas','Jiménez','1978-05-27',NULL,'F','A+',_binary '','2024-01-29 17:41:18',NULL),(875,'C.P.','Flor','Jiménez','Morales','1974-04-24',NULL,'F','O+',_binary '','2020-03-24 18:36:47',NULL),(876,NULL,'Federico','Castillo','Santiago','1960-05-14',NULL,'M','B-',_binary '','2020-04-25 09:04:28',NULL),(877,NULL,'Carlos','Santiago','López','1993-01-23',NULL,'M','A-',_binary '','2020-04-17 16:00:00',NULL),(878,'C.','Suri','Guzmán','Ramírez','1987-07-04',NULL,'F','B-',_binary '','2021-01-04 08:21:04',NULL),(879,NULL,'Bertha','Juárez','Velázquez','1960-12-25',NULL,'F','O+',_binary '','2020-07-25 09:35:18',NULL),(880,'Srita','Ameli','Domínguez','Juárez','1962-06-29',NULL,'F','AB+',_binary '','2021-06-20 10:47:17',NULL),(881,NULL,'Lucía','Ruíz','Ortiz','1962-08-24',NULL,'F','A+',_binary '','2023-05-20 08:37:11',NULL),(882,NULL,'Gustavo','Gutiérrez','García','1963-02-01',NULL,'M','B+',_binary '','2020-11-14 10:08:00',NULL),(883,NULL,'Carmen','Luna','Sánchez','1967-09-12',NULL,'F','B-',_binary '','2022-12-19 10:41:44',NULL),(884,'Tnte.','Iram','Ortega','Soto','1973-02-26',NULL,'M','B-',_binary '','2022-05-08 12:28:27',NULL),(885,'Med.','Gerardo','Santiago',' Rivera','1973-11-01',NULL,'M','AB-',_binary '','2022-08-25 08:44:53',NULL),(886,NULL,'Jazmin','Ortega','Estrada','1959-05-15',NULL,'F','A-',_binary '','2020-11-02 11:22:24',NULL),(887,NULL,'Ameli','Vázquez','Castro','1994-08-16',NULL,'F','AB+',_binary '','2021-06-12 10:43:29',NULL),(888,NULL,'Carmen','Chávez','Luna','1983-09-10',NULL,'F','O-',_binary '','2021-03-30 15:23:23',NULL),(889,NULL,'Marco','Ortega','Jiménez','2004-05-26',NULL,'M','AB-',_binary '','2022-12-03 13:08:52',NULL),(890,NULL,'Sofia',' González','Guerrero','1973-02-06',NULL,'F','AB-',_binary '','2022-05-19 17:41:03',NULL),(891,NULL,'Suri','Cruz','Torres','1963-06-25',NULL,'F','B-',_binary '','2020-02-23 17:33:19',NULL),(892,NULL,'Bertha','Hernández','Luna','1968-03-21',NULL,'F','B-',_binary '','2021-08-19 17:32:33',NULL),(893,NULL,'Ana','Domínguez','Moreno','1977-06-10',NULL,'F','B-',_binary '','2021-04-06 08:47:13',NULL),(894,'Pfra','Ana','Moreno','Méndez','1975-07-19',NULL,'F','A+',_binary '','2020-04-22 11:53:57',NULL),(895,NULL,'Pedro','Ramírez',' Rivera','1978-11-03',NULL,'M','B+',_binary '','2020-06-23 17:22:28',NULL),(896,NULL,'Ameli','Castro','Ortega','1971-01-25',NULL,'F','AB+',_binary '','2020-11-09 11:15:48',NULL),(897,'Ing.','Suri','Reyes','Santiago','1990-05-02',NULL,'F','B-',_binary '','2022-05-08 12:06:31',NULL),(898,NULL,'Brenda','Herrera','López','1979-04-18',NULL,'F','O+',_binary '','2023-07-20 17:47:29',NULL),(899,NULL,'Federico','Pérez','Bautista','1982-05-22',NULL,'M','B-',_binary '','2020-04-18 18:18:54',NULL),(900,NULL,'Aldair','Reyes','Domínguez','1974-05-14',NULL,'M','AB-',_binary '','2020-11-22 10:14:22',NULL),(901,NULL,'Suri','Ramos','Ramos','1971-01-07',NULL,'F','B+',_binary '','2024-01-03 17:37:47',NULL),(902,NULL,'Suri','De la Cruz','Gutiérrez','1984-08-02',NULL,'F','B-',_binary '','2023-06-08 16:23:49',NULL),(903,NULL,'Luz','Juárez','Velázquez','1961-08-19',NULL,'F','O-',_binary '','2021-12-24 15:15:50',NULL),(904,NULL,'Flor','Torres','Jiménez','1987-10-18',NULL,'F','O-',_binary '','2020-06-04 15:10:15',NULL),(905,NULL,'Valeria','Aguilar','Jiménez','1970-03-10',NULL,'F','A-',_binary '','2021-08-09 11:31:48',NULL),(906,NULL,'Daniel','Salazar','Vázquez','1997-10-25',NULL,'M','A-',_binary '','2021-11-04 16:45:54',NULL),(907,NULL,'Adan','Romero','Guerrero','1959-10-25',NULL,'M','B+',_binary '','2022-07-12 08:35:50',NULL),(908,NULL,'Maria','Castillo','Vázquez','2003-10-27',NULL,'F','AB-',_binary '','2024-01-24 15:54:06',NULL),(909,NULL,'Maria','Romero','Gutiérrez','1976-08-14',NULL,'F','AB-',_binary '','2021-02-03 11:46:21',NULL),(910,NULL,'Yair','Santiago','Estrada','2008-02-03',NULL,'M','A-',_binary '','2020-01-02 12:53:50',NULL),(911,NULL,'Esmeralda','Gutiérrez','Luna','1966-02-25',NULL,'F','A-',_binary '','2021-09-10 14:25:39',NULL),(912,NULL,'Jazmin','Ramos','Herrera','1980-12-15',NULL,'F','A-',_binary '','2022-12-01 18:37:05',NULL),(913,NULL,'Monica','Gómes','Cortes','1973-05-01',NULL,'F','O+',_binary '','2021-06-28 11:05:19',NULL),(914,NULL,'Lucía','Aguilar','Domínguez','2007-08-16',NULL,'F','O-',_binary '','2020-01-05 08:24:24',NULL),(915,NULL,'Yair','Torres','Rodríguez','1991-09-30',NULL,'M','O-',_binary '','2022-07-03 11:02:12',NULL),(916,NULL,'Adan',' Rivera','Gutiérrez','1960-08-24',NULL,'M','A+',_binary '','2020-10-11 17:13:58',NULL),(917,NULL,'Monica','Vargas','Chávez','1991-08-23',NULL,'F','AB+',_binary '','2020-06-12 16:09:29',NULL),(918,NULL,'Mario','Ramos','Luna','1976-11-18',NULL,'M','B+',_binary '','2021-02-12 14:23:18',NULL),(919,NULL,'Maximiliano','Álvarez','Ortega','1998-03-03',NULL,'M','B+',_binary '','2021-05-04 15:00:45',NULL),(920,NULL,'Pedro','Díaz','Mendoza','1961-04-13',NULL,'M','O-',_binary '','2022-11-04 14:21:05',NULL),(921,NULL,'Hortencia','Torres','Bautista','1996-03-22',NULL,'F','O-',_binary '','2021-12-17 14:09:40',NULL),(922,NULL,'Luz','Chávez','Juárez','1976-08-17',NULL,'F','O-',_binary '','2022-06-10 09:40:47',NULL),(923,'Mtro.','Adan','Chávez','Cruz','1970-09-23',NULL,'M','AB+',_binary '','2021-09-13 10:05:12',NULL),(924,'Med.','Alondra','Castro','Mendoza','2001-05-30',NULL,'F','A+',_binary '','2023-10-06 10:45:51',NULL),(925,NULL,'Adalid','Cortes','Estrada','1961-10-29',NULL,'M','B-',_binary '','2020-08-23 12:35:45',NULL),(926,NULL,'Bertha','Reyes','Sánchez','2003-03-02',NULL,'F','A+',_binary '','2021-12-14 10:59:14',NULL),(927,NULL,'Ameli',' Rivera','Morales','1982-06-20',NULL,'F','AB-',_binary '','2023-05-29 09:46:19',NULL),(928,NULL,'Lucía',' Rivera','Ortiz','1981-09-15',NULL,'F','O-',_binary '','2021-09-20 10:18:41',NULL),(929,NULL,'Dulce',' González',' González','1965-02-17',NULL,'F','B+',_binary '','2021-10-21 09:04:34',NULL),(930,NULL,'Gerardo','Ruíz','García','1960-11-16',NULL,'M','A+',_binary '','2020-10-15 17:15:40',NULL),(931,NULL,'Luz','Rodríguez','Torres','1969-06-12',NULL,'F','A+',_binary '','2023-05-15 17:26:32',NULL),(932,'Ing.','Daniel','Ortega','Díaz','1966-01-16',NULL,'M','AB-',_binary '','2023-10-24 14:57:50',NULL),(933,NULL,'Luz','Pérez','Reyes','1962-12-05',NULL,'F','AB+',_binary '','2021-10-02 14:12:08',NULL),(934,NULL,'Marco','Salazar','Pérez','1961-03-25',NULL,'M','O-',_binary '','2021-06-23 09:01:59',NULL),(935,NULL,'Lorena','López','Díaz','1983-09-09',NULL,'F','B-',_binary '','2023-05-04 15:34:24',NULL),(936,NULL,'Juan','Juárez','Ortega','1984-08-04',NULL,'M','O-',_binary '','2021-09-09 08:38:20',NULL),(937,'Sgto.','Aldair',' González',' Rivera','1993-01-07',NULL,'M','AB-',_binary '','2021-03-26 13:32:48',NULL),(938,'Lic.','Estrella','Cortes','Vázquez','1994-10-29',NULL,'F','O+',_binary '','2023-07-24 18:17:22',NULL),(939,NULL,'Lorena','Cruz','Estrada','1962-01-08',NULL,'F','AB+',_binary '','2021-07-16 11:53:06',NULL),(940,NULL,'Maximiliano','Cortés',' González','1988-03-11',NULL,'M','AB-',_binary '','2022-05-18 18:11:22',NULL),(941,NULL,' Agustin',' González','Estrada','1977-09-05',NULL,'M','A+',_binary '','2021-07-16 14:36:00',NULL),(942,NULL,'Bertha','Salazar','Guerrero','1961-11-20',NULL,'F','AB+',_binary '','2022-07-10 12:26:23',NULL),(943,NULL,'Ana','Aguilar','Torres','1980-02-28',NULL,'F','A-',_binary '','2021-07-04 13:04:14',NULL),(944,'Lic.','Federico','Martínez','Medina','1973-07-15',NULL,'M','B-',_binary '','2020-06-28 12:41:15',NULL),(945,NULL,'Ameli','Torres','Estrada','1990-07-08',NULL,'F','B-',_binary '','2020-12-19 18:28:05',NULL),(946,'Srita','Bertha',' Rivera','Medina','1991-10-27',NULL,'F','B+',_binary '','2021-02-16 15:08:10',NULL),(947,'Sgto.','Jorge','Medina','Rodríguez','1990-11-03',NULL,'M','O+',_binary '','2020-08-20 11:43:16',NULL),(948,NULL,'Lucía','Santiago','Estrada','2007-04-12',NULL,'F','A-',_binary '','2022-11-21 09:03:40',NULL),(949,NULL,'José','Morales','Reyes','1993-04-26',NULL,'M','AB+',_binary '','2020-01-11 10:05:34',NULL),(950,NULL,'Juan','Cruz','Salazar','1986-04-02',NULL,'M','B+',_binary '','2023-01-20 18:02:10',NULL),(951,NULL,'Fernando','Sánchez',' González','1959-10-08',NULL,'M','O+',_binary '','2023-06-06 17:39:45',NULL),(952,NULL,'Flor','Chávez','Romero','2001-02-18',NULL,'F','O+',_binary '','2020-10-13 16:15:36',NULL),(953,NULL,'Fernando','De la Cruz','Jiménez','1966-03-19',NULL,'M','O+',_binary '','2022-05-26 13:46:04',NULL),(954,'Mtra','Dulce','Domínguez','Luna','1975-06-02',NULL,'F','A+',_binary '','2021-09-07 17:24:42',NULL),(955,NULL,'Pedro','Mendoza','Herrera','1967-08-01',NULL,'M','O+',_binary '','2022-08-31 16:32:04',NULL),(956,'Pfra','Suri','Rodríguez',' González','1962-09-15',NULL,'F','A+',_binary '','2020-10-06 16:08:02',NULL),(957,NULL,'Adan','Romero','Estrada','1966-12-19',NULL,'M','O-',_binary '','2022-02-25 15:05:28',NULL),(958,NULL,'José','Sánchez','Guzmán','1972-02-10',NULL,'M','A+',_binary '','2022-07-29 18:10:31',NULL),(959,NULL,'Maximiliano','Soto','Reyes','1981-03-25',NULL,'M','B-',_binary '','2022-05-02 15:54:48',NULL),(960,NULL,'Estrella','Torres','Ortega','1976-05-07',NULL,'F','A-',_binary '','2022-07-23 16:05:17',NULL),(961,NULL,'Suri','Ramírez','Reyes','2004-07-02',NULL,'F','O+',_binary '','2020-04-27 08:53:15',NULL),(962,NULL,'Flor','Moreno','Guerrero','1968-06-09',NULL,'F','A-',_binary '','2021-11-04 15:18:37',NULL),(963,NULL,'Aldair','Cortes','Cortes','1979-10-23',NULL,'M','B-',_binary '','2020-06-11 09:20:14',NULL),(964,NULL,'José','Romero','Chávez','1976-02-05',NULL,'M','O-',_binary '','2023-12-29 17:37:40',NULL),(965,NULL,'Diana','Romero','Pérez','1960-06-26',NULL,'F','O+',_binary '','2024-02-23 14:28:08',NULL),(966,NULL,'Adan','Ortega','Vargas','1960-03-08',NULL,'M','O-',_binary '','2022-06-15 09:54:48',NULL),(967,NULL,'Adan','Pérez','Luna','2004-09-05',NULL,'M','A+',_binary '','2022-11-28 10:27:18',NULL),(968,NULL,'Hugo','Juárez','López','1983-08-06',NULL,'M','B+',_binary '','2023-12-10 18:27:25',NULL),(969,NULL,'Ricardo','Ortiz','Méndez','1981-03-22',NULL,'M','AB+',_binary '','2022-05-22 09:24:58',NULL),(970,NULL,'Hortencia','Bautista','Pérez','1993-05-20',NULL,'F','A-',_binary '','2023-01-25 10:14:51',NULL),(971,NULL,'Aldair',' González','Ramos','2003-10-02',NULL,'M','AB-',_binary '','2022-01-13 14:10:09',NULL),(972,NULL,'Maria','Mendoza','Luna','2007-08-02',NULL,'F','B-',_binary '','2020-03-17 08:29:57',NULL),(973,NULL,'Iram','Luna','Estrada','1961-09-05',NULL,'M','B-',_binary '','2021-03-08 19:30:25',NULL),(974,'Joven','Jesus','Romero','Rodríguez','1964-08-16',NULL,'M','A-',_binary '','2022-06-05 12:24:37',NULL),(975,NULL,'Maximiliano','Romero','De la Cruz','1977-06-30',NULL,'M','AB+',_binary '','2022-02-02 19:16:03',NULL),(976,NULL,'Valeria','Santiago','Medina','1996-09-17',NULL,'F','O+',_binary '','2022-03-16 12:13:53',NULL),(977,NULL,'Ameli','Ruíz','Vázquez','1970-06-23',NULL,'F','B+',_binary '','2023-09-20 14:13:22',NULL),(978,'Srita','Suri','Castillo','Guerrero','1964-05-20',NULL,'F','O+',_binary '','2022-05-14 14:08:15',NULL),(979,NULL,'Suri','Santiago','Hernández','1974-07-16',NULL,'F','AB+',_binary '','2023-08-15 15:58:33',NULL),(980,NULL,'Maximiliano','Medina','Guzmán','1992-11-06',NULL,'M','A-',_binary '','2023-09-03 18:10:01',NULL),(981,NULL,'Ana','Gómes','Díaz','1962-08-02',NULL,'F','B+',_binary '','2020-09-28 08:44:32',NULL),(982,'Pfra','Dulce','Estrada','Cruz','1967-04-22',NULL,'F','B+',_binary '','2023-08-24 14:42:07',NULL),(983,'C.P.','Samuel','Ortega','Romero','2006-05-22',NULL,'M','B+',_binary '','2021-11-14 13:20:20',NULL),(984,NULL,'Brenda','Castro','Gutiérrez','1992-08-08',NULL,'F','B+',_binary '','2022-07-16 08:42:21',NULL),(985,NULL,'Suri','Mendoza','Méndez','1984-07-27',NULL,'F','O-',_binary '','2020-07-13 17:57:10',NULL),(986,NULL,'Alejandro','Domínguez','Salazar','1967-12-07',NULL,'M','B-',_binary '','2022-06-23 16:22:33',NULL),(987,NULL,'Edgar','Salazar','García','1992-03-20',NULL,'M','B+',_binary '','2021-04-15 16:59:28',NULL),(988,NULL,'Gerardo','Herrera','Aguilar','1964-03-29',NULL,'M','B+',_binary '','2024-02-03 09:41:45',NULL),(989,NULL,'Monica','Martínez','Gómes','1960-08-21',NULL,'F','B-',_binary '','2020-04-23 08:52:44',NULL),(990,NULL,'Adalid','Cruz','Salazar','1988-11-09',NULL,'M','AB+',_binary '','2023-05-12 13:34:12',NULL),(991,NULL,'Edgar','Castillo','Torres','1966-11-22',NULL,'M','O+',_binary '','2022-09-29 17:50:45',NULL),(992,'C.P.','Juan','Gutiérrez','Vargas','1984-08-18',NULL,'M','B-',_binary '','2021-12-16 09:38:08',NULL),(993,NULL,'Fernando','Ramírez','Morales','1994-08-14',NULL,'M','O+',_binary '','2020-08-02 09:24:36',NULL),(994,NULL,'Iram','Vázquez','Estrada','2003-08-13',NULL,'M','AB-',_binary '','2023-09-22 11:40:56',NULL),(995,NULL,'Daniel','Luna','Mendoza','1980-06-28',NULL,'M','O-',_binary '','2022-04-08 17:46:50',NULL),(996,NULL,'Jesus',' González',' González','1968-10-22',NULL,'M','AB-',_binary '','2023-08-14 11:15:50',NULL),(997,NULL,'Esmeralda','Cortés','Santiago','1986-12-30',NULL,'F','A-',_binary '','2020-05-04 19:16:17',NULL),(998,NULL,'Dulce','Vargas','Morales','1960-11-07',NULL,'F','B-',_binary '','2020-04-17 08:34:46',NULL),(999,'Mtro.','Gerardo','Romero','Herrera','2000-04-11',NULL,'M','A-',_binary '','2021-06-27 11:10:56',NULL),(1000,NULL,'Aldair','Méndez','Luna','1989-10-28',NULL,'M','AB+',_binary '','2020-02-07 12:35:03',NULL),(1001,NULL,'Juan','Estrada','Ruíz','1967-12-25',NULL,'M','AB-',_binary '','2020-05-28 11:40:27',NULL),(1002,NULL,'Jazmin','De la Cruz','Mendoza','1995-01-28',NULL,'F','B-',_binary '','2023-07-22 08:29:38',NULL),(1003,'Srita','Ana','Velázquez','Sánchez','1978-10-14',NULL,'F','AB+',_binary '','2022-06-20 11:30:03',NULL),(1004,'Tnte.','Alejandro','Morales','Luna','1986-08-11',NULL,'M','A-',_binary '','2021-11-01 14:24:50',NULL),(1005,NULL,'Monica','Sánchez','Contreras','1986-07-20',NULL,'F','B-',_binary '','2021-01-06 08:49:17',NULL),(1006,NULL,'Guadalupe','Romero','Guzmán','1971-06-04',NULL,'F','O-',_binary '','2020-08-24 18:01:50',NULL),(1007,NULL,'Gerardo','Jiménez','Herrera','1982-01-05',NULL,'M','B+',_binary '','2020-05-23 14:55:14',NULL),(1008,NULL,'Ana','Ortega','Chávez','1973-06-20',NULL,'F','AB-',_binary '','2023-01-06 13:35:20',NULL),(1009,NULL,' Agustin','Aguilar','Castro','1972-02-06',NULL,'M','A-',_binary '','2020-03-31 17:27:09',NULL),(1010,NULL,'Adalid','Contreras','Ortega','2004-02-12',NULL,'M','O-',_binary '','2020-10-06 19:30:08',NULL),(1011,NULL,'Mario','Aguilar','Luna','2005-11-01',NULL,'M','A-',_binary '','2021-01-18 15:08:15',NULL),(1012,'Med.','Adalid','Sánchez','Ramos','1991-06-04',NULL,'M','B-',_binary '','2020-05-24 10:48:07',NULL),(1013,NULL,'Bertha','Juárez','Salazar','1972-12-05',NULL,'F','O-',_binary '','2023-06-29 12:39:32',NULL),(1014,NULL,'Esmeralda','Domínguez','Gutiérrez','2000-08-13',NULL,'F','A-',_binary '','2020-08-14 11:59:45',NULL),(1015,NULL,'Lucía','Pérez','Pérez','1971-11-08',NULL,'F','O-',_binary '','2023-12-02 18:34:33',NULL),(1016,'Lic.','Lucía','Cortes','Ramos','1983-08-15',NULL,'F','AB+',_binary '','2022-06-15 09:11:18',NULL),(1017,NULL,'Mario',' Rivera','Velázquez','1961-01-24',NULL,'M','O-',_binary '','2021-07-27 10:17:14',NULL),(1018,NULL,'Valeria','Romero','De la Cruz','1978-08-07',NULL,'F','AB+',_binary '','2023-08-30 14:44:10',NULL),(1019,NULL,'Ameli','Cortés','Pérez','1992-03-04',NULL,'F','A+',_binary '','2020-06-14 13:35:36',NULL),(1020,NULL,'Brenda','Ortega','Cortes','1981-07-03',NULL,'F','AB-',_binary '','2023-03-06 19:16:54',NULL),(1021,NULL,'Pedro','Méndez','Aguilar','1983-10-10',NULL,'M','A-',_binary '','2022-08-18 13:44:59',NULL),(1022,NULL,'Aldair','Castillo','Romero','1963-03-02',NULL,'M','O-',_binary '','2020-10-14 11:26:27',NULL),(1023,NULL,'Sofia','Mendoza','Castillo','1970-09-20',NULL,'F','AB-',_binary '','2023-03-25 17:30:02',NULL),(1024,NULL,'Guadalupe','Guerrero','Castro','1999-11-17',NULL,'F','A+',_binary '','2022-11-08 11:53:34',NULL),(1025,NULL,'Estrella','Ortiz','Aguilar','1996-04-20',NULL,'F','AB+',_binary '','2021-01-04 16:06:22',NULL),(1026,NULL,'José','Morales','Jiménez','1996-08-05',NULL,'M','O-',_binary '','2020-11-21 12:07:03',NULL),(1027,'C.',' Agustin','Gómes','Ramos','1980-02-26',NULL,'M','A-',_binary '','2024-01-31 08:10:25',NULL),(1028,NULL,'José','Rodríguez','Domínguez','2000-03-06',NULL,'M','A-',_binary '','2023-01-04 17:21:45',NULL),(1029,NULL,'Paula','Castillo','Guzmán','1974-09-09',NULL,'F','B+',_binary '','2022-07-20 08:31:57',NULL),(1030,NULL,'Juan','Pérez','Jiménez','1971-07-23',NULL,'M','B+',_binary '','2023-07-19 10:10:41',NULL),(1031,NULL,'Flor','Soto','Ramos','1968-05-18',NULL,'F','A+',_binary '','2022-11-17 10:33:50',NULL),(1032,'Sra.','Jazmin','Sánchez','Vázquez','2005-01-13',NULL,'F','O+',_binary '','2021-11-27 16:03:47',NULL),(1033,'Med.','Adalid','Morales','Rodríguez','2001-07-20',NULL,'M','O-',_binary '','2020-05-21 15:44:08',NULL),(1034,NULL,'Karla','Bautista','Guerrero','1991-07-21',NULL,'F','AB+',_binary '','2023-12-20 18:31:31',NULL),(1035,NULL,'Adalid','Ramos','Soto','1960-05-12',NULL,'M','A-',_binary '','2023-01-06 08:33:42',NULL),(1036,'Srita','Ana','De la Cruz','Cortes','1993-02-09',NULL,'F','O+',_binary '','2024-02-18 12:38:57',NULL),(1037,'Mtro.','Yair','Mendoza',' Rivera','1993-05-31',NULL,'M','AB-',_binary '','2021-12-16 09:50:01',NULL),(1038,NULL,'Bertha','Chávez','Álvarez','1959-06-13',NULL,'F','B-',_binary '','2024-03-29 16:49:58',NULL),(1039,NULL,'Iram','Salazar','Castro','1963-03-21',NULL,'M','B+',_binary '','2020-07-21 17:53:07',NULL),(1040,NULL,'Jorge','Sánchez','Castillo','1960-08-18',NULL,'M','AB-',_binary '','2021-01-02 10:09:54',NULL),(1041,'Sgto.','Pedro','Aguilar','Ortega','1962-09-29',NULL,'M','AB-',_binary '','2021-08-29 17:16:58',NULL),(1042,NULL,'Daniel','Morales','Torres','2003-10-17',NULL,'M','AB+',_binary '','2023-12-29 08:38:37',NULL),(1043,NULL,'Iram','Rodríguez','Gutiérrez','1980-08-22',NULL,'M','A+',_binary '','2020-02-23 19:35:55',NULL),(1044,NULL,'Guadalupe','Chávez','Rodríguez','2005-04-20',NULL,'F','B+',_binary '','2023-04-27 18:54:02',NULL),(1045,NULL,'Hugo','Mendoza',' González','1970-03-31',NULL,'M','O+',_binary '','2022-05-03 10:16:42',NULL),(1046,NULL,'Alejandro','Castro','López','1972-04-20',NULL,'M','A+',_binary '','2022-11-12 08:39:12',NULL),(1047,NULL,' Agustin','Torres','Pérez','1988-01-12',NULL,'M','AB+',_binary '','2020-06-24 18:01:10',NULL),(1048,NULL,'Esmeralda','Vargas','Vargas','1981-12-12',NULL,'F','A-',_binary '','2021-03-13 19:55:14',NULL),(1049,'Pfra','Valeria','Ramos','Ruíz','1963-03-10',NULL,'F','A-',_binary '','2023-07-26 14:06:10',NULL),(1050,'Ing.','Jazmin','De la Cruz','Castillo','1961-12-24',NULL,'F','O+',_binary '','2024-03-12 12:46:06',NULL),(1051,'Mtro.','Gustavo','Torres','Estrada','1989-07-14',NULL,'M','B+',_binary '','2022-12-31 14:42:36',NULL),(1052,NULL,'Maria','Luna','Martínez','1991-01-12',NULL,'F','A+',_binary '','2022-10-10 18:30:20',NULL),(1053,NULL,'Hortencia','García','Castillo','1976-03-20',NULL,'F','B+',_binary '','2021-05-16 17:23:34',NULL),(1054,NULL,'Gerardo','Cruz','García','1986-12-13',NULL,'M','O+',_binary '','2020-05-09 09:46:49',NULL),(1055,NULL,'Aldair',' González','Chávez','1989-02-07',NULL,'M','B+',_binary '','2023-01-04 15:01:35',NULL),(1056,NULL,'Mario','Bautista','Romero','1993-02-26',NULL,'M','O-',_binary '','2022-05-13 19:43:16',NULL),(1057,NULL,'Yair','Castro',' González','1973-09-07',NULL,'M','A-',_binary '','2020-12-13 13:21:02',NULL),(1058,NULL,'Jorge','Morales','Hernández','1976-07-03',NULL,'M','AB-',_binary '','2021-11-04 08:39:51',NULL),(1059,NULL,'Valeria','Gutiérrez','Martínez','1965-04-14',NULL,'F','B-',_binary '','2023-12-27 11:08:03',NULL),(1060,NULL,'Guadalupe','Moreno',' Rivera','1985-02-17',NULL,'F','O+',_binary '','2023-03-13 09:28:11',NULL),(1061,NULL,'Guadalupe','Cruz','Vázquez','1997-02-13',NULL,'F','A+',_binary '','2024-01-13 14:29:27',NULL),(1062,NULL,'Bertha','Medina','Cruz','2003-05-18',NULL,'F','O-',_binary '','2023-06-17 11:51:32',NULL),(1063,'Lic.',' Agustin','Chávez','Jiménez','2002-08-02',NULL,'M','B-',_binary '','2022-10-31 18:54:33',NULL),(1064,NULL,'Federico','García','Álvarez','1985-05-22',NULL,'M','A+',_binary '','2023-08-15 19:22:21',NULL);
/*!40000 ALTER TABLE `personas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `personas_AFTER_INSERT` AFTER INSERT ON `personas` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "personas",
        CONCAT_WS(" ","Se ha insertado una nueva persona con el ID: ",NEW.ID, 
        "con los siguientes datos:  TITULO CORTESIA = ", NEW.titulo_cortesia,
        "NOMBRE=", NEW.nombre,
        "PRIMER APELLIDO = ", NEW.primer_apellido,
        "SEGUNDO APELLIDO = ", NEW.segundo_apellido,
        "FECHA NACIMIENTO = ",  NEW.fecha_nacimiento,
        "FOTOGRAFIA = ", NEW.fotografia, 
        "GENERO = ", NEW.genero, 
        "TIPO SANGRE = ", NEW.tipo_sangre,
        "ESTATUS = ", NEW.estatus,
        "FECHA REGISTRO = ",  NEW.fecha_registro,
        "FECHA ACTUALIZACIÓN = ",  NEW.fecha_actualizacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `personas_AFTER_UPDATE` AFTER UPDATE ON `personas` FOR EACH ROW BEGIN
 INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Update",
        "personas",
        CONCAT_WS(" ","Se han actualizado los datos de la persona con el ID: ",NEW.ID, 
        "con los siguientes datos: TITULO CORTESIA = ", old.titulo_cortesia, " cambio a " ,NEW.titulo_cortesia,
        "NOMBRE=", OLD.nombre, " cambio a " ,NEW.nombre,
        "PRIMER APELLIDO = ", OLD.primer_apellido, " cambio a " , NEW.primer_apellido,
        "SEGUNDO APELLIDO = ", OLD.segundo_apellido, " cambio a " , NEW.segundo_apellido, 
        "FECHA NACIMIENTO = ",  OLD.fecha_nacimiento, " cambio a " ,NEW.fecha_nacimiento, 
        "FOTOGRAFIA = ",  OLD.fotografia, " cambio a " ,NEW.fotografia, 
        "GENERO = ", OLD.genero, " cambio a " , NEW.genero,
        "TIPO SANGRE = ", OLD.tipo_sangre, " cambio a " , NEW.tipo_sangre,
        "ESTATUS = ", OLD.estatus, " cambio a " ,  NEW.estatus,
        "FECHA REGISTRO = ", OLD.fecha_registro, " cambio a " ,   NEW.fecha_registro,
        "FECHA ACTUALIZACIÓN = ",  OLD.fecha_actualizacion, " cambio a " ,  NEW.fecha_actualizacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `personas_AFTER_DELETE` AFTER DELETE ON `personas` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "personas",
        CONCAT_WS(" ","Se ha eliminado una persona con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `prestamos`
--

DROP TABLE IF EXISTS `prestamos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prestamos` (
  `ID_Prestamo` int NOT NULL AUTO_INCREMENT,
  `Equipo_Prestado` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Fecha_Prestamo` date NOT NULL,
  `Fecha_Devolucion` date NOT NULL,
  `Estado_Prestamo` enum('activo','vencido','devuelto') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Comentarios` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Monto_Deposito` decimal(10,2) DEFAULT NULL,
  `Monto_Multa` decimal(10,2) DEFAULT NULL,
  `Estado_Pago` enum('pagado','pendiente') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `membresias_ID` int unsigned NOT NULL,
  `personas_ID` int unsigned NOT NULL,
  PRIMARY KEY (`ID_Prestamo`),
  KEY `fk_prestamos_membresias1_idx` (`membresias_ID`),
  KEY `fk_prestamos_personas1_idx` (`personas_ID`),
  CONSTRAINT `fk_prestamos_membresias1` FOREIGN KEY (`membresias_ID`) REFERENCES `membresias` (`ID`),
  CONSTRAINT `fk_prestamos_personas1` FOREIGN KEY (`personas_ID`) REFERENCES `personas` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prestamos`
--

LOCK TABLES `prestamos` WRITE;
/*!40000 ALTER TABLE `prestamos` DISABLE KEYS */;
INSERT INTO `prestamos` VALUES (1,'Equipo de prueba','2024-04-13','2024-04-20','activo','Prueba de préstamo',100.00,0.00,'pendiente',1,1);
/*!40000 ALTER TABLE `prestamos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `prestamos_AFTER_INSERT` AFTER INSERT ON `prestamos` FOR EACH ROW BEGIN
  -- Declaración de variables
    DECLARE v_membresia varchar(100) default null;
    DECLARE v_nombre_persona varchar(60) default null;
    
    if new.membresias_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_membresia = (SELECT CONCAT_WS(" ", m.id ,m.codigo, m.tipo, m.tipo_servicios, m.tipo_plan) FROM membresias m WHERE id = NEW.membresias_id);
    else
        SET v_membresia = "Sin membresia asignada";
    end if;
    /*------------------------------------------*/
    if new.personas_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_persona = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.personas_id);
    else
        SET v_nombre_persona = "Sin responsable asignado";
    end if;
    
    
    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "prestamos",
        CONCAT_WS(" ","Se ha insertado una nuevo pago con el ID: ",NEW.ID_Prestamo, 
        "con los siguientes datos: ",
        "EQUIPO_PRESTADO = ", NEW.equipo_prestado,
        "FECHA_PRESTAMO = ", NEW.fecha_prestamo,
        "FECHA_DEVOLUCION = ", NEW.fecha_devolucion,
        "ESTADO_PRESTAMO = ", NEW.estado_prestamo,
        "COMENTARIOS = ", NEW.comentarios,
        "MONTO_DEPOSITO = ", NEW.monto_deposito,
        "MONTO_MULTA = ", NEW.monto_multa,
        "ESTADO_PAGO = ", NEW.estado_pago,
        "MEMBRESIAS_ID = ", v_membresia,
        "PERSONAS_ID = ", v_nombre_persona),
        NOW(),
        DEFAULT
    );

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `prestamos_AFTER_UPDATE` AFTER UPDATE ON `prestamos` FOR EACH ROW BEGIN
  -- Declaración de variables
    DECLARE v_membresia varchar(100) default null;
    DECLARE v_membresia2 varchar(100) default null;
    DECLARE v_nombre_persona varchar(60) default null;
    DECLARE v_nombre_persona2 varchar(60) default null;
    
    if new.membresias_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_membresia = (SELECT CONCAT_WS(" ", m.id ,m.codigo, m.tipo, m.tipo_servicios, m.tipo_plan) FROM membresias m WHERE id = NEW.membresias_id);
    else
        SET v_membresia = "Sin membresia asignada";
    end if;
    
    if OLD.membresias_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_membresia2 = (SELECT CONCAT_WS(" ", m.id ,m.codigo, m.tipo, m.tipo_servicios, m.tipo_plan) FROM membresias m WHERE id = OLD.membresias_id);
    else
        SET v_membresia2 = "Sin membresia asignada";
    end if;
    
    /*------------------------------------------*/
    if new.personas_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_persona = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.personas_id);
    else
        SET v_nombre_persona = "Sin responsable asignado";
    end if;
    
    if OLD.personas_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_persona2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.personas_id);
    else
        SET v_nombre_persona2 = "Sin responsable asignado";
    end if;
    
    
     -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "prestamos",
        CONCAT_WS(" ","Se han actualizado los datos del DETALLES_PEDIDOS con el ID: ",NEW.ID_Prestamo, 
        "con los siguientes datos: ",
        "EQUIPO_PRESTADO = ", OLD.equipo_prestado, "cambio a",  OLD.equipo_prestado, 
        "FECHA_PRESTAMO = ", OLD.fecha_prestamo, "cambio a", OLD.fecha_prestamo,
        "FECHA_DEVOLUCION = ", OLD.fecha_devolucion, "cambio a", OLD.fecha_devolucion,
        "ESTADO_PRESTAMO = ", OLD.estado_prestamo, "cambio a", OLD.estado_prestamo,
        "COMENTARIOS = ", OLD.comentarios, "cambio a", OLD.comentarios,
        "MONTO_DEPOSITO = ", OLD.monto_deposito, "cambio a", OLD.monto_deposito,
        "MONTO_MULTA = ", OLD.monto_multa, "cambio a", OLD.monto_multa,
        "ESTADO_PAGO = ", OLD.estado_pago, "cambio a", OLD.estado_pago,
        "MEMBRESIAS_ID = ", v_membresia2, "cambio a", v_membresia,
        "PERSONAS_ID = ", v_nombre_persona2, "cambio a", v_nombre_persona), 
        NOW(),
        DEFAULT
        );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `prestamos_AFTER_DELETE` AFTER DELETE ON `prestamos` FOR EACH ROW BEGIN
INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Delete",
        "empleados",
        CONCAT_WS(" ","Se ha eliminado un PRESTAMOS con el ID: ", OLD.id_prestamo),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(150) NOT NULL,
  `Marca` varchar(100) NOT NULL,
  `Codigo_Barras` varchar(100) DEFAULT NULL,
  `Descripcion` text,
  `Presentacion` varchar(50) NOT NULL,
  `Precio_Actual` decimal(6,2) NOT NULL,
  `Fotografia` varchar(100) NOT NULL,
  `Estatus` bit(1) DEFAULT b'1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `productos_AFTER_INSERT` AFTER INSERT ON `productos` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "productos",
        CONCAT_WS(" ","Se ha insertado una nueva AREA con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "NOMBRE = ", NEW.nombre,
        "MARCA = ", NEW.marca,
        "CODIGO DE BARRAS = ",  NEW.codigo_barras,
        "DESCRIPCIÓN = ", NEW.descripcion,
        "PRESENTACIÓN = ", NEW.presentacion, 
        "PRECIO ACTUAL = ", NEW.precio_actual,
        "FOTOGRAFÍA = ",  NEW.fotografia,
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `productos_AFTER_UPDATE` AFTER UPDATE ON `productos` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;

    -- Inicialización de las variables 
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "productos",
        CONCAT_WS(" ","Se han actualizado los datos del PRODUCTO con el ID: ",NEW.ID,
        "con los siguientes datos:",
        "NOMBRE = ", OLD.nombre, " cambio a " ,NEW.nombre,
        "MARCA = ", OLD.marca, " cambio a " , NEW.marca, 
        "CODIGO DE BARRAS = ", OLD.codigo_barras, " cambio a " , NEW.codigo_barras,
        "DESCRIPCIÓN = ",  OLD.descripcion, " cambio a " ,NEW.descripcion, 
        "PRESENTACIÓN = ", OLD.presentacion, " cambio a " , NEW.presentacion,
        "PRECIO ACTUAL = ",  OLD.precio_actual, " cambio a " ,NEW.precio_actual, 
        "FOTOGRAFÍA = ", OLD.fotografia, " cambio a " , NEW.fotografia,
        "ESTATUS = ", v_cadena_estatus2, "cambio a", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `productos_AFTER_DELETE` AFTER DELETE ON `productos` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "productos",
        CONCAT_WS(" ","Se ha eliminado un PRODUCTO con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `programas_saludables`
--

DROP TABLE IF EXISTS `programas_saludables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programas_saludables` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(250) NOT NULL,
  `Usuario_ID` int unsigned NOT NULL,
  `Instructor_ID` int unsigned NOT NULL,
  `Fecha_Creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Estatus` enum('Registrado','Sugerido','Aprobado por el Médico','Aprobado por el Usuario','Rechazado por el Médico','Rechazado por el Usuario','Terminado','Suspendido','Cancelado') NOT NULL DEFAULT 'Registrado',
  `Duracion` varchar(80) NOT NULL,
  `Porcentaje_Avance` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_usuario_1` (`Usuario_ID`),
  KEY `fk_instructores_1` (`Instructor_ID`),
  CONSTRAINT `fk_instructores_1` FOREIGN KEY (`Instructor_ID`) REFERENCES `instructores` (`Empleado_ID`),
  CONSTRAINT `fk_usuario_1` FOREIGN KEY (`Usuario_ID`) REFERENCES `usuarios` (`Persona_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programas_saludables`
--

LOCK TABLES `programas_saludables` WRITE;
/*!40000 ALTER TABLE `programas_saludables` DISABLE KEYS */;
/*!40000 ALTER TABLE `programas_saludables` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `programas_saludables_AFTER_INSERT` AFTER INSERT ON `programas_saludables` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_usuario varchar(60) default null;
    DECLARE v_nombre_instructor varchar(60) default null;

    -- Iniciación de las variables
    if new.usuario_id is not null then
        -- En caso de tener el id del usuario debemos recuperar su nombre
        set v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.usuario_id);
    else
        SET v_nombre_usuario = "Sin usuario asignado";
    end if;

    if new.instructor_id is not null then
        -- En caso de tener el id del instructor debemos recuperar su nombre
        set v_nombre_instructor = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.instructor_id);
    else
        SET v_nombre_instructor = "Sin instructor asignado";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "programas_saludables",
        CONCAT_WS(" ","Se ha insertado una nueva relación de PROGRAMAS SALUDABLES con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "NOMBRE = ", NEW.nombre,
        "USUARIO ID = ", v_nombre_usuario,
        "INSTRUCTOR ID = ",  v_nombre_instructor,
        "FECHA DE CREACIÓN = ", NEW.fecha_creacion,
		"ESTATUS = ", NEW.estatus,
        "DURACIÓN = ", NEW.duracion, 
        "PORCENTAJE DE AVANCE = ", NEW.porcentaje_avance,
        "FECHA DE ULTIMA ACTUALIZACIÓN = ", NEW.fecha_ultima_actualizacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `programas_saludables_AFTER_UPDATE` AFTER UPDATE ON `programas_saludables` FOR EACH ROW BEGIN
	 -- Declaración de variables
    DECLARE v_nombre_usuario VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_usuario2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_instructor VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_instructor2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    IF NEW.usuario_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = NEW.usuario_id);
    ELSE
		SET v_nombre_usuario = "Sin usuario asignado.";
    END IF;
    
    IF OLD.usuario_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = OLD.usuario_id);
    ELSE
		SET v_nombre_usuario2 = "Sin usuario asignado.";
    END IF;

    IF NEW.instructor_id IS NOT NULL THEN 
		-- En caso de tener el id del instructor
		SET v_nombre_instructor = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = NEW.instructor_id);
    ELSE
		SET v_nombre_instructor = "Sin instructor asignado.";
    END IF;

    IF OLD.instructor_id IS NOT NULL THEN 
		-- En caso de tener el id del instructor
		SET v_nombre_instructor2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = OLD.instructor_id);
    ELSE
		SET v_nombre_instructor2 = "Sin instructor asignado.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "programas_saludables",
        CONCAT_WS(" ","Se han actualizado los datos de la relación PROGRAMAS SALUDABLES con el ID: ",NEW.ID,
        "con los siguientes datos:",
        "NOMBRE = ", OLD.nombre, "cambio a", NEW.nombre,
        "USUARIO ID = ", v_nombre_usuario2, "cambio a", v_nombre_usuario,
        "INSTRUCTOR ID =",v_nombre_instructor2,"cambio a", v_nombre_instructor,
        "FECHA DE CREACIÓN = ", OLD.fecha_creacion, "cambio a", NEW.fecha_creacion,
        "ESTATUS = ", OLD.estatus, "cambio a", NEW.estatus,
        "DURACIÓN = ", OLD.duracion, "cambio a", NEW.duracion,
        "PORCENTAJE DE AVANCE = ", OLD.porcentaje_avance, "cambio a", NEW.porcentaje_avance,
        "FECHA DE ULTIMA ACTUALIZACIÓN = ", OLD.fecha_ultima_actualizacion, "cambio a", NEW.fecha_ultima_actualizacion),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `programas_saludables_AFTER_DELETE` AFTER DELETE ON `programas_saludables` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "programas_saludables",
        CONCAT_WS(" ","Se ha eliminado una relación en PROGRAMAS SALUDABLES con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rutinas`
--

DROP TABLE IF EXISTS `rutinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rutinas` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Instructor_ID` int unsigned NOT NULL,
  `Usuario_ID` int unsigned NOT NULL,
  `Fecha_Asignacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Termino` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Tiempo_Aproximado` time DEFAULT NULL,
  `Estatus` enum('Concluido','Actual','Suspendida') DEFAULT NULL,
  `Resultados_Esperados` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rutinas`
--

LOCK TABLES `rutinas` WRITE;
/*!40000 ALTER TABLE `rutinas` DISABLE KEYS */;
/*!40000 ALTER TABLE `rutinas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rutinas_AFTER_INSERT` AFTER INSERT ON `rutinas` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_instructor varchar(60) default null;
    DECLARE v_nombre_usuario varchar(60) default null;

    -- Iniciación de las variables
    if new.instructor_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_instructor = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.instructor_id);
    else
        SET v_nombre_instructor = "Sin responsable asignado";
    end if;

    if new.usuario_id is not null then
        -- En caso de tener el id del usuario
        set v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.usuario_id);
    else
        SET v_nombre_usuario = "Sin usuario asignado";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "rutinas",
        CONCAT_WS(" ","Se ha insertado una nueva RUTINA con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "INSTRUCTOR ID = ", v_nombre_instructor,
        "USUARIO ID = ", v_nombre_usuario,
        "FECHA DE ASIGNACIÓN = ", NEW.fecha_asignacion,
        "FECHA DE TERMINO = ", NEW.fecha_termino,
        "TIEMPO APROXIMADO = ", NEW.tiempo_Aproximado, 
        "ESTATUS = ", NEW.estatus,
        "RESULTADOS ESPERADOS = ", NEW.resultados_esperados),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rutinas_AFTER_UPDATE` AFTER UPDATE ON `rutinas` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_instructor VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_instructor2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_usuario VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_usuario2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    IF NEW.instructor_id IS NOT NULL THEN 
		-- En caso de tener el id del empleado
		SET v_nombre_instructor = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = NEW.instructor_id);
    ELSE
		SET v_nombre_instructor = "Sin responsable asignado.";
    END IF;
    
    IF OLD.instructor_id IS NOT NULL THEN 
		-- En caso de tener el id del empleado 
		SET v_nombre_instructor2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,
		p.segundo_apellido) FROM personas p WHERE id = OLD.instructor_id);
    ELSE
		SET v_nombre_instructor2 = "Sin responsable asignado.";
    END IF;

    IF NEW.usuario_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = NEW.usuario_id);
    ELSE
		SET v_nombre_usuario = "Sin usuario asignado.";
    END IF;

    IF OLD.usuario_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_apellido) FROM personas p WHERE id = OLD.usuario_id);
    ELSE
		SET v_nombre_usuario2 = "Sin usuario asignado.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "areas",
        CONCAT_WS(" ","Se han actualizado los datos del área con el ID: ",
        NEW.ID, "con los siguientes datos:",
        "INSTRUCTOR ID = ", v_nombre_instructor2, " cambio a ", v_nombre_instructor,
        "USUARIO ID =",v_nombre_usuario2," cambio a ", v_nombre_usuario,
        "FECHA DE ASIGNACIÓN = ", OLD.fecha_asignacion, "cambio a", NEW.fecha_asignacion,
        "FECHA DE TERMINO = ", OLD.fecha_termino, "cambio a", NEW.fecha_termino,
        "TIEMPO APROXIMADO = ", OLD.tiempo_aproximado, "cambio a", NEW.tiempo_aproximado,
        "ESTATUS = ", OLD.estatus, " cambio a ", NEW.estatus,
        "RESULTADOS ESPERADOS = ", OLD.resultados_esperados, " cambio a ", NEW.resultados_esperados),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rutinas_AFTER_DELETE` AFTER DELETE ON `rutinas` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "rutinas",
        CONCAT_WS(" ","Se ha eliminado una RUTINA con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rutinas_ejercicios`
--

DROP TABLE IF EXISTS `rutinas_ejercicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rutinas_ejercicios` (
  `Ejercicio_ID` int unsigned DEFAULT NULL,
  `Rutina_ID` int unsigned DEFAULT NULL,
  `Repeticiones` int unsigned DEFAULT NULL,
  `Tiempo` time DEFAULT NULL,
  `Estatus` bit(1) DEFAULT b'1',
  KEY `fk_ejercicio_1` (`Ejercicio_ID`),
  KEY `fk_rutina_2` (`Rutina_ID`),
  CONSTRAINT `fk_ejercicio_1` FOREIGN KEY (`Ejercicio_ID`) REFERENCES `ejercicios` (`ID`),
  CONSTRAINT `fk_rutina_2` FOREIGN KEY (`Rutina_ID`) REFERENCES `rutinas` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rutinas_ejercicios`
--

LOCK TABLES `rutinas_ejercicios` WRITE;
/*!40000 ALTER TABLE `rutinas_ejercicios` DISABLE KEYS */;
/*!40000 ALTER TABLE `rutinas_ejercicios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rutinas_ejercicios_AFTER_INSERT` AFTER INSERT ON `rutinas_ejercicios` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
    DECLARE v_nombre_ejercicio varchar(60) default null;
    DECLARE v_nombre_rutina varchar(60) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    if new.ejercicio_id is not null then
        -- En caso de tener el id del ejercicio
        set v_nombre_ejercicio = (SELECT CONCAT_WS(" ", e.nombre_formal, e.nombre_comun) FROM ejercicios e WHERE id = NEW.ejercicio_id);
    else
        SET v_nombre_ejercicio = "Sin ejercicio asignado";
    end if;

    if new.rutina_id is not null then
        -- En caso de tener el id de la rutina
        set v_nombre_rutina = (SELECT resultados_esperados FROM rutinas WHERE id = NEW.rutina_id);
    else
        SET v_nombre_rutina = "Sin rutina asignada";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "rutinas_ejercicios",
        CONCAT_WS(" ","Se ha insertado una nueva relación RUTINAS EJERCICIOS con los IDs: Ejercicio - ", NEW.ejercicio_ID, ", Rutina - ", NEW.Rutina_ID , 
        "con los siguientes datos: ",
        "EJERCICIO ID = ", v_nombre_ejercicio,
        "RUTINA ID = ",  v_nombre_rutina,
        "REPETICIONES = ", NEW.repeticiones, 
		"TIEMPO = ", NEW.tiempo,
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rutinas_ejercicios_AFTER_UPDATE` AFTER UPDATE ON `rutinas_ejercicios` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_ejercicio VARCHAR(100) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_ejercicio2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_rutina VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_rutina2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    IF NEW.ejercicio_id IS NOT NULL THEN 
		-- En caso de tener el id del ejercicio
		SET v_nombre_ejercicio = (SELECT CONCAT_WS(" ", e.nombre_formal, e.nombre_comun) FROM ejercicios e WHERE id = NEW.ejercicio_id);
    ELSE
		SET v_nombre_ejercicio = "Sin ejercicio asignado.";
    END IF;
    
    IF OLD.ejercicio_id IS NOT NULL THEN 
		-- En caso de tener el id del ejercicio
		SET v_nombre_ejercicio2 = (SELECT CONCAT_WS(" ", e.nombre_formal, e.nombre_comun) FROM ejercicios e WHERE id = OLD.ejercicio_id);
    ELSE
		SET v_nombre_ejercicio2 = "Sin ejercicio asignado.";
    END IF;

    IF NEW.rutina_id IS NOT NULL THEN 
		-- En caso de tener el id de la rutina
		SET v_nombre_rutina = (SELECT resultados_esperados FROM rutinas WHERE id = NEW.rutina_id);
    ELSE
		SET v_nombre_rutina = "Sin rutina asignada.";
    END IF;

    IF OLD.rutina_id IS NOT NULL THEN 
		-- En caso de tener el id de la rutina
		SET v_nombre_rutina2 = (SELECT resultados_esperados FROM rutinas WHERE id = OLD.rutina_id);
    ELSE
		SET v_nombre_rutina2 = "Sin rutina asignada.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "rutinas_ejercicios",
        CONCAT_WS(" ","Se han actualizado los datos de la relación RUTINAS EJERCICIOS con los IDs: Rutina -", NEW.Rutina_ID, "Ejercicio -", NEW.Ejercicio_ID, 
        "con los siguientes datos:",
        "EJERCICIO ID  = ", v_nombre_ejercicio2, " cambio a ", v_nombre_ejercicio,
        "RUTINA ID = ",v_nombre_rutina2," cambio a ", v_nombre_rutina,
        "REPETICIONES  = ", OLD.repeticiones, " cambio a ", NEW.repeticiones,
        "TIEMPO = ",OLD.tiempo," cambio a ", NEW.tiempo,
        "ESTATUS = ", v_cadena_estatus2, " cambio a ", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rutinas_ejercicios_AFTER_DELETE` AFTER DELETE ON `rutinas_ejercicios` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "rutinas_ejercicios",
        CONCAT_WS(" ","Se ha eliminado una relación RUTINAS EJERCICIOS con los IDs: Ejercicio - ", OLD.ejercicio_ID, ", Rutina - ", OLD.Rutina_ID ),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sucursales`
--

DROP TABLE IF EXISTS `sucursales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sucursales` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(150) NOT NULL,
  `Direccion` varchar(250) NOT NULL,
  `Responsable_ID` int unsigned DEFAULT NULL,
  `Total_Clientes_Atendidos` int unsigned NOT NULL DEFAULT '0',
  `Promedio_Clientes_X_Dia` int unsigned NOT NULL DEFAULT '0',
  `Capacidad_Maxima` int unsigned NOT NULL DEFAULT '0',
  `Total_Empleados` int unsigned DEFAULT '0',
  `Horario_Disponibilidad` text NOT NULL,
  `Estatus` bit(1) DEFAULT b'1',
  PRIMARY KEY (`ID`),
  KEY `fk_empleado_2` (`Responsable_ID`),
  CONSTRAINT `fk_empleado_2` FOREIGN KEY (`Responsable_ID`) REFERENCES `empleados` (`Persona_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sucursales`
--

LOCK TABLES `sucursales` WRITE;
/*!40000 ALTER TABLE `sucursales` DISABLE KEYS */;
INSERT INTO `sucursales` VALUES (1,'Xicotepec','Av. 5 de Mayo #75, Col. Centro',NULL,0,0,80,0,'08:00 a 24:00',_binary ''),(2,'Villa Ávila Camacho','Calle Asturinas #124, Col. del Rio',NULL,0,0,50,0,'08:00 a 20:00',_binary ''),(3,'San Isidro','Av. Lopez Mateoz #162 Col. Tierra Negra',NULL,1,1,90,0,'09:00 a 21:00',_binary ''),(4,'Seiva','Av. de las Torres #239, Col. Centro',NULL,0,0,50,0,'07:00 a 22:00',_binary '\0'),(5,'Huahuchinango','Calle Abasolo #25, Col.Barrio tibanco',NULL,0,0,56,0,'07:00 a 21:00',_binary '');
/*!40000 ALTER TABLE `sucursales` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `sucursales_AFTER_INSERT` AFTER INSERT ON `sucursales` FOR EACH ROW BEGIN
-- Declaración de variables
	DECLARE v_cadena_estatus varchar(15) default null;
    DECLARE v_nombre_responsable varchar(60) default null;
-- Iniciación de las variables
-- El estatus de la sucursal se almacena en un dato del tipo BIT, por
-- cuestiones de memoria, pero para registrar eventos en bitacora
-- se requiere ser más descriptivo con la redacción de los eventos
IF new.estatus = b'1' then
	set v_cadena_estatus = "Activa";
else
	set v_cadena_estatus = "Inactiva";
end if;

if new. responsable_id is not null then
-- En caso de tener el id del empleado responsable debemos recuperar su nombre
-- 
	set v_nombre_responsable = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.responsable_id);
else
	SET v_nombre_responsable = "Sin responsable asignado";
end if;
-- Insertar en la bitacora
INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "sucursales",
        CONCAT_WS(" ","Se ha insertado una nueva SUCURSAL con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "NOMBRE=", NEW.nombre,
        "DIRECCION = ", NEW.direccion,
        "RESPONSABLE ID = ", v_nombre_responsable,
        "TOTAL CLIENTES ATENDIDOS = ",  NEW.total_clientes_atendidos,
        "PROMEDIO CLIENTES POR DIA = ", NEW.promedio_clientes_x_dia, 
        "CAPACIDAD MAXIMA = ", NEW.capacidad_maxima, 
        "TOTAL EMPLEADOS = ", NEW.total_empleados,
        "HORARIO DISPONIBILIDAD = ", NEW.horario_disponibilidad,
        "ESTATUS = ",  v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `sucursales_AFTER_UPDATE` AFTER UPDATE ON `sucursales` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_responsable VARCHAR(100) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_responsable2 VARCHAR(100) DEFAULT NULL;

    -- Inicialización de las variables
    -- El estatus de la sucursa se almacena en un dato del tipo BIT, por
    -- cuestiones de memorìa, pero para registrar eventos en bitacora
    -- se requiere ser más descriptivo con las readcción de los eventos. 
    IF NEW.estatus = b'1' THEN
     SET v_cadena_estatus= "Activa";
	ELSE
	 SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
     SET v_cadena_estatus2= "Activa";
	ELSE
	 SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
	IF NEW.responsable_id IS NOT NULL THEN 
    -- En caso de tener el id del empleado responsable debemos recuperar su nombre
    -- para ingresarlo en la bitacora.
	SET v_nombre_responsable = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,
    p.segundo_apellido) FROM personas p WHERE id = NEW.responsable_id);
	ELSE
    SET v_nombre_responsable = "Sin responsable asingado.";
    END IF;
    
    IF OLD.responsable_id IS NOT NULL THEN 
    -- En caso de tener el id del empleado responsable debemos recuperar su nombre
    -- para ingresarlo en la bitacora.
	SET v_nombre_responsable2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,
    p.segundo_apellido) FROM personas p WHERE id = OLD.responsable_id);
	ELSE
    SET v_nombre_responsable2 = "Sin responsable asingado.";
    END IF;
    
    
    INSERT INTO bitacora VALUES(
		DEFAULT,
		USER(),
        "Update",
        "sucursales",
        CONCAT_WS(" ","Se ha modificado una SUCURSAL  existente con el ID: ",
        NEW.ID, "con los siguientes datos: NOMBRE =", OLD.nombre,"cambio a",NEW.nombre,
        "DIRECCION =", OLD.direccion,"cambio a",NEW.direccion,
        "RESPONSABLE = ", v_nombre_responsable2, "cambio a", v_nombre_responsable,
        "TOTAL CLIENTES ATENDIDOS  =",OLD.total_clientes_atendidos,"cambio a", NEW.total_clientes_atendidos,
        "PROMEDIO DE CLIENTES POR DIA =", OLD.promedio_clientes_x_dia,"cambio a",NEW.promedio_clientes_x_dia, 
        "CAPACIDAD MÀXIMA =", OLD.capacidad_maxima,"cambio a", NEW.capacidad_maxima,
        "TOTAL EMPLEADOS =", OLD.total_empleados, "cambio a", NEW.total_empleados,
        "HORARIO_DISPONIBILIDAD =", OLD.horario_disponibilidad, "cambio a", NEW.horario_disponibilidad, 
        "ESTATUS = ", v_cadena_estatus2, "cambio a", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `sucursales_AFTER_DELETE` AFTER DELETE ON `sucursales` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "sucursales",
        CONCAT_WS(" ","Se ha eliminado una SUCURSAL con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `Persona_ID` int unsigned NOT NULL,
  `Nombre_Usuario` int NOT NULL,
  `Password` blob,
  `Tipo` enum('Empleado','Visitante','Miembro','Instructor') DEFAULT NULL,
  `Estatus_Conexion` enum('Online','Offline','Banned') DEFAULT NULL,
  `Ultima_Conexion` datetime DEFAULT NULL,
  PRIMARY KEY (`Persona_ID`),
  UNIQUE KEY `Nombre_Usuario` (`Nombre_Usuario`),
  CONSTRAINT `fk_persona_3` FOREIGN KEY (`Persona_ID`) REFERENCES `personas` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (101,101,NULL,'Visitante','Offline','2024-01-07 14:40:26'),(102,102,NULL,'Empleado','Banned','2023-11-24 17:28:45'),(103,103,NULL,'Empleado','Offline','2024-01-02 19:26:08'),(104,104,NULL,'Empleado','Online','2023-09-09 10:20:40'),(105,105,NULL,'Visitante','Offline','2023-02-02 13:29:07'),(106,106,NULL,'Empleado','Online','2023-09-05 10:20:12'),(107,107,NULL,'Instructor','Offline','2022-10-08 18:47:22'),(108,108,NULL,'Instructor','Banned','2023-01-02 10:00:48'),(109,109,NULL,'Empleado','Banned','2023-12-23 09:11:38'),(110,110,NULL,'Instructor','Offline','2022-07-06 17:45:20'),(111,111,NULL,'Miembro','Offline','2020-12-29 10:50:44'),(112,112,NULL,'Visitante','Banned','2021-03-06 17:05:19'),(113,113,NULL,'Instructor','Offline','2024-02-24 16:09:22'),(114,114,NULL,'Instructor','Online','2023-03-06 10:01:13'),(115,115,NULL,'Instructor','Online','2021-07-07 19:02:56'),(116,116,NULL,'Empleado','Online','2023-08-20 15:31:29'),(117,117,NULL,'Miembro','Banned','2020-10-26 19:29:09'),(118,118,NULL,'Instructor','Online','2021-11-04 18:58:13'),(119,119,NULL,'Visitante','Banned','2022-10-02 09:51:22'),(120,120,NULL,'Visitante','Online','2023-12-25 12:41:00'),(121,121,NULL,'Instructor','Offline','2023-11-04 14:19:59'),(122,122,NULL,'Empleado','Banned','2021-10-22 16:33:25'),(123,123,NULL,'Miembro','Online','2024-02-14 19:32:04'),(124,124,NULL,'Miembro','Offline','2023-10-09 13:02:17'),(125,125,NULL,'Instructor','Online','2024-02-13 09:57:29'),(126,126,NULL,'Miembro','Online','2023-12-11 13:10:26'),(127,127,NULL,'Visitante','Offline','2020-12-02 16:49:52'),(128,128,NULL,'Miembro','Offline','2022-09-02 10:20:17'),(129,129,NULL,'Empleado','Banned','2021-09-20 08:47:19'),(130,130,NULL,'Instructor','Offline','2023-02-19 14:47:51'),(131,131,NULL,'Instructor','Banned','2024-02-02 13:18:14'),(132,132,NULL,'Instructor','Banned','2021-03-09 12:24:11'),(133,133,NULL,'Empleado','Banned','2024-01-17 10:48:10'),(134,134,NULL,'Miembro','Banned','2023-11-29 08:50:05'),(135,135,NULL,'Miembro','Banned','2023-06-24 09:27:03'),(136,136,NULL,'Miembro','Banned','2024-01-02 15:05:28'),(137,137,NULL,'Instructor','Online','2023-11-15 16:59:18'),(138,138,NULL,'Empleado','Online','2022-10-08 17:27:54'),(139,139,NULL,'Miembro','Banned','2022-05-09 09:00:06'),(140,140,NULL,'Empleado','Online','2022-08-06 16:59:22'),(141,141,NULL,'Empleado','Banned','2024-02-17 19:26:36'),(142,142,NULL,'Miembro','Banned','2024-01-16 14:50:26'),(143,143,NULL,'Miembro','Banned','2022-07-12 16:22:26'),(144,144,NULL,'Miembro','Offline','2024-01-19 19:25:52'),(145,145,NULL,'Empleado','Offline','2023-12-06 14:48:24'),(146,146,NULL,'Visitante','Offline','2021-11-24 13:59:53'),(147,147,NULL,'Visitante','Online','2024-01-13 10:29:13'),(148,148,NULL,'Visitante','Online','2023-07-28 12:56:17'),(149,149,NULL,'Empleado','Online','2024-01-08 08:03:43'),(150,150,NULL,'Empleado','Online','2024-01-14 15:34:10'),(151,151,NULL,'Empleado','Banned','2023-08-30 18:35:45'),(152,152,NULL,'Instructor','Offline','2023-04-16 09:45:25'),(153,153,NULL,'Visitante','Banned','2024-01-01 12:28:48'),(154,154,NULL,'Miembro','Online','2023-07-10 12:20:20'),(155,155,NULL,'Miembro','Banned','2023-12-21 12:26:31'),(156,156,NULL,'Empleado','Offline','2023-04-05 17:16:35'),(157,157,NULL,'Empleado','Online','2023-08-27 18:09:42'),(158,158,NULL,'Miembro','Offline','2023-02-19 13:47:50'),(159,159,NULL,'Instructor','Offline','2022-05-20 17:14:28'),(160,160,NULL,'Visitante','Banned','2024-01-27 16:55:05'),(161,161,NULL,'Empleado','Offline','2020-04-02 15:23:12'),(162,162,NULL,'Miembro','Online','2024-02-22 15:45:56'),(163,163,NULL,'Instructor','Online','2021-12-22 11:51:28'),(164,164,NULL,'Empleado','Online','2023-03-02 17:13:22'),(165,165,NULL,'Miembro','Offline','2022-11-25 08:47:23'),(166,166,NULL,'Miembro','Offline','2022-09-15 09:46:10'),(167,167,NULL,'Miembro','Banned','2021-08-27 09:48:41'),(168,168,NULL,'Visitante','Offline','2024-01-02 18:49:03'),(169,169,NULL,'Miembro','Online','2023-04-17 18:22:07'),(170,170,NULL,'Instructor','Offline','2022-12-21 12:23:56'),(171,171,NULL,'Instructor','Offline','2023-08-18 17:37:18'),(172,172,NULL,'Visitante','Online','2020-10-16 13:01:23'),(173,173,NULL,'Visitante','Online','2024-02-20 19:44:13'),(174,174,NULL,'Miembro','Banned','2023-04-02 13:07:04'),(175,175,NULL,'Miembro','Banned','2024-02-12 10:26:39'),(176,176,NULL,'Empleado','Online','2021-08-08 18:36:48'),(177,177,NULL,'Empleado','Banned','2023-07-11 18:55:31'),(178,178,NULL,'Empleado','Offline','2023-08-11 11:11:55'),(179,179,NULL,'Instructor','Online','2020-04-28 10:59:41'),(180,180,NULL,'Instructor','Online','2023-04-23 12:15:37'),(181,181,NULL,'Miembro','Banned','2023-08-22 16:43:04'),(182,182,NULL,'Visitante','Banned','2023-09-19 13:41:03'),(183,183,NULL,'Instructor','Offline','2022-11-01 13:56:55'),(184,184,NULL,'Instructor','Offline','2021-07-10 19:18:37'),(185,185,NULL,'Instructor','Banned','2023-03-21 16:46:08'),(186,186,NULL,'Miembro','Offline','2024-02-21 13:01:13'),(187,187,NULL,'Instructor','Offline','2023-12-12 08:36:54'),(188,188,NULL,'Miembro','Online','2023-05-02 16:47:16'),(189,189,NULL,'Miembro','Online','2024-01-17 16:53:01'),(190,190,NULL,'Empleado','Offline','2020-09-15 18:21:08'),(191,191,NULL,'Empleado','Banned','2021-07-17 08:54:33'),(192,192,NULL,'Instructor','Offline','2023-12-16 19:59:18'),(193,193,NULL,'Instructor','Offline','2023-11-18 10:09:54'),(194,194,NULL,'Miembro','Offline','2023-07-06 15:35:14'),(195,195,NULL,'Miembro','Banned','2020-02-26 16:37:52'),(196,196,NULL,'Miembro','Offline','2022-11-01 12:17:36'),(197,197,NULL,'Instructor','Banned','2022-05-18 15:19:36'),(198,198,NULL,'Miembro','Banned','2021-10-30 13:47:20'),(199,199,NULL,'Visitante','Banned','2024-01-30 11:21:21'),(200,200,NULL,'Empleado','Online','2021-05-04 09:48:36'),(201,201,NULL,'Empleado','Banned','2024-01-30 11:17:41'),(202,202,NULL,'Instructor','Offline','2023-01-06 10:15:46'),(203,203,NULL,'Visitante','Online','2022-01-06 11:11:22'),(204,204,NULL,'Instructor','Banned','2023-05-08 10:58:43'),(205,205,NULL,'Empleado','Offline','2021-04-10 17:20:13'),(206,206,NULL,'Empleado','Online','2022-12-09 09:02:35'),(207,207,NULL,'Visitante','Offline','2023-10-30 13:23:36'),(208,208,NULL,'Miembro','Banned','2023-05-21 18:54:16'),(209,209,NULL,'Empleado','Banned','2022-11-02 14:59:46'),(210,210,NULL,'Instructor','Online','2023-06-12 18:03:55'),(211,211,NULL,'Visitante','Banned','2024-01-11 13:50:18'),(212,212,NULL,'Miembro','Offline','2022-10-07 15:12:53'),(213,213,NULL,'Instructor','Banned','2022-01-03 13:49:30'),(214,214,NULL,'Miembro','Banned','2023-12-15 11:04:36'),(215,215,NULL,'Miembro','Banned','2024-02-06 11:55:38'),(216,216,NULL,'Instructor','Online','2022-02-18 13:34:29'),(217,217,NULL,'Visitante','Offline','2023-05-16 14:16:06'),(218,218,NULL,'Instructor','Offline','2024-02-03 13:10:44'),(219,219,NULL,'Visitante','Banned','2023-03-01 15:06:08'),(220,220,NULL,'Miembro','Online','2024-01-04 09:15:37'),(221,221,NULL,'Visitante','Banned','2023-09-05 19:52:34'),(222,222,NULL,'Miembro','Online','2023-05-31 15:38:50'),(223,223,NULL,'Empleado','Offline','2023-01-06 09:43:51'),(224,224,NULL,'Instructor','Banned','2023-11-18 18:32:45'),(225,225,NULL,'Instructor','Online','2022-11-14 11:41:14'),(226,226,NULL,'Miembro','Online','2023-03-21 18:20:21'),(227,227,NULL,'Empleado','Offline','2021-12-23 12:06:33'),(228,228,NULL,'Miembro','Offline','2024-02-24 18:58:19'),(229,229,NULL,'Visitante','Online','2022-11-23 12:02:40'),(230,230,NULL,'Miembro','Banned','2023-10-13 17:06:56'),(231,231,NULL,'Instructor','Online','2023-11-04 17:33:32'),(232,232,NULL,'Empleado','Banned','2022-10-03 15:52:39'),(233,233,NULL,'Instructor','Offline','2024-02-10 11:52:19'),(234,234,NULL,'Instructor','Banned','2022-07-17 08:01:18'),(235,235,NULL,'Instructor','Offline','2023-05-23 09:14:06'),(236,236,NULL,'Instructor','Offline','2022-01-21 19:24:34'),(237,237,NULL,'Miembro','Banned','2023-12-26 13:00:31'),(238,238,NULL,'Miembro','Online','2021-10-31 10:02:38'),(239,239,NULL,'Visitante','Offline','2022-11-29 08:09:23'),(240,240,NULL,'Visitante','Online','2022-12-25 17:02:37'),(241,241,NULL,'Empleado','Offline','2023-11-23 10:17:48'),(242,242,NULL,'Visitante','Online','2021-12-30 12:52:53'),(243,243,NULL,'Instructor','Banned','2023-12-27 19:49:25'),(244,244,NULL,'Visitante','Banned','2022-07-30 15:23:33'),(245,245,NULL,'Instructor','Online','2024-02-16 15:01:43'),(246,246,NULL,'Miembro','Online','2024-01-05 08:42:31'),(247,247,NULL,'Visitante','Banned','2022-06-03 13:49:04'),(248,248,NULL,'Empleado','Banned','2023-08-21 11:30:34'),(249,249,NULL,'Empleado','Online','2023-07-14 17:37:40'),(250,250,NULL,'Miembro','Banned','2023-08-04 17:57:10'),(251,251,NULL,'Empleado','Banned','2023-10-08 15:59:45'),(252,252,NULL,'Visitante','Online','2024-01-02 19:27:09'),(253,253,NULL,'Empleado','Banned','2023-12-26 19:25:19'),(254,254,NULL,'Empleado','Banned','2024-01-14 18:17:21'),(255,255,NULL,'Empleado','Banned','2023-07-10 19:15:11'),(256,256,NULL,'Visitante','Banned','2021-12-29 12:46:26'),(257,257,NULL,'Empleado','Banned','2024-01-06 17:24:15'),(258,258,NULL,'Instructor','Online','2024-01-15 09:39:25'),(259,259,NULL,'Miembro','Offline','2023-01-17 08:22:57'),(260,260,NULL,'Visitante','Online','2021-11-09 13:38:04'),(261,261,NULL,'Miembro','Offline','2023-02-12 08:42:17'),(262,262,NULL,'Miembro','Online','2024-01-01 18:26:43'),(263,263,NULL,'Visitante','Offline','2021-02-11 10:55:29'),(264,264,NULL,'Miembro','Online','2023-01-14 10:55:30'),(265,265,NULL,'Empleado','Online','2022-04-08 15:04:32'),(266,266,NULL,'Empleado','Banned','2020-08-04 11:58:11'),(267,267,NULL,'Visitante','Banned','2022-02-28 17:29:15'),(268,268,NULL,'Instructor','Online','2021-11-27 12:48:44'),(269,269,NULL,'Instructor','Offline','2023-03-20 10:18:00'),(270,270,NULL,'Instructor','Banned','2022-11-29 15:19:50'),(271,271,NULL,'Empleado','Online','2022-11-11 18:57:09'),(272,272,NULL,'Miembro','Online','2023-09-15 13:59:28'),(273,273,NULL,'Instructor','Online','2021-12-22 13:03:32'),(274,274,NULL,'Instructor','Banned','2023-12-14 14:33:16'),(275,275,NULL,'Instructor','Banned','2023-10-03 10:09:49'),(276,276,NULL,'Instructor','Online','2023-03-23 08:00:35'),(277,277,NULL,'Instructor','Offline','2022-09-15 19:16:45'),(278,278,NULL,'Instructor','Banned','2023-11-24 19:08:50'),(279,279,NULL,'Visitante','Online','2021-04-26 10:54:28'),(280,280,NULL,'Visitante','Offline','2022-12-19 14:52:49'),(281,281,NULL,'Visitante','Offline','2021-10-27 17:27:24'),(282,282,NULL,'Miembro','Online','2023-04-07 16:46:08'),(283,283,NULL,'Empleado','Banned','2024-01-28 17:16:49'),(284,284,NULL,'Visitante','Banned','2023-03-05 17:53:12'),(285,285,NULL,'Miembro','Offline','2023-07-13 15:04:34'),(286,286,NULL,'Empleado','Offline','2023-12-06 16:47:10'),(287,287,NULL,'Miembro','Banned','2022-05-21 19:12:20'),(288,288,NULL,'Instructor','Offline','2023-05-30 17:10:21'),(289,289,NULL,'Visitante','Online','2023-09-20 14:10:42'),(290,290,NULL,'Visitante','Banned','2024-01-19 11:13:28'),(291,291,NULL,'Visitante','Online','2023-01-16 13:29:04'),(292,292,NULL,'Instructor','Banned','2023-04-15 16:14:24'),(293,293,NULL,'Miembro','Banned','2022-10-10 16:03:49'),(294,294,NULL,'Miembro','Banned','2021-08-01 14:37:11'),(295,295,NULL,'Visitante','Offline','2023-08-21 19:21:19'),(296,296,NULL,'Empleado','Online','2021-12-04 17:54:25'),(297,297,NULL,'Miembro','Offline','2023-02-12 17:54:06'),(298,298,NULL,'Miembro','Online','2023-02-14 14:44:19'),(299,299,NULL,'Miembro','Online','2021-05-29 14:22:10'),(300,300,NULL,'Empleado','Banned','2023-12-11 11:19:05'),(301,301,NULL,'Miembro','Online','2022-08-23 11:30:22'),(302,302,NULL,'Miembro','Banned','2024-01-22 08:20:40'),(303,303,NULL,'Visitante','Banned','2021-10-24 08:31:34'),(304,304,NULL,'Instructor','Offline','2021-09-24 16:59:41'),(305,305,NULL,'Empleado','Offline','2023-06-06 16:23:59'),(306,306,NULL,'Empleado','Banned','2023-05-03 16:38:30'),(307,307,NULL,'Instructor','Offline','2021-12-23 12:49:14'),(308,308,NULL,'Empleado','Online','2024-02-21 09:24:00'),(309,309,NULL,'Empleado','Banned','2021-04-27 15:50:28'),(310,310,NULL,'Empleado','Banned','2022-06-10 12:37:22'),(311,311,NULL,'Instructor','Offline','2023-02-24 19:35:54'),(312,312,NULL,'Empleado','Online','2024-02-01 13:03:55'),(313,313,NULL,'Instructor','Banned','2024-01-17 08:07:11'),(314,314,NULL,'Empleado','Banned','2023-12-08 18:48:55'),(315,315,NULL,'Visitante','Online','2023-07-13 18:22:19'),(316,316,NULL,'Visitante','Online','2023-05-02 08:09:41'),(317,317,NULL,'Empleado','Online','2023-12-03 19:52:50'),(318,318,NULL,'Instructor','Banned','2023-11-13 14:27:18'),(319,319,NULL,'Miembro','Offline','2023-12-29 19:45:14'),(320,320,NULL,'Visitante','Online','2023-12-04 08:01:36'),(321,321,NULL,'Visitante','Offline','2024-02-07 12:49:42'),(322,322,NULL,'Miembro','Offline','2023-10-07 17:40:26'),(323,323,NULL,'Visitante','Banned','2023-03-09 18:08:50'),(324,324,NULL,'Visitante','Online','2023-10-26 08:52:18'),(325,325,NULL,'Empleado','Banned','2022-05-22 16:02:20'),(326,326,NULL,'Empleado','Online','2022-04-05 08:20:42'),(327,327,NULL,'Instructor','Online','2024-02-21 16:52:35'),(328,328,NULL,'Empleado','Online','2023-08-17 13:22:23'),(329,329,NULL,'Empleado','Banned','2023-06-15 14:08:04'),(330,330,NULL,'Empleado','Offline','2023-12-23 18:31:20'),(331,331,NULL,'Empleado','Banned','2024-02-27 13:38:09'),(332,332,NULL,'Visitante','Banned','2022-01-17 14:49:21'),(333,333,NULL,'Instructor','Offline','2023-11-28 09:34:44'),(334,334,NULL,'Miembro','Online','2023-03-11 14:59:41'),(335,335,NULL,'Instructor','Online','2023-12-13 08:49:20'),(336,336,NULL,'Instructor','Offline','2022-07-07 18:44:19'),(337,337,NULL,'Visitante','Offline','2021-12-05 08:23:29'),(338,338,NULL,'Instructor','Offline','2023-10-08 08:12:15'),(339,339,NULL,'Miembro','Banned','2022-07-05 16:20:52'),(340,340,NULL,'Visitante','Offline','2020-12-22 11:16:52'),(341,341,NULL,'Instructor','Offline','2021-11-17 10:04:46'),(342,342,NULL,'Miembro','Online','2022-11-26 13:46:09'),(343,343,NULL,'Empleado','Offline','2022-01-16 10:52:39'),(344,344,NULL,'Instructor','Banned','2022-09-01 15:56:05'),(345,345,NULL,'Instructor','Online','2022-09-14 18:36:49'),(346,346,NULL,'Instructor','Online','2023-06-16 11:19:06'),(347,347,NULL,'Visitante','Banned','2023-06-02 17:17:08'),(348,348,NULL,'Instructor','Online','2023-01-19 10:41:04'),(349,349,NULL,'Empleado','Online','2023-06-28 09:04:22'),(350,350,NULL,'Visitante','Online','2023-06-21 17:53:33'),(351,351,NULL,'Empleado','Offline','2023-02-27 13:25:05'),(352,352,NULL,'Miembro','Banned','2022-05-23 15:28:28'),(353,353,NULL,'Empleado','Banned','2022-06-21 19:25:13'),(354,354,NULL,'Empleado','Online','2021-06-04 19:46:18'),(355,355,NULL,'Instructor','Banned','2024-01-08 17:18:14'),(356,356,NULL,'Empleado','Banned','2023-11-17 08:13:41'),(357,357,NULL,'Miembro','Banned','2022-04-29 19:36:03'),(358,358,NULL,'Empleado','Banned','2022-10-24 13:07:50'),(359,359,NULL,'Empleado','Offline','2023-07-18 18:40:39'),(360,360,NULL,'Instructor','Online','2023-09-27 17:14:19'),(361,361,NULL,'Instructor','Online','2023-08-30 11:14:58'),(362,362,NULL,'Empleado','Offline','2023-09-07 18:59:00'),(363,363,NULL,'Miembro','Online','2022-01-03 13:44:47'),(364,364,NULL,'Visitante','Banned','2022-11-06 08:17:21'),(365,365,NULL,'Visitante','Banned','2023-12-27 15:46:24'),(366,366,NULL,'Miembro','Offline','2022-05-02 09:43:55'),(367,367,NULL,'Empleado','Banned','2022-08-10 13:41:05'),(368,368,NULL,'Instructor','Online','2023-05-03 19:14:49'),(369,369,NULL,'Miembro','Offline','2022-01-08 18:37:49'),(370,370,NULL,'Miembro','Online','2023-08-30 09:45:32'),(371,371,NULL,'Miembro','Offline','2024-02-11 16:26:21'),(372,372,NULL,'Empleado','Online','2021-06-11 09:48:19'),(373,373,NULL,'Instructor','Online','2024-02-27 12:38:01'),(374,374,NULL,'Visitante','Offline','2023-09-11 19:35:16'),(375,375,NULL,'Empleado','Banned','2024-01-27 15:43:09'),(376,376,NULL,'Instructor','Offline','2020-12-08 13:03:47'),(377,377,NULL,'Miembro','Offline','2023-05-09 10:19:55'),(378,378,NULL,'Miembro','Banned','2024-01-03 14:32:07'),(379,379,NULL,'Miembro','Banned','2021-07-14 17:03:32'),(380,380,NULL,'Visitante','Offline','2023-09-30 15:04:57'),(381,381,NULL,'Visitante','Offline','2023-05-08 11:24:34'),(382,382,NULL,'Instructor','Offline','2024-02-23 08:53:56'),(383,383,NULL,'Visitante','Online','2020-07-25 13:46:22'),(384,384,NULL,'Miembro','Offline','2023-10-23 12:03:24'),(385,385,NULL,'Instructor','Banned','2023-12-15 17:33:04'),(386,386,NULL,'Instructor','Banned','2023-04-28 19:54:09'),(387,387,NULL,'Miembro','Banned','2024-01-19 14:50:00'),(388,388,NULL,'Miembro','Offline','2024-02-12 19:08:55'),(389,389,NULL,'Empleado','Offline','2023-06-28 10:53:09'),(390,390,NULL,'Visitante','Online','2024-02-10 10:21:56'),(391,391,NULL,'Instructor','Online','2022-12-13 13:21:56'),(392,392,NULL,'Visitante','Online','2024-02-22 09:05:05'),(393,393,NULL,'Instructor','Online','2023-04-13 11:17:40'),(394,394,NULL,'Visitante','Offline','2022-12-01 10:30:03'),(395,395,NULL,'Visitante','Online','2022-02-14 11:59:03'),(396,396,NULL,'Instructor','Online','2024-02-04 14:50:40'),(397,397,NULL,'Miembro','Offline','2020-09-15 19:43:55'),(398,398,NULL,'Instructor','Offline','2023-07-28 19:19:55'),(399,399,NULL,'Instructor','Banned','2022-10-08 15:20:23'),(400,400,NULL,'Miembro','Banned','2022-08-27 09:10:31'),(401,401,NULL,'Instructor','Online','2022-09-22 08:35:50'),(402,402,NULL,'Instructor','Banned','2021-09-24 12:28:54'),(403,403,NULL,'Visitante','Online','2024-01-11 13:52:38'),(404,404,NULL,'Miembro','Banned','2024-02-12 13:59:53'),(405,405,NULL,'Instructor','Banned','2023-09-27 12:32:15'),(406,406,NULL,'Instructor','Online','2021-05-20 17:36:26'),(407,407,NULL,'Visitante','Online','2023-05-01 18:45:53'),(408,408,NULL,'Miembro','Online','2022-07-10 17:42:14'),(409,409,NULL,'Empleado','Banned','2023-05-13 11:17:17'),(410,410,NULL,'Miembro','Banned','2024-02-14 14:03:05'),(411,411,NULL,'Visitante','Banned','2024-01-28 14:02:03'),(412,412,NULL,'Visitante','Banned','2023-07-08 18:11:27'),(413,413,NULL,'Empleado','Offline','2024-02-22 12:59:35'),(414,414,NULL,'Empleado','Banned','2023-09-08 11:56:00'),(415,415,NULL,'Empleado','Offline','2024-02-20 13:49:15'),(416,416,NULL,'Empleado','Online','2022-08-31 14:06:59'),(417,417,NULL,'Visitante','Online','2020-11-12 10:33:29'),(418,418,NULL,'Miembro','Banned','2024-01-13 16:59:09'),(419,419,NULL,'Empleado','Online','2022-06-16 12:24:00'),(420,420,NULL,'Instructor','Offline','2021-10-11 16:56:19'),(421,421,NULL,'Empleado','Online','2023-01-26 17:19:59'),(422,422,NULL,'Visitante','Online','2023-05-13 18:12:27'),(423,423,NULL,'Empleado','Banned','2023-07-28 13:59:35'),(424,424,NULL,'Instructor','Online','2023-04-04 17:38:21'),(425,425,NULL,'Empleado','Online','2024-02-04 10:08:57'),(426,426,NULL,'Instructor','Banned','2023-11-08 11:44:58'),(427,427,NULL,'Empleado','Banned','2023-12-03 13:44:10'),(428,428,NULL,'Visitante','Online','2024-01-11 16:33:28'),(429,429,NULL,'Miembro','Offline','2023-11-01 17:45:45'),(430,430,NULL,'Miembro','Online','2022-12-28 11:17:16'),(431,431,NULL,'Empleado','Online','2022-05-02 11:35:40'),(432,432,NULL,'Miembro','Offline','2023-08-03 09:54:23'),(433,433,NULL,'Miembro','Online','2022-10-14 16:24:47'),(434,434,NULL,'Empleado','Online','2023-11-21 19:04:26'),(435,435,NULL,'Miembro','Offline','2021-12-16 19:41:16'),(436,436,NULL,'Miembro','Offline','2023-10-24 14:47:32'),(437,437,NULL,'Empleado','Banned','2023-01-09 17:07:28'),(438,438,NULL,'Instructor','Online','2023-12-20 14:30:49'),(439,439,NULL,'Visitante','Offline','2023-03-25 13:39:59'),(440,440,NULL,'Miembro','Banned','2022-07-29 11:25:50'),(441,441,NULL,'Miembro','Online','2023-05-30 19:23:55'),(442,442,NULL,'Miembro','Offline','2023-04-26 12:55:13'),(443,443,NULL,'Empleado','Banned','2023-08-18 08:09:52'),(444,444,NULL,'Miembro','Offline','2023-11-06 18:47:51'),(445,445,NULL,'Visitante','Offline','2023-11-18 13:46:35'),(446,446,NULL,'Miembro','Online','2023-03-26 09:17:06'),(447,447,NULL,'Empleado','Online','2022-09-03 16:01:40'),(448,448,NULL,'Empleado','Online','2023-05-22 11:28:06'),(449,449,NULL,'Empleado','Offline','2022-02-20 10:35:51'),(450,450,NULL,'Visitante','Banned','2020-10-08 17:07:19'),(451,451,NULL,'Empleado','Banned','2023-06-05 15:21:20'),(452,452,NULL,'Instructor','Offline','2023-09-27 08:00:12'),(453,453,NULL,'Empleado','Banned','2022-12-18 13:19:51'),(454,454,NULL,'Visitante','Banned','2023-04-09 08:26:06'),(455,455,NULL,'Visitante','Offline','2021-11-03 15:46:43'),(456,456,NULL,'Visitante','Banned','2024-02-17 09:14:55'),(457,457,NULL,'Empleado','Banned','2024-02-22 14:33:00'),(458,458,NULL,'Miembro','Online','2023-12-06 14:07:03'),(459,459,NULL,'Instructor','Online','2021-05-25 17:31:52'),(460,460,NULL,'Visitante','Offline','2021-09-20 17:54:02'),(461,461,NULL,'Visitante','Offline','2023-03-06 17:48:03'),(462,462,NULL,'Empleado','Online','2020-10-13 12:50:40'),(463,463,NULL,'Instructor','Banned','2023-05-26 12:02:03'),(464,464,NULL,'Empleado','Banned','2022-11-07 12:37:15'),(465,465,NULL,'Miembro','Online','2023-05-01 10:55:21'),(466,466,NULL,'Empleado','Banned','2022-05-01 10:11:24'),(467,467,NULL,'Instructor','Online','2021-09-10 13:11:29'),(468,468,NULL,'Empleado','Banned','2023-11-26 19:43:14'),(469,469,NULL,'Empleado','Offline','2023-04-19 16:09:44'),(470,470,NULL,'Visitante','Banned','2024-01-23 14:15:44'),(471,471,NULL,'Visitante','Offline','2024-02-13 15:26:49'),(472,472,NULL,'Miembro','Online','2021-06-29 14:15:15'),(473,473,NULL,'Visitante','Online','2021-10-19 10:01:13'),(474,474,NULL,'Instructor','Banned','2021-11-21 15:45:45'),(475,475,NULL,'Miembro','Online','2023-12-27 17:29:42'),(476,476,NULL,'Visitante','Banned','2024-02-08 11:34:59'),(477,477,NULL,'Instructor','Banned','2023-04-19 13:52:07'),(478,478,NULL,'Miembro','Offline','2022-04-02 10:33:03'),(479,479,NULL,'Miembro','Offline','2023-09-14 13:01:22'),(480,480,NULL,'Instructor','Offline','2022-08-05 09:41:41'),(481,481,NULL,'Empleado','Banned','2023-10-03 18:50:11'),(482,482,NULL,'Instructor','Online','2023-05-03 17:47:51'),(483,483,NULL,'Miembro','Banned','2023-04-30 13:28:26'),(484,484,NULL,'Instructor','Banned','2023-12-26 10:46:51'),(485,485,NULL,'Miembro','Offline','2022-04-28 09:46:54'),(486,486,NULL,'Visitante','Banned','2021-06-14 10:17:21'),(487,487,NULL,'Empleado','Offline','2023-08-27 16:38:33'),(488,488,NULL,'Empleado','Offline','2023-09-10 09:01:17'),(489,489,NULL,'Instructor','Online','2022-10-30 13:01:50'),(490,490,NULL,'Visitante','Banned','2023-09-12 11:50:38'),(491,491,NULL,'Miembro','Offline','2023-10-21 12:46:59'),(492,492,NULL,'Empleado','Online','2023-10-01 11:07:51'),(493,493,NULL,'Instructor','Online','2023-09-08 16:12:01'),(494,494,NULL,'Visitante','Banned','2022-11-11 17:59:36'),(495,495,NULL,'Instructor','Online','2024-02-11 13:09:43'),(496,496,NULL,'Visitante','Online','2023-11-29 11:03:27'),(497,497,NULL,'Instructor','Banned','2023-08-30 18:23:38'),(498,498,NULL,'Instructor','Offline','2023-09-27 11:00:02'),(499,499,NULL,'Empleado','Banned','2023-12-23 12:28:49'),(500,500,NULL,'Miembro','Banned','2023-11-21 15:24:58'),(501,501,NULL,'Empleado','Banned','2023-12-04 11:36:33'),(502,502,NULL,'Miembro','Offline','2023-08-11 15:51:44'),(503,503,NULL,'Instructor','Banned','2022-09-18 11:04:20'),(504,504,NULL,'Instructor','Offline','2023-11-20 09:57:18'),(505,505,NULL,'Empleado','Banned','2023-05-14 14:04:41'),(506,506,NULL,'Instructor','Offline','2023-06-27 18:14:03'),(507,507,NULL,'Miembro','Banned','2023-03-23 19:57:31'),(508,508,NULL,'Instructor','Offline','2023-12-17 19:49:38'),(509,509,NULL,'Visitante','Online','2020-02-16 17:23:11'),(510,510,NULL,'Empleado','Offline','2023-03-19 19:16:56'),(511,511,NULL,'Visitante','Offline','2023-02-11 19:00:00'),(512,512,NULL,'Visitante','Offline','2022-11-26 14:16:41'),(513,513,NULL,'Miembro','Online','2023-12-14 10:57:35'),(514,514,NULL,'Miembro','Offline','2022-03-09 14:07:34'),(515,515,NULL,'Instructor','Online','2021-03-05 09:55:15'),(516,516,NULL,'Visitante','Offline','2024-02-09 12:37:54'),(517,517,NULL,'Visitante','Offline','2024-02-13 14:32:16'),(518,518,NULL,'Empleado','Banned','2023-02-02 08:00:12'),(519,519,NULL,'Instructor','Banned','2022-06-09 17:38:13'),(520,520,NULL,'Empleado','Offline','2023-03-29 18:10:50'),(521,521,NULL,'Empleado','Offline','2022-05-17 16:16:30'),(522,522,NULL,'Instructor','Banned','2024-01-05 14:30:39'),(523,523,NULL,'Visitante','Online','2021-01-20 17:13:50'),(524,524,NULL,'Visitante','Online','2021-07-21 13:16:32'),(525,525,NULL,'Miembro','Banned','2022-07-11 13:34:35'),(526,526,NULL,'Instructor','Online','2023-02-25 11:42:32'),(527,527,NULL,'Empleado','Offline','2023-10-27 17:47:46'),(528,528,NULL,'Empleado','Banned','2024-01-18 09:30:40'),(529,529,NULL,'Instructor','Banned','2022-08-06 11:10:23'),(530,530,NULL,'Visitante','Offline','2024-01-12 17:03:38'),(531,531,NULL,'Instructor','Offline','2023-06-12 12:33:10'),(532,532,NULL,'Empleado','Offline','2023-11-30 11:16:53'),(533,533,NULL,'Miembro','Banned','2023-12-21 10:49:09'),(534,534,NULL,'Miembro','Online','2023-12-21 15:46:26'),(535,535,NULL,'Miembro','Banned','2023-05-28 16:37:51'),(536,536,NULL,'Empleado','Banned','2023-04-21 17:50:18'),(537,537,NULL,'Visitante','Offline','2024-02-25 18:23:06'),(538,538,NULL,'Miembro','Banned','2023-10-03 09:35:21'),(539,539,NULL,'Empleado','Offline','2022-08-26 11:05:16'),(540,540,NULL,'Instructor','Online','2023-11-27 17:38:12'),(541,541,NULL,'Empleado','Online','2023-09-18 12:12:21'),(542,542,NULL,'Miembro','Offline','2023-12-21 10:57:14'),(543,543,NULL,'Miembro','Online','2022-10-14 12:45:32'),(544,544,NULL,'Instructor','Banned','2022-09-29 10:08:33'),(545,545,NULL,'Empleado','Offline','2023-06-20 18:31:05'),(546,546,NULL,'Empleado','Offline','2023-02-02 16:53:08'),(547,547,NULL,'Empleado','Banned','2021-02-25 18:23:03'),(548,548,NULL,'Empleado','Offline','2022-09-08 13:51:41'),(549,549,NULL,'Miembro','Banned','2023-07-14 12:41:20'),(550,550,NULL,'Visitante','Banned','2023-06-24 08:47:50'),(551,551,NULL,'Miembro','Offline','2021-07-14 13:49:01'),(552,552,NULL,'Visitante','Online','2022-09-20 15:02:20'),(553,553,NULL,'Miembro','Offline','2023-09-26 17:35:52'),(554,554,NULL,'Empleado','Banned','2023-06-28 18:02:16'),(555,555,NULL,'Miembro','Offline','2023-12-24 19:36:43'),(556,556,NULL,'Miembro','Banned','2022-07-23 18:05:31'),(557,557,NULL,'Instructor','Offline','2024-01-14 10:00:24'),(558,558,NULL,'Miembro','Offline','2024-01-08 09:22:55'),(559,559,NULL,'Empleado','Online','2022-09-01 12:41:36'),(560,560,NULL,'Empleado','Offline','2023-01-13 08:54:44'),(561,561,NULL,'Miembro','Offline','2023-08-25 14:56:17'),(562,562,NULL,'Empleado','Online','2021-06-21 15:49:19'),(563,563,NULL,'Visitante','Offline','2023-01-11 19:27:32'),(564,564,NULL,'Visitante','Offline','2023-02-18 16:59:44'),(565,565,NULL,'Visitante','Online','2023-11-08 18:55:16'),(566,566,NULL,'Visitante','Offline','2022-07-17 09:43:53'),(567,567,NULL,'Instructor','Offline','2023-02-12 14:32:03'),(568,568,NULL,'Visitante','Banned','2023-11-23 14:16:34'),(569,569,NULL,'Empleado','Banned','2021-10-15 15:21:14'),(570,570,NULL,'Empleado','Online','2023-10-06 17:03:47'),(571,571,NULL,'Visitante','Online','2023-01-22 08:42:47'),(572,572,NULL,'Empleado','Offline','2021-07-16 14:35:57'),(573,573,NULL,'Instructor','Online','2023-03-13 11:11:40'),(574,574,NULL,'Empleado','Online','2023-05-20 14:26:45'),(575,575,NULL,'Instructor','Banned','2024-01-26 14:40:05'),(576,576,NULL,'Visitante','Offline','2024-01-04 09:13:07'),(577,577,NULL,'Instructor','Online','2023-08-09 13:09:41'),(578,578,NULL,'Instructor','Offline','2022-12-05 17:05:56'),(579,579,NULL,'Empleado','Online','2023-02-25 10:52:25'),(580,580,NULL,'Empleado','Offline','2024-01-22 12:27:15'),(581,581,NULL,'Empleado','Offline','2022-09-29 12:34:28'),(582,582,NULL,'Visitante','Offline','2021-05-29 10:44:03'),(583,583,NULL,'Instructor','Online','2023-02-09 08:44:02'),(584,584,NULL,'Visitante','Offline','2022-03-24 19:03:22'),(585,585,NULL,'Miembro','Offline','2021-12-09 10:07:22'),(586,586,NULL,'Instructor','Banned','2022-04-09 17:50:38'),(587,587,NULL,'Miembro','Online','2024-02-18 19:50:10'),(588,588,NULL,'Instructor','Banned','2024-01-18 13:25:14'),(589,589,NULL,'Empleado','Online','2020-07-22 15:42:14'),(590,590,NULL,'Instructor','Banned','2024-01-27 13:39:14'),(591,591,NULL,'Empleado','Offline','2020-11-06 18:31:58'),(592,592,NULL,'Empleado','Banned','2024-01-12 17:42:38'),(593,593,NULL,'Visitante','Offline','2023-09-28 19:08:25'),(594,594,NULL,'Miembro','Offline','2023-11-10 15:45:19'),(595,595,NULL,'Instructor','Offline','2022-05-25 12:01:34'),(596,596,NULL,'Visitante','Banned','2022-10-16 12:13:53'),(597,597,NULL,'Empleado','Offline','2023-09-24 10:02:32'),(598,598,NULL,'Empleado','Offline','2023-09-20 17:32:39'),(599,599,NULL,'Miembro','Offline','2022-05-07 13:53:53'),(600,600,NULL,'Miembro','Offline','2021-01-28 11:59:08'),(601,601,NULL,'Empleado','Offline','2021-10-22 08:23:55'),(602,602,NULL,'Instructor','Banned','2021-10-23 10:34:28'),(603,603,NULL,'Empleado','Banned','2023-08-01 14:36:01'),(604,604,NULL,'Visitante','Offline','2023-07-13 17:01:18'),(605,605,NULL,'Instructor','Offline','2023-08-24 19:11:28'),(606,606,NULL,'Visitante','Online','2021-02-20 14:10:12'),(607,607,NULL,'Empleado','Online','2023-09-25 14:45:21'),(608,608,NULL,'Miembro','Offline','2023-11-03 12:11:33'),(609,609,NULL,'Empleado','Offline','2024-02-25 15:21:07'),(610,610,NULL,'Miembro','Online','2023-11-17 08:02:27'),(611,611,NULL,'Visitante','Offline','2023-12-01 09:00:35'),(612,612,NULL,'Instructor','Online','2022-12-04 15:13:49'),(613,613,NULL,'Empleado','Banned','2022-06-17 11:24:10'),(614,614,NULL,'Empleado','Banned','2023-12-04 11:24:09'),(615,615,NULL,'Visitante','Online','2023-10-09 15:54:12'),(616,616,NULL,'Instructor','Online','2023-07-22 14:22:02'),(617,617,NULL,'Miembro','Online','2022-11-30 16:47:12'),(618,618,NULL,'Visitante','Offline','2022-10-29 10:46:18'),(619,619,NULL,'Miembro','Banned','2020-11-03 15:52:43'),(620,620,NULL,'Instructor','Offline','2024-02-26 12:04:59'),(621,621,NULL,'Visitante','Online','2023-11-24 08:34:29'),(622,622,NULL,'Visitante','Banned','2022-07-26 17:27:33'),(623,623,NULL,'Visitante','Online','2022-08-11 18:58:18'),(624,624,NULL,'Visitante','Banned','2024-01-21 09:54:02'),(625,625,NULL,'Visitante','Online','2023-06-07 15:50:34'),(626,626,NULL,'Empleado','Offline','2023-01-02 16:32:39'),(627,627,NULL,'Miembro','Banned','2023-10-19 10:12:53'),(628,628,NULL,'Instructor','Banned','2021-11-10 15:24:36'),(629,629,NULL,'Visitante','Banned','2021-11-20 13:13:25'),(630,630,NULL,'Empleado','Banned','2024-02-24 10:49:38'),(631,631,NULL,'Instructor','Offline','2022-11-25 19:46:10'),(632,632,NULL,'Visitante','Offline','2022-04-02 11:07:01'),(633,633,NULL,'Miembro','Offline','2022-10-28 11:39:00'),(634,634,NULL,'Empleado','Banned','2021-03-30 17:02:16'),(635,635,NULL,'Instructor','Online','2022-12-12 13:43:56'),(636,636,NULL,'Empleado','Banned','2022-06-20 09:53:40'),(637,637,NULL,'Instructor','Online','2024-02-11 17:02:20'),(638,638,NULL,'Instructor','Offline','2023-02-07 13:32:32'),(639,639,NULL,'Empleado','Offline','2023-05-06 10:07:11'),(640,640,NULL,'Miembro','Online','2022-01-25 08:54:25'),(641,641,NULL,'Empleado','Banned','2022-09-05 17:44:52'),(642,642,NULL,'Miembro','Banned','2022-02-07 09:37:25'),(643,643,NULL,'Visitante','Online','2023-10-12 16:48:09'),(644,644,NULL,'Visitante','Banned','2023-09-20 08:13:23'),(645,645,NULL,'Miembro','Offline','2023-06-14 14:59:16'),(646,646,NULL,'Miembro','Banned','2023-01-13 19:10:17'),(647,647,NULL,'Miembro','Offline','2023-05-16 13:36:58'),(648,648,NULL,'Instructor','Offline','2023-12-30 19:33:27'),(649,649,NULL,'Empleado','Online','2024-02-03 15:23:18'),(650,650,NULL,'Instructor','Offline','2023-11-15 08:17:40'),(651,651,NULL,'Instructor','Online','2022-05-27 11:38:48'),(652,652,NULL,'Visitante','Offline','2023-03-30 17:21:47'),(653,653,NULL,'Miembro','Online','2022-12-17 08:20:47'),(654,654,NULL,'Miembro','Banned','2023-03-09 14:52:18'),(655,655,NULL,'Empleado','Online','2023-05-03 17:50:49'),(656,656,NULL,'Instructor','Online','2023-07-07 17:46:44'),(657,657,NULL,'Empleado','Offline','2023-08-08 10:47:34'),(658,658,NULL,'Instructor','Banned','2023-08-30 16:26:42'),(659,659,NULL,'Empleado','Banned','2023-02-25 19:13:51'),(660,660,NULL,'Instructor','Banned','2023-01-15 10:47:51'),(661,661,NULL,'Miembro','Online','2023-10-24 14:55:12'),(662,662,NULL,'Miembro','Offline','2023-08-21 10:17:52'),(663,663,NULL,'Instructor','Online','2023-12-01 09:03:04'),(664,664,NULL,'Visitante','Online','2023-11-30 18:17:47'),(665,665,NULL,'Empleado','Offline','2024-02-09 12:29:46'),(666,666,NULL,'Instructor','Online','2020-12-01 10:03:28'),(667,667,NULL,'Visitante','Online','2022-04-24 18:57:45'),(668,668,NULL,'Instructor','Offline','2023-11-21 19:37:47'),(669,669,NULL,'Visitante','Banned','2023-08-12 19:23:45'),(670,670,NULL,'Instructor','Online','2021-07-12 08:55:56'),(671,671,NULL,'Visitante','Online','2023-12-24 10:41:06'),(672,672,NULL,'Empleado','Banned','2021-12-26 10:15:59'),(673,673,NULL,'Miembro','Online','2023-11-19 18:40:21'),(674,674,NULL,'Visitante','Online','2022-09-20 18:28:14'),(675,675,NULL,'Miembro','Offline','2023-06-16 10:04:45'),(676,676,NULL,'Instructor','Banned','2023-11-24 11:44:32'),(677,677,NULL,'Empleado','Offline','2023-07-15 15:12:33'),(678,678,NULL,'Miembro','Banned','2023-11-26 17:01:17'),(679,679,NULL,'Visitante','Offline','2022-10-27 14:08:34'),(680,680,NULL,'Empleado','Banned','2022-12-15 12:22:03'),(681,681,NULL,'Miembro','Online','2022-10-30 17:48:21'),(682,682,NULL,'Miembro','Online','2022-11-04 13:40:57'),(683,683,NULL,'Empleado','Online','2021-03-04 17:48:24'),(684,684,NULL,'Empleado','Offline','2022-06-21 11:54:36'),(685,685,NULL,'Miembro','Offline','2022-04-02 12:39:31'),(686,686,NULL,'Instructor','Online','2021-03-24 09:50:21'),(687,687,NULL,'Empleado','Online','2023-09-04 14:06:08'),(688,688,NULL,'Instructor','Banned','2022-05-31 09:31:06'),(689,689,NULL,'Instructor','Online','2023-06-30 15:58:58'),(690,690,NULL,'Miembro','Online','2023-10-05 10:21:05'),(691,691,NULL,'Empleado','Banned','2023-01-30 16:29:25'),(692,692,NULL,'Miembro','Offline','2023-04-03 18:56:45'),(693,693,NULL,'Empleado','Banned','2022-06-04 19:57:18'),(694,694,NULL,'Empleado','Online','2022-04-22 18:55:53'),(695,695,NULL,'Miembro','Online','2023-05-14 09:37:40'),(696,696,NULL,'Instructor','Offline','2022-01-03 11:04:09'),(697,697,NULL,'Visitante','Offline','2023-09-22 15:34:35'),(698,698,NULL,'Instructor','Banned','2023-12-27 18:58:53'),(699,699,NULL,'Visitante','Offline','2023-01-07 16:40:43'),(700,700,NULL,'Empleado','Online','2024-02-20 14:13:41'),(701,701,NULL,'Empleado','Online','2023-09-23 17:12:33'),(702,702,NULL,'Miembro','Offline','2021-05-06 16:34:05'),(703,703,NULL,'Miembro','Offline','2023-10-22 08:38:37'),(704,704,NULL,'Empleado','Online','2022-09-28 08:17:55'),(705,705,NULL,'Empleado','Offline','2023-10-02 19:33:53'),(706,706,NULL,'Visitante','Online','2023-12-03 12:31:53'),(707,707,NULL,'Miembro','Banned','2023-08-20 16:58:59'),(708,708,NULL,'Miembro','Offline','2023-03-20 08:44:06'),(709,709,NULL,'Visitante','Offline','2024-01-24 12:11:41'),(710,710,NULL,'Visitante','Offline','2023-11-23 13:32:13'),(711,711,NULL,'Miembro','Banned','2024-02-16 18:51:08'),(712,712,NULL,'Empleado','Online','2023-02-25 16:36:05'),(713,713,NULL,'Empleado','Offline','2022-07-28 12:42:56'),(714,714,NULL,'Empleado','Online','2023-05-02 18:42:52'),(715,715,NULL,'Miembro','Offline','2023-11-26 18:34:02'),(716,716,NULL,'Visitante','Offline','2022-07-02 14:09:16'),(717,717,NULL,'Visitante','Offline','2023-02-14 18:59:02'),(718,718,NULL,'Empleado','Banned','2022-07-15 08:53:28'),(719,719,NULL,'Visitante','Online','2022-06-15 18:24:01'),(720,720,NULL,'Miembro','Online','2023-08-29 09:57:07'),(721,721,NULL,'Instructor','Offline','2024-02-17 12:59:17'),(722,722,NULL,'Instructor','Banned','2023-12-31 09:30:07'),(723,723,NULL,'Instructor','Offline','2022-10-17 17:57:59'),(724,724,NULL,'Empleado','Offline','2023-09-14 17:14:25'),(725,725,NULL,'Instructor','Online','2023-12-09 09:27:13'),(726,726,NULL,'Visitante','Banned','2024-02-05 14:36:36'),(727,727,NULL,'Instructor','Banned','2022-04-13 18:34:45'),(728,728,NULL,'Instructor','Offline','2024-01-02 13:04:11'),(729,729,NULL,'Miembro','Online','2022-06-21 08:36:42'),(730,730,NULL,'Instructor','Offline','2020-07-01 18:33:32'),(731,731,NULL,'Miembro','Banned','2023-01-23 09:06:13'),(732,732,NULL,'Miembro','Online','2023-02-21 12:58:54'),(733,733,NULL,'Instructor','Banned','2024-01-23 12:16:21'),(734,734,NULL,'Instructor','Banned','2023-07-15 10:37:28'),(735,735,NULL,'Empleado','Banned','2022-08-02 17:04:27'),(736,736,NULL,'Instructor','Offline','2023-01-12 18:42:50'),(737,737,NULL,'Instructor','Banned','2023-11-24 10:23:27'),(738,738,NULL,'Instructor','Banned','2023-03-21 11:21:55'),(739,739,NULL,'Instructor','Online','2023-12-02 16:34:02'),(740,740,NULL,'Visitante','Offline','2023-12-18 14:01:55'),(741,741,NULL,'Instructor','Offline','2022-11-06 15:37:19'),(742,742,NULL,'Instructor','Online','2023-06-04 11:40:58'),(743,743,NULL,'Empleado','Online','2023-10-20 14:18:07'),(744,744,NULL,'Visitante','Offline','2022-12-16 11:20:04'),(745,745,NULL,'Miembro','Online','2023-03-12 17:34:42'),(746,746,NULL,'Miembro','Banned','2022-02-16 09:05:02'),(747,747,NULL,'Visitante','Banned','2020-11-07 16:33:49'),(748,748,NULL,'Miembro','Banned','2022-11-26 12:53:34'),(749,749,NULL,'Empleado','Offline','2022-11-11 14:29:15'),(750,750,NULL,'Instructor','Banned','2023-12-07 15:04:25'),(751,751,NULL,'Miembro','Online','2023-08-03 14:51:23'),(752,752,NULL,'Visitante','Online','2023-06-22 12:44:21'),(753,753,NULL,'Empleado','Online','2022-09-15 12:12:03'),(754,754,NULL,'Instructor','Offline','2022-10-19 09:17:16'),(755,755,NULL,'Empleado','Offline','2023-07-16 13:36:32'),(756,756,NULL,'Miembro','Offline','2020-11-27 09:14:17'),(757,757,NULL,'Empleado','Online','2023-06-24 09:51:28'),(758,758,NULL,'Visitante','Banned','2023-05-27 10:16:53'),(759,759,NULL,'Miembro','Online','2020-06-21 11:13:08'),(760,760,NULL,'Empleado','Banned','2023-05-18 09:34:02'),(761,761,NULL,'Visitante','Banned','2022-01-10 19:55:45'),(762,762,NULL,'Miembro','Online','2023-07-19 16:32:15'),(763,763,NULL,'Empleado','Offline','2022-10-02 19:19:18'),(764,764,NULL,'Miembro','Banned','2021-05-14 09:28:47'),(765,765,NULL,'Empleado','Online','2022-10-25 13:04:19'),(766,766,NULL,'Instructor','Online','2023-02-02 12:13:48'),(767,767,NULL,'Empleado','Online','2023-04-27 08:34:47'),(768,768,NULL,'Visitante','Offline','2023-04-05 19:40:59'),(769,769,NULL,'Visitante','Online','2021-07-27 15:22:26'),(770,770,NULL,'Empleado','Online','2023-04-13 10:50:42'),(771,771,NULL,'Miembro','Offline','2023-10-10 12:05:22'),(772,772,NULL,'Instructor','Banned','2024-02-23 10:10:39'),(773,773,NULL,'Empleado','Banned','2023-12-18 18:49:12'),(774,774,NULL,'Empleado','Banned','2024-02-01 17:10:27'),(775,775,NULL,'Visitante','Offline','2021-11-23 18:55:42'),(776,776,NULL,'Empleado','Online','2023-05-06 18:58:45'),(777,777,NULL,'Empleado','Offline','2023-03-09 18:20:41'),(778,778,NULL,'Miembro','Online','2022-06-11 11:25:25'),(779,779,NULL,'Instructor','Offline','2023-12-25 17:30:16'),(780,780,NULL,'Visitante','Offline','2020-12-19 09:51:28'),(781,781,NULL,'Empleado','Banned','2023-03-24 19:31:02'),(782,782,NULL,'Visitante','Online','2023-01-15 14:30:15'),(783,783,NULL,'Empleado','Offline','2024-02-19 13:57:13'),(784,784,NULL,'Miembro','Offline','2024-01-07 13:36:40'),(785,785,NULL,'Empleado','Offline','2023-10-15 11:29:45'),(786,786,NULL,'Instructor','Offline','2022-07-02 17:10:46'),(787,787,NULL,'Empleado','Banned','2023-06-25 18:38:21'),(788,788,NULL,'Empleado','Online','2023-11-13 15:23:11'),(789,789,NULL,'Miembro','Offline','2022-11-29 13:42:43'),(790,790,NULL,'Empleado','Banned','2023-06-29 13:35:37'),(791,791,NULL,'Visitante','Banned','2023-09-07 13:54:29'),(792,792,NULL,'Visitante','Online','2023-12-16 19:54:11'),(793,793,NULL,'Miembro','Offline','2022-04-21 14:12:46'),(794,794,NULL,'Miembro','Online','2021-10-23 18:35:33'),(795,795,NULL,'Instructor','Banned','2024-02-24 11:39:04'),(796,796,NULL,'Instructor','Banned','2023-11-24 18:56:37'),(797,797,NULL,'Visitante','Banned','2022-01-19 09:53:54'),(798,798,NULL,'Miembro','Banned','2024-01-21 14:12:47'),(799,799,NULL,'Empleado','Banned','2024-01-23 08:26:25'),(800,800,NULL,'Empleado','Offline','2022-10-22 16:00:38'),(801,801,NULL,'Instructor','Banned','2020-08-19 16:35:52'),(802,802,NULL,'Miembro','Offline','2023-11-12 13:23:16'),(803,803,NULL,'Miembro','Offline','2023-10-27 08:14:48'),(804,804,NULL,'Miembro','Online','2023-12-09 08:18:41'),(805,805,NULL,'Miembro','Offline','2022-05-11 18:42:15'),(806,806,NULL,'Miembro','Offline','2022-09-16 13:16:50'),(807,807,NULL,'Empleado','Offline','2023-08-27 17:36:11'),(808,808,NULL,'Empleado','Online','2023-09-20 10:16:26'),(809,809,NULL,'Miembro','Offline','2022-06-24 15:28:08'),(810,810,NULL,'Instructor','Online','2023-08-26 16:04:42'),(811,811,NULL,'Visitante','Offline','2023-12-15 13:55:32'),(812,812,NULL,'Miembro','Offline','2023-08-03 08:18:34'),(813,813,NULL,'Empleado','Online','2024-01-10 16:59:50'),(814,814,NULL,'Empleado','Offline','2024-01-09 10:17:26'),(815,815,NULL,'Visitante','Offline','2024-01-16 17:20:47'),(816,816,NULL,'Miembro','Banned','2024-01-18 14:25:27'),(817,817,NULL,'Empleado','Offline','2024-02-24 19:08:39'),(818,818,NULL,'Empleado','Online','2024-02-24 08:42:05'),(819,819,NULL,'Visitante','Online','2022-03-28 13:50:20'),(820,820,NULL,'Miembro','Offline','2024-02-27 17:02:31'),(821,821,NULL,'Instructor','Offline','2023-06-10 13:54:59'),(822,822,NULL,'Empleado','Offline','2023-07-25 14:01:34'),(823,823,NULL,'Empleado','Offline','2023-10-25 10:01:01'),(824,824,NULL,'Miembro','Online','2023-12-17 18:02:18'),(825,825,NULL,'Miembro','Offline','2022-09-27 13:50:03'),(826,826,NULL,'Empleado','Banned','2023-11-16 14:23:01'),(827,827,NULL,'Empleado','Banned','2021-07-18 16:12:39'),(828,828,NULL,'Empleado','Online','2023-01-07 12:43:00'),(829,829,NULL,'Instructor','Offline','2023-07-13 16:13:06'),(830,830,NULL,'Instructor','Banned','2021-08-13 08:08:10'),(831,831,NULL,'Empleado','Offline','2023-10-28 12:57:37'),(832,832,NULL,'Visitante','Offline','2022-11-06 14:32:57'),(833,833,NULL,'Instructor','Online','2024-02-02 11:36:36'),(834,834,NULL,'Visitante','Offline','2022-11-26 11:37:26'),(835,835,NULL,'Instructor','Offline','2024-02-09 09:25:09'),(836,836,NULL,'Visitante','Online','2024-02-22 10:15:40'),(837,837,NULL,'Empleado','Banned','2021-03-17 18:43:00'),(838,838,NULL,'Empleado','Banned','2023-04-28 19:08:42'),(839,839,NULL,'Instructor','Online','2022-09-24 13:00:16'),(840,840,NULL,'Visitante','Offline','2023-07-14 17:22:53'),(841,841,NULL,'Instructor','Banned','2023-06-14 17:36:20'),(842,842,NULL,'Visitante','Offline','2024-01-30 13:00:07'),(843,843,NULL,'Empleado','Offline','2021-09-17 17:09:27'),(844,844,NULL,'Miembro','Banned','2022-06-15 13:16:44'),(845,845,NULL,'Empleado','Online','2024-01-15 11:04:54'),(846,846,NULL,'Miembro','Offline','2022-05-29 10:35:23'),(847,847,NULL,'Miembro','Online','2023-08-27 10:00:52'),(848,848,NULL,'Miembro','Offline','2021-08-26 19:48:22'),(849,849,NULL,'Empleado','Banned','2021-12-30 19:55:26'),(850,850,NULL,'Visitante','Online','2022-03-10 13:14:11'),(851,851,NULL,'Instructor','Offline','2023-08-26 18:51:19'),(852,852,NULL,'Visitante','Offline','2023-09-12 09:42:32'),(853,853,NULL,'Miembro','Banned','2022-08-08 19:06:36'),(854,854,NULL,'Instructor','Online','2023-05-23 19:23:11'),(855,855,NULL,'Instructor','Banned','2022-06-04 15:17:55'),(856,856,NULL,'Instructor','Online','2022-05-25 10:26:44'),(857,857,NULL,'Instructor','Offline','2020-08-17 18:46:20'),(858,858,NULL,'Instructor','Banned','2021-06-17 13:22:18'),(859,859,NULL,'Instructor','Online','2023-07-30 15:53:53'),(860,860,NULL,'Empleado','Offline','2021-01-23 09:11:13'),(861,861,NULL,'Visitante','Offline','2024-01-08 18:25:36'),(862,862,NULL,'Empleado','Banned','2022-06-14 19:50:26'),(863,863,NULL,'Empleado','Online','2024-02-10 11:51:29'),(864,864,NULL,'Miembro','Offline','2024-02-27 19:07:18'),(865,865,NULL,'Empleado','Online','2023-12-31 11:39:51'),(866,866,NULL,'Empleado','Offline','2023-08-28 16:20:15'),(867,867,NULL,'Instructor','Online','2021-09-20 13:46:06'),(868,868,NULL,'Instructor','Online','2024-01-27 15:01:47'),(869,869,NULL,'Visitante','Banned','2021-11-03 13:25:32'),(870,870,NULL,'Empleado','Online','2023-11-30 17:00:20'),(871,871,NULL,'Instructor','Offline','2021-04-11 16:10:15'),(872,872,NULL,'Empleado','Offline','2022-06-02 15:36:48'),(873,873,NULL,'Empleado','Offline','2023-12-15 19:18:40'),(874,874,NULL,'Empleado','Online','2024-02-27 17:12:35'),(875,875,NULL,'Visitante','Offline','2021-10-25 09:22:53'),(876,876,NULL,'Empleado','Banned','2022-03-23 19:53:49'),(877,877,NULL,'Empleado','Offline','2022-10-24 13:24:49'),(878,878,NULL,'Visitante','Banned','2023-04-14 15:30:54'),(879,879,NULL,'Visitante','Banned','2022-08-29 11:42:16'),(880,880,NULL,'Empleado','Banned','2023-06-27 11:48:05'),(881,881,NULL,'Instructor','Banned','2023-07-18 11:03:34'),(882,882,NULL,'Visitante','Banned','2021-01-22 19:51:06'),(883,883,NULL,'Instructor','Online','2023-04-13 15:10:06'),(884,884,NULL,'Empleado','Banned','2022-07-21 12:44:54'),(885,885,NULL,'Visitante','Banned','2024-01-03 08:24:12'),(886,886,NULL,'Instructor','Online','2022-01-28 12:49:38'),(887,887,NULL,'Empleado','Banned','2023-02-19 17:19:55'),(888,888,NULL,'Empleado','Online','2023-06-01 14:38:37'),(889,889,NULL,'Empleado','Banned','2023-05-28 10:57:34'),(890,890,NULL,'Visitante','Online','2023-12-10 18:43:30'),(891,891,NULL,'Instructor','Banned','2021-06-05 15:33:44'),(892,892,NULL,'Instructor','Offline','2023-03-17 11:39:42'),(893,893,NULL,'Visitante','Banned','2021-10-06 10:33:49'),(894,894,NULL,'Visitante','Online','2024-01-10 16:41:26'),(895,895,NULL,'Miembro','Offline','2022-11-14 18:11:54'),(896,896,NULL,'Miembro','Banned','2021-07-01 11:52:03'),(897,897,NULL,'Empleado','Online','2022-09-26 18:58:01'),(898,898,NULL,'Miembro','Online','2023-08-29 13:33:39'),(899,899,NULL,'Empleado','Banned','2024-01-13 11:40:55'),(900,900,NULL,'Visitante','Banned','2022-09-07 09:07:46'),(901,901,NULL,'Empleado','Online','2024-02-09 16:24:10'),(902,902,NULL,'Empleado','Online','2024-02-19 17:55:40'),(903,903,NULL,'Miembro','Online','2022-02-12 17:36:49'),(904,904,NULL,'Miembro','Offline','2020-07-10 11:28:33'),(905,905,NULL,'Visitante','Banned','2022-10-09 10:58:01'),(906,906,NULL,'Visitante','Offline','2022-02-23 12:49:05'),(907,907,NULL,'Visitante','Banned','2023-07-16 09:57:43'),(908,908,NULL,'Visitante','Banned','2024-01-26 18:17:56'),(909,909,NULL,'Instructor','Banned','2022-09-18 16:36:18'),(910,910,NULL,'Empleado','Banned','2022-11-06 14:34:44'),(911,911,NULL,'Visitante','Banned','2024-02-24 19:32:29'),(912,912,NULL,'Visitante','Banned','2023-11-18 08:30:05'),(913,913,NULL,'Empleado','Online','2023-07-29 08:41:17'),(914,914,NULL,'Empleado','Banned','2020-01-15 19:18:34'),(915,915,NULL,'Visitante','Offline','2022-12-24 18:06:44'),(916,916,NULL,'Visitante','Online','2023-04-01 11:38:18'),(917,917,NULL,'Empleado','Offline','2022-04-06 12:59:06'),(918,918,NULL,'Instructor','Banned','2023-08-14 08:56:05'),(919,919,NULL,'Instructor','Online','2022-01-21 10:25:46'),(920,920,NULL,'Miembro','Offline','2023-01-25 16:14:11'),(921,921,NULL,'Empleado','Online','2023-05-24 15:09:38'),(922,922,NULL,'Instructor','Online','2023-06-05 08:22:31'),(923,923,NULL,'Miembro','Banned','2023-01-06 15:11:23'),(924,924,NULL,'Visitante','Offline','2023-10-27 11:08:58'),(925,925,NULL,'Visitante','Online','2021-03-28 14:25:05'),(926,926,NULL,'Instructor','Offline','2023-06-04 08:21:47'),(927,927,NULL,'Visitante','Banned','2024-02-19 19:28:05'),(928,928,NULL,'Miembro','Online','2024-02-16 18:06:06'),(929,929,NULL,'Empleado','Offline','2023-11-20 08:17:58'),(930,930,NULL,'Visitante','Online','2023-06-18 14:50:38'),(931,931,NULL,'Miembro','Online','2023-08-03 19:02:49'),(932,932,NULL,'Empleado','Online','2024-01-12 09:19:59'),(933,933,NULL,'Visitante','Online','2022-05-28 10:39:16'),(934,934,NULL,'Visitante','Offline','2023-06-23 08:16:46'),(935,935,NULL,'Miembro','Banned','2024-02-19 11:57:34'),(936,936,NULL,'Empleado','Online','2022-04-18 19:55:46'),(937,937,NULL,'Visitante','Banned','2022-03-03 13:25:27'),(938,938,NULL,'Miembro','Online','2024-02-15 15:51:11'),(939,939,NULL,'Miembro','Offline','2022-05-19 18:48:12'),(940,940,NULL,'Miembro','Online','2024-01-15 12:10:39'),(941,941,NULL,'Miembro','Offline','2023-08-16 12:11:48'),(942,942,NULL,'Empleado','Online','2022-09-03 12:18:39'),(943,943,NULL,'Empleado','Banned','2022-02-14 14:54:51'),(944,944,NULL,'Miembro','Banned','2021-09-09 09:55:11'),(945,945,NULL,'Miembro','Banned','2022-08-03 13:18:45'),(946,946,NULL,'Empleado','Online','2022-11-17 18:16:52'),(947,947,NULL,'Empleado','Offline','2021-11-13 10:07:56'),(948,948,NULL,'Visitante','Offline','2023-08-08 10:39:08'),(949,949,NULL,'Instructor','Banned','2020-07-25 13:15:14'),(950,950,NULL,'Instructor','Offline','2024-02-19 16:58:43'),(951,951,NULL,'Miembro','Offline','2023-06-27 12:18:10'),(952,952,NULL,'Instructor','Online','2023-12-12 16:58:43'),(953,953,NULL,'Miembro','Banned','2023-05-23 08:50:57'),(954,954,NULL,'Miembro','Online','2023-08-17 12:34:14'),(955,955,NULL,'Miembro','Online','2023-01-17 10:11:17'),(956,956,NULL,'Instructor','Online','2021-09-08 18:39:02'),(957,957,NULL,'Visitante','Online','2024-02-07 09:50:17'),(958,958,NULL,'Visitante','Offline','2023-09-06 12:35:31'),(959,959,NULL,'Miembro','Online','2023-06-01 16:28:02'),(960,960,NULL,'Miembro','Offline','2023-04-10 13:03:54'),(961,961,NULL,'Empleado','Offline','2023-11-25 11:02:10'),(962,962,NULL,'Miembro','Banned','2023-04-13 18:08:39'),(963,963,NULL,'Empleado','Banned','2022-06-08 09:35:54'),(964,964,NULL,'Empleado','Online','2024-02-18 14:10:24'),(965,965,NULL,'Miembro','Banned','2024-02-24 11:11:26'),(966,966,NULL,'Empleado','Offline','2022-10-11 19:50:30'),(967,967,NULL,'Instructor','Online','2023-04-07 12:38:59'),(968,968,NULL,'Miembro','Banned','2023-12-29 12:21:58'),(969,969,NULL,'Instructor','Banned','2022-11-21 13:50:46'),(970,970,NULL,'Miembro','Online','2023-03-16 13:22:47'),(971,971,NULL,'Empleado','Banned','2023-03-21 18:24:56'),(972,972,NULL,'Empleado','Online','2022-10-03 16:47:12'),(973,973,NULL,'Instructor','Banned','2022-02-23 09:36:26'),(974,974,NULL,'Empleado','Online','2023-02-06 19:31:22'),(975,975,NULL,'Empleado','Online','2022-02-11 16:38:26'),(976,976,NULL,'Empleado','Banned','2023-03-20 09:59:11'),(977,977,NULL,'Instructor','Banned','2023-10-30 11:05:00'),(978,978,NULL,'Instructor','Banned','2022-06-07 08:26:26'),(979,979,NULL,'Miembro','Offline','2023-12-30 17:23:24'),(980,980,NULL,'Miembro','Offline','2023-10-11 18:44:14'),(981,981,NULL,'Instructor','Banned','2020-12-10 11:15:04'),(982,982,NULL,'Empleado','Online','2023-09-28 14:32:57'),(983,983,NULL,'Instructor','Online','2023-03-04 16:44:16'),(984,984,NULL,'Visitante','Online','2022-12-27 19:53:34'),(985,985,NULL,'Instructor','Online','2021-10-18 17:08:32'),(986,986,NULL,'Miembro','Offline','2022-06-25 17:02:06'),(987,987,NULL,'Instructor','Banned','2023-05-14 09:23:56'),(988,988,NULL,'Instructor','Offline','2024-02-15 13:25:37'),(989,989,NULL,'Empleado','Offline','2020-06-24 16:51:43'),(990,990,NULL,'Instructor','Online','2023-12-22 14:49:56'),(991,991,NULL,'Empleado','Online','2023-04-12 13:19:57'),(992,992,NULL,'Visitante','Banned','2023-11-13 14:23:58'),(993,993,NULL,'Empleado','Offline','2023-08-31 18:45:04'),(994,994,NULL,'Instructor','Online','2023-09-30 11:37:55'),(995,995,NULL,'Visitante','Banned','2023-02-12 19:50:31'),(996,996,NULL,'Instructor','Banned','2023-11-09 12:41:18'),(997,997,NULL,'Visitante','Offline','2023-05-30 16:43:08'),(998,998,NULL,'Empleado','Online','2023-11-20 15:38:05'),(999,999,NULL,'Visitante','Offline','2022-12-23 12:47:47'),(1000,1000,NULL,'Instructor','Online','2022-10-19 10:39:34'),(1001,1001,NULL,'Empleado','Online','2022-10-14 12:20:56'),(1002,1002,NULL,'Miembro','Online','2023-11-09 11:01:33'),(1003,1003,NULL,'Miembro','Offline','2023-05-10 09:08:03'),(1004,1004,NULL,'Visitante','Online','2023-04-23 17:09:51'),(1005,1005,NULL,'Miembro','Banned','2022-03-22 12:41:35'),(1006,1006,NULL,'Miembro','Online','2021-01-16 13:02:15'),(1007,1007,NULL,'Miembro','Online','2022-06-10 18:56:57'),(1008,1008,NULL,'Empleado','Offline','2023-06-12 17:20:13'),(1009,1009,NULL,'Instructor','Offline','2023-09-18 09:34:51'),(1010,1010,NULL,'Empleado','Online','2023-11-08 14:51:34'),(1011,1011,NULL,'Empleado','Online','2023-09-27 12:57:35'),(1012,1012,NULL,'Instructor','Banned','2023-10-16 12:35:40'),(1013,1013,NULL,'Visitante','Banned','2023-10-22 14:10:20'),(1014,1014,NULL,'Empleado','Online','2023-06-09 16:31:43'),(1015,1015,NULL,'Miembro','Online','2024-01-15 17:39:21'),(1016,1016,NULL,'Miembro','Online','2023-03-18 10:57:13'),(1017,1017,NULL,'Instructor','Offline','2022-01-28 12:37:51'),(1018,1018,NULL,'Empleado','Online','2023-10-04 14:46:37'),(1019,1019,NULL,'Empleado','Offline','2020-10-25 15:30:13'),(1020,1020,NULL,'Visitante','Online','2024-01-22 17:48:17'),(1021,1021,NULL,'Visitante','Online','2023-10-21 16:12:08'),(1022,1022,NULL,'Instructor','Offline','2023-04-01 11:02:47'),(1023,1023,NULL,'Miembro','Banned','2024-02-16 14:15:10'),(1024,1024,NULL,'Miembro','Banned','2023-07-12 08:41:12');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `usuarios_AFTER_INSERT` AFTER INSERT ON `usuarios` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_usuario varchar(60) default null;

    -- Iniciación de las variables
    if new.nombre_usuario is not null then
        -- En caso de tener el id del usuario debemos recuperar su nombre
        set v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.nombre_usuario);
    else
        SET v_nombre_usuario = "Sin usuario asignado";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "usuarios",
        CONCAT_WS(" ","Se ha insertado un nuevo USUARIO con el ID: ",NEW.persona_id, 
        "con los siguientes datos: ",
        "NOMBRE USUARIO= ", v_nombre_usuario,
        "PASSWORD = ", NEW.password,
        "TIPO = ", NEW.tipo,
        "ESTATUS CONEXIÓN = ", NEW.estatus_conexion,
        "ULTIMA CONEXIÓN = ", NEW.ultima_conexion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `usuarios_AFTER_UPDATE` AFTER UPDATE ON `usuarios` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_usuario varchar(60) default null;
    DECLARE v_nombre_usuario2 varchar(60) default null;

    -- Iniciación de las variables
    if new.nombre_usuario is not null then
        -- En caso de tener el id del usuario debemos recuperar su nombre
        set v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.nombre_usuario);
    else
        SET v_nombre_usuario = "Sin usuario asignado";
    end if;
    
    IF OLD.nombre_usuario IS NOT NULL THEN 
		-- En caso de tener el id del usuario debemos recuperar su nombre
		SET v_nombre_usuario2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_apellido) FROM personas p WHERE id = OLD.nombre_usuario);
    ELSE
		SET v_nombre_usuario2 = "Sin responsable asignado.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "usuarios",
        CONCAT_WS(" ","Se han actualizado los datos del USUARIO con el ID: ",
        NEW.persona_id, "con los siguientes datos:",
        "NOMBRE USUARIO = ", v_nombre_usuario2, "cambio a", v_nombre_usuario,
        "PASSWORD =",OLD.password,"cambio a", NEW.password,
        "TIPO = ", OLD.tipo, "cambio a", NEW.tipo,
        "ESTATUS CONEXIÓN = ", OLD.estatus_conexion, "cambio a", NEW.estatus_conexion,
        "ULTIMA CONEXIÓN = ", OLD.ultima_conexion, "cambio a", NEW.ultima_conexion),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `usuarios_AFTER_DELETE` AFTER DELETE ON `usuarios` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "usuarios",
        CONCAT_WS(" ","Se ha eliminado un USUARIO con el ID: ", OLD.persona_id),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `vw_clientes_empleados_por_genero`
--

DROP TABLE IF EXISTS `vw_clientes_empleados_por_genero`;
/*!50001 DROP VIEW IF EXISTS `vw_clientes_empleados_por_genero`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_clientes_empleados_por_genero` AS SELECT 
 1 AS `Tipo`,
 1 AS `genero`,
 1 AS `Total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_genero_por_edad`
--

DROP TABLE IF EXISTS `vw_genero_por_edad`;
/*!50001 DROP VIEW IF EXISTS `vw_genero_por_edad`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_genero_por_edad` AS SELECT 
 1 AS `Genero`,
 1 AS `Total`,
 1 AS `Rango`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_membresias_genero`
--

DROP TABLE IF EXISTS `vw_membresias_genero`;
/*!50001 DROP VIEW IF EXISTS `vw_membresias_genero`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_membresias_genero` AS SELECT 
 1 AS `tipo`,
 1 AS `genero`,
 1 AS `count(*)`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_personas_por_genero`
--

DROP TABLE IF EXISTS `vw_personas_por_genero`;
/*!50001 DROP VIEW IF EXISTS `vw_personas_por_genero`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_personas_por_genero` AS SELECT 
 1 AS `genero`,
 1 AS `Total`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'bd_gimnasio_integradora'
--

--
-- Dumping routines for database 'bd_gimnasio_integradora'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_calcular_fin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_calcular_fin`(fecha_inicio DATETIME, v_tipo_plan VARCHAR(255)) RETURNS datetime
    DETERMINISTIC
BEGIN
  DECLARE fecha_final DATETIME;

  SET fecha_final = 
    CASE v_tipo_plan
      WHEN "Anual" THEN DATE_ADD(fecha_inicio, INTERVAL 1 YEAR)
      WHEN "Semestral" THEN DATE_ADD(fecha_inicio, INTERVAL 6 MONTH)
      WHEN "Trimestral" THEN DATE_ADD(fecha_inicio, INTERVAL 3 MONTH)
      WHEN "Bimestral" THEN DATE_ADD(fecha_inicio, INTERVAL 2 MONTH)
      WHEN "Mensual" THEN DATE_ADD(fecha_inicio, INTERVAL 1 MONTH)
      WHEN "Semanal" THEN DATE_ADD(fecha_inicio, INTERVAL 1 WEEK)
      WHEN "Diaria" THEN DATE_ADD(fecha_inicio, INTERVAL 1 DAY)
      ELSE fecha_inicio
    END;

  RETURN fecha_final;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_calcula_antiguedad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_calcula_antiguedad`(fecha DATE) RETURNS varchar(200) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE fecha_actual date;
    DECLARE anios INT;
    DECLARE meses INT;
    DECLARE semanas INT;
    DECLARE dias INT;
    DECLARE edad VARCHAR(200);
    
    -- Obtenemos la fecla actual
    SET fecha_actual = CURDATE();
    
    -- Calculamos la diferencia en años, mese, semanas, y dias
    SET anios = TIMESTAMPDIFF(YEAR, fecha, fecha_actual);
    SET meses = TIMESTAMPDIFF(MONTH, fecha, fecha_actual) - (12 * anios);
    SET dias = DATEDIFF(fecha_actual, DATE_ADD(fecha, INTERVAL anios YEAR) + INTERVAL meses MONTH);
    SET semanas = dias / 7;
    SET dias = dias % 7;
    
    -- Construimos el mensaje de la edad
    SET edad = concat_ws(" ", anios, "años, ", meses, "meses, ", semanas, "semanas y ", dias, "dias");
RETURN edad;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_calcula_edad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_calcula_edad`(v_fecha_nacimiento DATE) RETURNS int
    DETERMINISTIC
BEGIN

RETURN timestampdiff(year, v_fecha_nacimiento, CURDATE());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_generar_codigo_aleatorio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_generar_codigo_aleatorio`(longitud INT) RETURNS varchar(255) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
  DECLARE codigo_aleatorio VARCHAR(255) DEFAULT '';
  DECLARE caracteres VARCHAR(62) DEFAULT '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  DECLARE i INT DEFAULT 0;
  
  WHILE i < longitud DO
    SET codigo_aleatorio = CONCAT(codigo_aleatorio, SUBSTRING(caracteres, FLOOR(RAND() * LENGTH(caracteres)) + 1, 1));
    SET i = i + 1;
  END WHILE;
  
  RETURN codigo_aleatorio;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_generar_contrasena_aleatoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_generar_contrasena_aleatoria`() RETURNS blob
    DETERMINISTIC
BEGIN
	DECLARE v_contrasena VARCHAR(255);
    DECLARE v_contrasena_blob BLOB;
  
	-- Genera una contraseña aleatoria
	SET v_contrasena = SUBSTRING(MD5(RAND()) FROM 1 FOR 8);

	-- Convierte la contraseña a BLOB
	SET v_contrasena_blob = UNHEX(SHA2(v_contrasena, 256));
RETURN v_contrasena_blob;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_Apellido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_Apellido`() RETURNS varchar(60) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE v_apellido_generado varchar(60) default null; 
	SET v_apellido_generado = ELT (fn_numero_aleatorio_rangos(1,50),
	"Hernández","García", "Martínez", "López"," González",
	"Pérez","Rodríguez", "Sánchez", "Ramírez","Cruz",
	"Cortes","Gómes","Morales", "Vázquez","Reyes",
	"Jiménez","Torres","Díaz", "Gutiérrez","Ruíz",
	"Mendoza","Aguilar","Ortiz","Moreno","Castillo",
	"Romero","Álvarez", "Méndez", "Chávez"," Rivera",
	"Juárez","Ramos", "Domínguez", "Herrera","Medina",
	"Castro","Vargas","Guzmán", "Velázquez","De la Cruz",
	"Contreras","Salazar","Luna", "Ortega","Santiago",
	"Guerrero","Estrada","Bautista","Cortés","Soto");
RETURN v_apellido_generado;
RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_bandera_porcentaje` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_bandera_porcentaje`(porcentaje int) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	DECLARE num_generado int default 0;
    DECLARE bandera BOOLEAN;
	set num_generado = fn_numero_aleatorio_rangos(0, 100);
    
    if  num_generado <= porcentaje then
		set bandera = true;
	else 
		set bandera = false;
	end if;
 return bandera;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_fecha` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_fecha`(fecha_inicio date, fecha_fin date) RETURNS date
    DETERMINISTIC
BEGIN
	DECLARE dia int default null; 
	DECLARE mes int default null; 
	DECLARE anio int default null; 
	DECLARE fecha date default null;
    SET dia = fn_numero_aleatorio_rangos (EXTRACT(DAY FROM fecha_inicio),EXTRACT(DAY FROM fecha_fin));
    SET mes = fn_numero_aleatorio_rangos (EXTRACT(MONTH  FROM fecha_inicio),EXTRACT(MONTH  FROM fecha_fin));
    SET anio = fn_numero_aleatorio_rangos (EXTRACT(YEAR  FROM fecha_inicio),EXTRACT(YEAR  FROM fecha_fin));
    set fecha = concat(anio,'-',mes,'-',dia);
RETURN fecha;
RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_fecha_nacimiento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_fecha_nacimiento`(fecha_inicio date, fecha_fin date) RETURNS date
    DETERMINISTIC
BEGIN
	DECLARE min_dias INT;
    DECLARE max_dias INT;
    DECLARE dias_aleatorios INT;
    DECLARE fecha_aleatoria DATE;
    
    set min_dias = datediff(fecha_inicio, '1900-01-01');
    set max_dias = datediff(fecha_fin, '1900-01-01');
    set dias_aleatorios = fn_numero_aleatorio_rangos(min_dias, max_dias);
    set fecha_aleatoria = date_add( '1900-01-01', interval dias_aleatorios DAY);
RETURN fecha_aleatoria;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_fecha_registro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_fecha_registro`(fechaInicio date, fechaFin date, horaInicio time, horaFin time) RETURNS datetime
    DETERMINISTIC
BEGIN
	DECLARE fechaAleatoria DATE;
	DECLARE horaEntrada time;
    DECLARE horaSalida time;   
	DECLARE horaRegistro time;
	DECLARE fechaHoraGenerada datetime;
    
    SET fechaAleatoria = date_add(fechaInicio, INTERVAL floor(rand() * (datediff(fechaFin, fechaInicio) + 1)) DAY);
    
    SET horaRegistro = addtime(horaInicio, SEC_TO_TIME(FLOOR(RAND() * TIME_TO_SEC(TIMEDIFF(horaFin, horaInicio)))));
    
    set fechaHoraGenerada = concat(fechaAleatoria, " ", horaRegistro);
RETURN fechaHoraGenerada;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_nombre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_nombre`(v_genero CHAR(1)) RETURNS varchar(60) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE v_nombre_generado varchar(60) default null; 
	if v_genero = 'M' THEN 
		SET v_nombre_generado = ELT (fn_numero_aleatorio_rangos(1,25),
        "Marco","Juan", "Pedro", "Alejandro"," Agustin",
        "Ricardo","Gustavo", "Gerardo", "Hugo","Adalid",
        "Mario","Jesus","Yair", "Adan","Maximiliano",
        "Aldair","José","Edgar", "Jorge","Iram",
        "Carlos","Federico","Fernando","Samuel","Daniel");
	else
		SET v_nombre_generado = ELT (fn_numero_aleatorio_rangos(1,25),
        "Lorena","Maria","Luz", "Dulce","Suri",
        "Ameli","Ana","Karla","Carmen","Alondra",
        "Bertha", "Diana","Jazmin","Hortencia", "Guadalupe",
        "Estrella","Monica", "Paola","Brenda", "Flor",
        "Lucía","Sofia","Paula","Valeria","Esmeralda");
	END IF;
RETURN v_nombre_generado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_sangre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_sangre`() RETURNS varchar(10) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE v_sangre_generado varchar(10) default null; 
	SET v_sangre_generado = ELT (fn_numero_aleatorio_rangos(1,8),
	"A+","A-","B+","B-","AB+","AB-","O+","O-");
RETURN v_sangre_generado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_titulo_cortesia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_titulo_cortesia`(v_genero CHAR(1) ) RETURNS varchar(20) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
-- función de insertar personas
	declare  v_titulo varchar(20) default null;
    
	if v_genero = 'M' then
		set v_titulo = ELT(fn_numero_aleatorio_rangos(1,10), 
		"Ing.","Sr.", "Joven","Mtro.","Lic.",
		"Med.", "Sgto.", "Tnte.", "C.", "C.P.");
	else
		set v_titulo = ELT(fn_numero_aleatorio_rangos(1,10), 
		"Sra.","Srita", "Dra.","Mtra","Med.",
		"Ing.", "Lic.", "C.", "C.P.", "Pfra");
	end if;
	

RETURN v_titulo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_vandera_porcentaje` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_vandera_porcentaje`(porcentaje int) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	DECLARE num_generado int default 0;
    DECLARE bandera BOOLEAN;
	set num_generado = fn_numero_aleatorio_rangos(0, 100);
    
    if  num_generado <= porcentaje then
		set bandera = true;
	else 
		set bandera = false;
	end if;
 return bandera;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_numero_aleatorio_rangos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_numero_aleatorio_rangos`(v_limite_inferior int, v_limite_superior int) RETURNS int
    DETERMINISTIC
BEGIN	
	declare v_numero_generado INT 
    default floor(Rand()* (v_limite_superior - v_limite_inferior + 1) + v_limite_inferior);
    SET @numero_generado = v_numero_generado;
RETURN v_numero_generado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `Saludar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `Saludar`() RETURNS varchar(50) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE saludo VARCHAR(50);
	SET saludo = '¡Hola!';
	RETURN saludo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `SaludarHora` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `SaludarHora`(nombre VARCHAR(50)) RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE hora INT;
    DECLARE saludo VARCHAR(100);
    
    SET hora = HOUR(now());
	IF hora >= 6 AND hora< 12 THEN
        SET saludo = CONCAT('¡Buenos días ', nombre,'!');
    ELSEIF hora >= 12 AND hora < 18 THEN
        SET saludo = CONCAT('¡Buenas tardes ', nombre,'!');
    ELSE
        SET saludo = CONCAT('¡Buenas noches ', nombre,'!');
    END IF;
    RETURN saludo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `SaludarHoraEspecifica` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `SaludarHoraEspecifica`(nombre VARCHAR(50), hora TIME) RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE saludo VARCHAR(100);
    IF HOUR(hora) >= 6 AND HOUR(hora) < 12 THEN
        SET saludo = CONCAT('¡Buenos días ', nombre,'!');
    ELSEIF HOUR(hora) >= 12 AND HOUR(hora) < 18 THEN
        SET saludo = CONCAT('¡Buenas tardes ', nombre,'!');
    ELSE
        SET saludo = CONCAT('¡Buenas noches ', nombre,'!');
    END IF;
    RETURN saludo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `SaludarNombre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `SaludarNombre`(nombre VARCHAR(50)) RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE saludo VARCHAR(100);
    SET saludo = CONCAT('¡Hola ', nombre, '! ');
    RETURN saludo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_estatus_bd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_estatus_bd`(v_password varchar(10))
    DETERMINISTIC
BEGIN
	if v_password = "abcde" then 
		(SELECT "areas" as Tabla, "Débil, Catálogo", (SELECT COUNT(*) FROM areas) as Total_Registros)
        UNION
        (SELECT "detalles_pedidos" as Tabla, "Débil, Derivada", (SELECT COUNT(*) FROM detalles_pedidos))
        UNION
        (SELECT "detalles_programas_saludables" as Tabla, "Débil, Derivada", (SELECT COUNT(*) FROM detalles_programas_saludables))
        UNION
        (SELECT "dietas" as Tabla, "Devil", (SELECT COUNT(*) FROM dietas))
        UNION
        (SELECT "ejercicios" as Tabla, "Fuerte, Catálogo", (SELECT COUNT(*) FROM ejercicios))
        UNION
        (SELECT "empleados" as Tabla, "Débil", (SELECT COUNT(*) FROM empleados))
        UNION
        (SELECT "equipos" as Tabla, "Débil, Derivada", (SELECT COUNT(*) FROM equipos))
        UNION
        (SELECT "equipos_existencias" as Tabla, "Débil, Derivada", (SELECT COUNT(*) FROM equipos_existencias))
        UNION
        (SELECT "instructores" as Tabla, "Débil", (SELECT COUNT(*) FROM instructores))
        UNION
        (SELECT "membresias_usuarios" as Tabla, "Débil, Derivada", (SELECT COUNT(*) FROM membresias_usuarios))
        UNION
        (SELECT "membresias" as Tabla, "Débil", (SELECT COUNT(*) FROM membresias))
        UNION
        (SELECT "miembros" as Tabla, "Débil", (SELECT COUNT(*) FROM miembros))
        UNION
        (SELECT "pedidos" as Tabla, "Débil", (SELECT COUNT(*) FROM pedidos))
        UNION
        (SELECT "personas" as Tabla, "Fuerte", (SELECT COUNT(*) FROM personas))
        UNION
        (SELECT "productos" as Tabla, "Fuerte", (SELECT COUNT(*) FROM productos))
        UNION
        (SELECT "programas_saludables" as Tabla, "Débil", (SELECT COUNT(*) FROM programas_saludables))
        UNION
        (SELECT "rutinas" as Tabla, "Débil", (SELECT COUNT(*) FROM rutinas))
        UNION
        (SELECT "rutinas_ejercicios" as Tabla, "Débil, Derivada", (SELECT COUNT(*) FROM rutinas_ejercicios))
        UNION
        (SELECT "sucursales" as Tabla, "Débil, Catálogo", (SELECT COUNT(*) FROM sucursales))
        UNION
        (SELECT "usuarios" as Tabla, "Débil", (SELECT COUNT(*) FROM usuarios))
        UNION
        (SELECT "bitacora" as Tabla, "Isla", (SELECT COUNT(*) FROM bitacora));
	else
		select "La contraseña es incorrecta, no puedo mostrar el estatus de la BD" as Mensaje;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_empleados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_empleados`(v_cuantos int, v_tipo varchar(15))
BEGIN
	DECLARE i INT default 1;
    DECLARE v_id_persona INT;
    DECLARE v_id_sucursal INT;
	DECLARE v_pos_sucursal INT DEFAULT 0;
    -- debemos conocer el total de sucursales activas
	DECLARE v_total_sucursales INT DEFAULT (select count(*) FROM sucursales WHERE estatus = b'1');
    
    DECLARE v_id_area INT;
    DECLARE v_pos_area INT DEFAULT 0;
    -- 
    DECLARE v_total_areas INT default null;
    DECLARE v_numero_empleados_sucursal INT default null;
	
    -- Para elegir a la sucursal a la que se le dasignara
    while i <= v_cuantos do
		-- Insertar los datos del la persona
        SET v_tipo = null;
        call sp_inserta_personas(1);
        set v_id_persona = last_insert_id();
        
        -- Determina la sucursal a la que pertenece el empleado
        sucursal:LOOP
        if v_total_sucursales > 1 then
			set v_pos_sucursal  = fn_numero_aleatorio_rangos(0, v_total_sucursales-1);
            SET v_id_sucursal = (SELECT id FROM sucursales LIMIT v_pos_sucursal,1);
            
            -- como ya se que sucursal, calcular el area a ala que le trabaja
            SET v_total_areas = (SELECT count(*) FROM areas WHERE sucursal_id = v_id_sucursal AND estatus = b'1');
            -- calcular el total de empleados de la sucursal
            SET v_numero_empleados_sucursal = (SELECT COUNT(*) FROM empleados WHERE sucursal_id = v_id_sucursal);
            
            -- si la sucursal no tiene areas, elegir una de las de la matriz
            IF v_total_areas = 0 THEN 
				set v_total_areas = (SELECT COUNT(*) FROM areas WHERE sucursal_id = 1 AND estatus = b'1');
                SET v_pos_area = fn_numero_aleatorio_rangos(0,v_total_areas-1);
                SET v_id_area = (SELECT id FROM areas WHERE  sucursal_id = 1 LIMIT v_pos_area,1);
            ELSE
				SET v_pos_area = fn_numero_aleatorio_rangos(0,v_total_areas-1);
                SET v_id_area = (SELECT id FROM areas WHERE  sucursal_id = v_id_sucursal LIMIT v_pos_area,1);
            END IF;
            LEAVE sucursal;
		ELSE 
			SELECT ("Al menos debería existir 1 sucursal") as MensajeError;
            LEAVE sucursal;
        end if;
        end loop;
        
        -- En caso de que no se diga que tipo de empleado creamos, se elige uno aleatorio
        if v_tipo IS NULL THEN
			set v_tipo = ELT(fn_numero_aleatorio_rangos(1,5), "Instructor","Administrativo","Intendecia", "Area Medicá","Directivo");
        END IF;
        
        -- Ya que se tiene todos los datos del trabajador insertar en la subentidad
        INSERT INTO empleados VALUES(v_id_persona,
									 v_tipo,
                                     v_id_area,
                                     v_numero_empleados_sucursal+1,
                                     v_id_sucursal,
                                     fn_genera_fecha_registro("2015-01-01", CURDATE(), "08:00:00", "20:00:00"));
        
		set i = i+1;
    end while;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_membresias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_membresias`(v_cuantos INT, v_tipo varchar(20))
    DETERMINISTIC
BEGIN
	 -- Declaración de variables
    DECLARE i INT default 1;
    DECLARE v_id_persona INT;
	DECLARE v_lim_miembros INT;
    DECLARE v_id_membresia INT;
    DECLARE v_tipo_servicios VARCHAR(10);
    DECLARE v_tipo_plan VARCHAR(10);
    DECLARE v_nivel VARCHAR(10);
    DECLARE v_codigo varchar(50);
    DECLARE v_aleatorio BIT DEFAULT b'0';
    DECLARE v_fecha_inicio datetime default NULL;
    DECLARE v_fecha_fin DATETIME default NULL;
    DECLARE v_fecha_registro DATETIME DEFAULT NULL;
    
    -- Determinar si la membresia creada sera aleatoria
    IF v_tipo IS NULL THEN
		SET v_aleatorio = b'1';
    END IF;
    
    while i <= v_cuantos do
		IF v_aleatorio = b'1' THEN
            set v_tipo = ELT(fn_numero_aleatorio_rangos(1,3), "Individual","Familiar","Empresarial");
        END IF;
        
        SET v_tipo_servicios = NULL;
		SET v_tipo_plan = NULL;
		SET v_nivel = NULL;
        SET v_codigo = NULL;
        
        -- INSERTAR EN MEMBRESIAS, LUEGO PERSONAS, LUEGO USUARIOS, TAL VEZ EN MIEMBROS, MEMBRESIAS_USUARIOS
        
        CASE v_tipo
		  WHEN "Individual" THEN SET v_lim_miembros=1;
		  WHEN "Familiar" THEN SET v_lim_miembros= fn_numero_aleatorio_rangos(1,5);
		  WHEN "Empresarial" THEN SET v_lim_miembros = fn_numero_aleatorio_rangos(10,50);
          ELSE SET  v_lim_miembros=1;
		END case;
        
        -- Calcular el servicio aleoatoriamente
        if v_tipo_servicios IS NULL THEN
			set v_tipo_servicios = ELT(fn_numero_aleatorio_rangos(1,4), "Basicos","Completa","Coaching", "Nutriólogo");
        END IF;
        
        -- Calcular el codigo aleatoriamente
        IF v_codigo IS NULL THEN
			SET v_codigo = fn_generar_codigo_aleatorio(50);
        END IF;
        
        -- Calcular el plan aleatoriamente
        if v_tipo_plan IS NULL THEN
			set v_tipo_plan = ELT(fn_numero_aleatorio_rangos(1,7), "Anual","Semestral","Trimestral", "Bimestral", "Mensual", "Semanal", "Diaria");
        END IF;
        
        -- Calculamos la fecha de inicio de la membresia
        set v_fecha_inicio = fn_genera_fecha_registro("2015-01-01", CURDATE(), "08:00:00", "20:00:00");
        
        -- Culamos la fecha del fin de la membresia
        SET v_fecha_fin = fn_calcular_fin(v_fecha_inicio, v_tipo_plan);
        
        -- Calcular el nivel aleatoriamente
        if v_nivel IS NULL THEN
			set v_nivel = ELT(fn_numero_aleatorio_rangos(1,4), "Nuevo","Plata","Oro", "Diamante");
        END IF;
        
        -- Ingresamos la fecha de registro
        SET v_fecha_registro = v_fecha_inicio;
        
		-- Ya que se tiene todos los datos del usuario se inserta en la subentidad
        INSERT INTO membresias VALUES (default,
									   v_codigo,
									   v_tipo,
									   v_tipo_servicios,
									   v_tipo_plan,
                                       v_nivel,
                                       v_fecha_inicio,
                                       v_fecha_fin,
                                       default,
                                       v_fecha_registro,
                                       null);

		-- Obtenemos el ID de la membresia
		set v_id_membresia = last_insert_id();

        -- Insertamos en las relaciones
        call sp_inserta_membresias_usuarios(v_lim_miembros,v_id_membresia);

		set i = i+1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_membresias_usuarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_membresias_usuarios`(v_cuantos int,v_id_membresia int)
    DETERMINISTIC
BEGIN
	-- Declaración de variables
    DECLARE i INT default 1;
    DECLARE v_id_usuario int;
	DECLARE v_fecha_conexion DATETIME;
    
    while i <= v_cuantos do
		call sp_inserta_miembros(1, null);
		set v_id_usuario = last_insert_id();
		-- Revisando la fecha de la ultima conexión
		SET v_fecha_conexion = (SELECT ultima_conexion from usuarios where persona_id = v_id_usuario );
		
		-- Insertar los datos
		INSERT INTO membresias_usuarios values (v_id_membresia,
												v_id_usuario,
												v_fecha_conexion,
												default);
		set i = i+1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_miembros` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_miembros`(v_cuantos int, v_tipo varchar(15))
BEGIN
    -- Declaración de variables
    DECLARE i INT default 1;
    DECLARE v_id_persona INT;
    DECLARE v_tiempo DATETIME;
    DECLARE v_antiguedad VARCHAR(80);
    
    -- debemos conocer el total de personas activas
    DECLARE v_total_personas INT DEFAULT (select count(*) FROM personas WHERE estatus = b'1');
    
	while i <= v_cuantos do
		SET v_tipo = NULL;
        SET v_tiempo = NULL;
		
        -- obtener un id que no este repetido
        
        call sp_inserta_usuarios(1, null);
        set v_id_persona = last_insert_id();
        
        -- En caso de que no se diga que tipo de miembro creamos, se elige uno aleatorio
        if v_tipo IS NULL THEN
            set v_tipo = ELT(fn_numero_aleatorio_rangos(1,5), "Frecuente","Ocasional","Nuevo", "Esporádico","Una sola visita");
        END IF;
        
        personas:LOOP
        SET v_tiempo = (SELECT Fecha_Registro FROM personas WHERE ID=v_id_persona); 
		
		if TIMESTAMPDIFF(YEAR,v_tiempo,CURDATE()) < 1 THEN 
			SET v_antiguedad = concat_ws(" ", 'Miembro nuevo con ',fn_calcula_antiguedad(v_tiempo) );
            LEAVE personas;
		ELSEIF TIMESTAMPDIFF(YEAR,v_tiempo,CURDATE()) BETWEEN 1 AND 3 THEN 
			SET v_antiguedad = concat_ws(" ", 'Miembro regular con ',fn_calcula_antiguedad(v_tiempo) );
            LEAVE personas;
		ELSE 
			SET v_antiguedad = concat_ws(" ", 'Miembro antiguo con ',fn_calcula_antiguedad(v_tiempo) );
            LEAVE personas;
        END IF;
        END LOOP;

        -- Ya que se tiene todos los datos del usuario se inserta en la subentidad
        INSERT INTO miembros VALUES (v_id_persona,
									 v_tipo,
                                     default,
                                     v_antiguedad);
		set i = i+1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_personas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_personas`(v_cuantos INT)
    DETERMINISTIC
BEGIN
	DECLARE i INT DEFAULT 1;
    DECLARE v_genero CHAR(1) default NULL;
    
    DECLARE v_titulo_porcentaje boolean DEFAULT NULL;
    declare  v_titulo varchar(20) default null;
    
    DECLARE v_fecha_actual DATE;
    DECLARE v_fecha_limite_16 DATE;
    DECLARE v_fecha_limite_65 DATE;
    declare v_fecha_inicio_registro date;
    declare v_fecha_fin_registro date;
    DECLARE v_horario_inicio_registro TIME;
    DECLARE v_horario_fin_registro TIME;
    
    set v_fecha_actual = curdate();
    set v_fecha_limite_16 = date_sub(v_fecha_actual, INTERVAL 16 YEAR);
	set v_fecha_limite_65 = date_sub(v_fecha_actual, INTERVAL 65 YEAR);
    
    -- considerando que el gimnasio empezo a funcionar el 01 de Enero de 2020 y que continua en operación
    SET v_fecha_inicio_registro = "2020-01-01";
    SET v_fecha_fin_registro = curdate();
    -- considera que el área de membresias 
    set v_horario_inicio_registro = "08:00:00";
    set v_horario_fin_registro = "20:00:00";
    
    while i <= v_cuantos DO
		set v_titulo_porcentaje= fn_genera_bandera_porcentaje(20);
        SET v_genero = ELT (fn_numero_aleatorio_rangos(1,2),"M","F");
        if v_titulo_porcentaje then
			set v_titulo = fn_genera_titulo_cortesia(v_genero);
		end if;
        
		INSERT INTO personas VALUES (
		default,
		v_titulo,
		fn_genera_nombre(v_genero),
		fn_genera_Apellido(),
		fn_genera_Apellido(),
        fn_genera_fecha_nacimiento(v_fecha_limite_65,v_fecha_limite_16),
		null,
		v_genero,
		fn_genera_sangre(),
		default,
		fn_genera_fecha_registro(v_fecha_inicio_registro, v_fecha_fin_registro, v_horario_inicio_registro,v_horario_fin_registro),
		NULL);
        set v_titulo = null;
        SET i = i +1;
	END while;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_usuarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_usuarios`(v_cuantos int, v_tipo varchar(15))
    DETERMINISTIC
BEGIN
	DECLARE i INT default 1;
    DECLARE v_aleatorio BIT default b'0';
    DECLARE v_estatus_conexion varchar(50) DEFAULT NULL;
    DECLARE v_id_persona INT;
    
    IF v_tipo IS NULL THEN
		SET v_aleatorio = b'1';
    END IF;
    
    while i <= v_cuantos do
		-- SELECT concat("Entrando en el ciclo #", i) as MensajeError;
		IF v_aleatorio = b'1' then
			SET v_tipo = null;
			SET v_estatus_conexion = NULL;
		END IF;
		
		call sp_inserta_personas(1);
		set v_id_persona = last_insert_id();
		
		-- En caso de que no se diga que tipo de empleado creamos, se elige uno aleatorio
		if v_tipo IS NULL THEN
			set v_tipo = ELT(fn_numero_aleatorio_rangos(1,4), "Empleado","Visitante","Miembro", "Instructor");
		END IF;
		
		-- En caso de que no se diga la ultima conexión, se elige uno aleatorio
		if v_estatus_conexion IS NULL THEN
			set v_estatus_conexion = ELT(fn_numero_aleatorio_rangos(1,3), "Online","Offline","Banned");
		END IF;
		
		-- Ya que se tiene todos los datos del trabajador insertar en la subentidad
		INSERT INTO usuarios VALUES(v_id_persona,
									 v_id_persona,
									 default,
									 v_tipo,
									 v_estatus_conexion,
									 fn_genera_fecha_registro( (SELECT fecha_registro FROM personas WHERE id= v_id_persona), CURDATE(), "08:00:00", "20:00:00"));
		set i = i+1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_limpia_bd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_limpia_bd`(v_password varchar(10))
    DETERMINISTIC
BEGIN
	if v_password = "abcde" then 
		-- Antes de poder eliminart a las personas tengo que asegurarme que ninguna sucurse
        UPDATE sucursales set responsable_id = null;
        -- Despues de haber eliminado a los responsables de las sucursales, eliminamos a los empleados
        delete from empleados;
        
        -- eliminamos los mienbros 
        -- UPDATE miembros set persona_id = null;
        delete from miembros;
        
        -- eliminamos la relación de membresias y usuarios
        delete from membresias_usuarios;
        
        -- eliminamos las membresias 
        delete from membresias;
        ALTER TABLE membresias AUTO_INCREMENT = 1;
        
        -- eliminamos los usuarios 
		-- UPDATE usuarios set nombre_usuario = null;
        delete from usuarios;
        
        -- entonces procedemos alimpiar a las personas
		delete from personas;
        ALTER TABLE personas AUTO_INCREMENT = 1;
	else
		select "La contraseña es incorrecta" as Mensaje;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_limpia_membresias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_limpia_membresias`(v_password varchar(10))
    DETERMINISTIC
BEGIN
	if v_password = "membresias" then 
		       		-- eliminamos las membresias 
        
                   -- eliminamos la relación de membresias y usuarios
        delete from membresias_usuarios;
           ALTER TABLE membresias_usuarios AUTO_INCREMENT = 1;
        
        delete from membresias;
        ALTER TABLE membresias AUTO_INCREMENT = 1;
        

        -- UPDATE usuarios set nombre_usuario = null;
        delete from usuarios;
        alter table usuarios auto_increment = 1;
        
         delete from miembros;
        ALTER TABLE miembros AUTO_INCREMENT = 1;
                 -- eliminamos los usuarios 
		
           
         -- entonces procedemos alimpiar a las personas
		delete from personas;
       ALTER TABLE personas AUTO_INCREMENT = 1;  
                

	else
		select "La contraseña es incorrecta" as Mensaje;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_poblar_bd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_poblar_bd`(v_password varchar(10))
    DETERMINISTIC
BEGIN
	if v_password = "abcde" then 
		call sp_inserta_empleados(100, null);
        CALL sp_inserta_membresias(20, null);
		CALL sp_inserta_membresias(20, 'Individual');
		CALL sp_inserta_membresias(20, 'Familiar');
		CALL sp_inserta_membresias(20, 'Empresarial');
	else
		select "La contraseña es incorrecta, no se poblo la BD" as Mensaje;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_poblar_membresias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_poblar_membresias`(v_password varchar(10))
    DETERMINISTIC
BEGIN
	if v_password = "membresias" then
		CALL sp_inserta_membresias_(5, 'Individual'); -- 1
        call sp_inserta_personas_(2); -- 5
		
		CALL sp_inserta_miembros_(2, 'Nuevo'); -- 4
        CALL sp_inserta_usuarios_(2, 'Empleado'); -- 3
		CALL sp_inserta_membresias_usuarios_(5, 81); -- 2
		
		
	else
		select "La contraseña es incorrecta, no se poblo la BD" as Mensaje;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_clientes_empleados_por_genero`
--

/*!50001 DROP VIEW IF EXISTS `vw_clientes_empleados_por_genero`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_clientes_empleados_por_genero` AS select 'Empleados' AS `Tipo`,`personas`.`Genero` AS `genero`,count(0) AS `Total` from (`empleados` join `personas` on((`empleados`.`Persona_ID` = `personas`.`ID`))) group by `personas`.`Genero` union select 'Clientes' AS `Tipo`,`personas`.`Genero` AS `genero`,count(0) AS `Total` from (`miembros` join `personas` on((`miembros`.`Persona_ID` = `personas`.`ID`))) group by `personas`.`Genero` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_genero_por_edad`
--

/*!50001 DROP VIEW IF EXISTS `vw_genero_por_edad`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_genero_por_edad` AS select `personas`.`Genero` AS `Genero`,count(0) AS `Total`,'16-20' AS `Rango` from `personas` where ((`fn_calcula_edad`(`personas`.`Fecha_Nacimiento`) >= 16) and (`fn_calcula_edad`(`personas`.`Fecha_Nacimiento`) <= 20)) group by `personas`.`Genero` union select `personas`.`Genero` AS `Genero`,count(0) AS `Total`,'21-30' AS `Rango` from `personas` where ((`fn_calcula_edad`(`personas`.`Fecha_Nacimiento`) >= 21) and (`fn_calcula_edad`(`personas`.`Fecha_Nacimiento`) <= 30)) group by `personas`.`Genero` union select `personas`.`Genero` AS `Genero`,count(0) AS `Total`,'31-40' AS `Rango` from `personas` where ((`fn_calcula_edad`(`personas`.`Fecha_Nacimiento`) >= 31) and (`fn_calcula_edad`(`personas`.`Fecha_Nacimiento`) <= 40)) group by `personas`.`Genero` union select `personas`.`Genero` AS `Genero`,count(0) AS `Total`,'41-50' AS `Rango` from `personas` where ((`fn_calcula_edad`(`personas`.`Fecha_Nacimiento`) >= 41) and (`fn_calcula_edad`(`personas`.`Fecha_Nacimiento`) <= 50)) group by `personas`.`Genero` union select `personas`.`Genero` AS `Genero`,count(0) AS `Total`,'+50' AS `Rango` from `personas` where (`fn_calcula_edad`(`personas`.`Fecha_Nacimiento`) >= 51) group by `personas`.`Genero` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_membresias_genero`
--

/*!50001 DROP VIEW IF EXISTS `vw_membresias_genero`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_membresias_genero` AS select `m`.`Tipo` AS `tipo`,`p`.`Genero` AS `genero`,count(0) AS `count(*)` from ((((`personas` `p` join `usuarios` `u` on((`p`.`ID` = `u`.`Persona_ID`))) join `miembros` `mi` on((`mi`.`Persona_ID` = `p`.`ID`))) join `membresias_usuarios` `mu` on((`mu`.`Usuarios_ID` = `p`.`ID`))) join `membresias` `m` on((`mu`.`Membresia_ID` = `m`.`ID`))) where (`mi`.`Membresia_Activa` = 0x01) group by `m`.`Tipo`,`p`.`Genero` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_personas_por_genero`
--

/*!50001 DROP VIEW IF EXISTS `vw_personas_por_genero`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_personas_por_genero` AS select `personas`.`Genero` AS `genero`,count(0) AS `Total` from `personas` group by `personas`.`Genero` */;
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

-- Dump completed on 2024-04-19  9:06:51
