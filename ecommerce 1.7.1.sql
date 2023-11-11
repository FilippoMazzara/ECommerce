-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
SHOW WARNINGS;
-- -----------------------------------------------------
-- Schema ecommerce
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ecommerce` ;

-- -----------------------------------------------------
-- Schema ecommerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ecommerce` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
SHOW WARNINGS;
USE `ecommerce` ;

-- -----------------------------------------------------
-- Table `ecommerce`.`utente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`utente` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ecommerce`.`utente` (
  `iduser` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(30) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `cognome` VARCHAR(30) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `email` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `username` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `psw` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `dataregistrazione` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `telefono` VARCHAR(15) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `nazionalita` VARCHAR(30) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `usereliminato` TINYINT UNSIGNED NOT NULL DEFAULT '0',
  `pagamentopreferito` INT UNSIGNED NOT NULL DEFAULT '0',
  `datadinascita` DATE NOT NULL,
  `immagineprofilo` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`iduser`))
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SHOW WARNINGS;
CREATE UNIQUE INDEX `username_UNIQUE` ON `ecommerce`.`utente` (`username` ASC) VISIBLE;

SHOW WARNINGS;
CREATE UNIQUE INDEX `email_UNIQUE` ON `ecommerce`.`utente` (`email` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ecommerce`.`carrello`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`carrello` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ecommerce`.`carrello` (
  `idcarrello` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `iduser` INT UNSIGNED NOT NULL,
  `costototale` DECIMAL(12,2) UNSIGNED NOT NULL DEFAULT '0.00',
  `datamodifica` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `numeroarticoli` INT UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`idcarrello`),
  CONSTRAINT `idusercarrello`
    FOREIGN KEY (`iduser`)
    REFERENCES `ecommerce`.`utente` (`iduser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SHOW WARNINGS;
CREATE UNIQUE INDEX `iduser_UNIQUE` ON `ecommerce`.`carrello` (`iduser` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ecommerce`.`categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`categoria` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ecommerce`.`categoria` (
  `nomecategoria` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `descrizione` VARCHAR(500) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `quantitaprodotti` INT UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`nomecategoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ecommerce`.`userstore`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`userstore` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ecommerce`.`userstore` (
  `iduserstore` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `iduser` INT UNSIGNED NOT NULL,
  `feedback` DECIMAL(2,1) UNSIGNED NOT NULL DEFAULT '0.0',
  `totaleordini` INT UNSIGNED NOT NULL DEFAULT '0',
  `descrizione` VARCHAR(500) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `commentitotali` INT UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`iduserstore`),
  CONSTRAINT `iduserstore`
    FOREIGN KEY (`iduser`)
    REFERENCES `ecommerce`.`utente` (`iduser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SHOW WARNINGS;
CREATE UNIQUE INDEX `iduser_UNIQUE` ON `ecommerce`.`userstore` (`iduser` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ecommerce`.`commenti`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`commenti` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ecommerce`.`commenti` (
  `idcommenti` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `iduser` INT UNSIGNED NOT NULL,
  `iduserstore` INT UNSIGNED NOT NULL,
  `titolo` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `testo` VARCHAR(5000) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `feedback` DECIMAL(2,1) UNSIGNED NOT NULL DEFAULT '0.0',
  `datacommento` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcommenti`),
  CONSTRAINT `commentouser`
    FOREIGN KEY (`iduser`)
    REFERENCES `ecommerce`.`utente` (`iduser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `userstorecommenti`
    FOREIGN KEY (`iduserstore`)
    REFERENCES `ecommerce`.`userstore` (`iduserstore`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SHOW WARNINGS;
CREATE UNIQUE INDEX `iduser_UNIQUE` ON `ecommerce`.`commenti` (`iduser` ASC, `iduserstore` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `commentouser_idx` ON `ecommerce`.`commenti` (`iduser` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `commentouserstore_idx` ON `ecommerce`.`commenti` (`iduserstore` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ecommerce`.`indirizzo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`indirizzo` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ecommerce`.`indirizzo` (
  `iduser` INT UNSIGNED NOT NULL,
  `regione` VARCHAR(30) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `citta` VARCHAR(30) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `via` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `civico` INT UNSIGNED NOT NULL,
  `cap` VARCHAR(7) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  PRIMARY KEY (`iduser`),
  CONSTRAINT `iduserindirizzo`
    FOREIGN KEY (`iduser`)
    REFERENCES `ecommerce`.`utente` (`iduser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SHOW WARNINGS;
CREATE UNIQUE INDEX `iduser_UNIQUE` ON `ecommerce`.`indirizzo` (`iduser` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `iduserindirizzo` ON `ecommerce`.`indirizzo` (`iduser` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ecommerce`.`prodotto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`prodotto` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ecommerce`.`prodotto` (
  `idprodotto` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `iduserstore` INT UNSIGNED NOT NULL,
  `nomecategoria` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `datavendita` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `quantitadisponibile` INT NOT NULL DEFAULT '0',
  `prezzo` DECIMAL(12,2) UNSIGNED NOT NULL DEFAULT '0.00',
  `descrizione` VARCHAR(500) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `titolo` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `immagine` VARCHAR(500) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL DEFAULT '"C:\\percorso immagine"',
  `costospedizione` DECIMAL(12,2) UNSIGNED NOT NULL DEFAULT '0.00',
  `prodottoeliminato` TINYINT UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`idprodotto`),
  CONSTRAINT `categoriaprodotto`
    FOREIGN KEY (`nomecategoria`)
    REFERENCES `ecommerce`.`categoria` (`nomecategoria`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `storeprodotto`
    FOREIGN KEY (`iduserstore`)
    REFERENCES `ecommerce`.`userstore` (`iduserstore`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SHOW WARNINGS;
CREATE INDEX `storeprodotto_idx` ON `ecommerce`.`prodotto` (`iduserstore` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `categoriaprodotto` ON `ecommerce`.`prodotto` (`nomecategoria` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ecommerce`.`itemcarrello`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`itemcarrello` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ecommerce`.`itemcarrello` (
  `iditemcarrello` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idcarrello` INT UNSIGNED NOT NULL,
  `idprodotto` INT UNSIGNED NOT NULL,
  `quantita` INT UNSIGNED NOT NULL DEFAULT '1',
  `dataaggiunta` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `spedizionetotale` DECIMAL(12,2) UNSIGNED NOT NULL DEFAULT '0.00',
  `prodottitotale` DECIMAL(12,2) UNSIGNED NOT NULL DEFAULT '0.00',
  `totalecosto` DECIMAL(12,2) UNSIGNED NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`iditemcarrello`, `idcarrello`),
  CONSTRAINT `iditemcart`
    FOREIGN KEY (`idcarrello`)
    REFERENCES `ecommerce`.`carrello` (`idcarrello`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `idprodcart`
    FOREIGN KEY (`idprodotto`)
    REFERENCES `ecommerce`.`prodotto` (`idprodotto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SHOW WARNINGS;
CREATE UNIQUE INDEX `idprodotto_UNIQUE` ON `ecommerce`.`itemcarrello` (`idprodotto` ASC, `idcarrello` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `idprodcart_idx` ON `ecommerce`.`itemcarrello` (`idprodotto` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `iditemcart_idx` ON `ecommerce`.`itemcarrello` (`idcarrello` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ecommerce`.`ordine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`ordine` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ecommerce`.`ordine` (
  `idordine` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `iduser` INT UNSIGNED NOT NULL,
  `totale` DECIMAL(12,2) UNSIGNED NOT NULL DEFAULT '0.00',
  `statoordine` VARCHAR(30) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL DEFAULT 'IN PROCESSO',
  `dataordine` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `carta` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `titolarecarta` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `indirizzo` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`idordine`),
  CONSTRAINT `iduserordine`
    FOREIGN KEY (`iduser`)
    REFERENCES `ecommerce`.`utente` (`iduser`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 92
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SHOW WARNINGS;
CREATE INDEX `iduserordine_idx` ON `ecommerce`.`ordine` (`iduser` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ecommerce`.`itemordine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`itemordine` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ecommerce`.`itemordine` (
  `iditemordine` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idprodotto` INT UNSIGNED NOT NULL,
  `idordine` INT UNSIGNED NOT NULL,
  `quantita` INT UNSIGNED NOT NULL DEFAULT '1',
  `prodottitotale` DECIMAL(12,2) UNSIGNED NOT NULL DEFAULT '0.00',
  `spedizionetotale` DECIMAL(12,2) UNSIGNED NOT NULL DEFAULT '0.00',
  `statospedizione` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL DEFAULT 'IN CONSEGNA',
  `totalecosto` DECIMAL(12,2) UNSIGNED NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`iditemordine`),
  CONSTRAINT `idordine`
    FOREIGN KEY (`idordine`)
    REFERENCES `ecommerce`.`ordine` (`idordine`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `idprodottoordine`
    FOREIGN KEY (`idprodotto`)
    REFERENCES `ecommerce`.`prodotto` (`idprodotto`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 45
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SHOW WARNINGS;
CREATE UNIQUE INDEX `idprodotto_UNIQUE` ON `ecommerce`.`itemordine` (`idprodotto` ASC, `idordine` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `idordine_idx` ON `ecommerce`.`itemordine` (`idordine` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ecommerce`.`pagamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`pagamento` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ecommerce`.`pagamento` (
  `idpagamento` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `iduser` INT UNSIGNED NOT NULL,
  `carta` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `cvc` INT NULL DEFAULT NULL,
  `scadenza` DATE NOT NULL,
  `titolare` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  PRIMARY KEY (`idpagamento`, `iduser`),
  CONSTRAINT `iduserpagamento`
    FOREIGN KEY (`iduser`)
    REFERENCES `ecommerce`.`utente` (`iduser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SHOW WARNINGS;
CREATE UNIQUE INDEX `iduser_UNIQUE` ON `ecommerce`.`pagamento` (`iduser` ASC, `carta` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `iduserpagamento_idx` ON `ecommerce`.`pagamento` (`iduser` ASC) VISIBLE;

SHOW WARNINGS;
USE `ecommerce` ;

-- -----------------------------------------------------
-- Placeholder table for view `ecommerce`.`utentieliminati`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`utentieliminati` (`iduser` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- Placeholder table for view `ecommerce`.`vistautente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`vistautente` (`iduser` INT, `nome` INT, `cognome` INT, `email` INT, `username` INT, `psw` INT, `dataregistrazione` INT, `telefono` INT, `nazionalita` INT, `datadinascita` INT, `pagamentopreferito` INT, `usereliminato` INT, `immagineprofilo` INT, `iduserstore` INT, `feedback` INT, `totaleordini` INT, `descrizione` INT, `commentitotali` INT, `regione` INT, `citta` INT, `via` INT, `civico` INT, `cap` INT, `idcarrello` INT, `costototale` INT, `numeroarticoli` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure checkout1
-- -----------------------------------------------------

USE `ecommerce`;
DROP procedure IF EXISTS `ecommerce`.`checkout1`;
SHOW WARNINGS;

DELIMITER $$
USE `ecommerce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkout1`(in idu int, in idpaga int, in riepilogoi varchar(500), out ord int)
BEGIN
declare c int;
declare k int;
declare z int;
declare idp int;
set c = (select idcarrello from carrello where carrello.iduser=idu);
set k = (select numeroarticoli from carrello where carrello.idcarrello=c);
if k>0 then
insert into ordine(ordine.iduser,ordine.carta,ordine.titolarecarta,ordine.indirizzo) values (idu, (select carta from pagamento where pagamento.iduser = idu and pagamento.idpagamento=idpaga),(select titolare from pagamento where pagamento.iduser = idu and pagamento.idpagamento=idpaga),riepilogoi);
set ord = (SELECT LAST_INSERT_ID());

	
    
	while k>0 do
	set idp = (select idprodotto from itemcarrello where itemcarrello.idcarrello=c and itemcarrello.iditemcarrello=k);
    insert into itemordine(itemordine.idordine,itemordine.idprodotto,itemordine.quantita,itemordine.prodottitotale,itemordine.spedizionetotale) values (ord,idp,(select quantita from itemcarrello where itemcarrello.idcarrello=c and itemcarrello.iditemcarrello=k),(select prodottitotale from itemcarrello where itemcarrello.idcarrello=c and itemcarrello.iditemcarrello=k),(select spedizionetotale from itemcarrello where itemcarrello.idcarrello=c and itemcarrello.iditemcarrello=k)) ;
    update prodotto set prodotto.quantitadisponibile = prodotto.quantitadisponibile - (select quantita from itemcarrello where itemcarrello.idcarrello=c and itemcarrello.iditemcarrello=k) where prodotto.idprodotto=idp;
    set z = (select prodotto.quantitadisponibile from prodotto where prodotto.idprodotto = idp);
    update itemcarrello set itemcarrello.quantita=z where itemcarrello.idprodotto=idp;
    set k = k-1;
    end while;
    delete from itemcarrello where itemcarrello.idcarrello = c;
else SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Il carrello è vuoto';
end if;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure checkout2
-- -----------------------------------------------------

USE `ecommerce`;
DROP procedure IF EXISTS `ecommerce`.`checkout2`;
SHOW WARNINGS;

DELIMITER $$
USE `ecommerce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkout2`(in idu int, in idpaga int, in riepilogoi varchar(500), in idprod int, in quantita int,  out ord int)
BEGIN
declare z int;
if( quantita <= (select quantitadisponibile from prodotto where prodotto.idprodotto=idprod) )then

insert into ordine(ordine.iduser,ordine.carta,ordine.titolarecarta,ordine.indirizzo) values (idu, (select carta from pagamento where pagamento.iduser = idu and pagamento.idpagamento=idpaga),(select titolare from pagamento where pagamento.iduser = idu and pagamento.idpagamento=idpaga),riepilogoi);
set ord = (SELECT LAST_INSERT_ID());
insert into itemordine(itemordine.idordine,itemordine.idprodotto,itemordine.quantita,itemordine.prodottitotale,itemordine.spedizionetotale) values (ord,idprod,quantita,quantita*(select prezzo from prodotto where prodotto.idprodotto=idprod),quantita*(select costospedizione from prodotto where prodotto.idprodotto=idprod));
update prodotto set prodotto.quantitadisponibile=prodotto.quantitadisponibile-quantita where prodotto.idprodotto=idprod;
set z = (select prodotto.quantitadisponibile from prodotto where prodotto.idprodotto = idprod);
update itemcarrello set itemcarrello.quantita=z where itemcarrello.idprodotto=idprod;
else SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'quantita errata';
end if;
End$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure eliminadalcarrello
-- -----------------------------------------------------

USE `ecommerce`;
DROP procedure IF EXISTS `ecommerce`.`eliminadalcarrello`;
SHOW WARNINGS;

DELIMITER $$
USE `ecommerce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminadalcarrello`(in idp int,in idc int)
BEGIN


declare k int;
declare o int;
set o = (select iditemcarrello from itemcarrello where itemcarrello.idprodotto=idp and itemcarrello.idcarrello=idc);
set k = (select max(iditemcarrello) from itemcarrello where itemcarrello.idcarrello=idc);
if not o=k then

update itemcarrello set itemcarrello.iditemcarrello=0 where itemcarrello.iditemcarrello = o;
update itemcarrello set itemcarrello.iditemcarrello=o where itemcarrello.iditemcarrello = k; 

delete from itemcarrello where itemcarrello.iditemcarrello=0 and itemcarrello.idcarrello=idc;
else 
delete from itemcarrello where itemcarrello.iditemcarrello=o and itemcarrello.idcarrello=idc;
end if;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure eliminapagamento
-- -----------------------------------------------------

USE `ecommerce`;
DROP procedure IF EXISTS `ecommerce`.`eliminapagamento`;
SHOW WARNINGS;

DELIMITER $$
USE `ecommerce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminapagamento`(in idp int, in idu int)
BEGIN


declare k int;
declare o int;
set o = (select idpagamento from pagamento where pagamento.iduser=idu and pagamento.idpagamento=idp);
set k = (select max(idpagamento) from pagamento where pagamento.iduser=idu);
if not o=k then

update pagamento set pagamento.idpagamento=0 where pagamento.idpagamento = o;
update pagamento set pagamento.idpagamento=o where pagamento.idpagamento = k; 

delete from pagamento where pagamento.idpagamento=0 and pagamento.iduser=idu;
else 
delete from pagamento where pagamento.idpagamento=o and pagamento.iduser=idu;
end if;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure getutente
-- -----------------------------------------------------

USE `ecommerce`;
DROP procedure IF EXISTS `ecommerce`.`getutente`;
SHOW WARNINGS;

DELIMITER $$
USE `ecommerce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getutente`(in idu int, out n varchar(30), out c varchar(30), out mail varchar(255), out uname varchar(255), out pasw varchar(255), out tel varchar(15), out naz varchar(30),out datar timestamp,out datan date,out pagapref int, out deluser int, out immprofilo varchar(500), out idstore int, out f decimal(12,2),  out totordini int,out descr varchar(500), out commentitot int , out reg  varchar(30), out cit  varchar(30), out cp  varchar(7), out viale varchar(50),out civ int, out idcart int ,out costotot decimal(12,2),out numeroart int)
BEGIN
set n =  (select nome from vistautente where vistautente.iduser=idu);
set c = (select cognome from vistautente where vistautente.iduser=idu);
set mail =(select email from vistautente where vistautente.iduser=idu);
set uname = (select username from vistautente where vistautente.iduser=idu);
set pasw =(select psw from vistautente where vistautente.iduser=idu);
set datar = (select dataregistrazione from vistautente where vistautente.iduser=idu);
set tel =(select telefono from vistautente where vistautente.iduser=idu);
set naz =(select nazionalita from vistautente where vistautente.iduser=idu);
set datan =(select datadinascita from vistautente where vistautente.iduser=idu);
set deluser =(select usereliminato from vistautente where vistautente.iduser=idu);
set pagapref =(select pagamentopreferito from vistautente where vistautente.iduser=idu);
set immprofilo =(select immagineprofilo from vistautente where vistautente.iduser=idu);
set idstore =(select `iduserstore` from vistautente where vistautente.iduser=idu);
set f =(select `feedback` from vistautente where vistautente.iduser=idu);
set totordini =(select `totaleordini` from vistautente where vistautente.iduser=idu);
set descr =(select `descrizione` from vistautente where vistautente.iduser=idu);
set commentitot =(select `commentitotali` from vistautente where vistautente.iduser=idu);
set reg =(select `regione` from vistautente where vistautente.iduser=idu);
set cit =(select `citta` from vistautente where vistautente.iduser=idu);
set viale =(select `via` from vistautente where vistautente.iduser=idu);
set civ =(select `civico` from vistautente where vistautente.iduser=idu);
set cp =(select `cap` from vistautente where vistautente.iduser=idu);
set idcart =(select `idcarrello` from vistautente where vistautente.iduser=idu);
set costotot =(select `costototale` from vistautente where vistautente.iduser=idu);
set numeroart =(select `numeroarticoli` from vistautente where vistautente.iduser=idu);
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure inseriscicommento
-- -----------------------------------------------------

USE `ecommerce`;
DROP procedure IF EXISTS `ecommerce`.`inseriscicommento`;
SHOW WARNINGS;

DELIMITER $$
USE `ecommerce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `inseriscicommento`(in idu int,in storeid int, in txt varchar(5000), in fb DECIMAL(2,1), out cid int)
BEGIN
insert into commenti(iduser,iduserstore,testo,feedback) values(idu,storeid,txt,fb);
set cid = (SELECT LAST_INSERT_ID());
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure inseriscinelcarrello
-- -----------------------------------------------------

USE `ecommerce`;
DROP procedure IF EXISTS `ecommerce`.`inseriscinelcarrello`;
SHOW WARNINGS;

DELIMITER $$
USE `ecommerce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `inseriscinelcarrello`(idc int ,idp int, in q int)
BEGIN
declare q1 int;
declare i int;
if exists (select * from itemcarrello where itemcarrello.idcarrello=idc and idp=itemcarrello.idprodotto) then
	set q1 =(select quantita from itemcarrello where itemcarrello.idcarrello=idc and idp=itemcarrello.idprodotto);
	set i = (select iditemcarrello from itemcarrello where itemcarrello.idcarrello=idc and idp=itemcarrello.idprodotto);
	delete from itemcarrello where iditemcarrello=i and idcarrello=idc;
	insert into itemcarrello(iditemcarrello,idcarrello,idprodotto,quantita) values (i,idc,idp,q+q1);
	
else 
	insert into itemcarrello(idcarrello,idprodotto,quantita) values (idc,idp,q);
	
end if;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure registraprodotto
-- -----------------------------------------------------

USE `ecommerce`;
DROP procedure IF EXISTS `ecommerce`.`registraprodotto`;
SHOW WARNINGS;

DELIMITER $$
USE `ecommerce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `registraprodotto`(in idu int, in cat varchar(50), in q int, in prezzo DECIMAL(12,2) ,in descr varchar(500), in titolo varchar(50), in immagine varchar(500), in csped DECIMAL(12,2), out pid int)
BEGIN
	insert into prodotto(iduserstore,nomecategoria,quantitadisponibile,prezzo,descrizione,titolo,immagine,costospedizione) values (idu,cat,q,prezzo,descr,titolo,immagine,csped);
    set pid =(SELECT LAST_INSERT_ID());
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure registrazione
-- -----------------------------------------------------

USE `ecommerce`;
DROP procedure IF EXISTS `ecommerce`.`registrazione`;
SHOW WARNINGS;

DELIMITER $$
USE `ecommerce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `registrazione`(in n varchar(30), in c varchar(30), in mail varchar(255), in uname varchar(255), in pasw varchar(255), in tel varchar(15), in naz varchar(30),in datan date, in reg  varchar(30), in cit  varchar(30), in cp  varchar(7), in viale varchar(50),in civ int, in immprofilo varchar(500), out uid int)
BEGIN
	insert into utente(nome,cognome,email,username,psw,telefono,nazionalita,datadinascita,immagineprofilo) values (n,c,mail,uname,md5(pasw),tel,naz,datan,immprofilo);
    set uid = (SELECT LAST_INSERT_ID());
    insert into indirizzo values (uid,reg,cit,viale,civ,cp);
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure registrazione_completa
-- -----------------------------------------------------

USE `ecommerce`;
DROP procedure IF EXISTS `ecommerce`.`registrazione_completa`;
SHOW WARNINGS;

DELIMITER $$
USE `ecommerce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `registrazione_completa`(in n varchar(30), in c varchar(30), in mail varchar(255), in uname varchar(255), in pasw varchar(255), in tel varchar(15), in naz varchar(30),in datan date, in reg  varchar(30), in cit  varchar(30), in cp  varchar(7), in viale varchar(50),in civ int, in immprofilo varchar(500),in carta VARCHAR(255), in scad date , in tit varchar(100), out uid int)
BEGIN
insert into utente(nome,cognome,email,username,psw,telefono,nazionalita,datadinascita,immagineprofilo) values (n,c,mail,uname,md5(pasw),tel,naz,datan,immprofilo);
    set uid = (SELECT LAST_INSERT_ID());
    insert into indirizzo values (uid,reg,cit,viale,civ,cp);
    insert into pagamento(iduser,carta,scadenza,titolare) values (uid,carta,scad,tit);
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure riepilogo1
-- -----------------------------------------------------

USE `ecommerce`;
DROP procedure IF EXISTS `ecommerce`.`riepilogo1`;
SHOW WARNINGS;

DELIMITER $$
USE `ecommerce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `riepilogo1`(in idu int , out r varchar(500))
BEGIN

declare reg VARCHAR(30);
declare c VARCHAR(30);
declare cap VARCHAR(7);
declare civ int;
declare via VARCHAR(50);
set reg = (select indirizzo.regione from indirizzo where indirizzo.iduser = idu);
set c = (select indirizzo.citta from indirizzo where indirizzo.iduser = idu);
set cap = (select indirizzo.cap from indirizzo where indirizzo.iduser = idu);
set civ = (select indirizzo.civico from indirizzo where indirizzo.iduser = idu);
set via = (select indirizzo.via from indirizzo where indirizzo.iduser = idu);
set r = concat_ws("", "Città: ",c,", ",reg," Via: ",via," ",civ," CAP: ",cap);
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure riepilogo2
-- -----------------------------------------------------

USE `ecommerce`;
DROP procedure IF EXISTS `ecommerce`.`riepilogo2`;
SHOW WARNINGS;

DELIMITER $$
USE `ecommerce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `riepilogo2`(in reg VARCHAR(30), in c VARCHAR(30), in via VARCHAR(50), in civ int, in cap VARCHAR(7), out r varchar(500))
BEGIN
set r = concat_ws("","Città: ",c,", ",reg," Via: ",via," ",civ," CAP: ",cap);
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- function riepilogoindirizzo
-- -----------------------------------------------------

USE `ecommerce`;
DROP function IF EXISTS `ecommerce`.`riepilogoindirizzo`;
SHOW WARNINGS;

DELIMITER $$
USE `ecommerce`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `riepilogoindirizzo`(idu int) RETURNS varchar(500) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci
    READS SQL DATA
BEGIN
declare r VARCHAR(30);
declare c VARCHAR(30);
declare cap VARCHAR(7);
declare civ int;
declare via VARCHAR(50);
set r = (select indirizzo.regione from indirizzo where indirizzo.iduser = idu);
set c = (select indirizzo.citta from indirizzo where indirizzo.iduser = idu);
set cap = (select indirizzo.cap from indirizzo where indirizzo.iduser = idu);
set civ = (select indirizzo.civico from indirizzo where indirizzo.iduser = idu);
set via = (select indirizzo.via from indirizzo where indirizzo.iduser = idu);
return concat_ws("", "Città: ",c,", ",r," Via: ",via," ",civ," CAP: ",cap);
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- function riepilogoindirizzo2
-- -----------------------------------------------------

USE `ecommerce`;
DROP function IF EXISTS `ecommerce`.`riepilogoindirizzo2`;
SHOW WARNINGS;

DELIMITER $$
USE `ecommerce`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `riepilogoindirizzo2`(r VARCHAR(30), c VARCHAR(30), via VARCHAR(50),  civ int, cap VARCHAR(7)) RETURNS varchar(500) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci
    READS SQL DATA
BEGIN
return (select concat_ws("","Città: ",c,", ",r," Via: ",via," ",civ," CAP: ",cap));
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure salvapagamento
-- -----------------------------------------------------

USE `ecommerce`;
DROP procedure IF EXISTS `ecommerce`.`salvapagamento`;
SHOW WARNINGS;

DELIMITER $$
USE `ecommerce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `salvapagamento`(in idu int, in carta VARCHAR(255),in cvc int, in scad date , in tit varchar(100), out pid int)
BEGIN
insert into pagamento(iduser,carta,cvc,scadenza,titolare) values (idu,carta,cvc,scad,tit);
    set pid = (SELECT LAST_INSERT_ID());
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `ecommerce`.`utentieliminati`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`utentieliminati`;
SHOW WARNINGS;
DROP VIEW IF EXISTS `ecommerce`.`utentieliminati` ;
SHOW WARNINGS;
USE `ecommerce`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ecommerce`.`utentieliminati` AS select `ecommerce`.`utente`.`iduser` AS `iduser` from `ecommerce`.`utente` where (`ecommerce`.`utente`.`usereliminato` = 1);
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `ecommerce`.`vistautente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`vistautente`;
SHOW WARNINGS;
DROP VIEW IF EXISTS `ecommerce`.`vistautente` ;
SHOW WARNINGS;
USE `ecommerce`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ecommerce`.`vistautente` AS select `ecommerce`.`utente`.`iduser` AS `iduser`,`ecommerce`.`utente`.`nome` AS `nome`,`ecommerce`.`utente`.`cognome` AS `cognome`,`ecommerce`.`utente`.`email` AS `email`,`ecommerce`.`utente`.`username` AS `username`,`ecommerce`.`utente`.`psw` AS `psw`,`ecommerce`.`utente`.`dataregistrazione` AS `dataregistrazione`,`ecommerce`.`utente`.`telefono` AS `telefono`,`ecommerce`.`utente`.`nazionalita` AS `nazionalita`,`ecommerce`.`utente`.`datadinascita` AS `datadinascita`,`ecommerce`.`utente`.`pagamentopreferito` AS `pagamentopreferito`,`ecommerce`.`utente`.`usereliminato` AS `usereliminato`,`ecommerce`.`utente`.`immagineprofilo` AS `immagineprofilo`,`ecommerce`.`userstore`.`iduserstore` AS `iduserstore`,`ecommerce`.`userstore`.`feedback` AS `feedback`,`ecommerce`.`userstore`.`totaleordini` AS `totaleordini`,`ecommerce`.`userstore`.`descrizione` AS `descrizione`,`ecommerce`.`userstore`.`commentitotali` AS `commentitotali`,`ecommerce`.`indirizzo`.`regione` AS `regione`,`ecommerce`.`indirizzo`.`citta` AS `citta`,`ecommerce`.`indirizzo`.`via` AS `via`,`ecommerce`.`indirizzo`.`civico` AS `civico`,`ecommerce`.`indirizzo`.`cap` AS `cap`,`ecommerce`.`carrello`.`idcarrello` AS `idcarrello`,`ecommerce`.`carrello`.`costototale` AS `costototale`,`ecommerce`.`carrello`.`numeroarticoli` AS `numeroarticoli` from (((`ecommerce`.`utente` join `ecommerce`.`userstore`) join `ecommerce`.`indirizzo`) join `ecommerce`.`carrello`) where ((`ecommerce`.`utente`.`iduser` = `ecommerce`.`userstore`.`iduser`) and (`ecommerce`.`utente`.`iduser` = `ecommerce`.`indirizzo`.`iduser`) and (`ecommerce`.`utente`.`iduser` = `ecommerce`.`carrello`.`iduser`));
SHOW WARNINGS;
USE `ecommerce`;

DELIMITER $$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`utente_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`utente_AFTER_INSERT`
AFTER INSERT ON `ecommerce`.`utente`
FOR EACH ROW
BEGIN
insert into userstore(iduser) values (new.iduser);
insert into carrello(iduser) values (new.iduser);
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`utente_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`utente_AFTER_UPDATE`
AFTER UPDATE ON `ecommerce`.`utente`
FOR EACH ROW
begin
 if  (new.usereliminato=1) then
    delete from itemcarrello where itemcarrello.idcarrello = (select carrello.idcarrello from carrello where carrello.iduser=new.iduser);
    update prodotto set prodotto.prodottoeliminato = 1 where prodotto.iduserstore=(select iduserstore from userstore where userstore.iduser=new.iduser);
end if;
end$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`utente_BEFORE_UPDATE` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`utente_BEFORE_UPDATE`
BEFORE UPDATE ON `ecommerce`.`utente`
FOR EACH ROW
BEGIN
if (old.pagamentopreferito <> new.pagamentopreferito) then 
	if (not exists (select * from pagamento where pagamento.iduser=new.iduser and pagamento.idpagamento=new.pagamentopreferito)) then
		set new.pagamentopreferito=0;
    end if;
end if;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`carrello_BEFORE_DELETE` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`carrello_BEFORE_DELETE`
BEFORE DELETE ON `ecommerce`.`carrello`
FOR EACH ROW
BEGIN
if (select usereliminato from utente where utente.iduser=old.iduser) = 0 then 
SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'il carrello non puo essere eliminato';
end if;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`carrello_BEFORE_INSERT` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`carrello_BEFORE_INSERT`
BEFORE INSERT ON `ecommerce`.`carrello`
FOR EACH ROW
BEGIN
set new.idcarrello=new.iduser;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`carrello_BEFORE_UPDATE` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`carrello_BEFORE_UPDATE`
BEFORE UPDATE ON `ecommerce`.`carrello`
FOR EACH ROW
BEGIN
set new.datamodifica=current_timestamp();
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`userstore_BEFORE_DELETE` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`userstore_BEFORE_DELETE`
BEFORE DELETE ON `ecommerce`.`userstore`
FOR EACH ROW
BEGIN
if (select usereliminato from utente where utente.iduser=old.iduser) = 0 then 
SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'lo store non puo essere eliminato';
end if;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`userstore_BEFORE_INSERT` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`userstore_BEFORE_INSERT`
BEFORE INSERT ON `ecommerce`.`userstore`
FOR EACH ROW
BEGIN
set new.iduserstore=new.iduser;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`commenti_AFTER_DELETE` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`commenti_AFTER_DELETE`
AFTER DELETE ON `ecommerce`.`commenti`
FOR EACH ROW
BEGIN

update userstore set userstore.feedback = truncate((userstore.feedback - old.feedback)/userstore.commentitotali,1) where userstore.iduserstore=old.iduserstore;
update userstore set  userstore.commentitotali=userstore.commentitotali-1 where userstore.iduserstore=old.iduserstore;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`commenti_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`commenti_AFTER_INSERT`
AFTER INSERT ON `ecommerce`.`commenti`
FOR EACH ROW
BEGIN

update userstore set userstore.feedback = truncate(((new.feedback + userstore.feedback)/(userstore.commentitotali+1)),1) where userstore.iduserstore=NEW.iduserstore;
update userstore set userstore.commentitotali=userstore.commentitotali +1 where userstore.iduserstore=NEW.iduserstore;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`commenti_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`commenti_AFTER_UPDATE`
AFTER UPDATE ON `ecommerce`.`commenti`
FOR EACH ROW
BEGIN
if (old.feedback <> new.feedback) then 
	update userstore set userstore.feedback = truncate(((userstore.feedback - old.feedback) + new.feedback)/userstore.commentitotali,1) where userstore.iduserstore=new.iduserstore;
end if;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`commenti_BEFORE_INSERT` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`commenti_BEFORE_INSERT`
BEFORE INSERT ON `ecommerce`.`commenti`
FOR EACH ROW
BEGIN
if (not exists (select * from itemordine where (itemordine.idprodotto in (select idprodotto from prodotto where prodotto.iduserstore=new.iduserstore)) and (itemordine.idordine in (select ordine.idordine from ordine where ordine.iduser=new.iduser)))) then
 SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'NON PUOI METTERE UN COMMENTO SE NON HAI COMPRATO IL PRODOTTO';
END IF;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`commenti_BEFORE_INSERT_1` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`commenti_BEFORE_INSERT_1`
BEFORE INSERT ON `ecommerce`.`commenti`
FOR EACH ROW
BEGIN
if new.iduser=(select iduser from userstore where userstore.iduserstore=new.iduserstore) then 
SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'NON PUOI METTERE UN COMMENTO SE sei il venditore';
            end if;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`commenti_BEFORE_INSERT_2` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`commenti_BEFORE_INSERT_2`
BEFORE INSERT ON `ecommerce`.`commenti`
FOR EACH ROW
BEGIN
if (select usereliminato from utente where utente.iduser=(select iduser from userstore where userstore.iduserstore=new.iduserstore))=1 then
		SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'il venditore è eliminato';
	end if;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`commenti_BEFORE_UPDATE` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`commenti_BEFORE_UPDATE`
BEFORE UPDATE ON `ecommerce`.`commenti`
FOR EACH ROW
BEGIN
if new.iduser=(select iduser from userstore where userstore.iduserstore=new.iduserstore) then 
SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'NON PUOI METTERE UN COMMENTO SE sei il venditore';
            end if;

END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`commenti_BEFORE_UPDATE_1` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`commenti_BEFORE_UPDATE_1`
BEFORE UPDATE ON `ecommerce`.`commenti`
FOR EACH ROW
begin
if (not exists (select * from itemordine where (itemordine.idprodotto in (select idprodotto from prodotto where prodotto.iduserstore=new.iduserstore)) and (itemordine.idordine in (select ordine.idordine from ordine where ordine.iduser=new.iduser)))) then
 SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'NON PUOI METTERE UN COMMENTO SE NON HAI COMPRATO IL PRODOTTO';
END IF;
end$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`commenti_BEFORE_UPDATE_2` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`commenti_BEFORE_UPDATE_2`
BEFORE UPDATE ON `ecommerce`.`commenti`
FOR EACH ROW
begin
set new.datacommento = current_timestamp();
end$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`commenti_BEFORE_UPDATE_3` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`commenti_BEFORE_UPDATE_3`
BEFORE UPDATE ON `ecommerce`.`commenti`
FOR EACH ROW
BEGIN
if (select usereliminato from utente where utente.iduser=(select iduser from userstore where userstore.iduserstore=new.iduserstore))=1 then
		SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'il venditore è eliminato';
	end if;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`prodotto_AFTER_DELETE` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`prodotto_AFTER_DELETE`
AFTER DELETE ON `ecommerce`.`prodotto`
FOR EACH ROW
BEGIN
update categoria set categoria.quantitaprodotti=categoria.quantitaprodotti-1 where categoria.nomecategoria=old.nomecategoria;

END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`prodotto_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`prodotto_AFTER_INSERT`
AFTER INSERT ON `ecommerce`.`prodotto`
FOR EACH ROW
BEGIN
update categoria set categoria.quantitaprodotti=categoria.quantitaprodotti+1 where categoria.nomecategoria=new.nomecategoria;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`prodotto_AFTER_UPDATE_1` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`prodotto_AFTER_UPDATE_1`
AFTER UPDATE ON `ecommerce`.`prodotto`
FOR EACH ROW
begin
if (old.costospedizione <> new.costospedizione) or (old.prezzo <> new.prezzo) then
	update itemcarrello set itemcarrello.spedizionetotale = new.costospedizione where itemcarrello.idprodotto = new.idprodotto;
end if;
end$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`prodotto_AFTER_UPDATE_2` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`prodotto_AFTER_UPDATE_2`
AFTER UPDATE ON `ecommerce`.`prodotto`
FOR EACH ROW
if new.prodottoeliminato=1 then 
	update categoria set categoria.quantitaprodotti=categoria.quantitaprodotti-1 where categoria.nomecategoria=old.nomecategoria;
	delete from itemcarrello where itemcarrello.idprodotto=new.idprodotto;
end if$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`prodotto_BEFORE_INSERT` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`prodotto_BEFORE_INSERT`
BEFORE INSERT ON `ecommerce`.`prodotto`
FOR EACH ROW
BEGIN
if (new.quantitadisponibile<1) then
	SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'quantità errata';
end if;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`prodotto_BEFORE_UPDATE` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`prodotto_BEFORE_UPDATE`
BEFORE UPDATE ON `ecommerce`.`prodotto`
FOR EACH ROW
BEGIN
if (new.quantitadisponibile<0) then
	SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'quantità errata';
end if;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`prodotto_BEFORE_UPDATE_1` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`prodotto_BEFORE_UPDATE_1`
BEFORE UPDATE ON `ecommerce`.`prodotto`
FOR EACH ROW
BEGIN
if old.quantitadisponibile = 0 and new.quantitadisponibile>0 then
 set new.prodottoeliminato=0;
 end if;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemcarrello_AFTER_DELETE` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemcarrello_AFTER_DELETE`
AFTER DELETE ON `ecommerce`.`itemcarrello`
FOR EACH ROW
BEGIN
update carrello set carrello.numeroarticoli = carrello.numeroarticoli -1 where carrello.idcarrello=old.idcarrello;
update carrello set carrello.costototale = carrello.costototale - old.totalecosto where carrello.idcarrello=old.idcarrello;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemcarrello_AFTER_INSERT_1` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemcarrello_AFTER_INSERT_1`
AFTER INSERT ON `ecommerce`.`itemcarrello`
FOR EACH ROW
begin
update carrello set carrello.costototale=carrello.costototale+new.totalecosto where carrello.idcarrello=new.idcarrello;
update carrello set carrello.numeroarticoli = carrello.numeroarticoli +1 where carrello.idcarrello=new.idcarrello;
end$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemcarrello_AFTER_UPDATE_1` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemcarrello_AFTER_UPDATE_1`
AFTER UPDATE ON `ecommerce`.`itemcarrello`
FOR EACH ROW
begin
update carrello set carrello.costototale=(carrello.costototale - old.totalecosto) +new.totalecosto where carrello.idcarrello=new.idcarrello;
end$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemcarrello_BEFORE_INSERT` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemcarrello_BEFORE_INSERT`
BEFORE INSERT ON `ecommerce`.`itemcarrello`
FOR EACH ROW
BEGIN
if new.quantita <0 then
 SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'la quantita deve essere almeno 1';
END IF;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemcarrello_BEFORE_INSERT_1` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemcarrello_BEFORE_INSERT_1`
BEFORE INSERT ON `ecommerce`.`itemcarrello`
FOR EACH ROW
begin
declare k boolean;
declare c int;
if not new.iditemcarrello=1 then
set k = false;
set c = 0;
while not k do
set k =  not exists (select * from itemcarrello where itemcarrello.iditemcarrello=c+1 and itemcarrello.idcarrello=new.idcarrello);
set c = c+1;
end while;
set new.iditemcarrello=c;
end if;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemcarrello_BEFORE_INSERT_2` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemcarrello_BEFORE_INSERT_2`
BEFORE INSERT ON `ecommerce`.`itemcarrello`
FOR EACH ROW
begin
	declare k int;
	set k = (select prodotto.quantitadisponibile from prodotto where prodotto.idprodotto=new.idprodotto);
	if k > 0  then
		if new.quantita > k then
			set new.quantita = k ;
		end if;
	else
		SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'il prodotto è esaurito';
	end if;
    if (select prodotto.prodottoeliminato from prodotto where prodotto.idprodotto=new.idprodotto)=1 then
		SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'il prodotto è esaurito';
	end if;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemcarrello_BEFORE_INSERT_3` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemcarrello_BEFORE_INSERT_3`
BEFORE INSERT ON `ecommerce`.`itemcarrello`
FOR EACH ROW
begin
if (select iduser from carrello where carrello.idcarrello=new.idcarrello)=(select iduserstore from prodotto where prodotto.idprodotto=new.idprodotto) then 
SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'IL VENDITORE NON PUO COMPRARE DA SE STESSO';
END IF;
end$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemcarrello_BEFORE_INSERT_4` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemcarrello_BEFORE_INSERT_4`
BEFORE INSERT ON `ecommerce`.`itemcarrello`
FOR EACH ROW
BEGIN
set new.prodottitotale=new.quantita*(select prezzo from prodotto where prodotto.idprodotto=new.idprodotto);
set new.spedizionetotale = new.quantita*(select costospedizione from prodotto where prodotto.idprodotto=new.idprodotto);
set new.totalecosto= new.prodottitotale+new.spedizionetotale;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemcarrello_BEFORE_UPDATE` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemcarrello_BEFORE_UPDATE`
BEFORE UPDATE ON `ecommerce`.`itemcarrello`
FOR EACH ROW
BEGIN
set new.prodottitotale=new.quantita*(select prezzo from prodotto where prodotto.idprodotto=new.idprodotto);
set new.spedizionetotale = new.quantita*(select costospedizione from prodotto where prodotto.idprodotto=new.idprodotto);
set new.totalecosto= new.prodottitotale+new.spedizionetotale;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemcarrello_BEFORE_UPDATE_1` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemcarrello_BEFORE_UPDATE_1`
BEFORE UPDATE ON `ecommerce`.`itemcarrello`
FOR EACH ROW
begin
if new.quantita <0 then
 SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'la quantita deve essere almeno 1';
END IF;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemcarrello_BEFORE_UPDATE_2` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemcarrello_BEFORE_UPDATE_2`
BEFORE UPDATE ON `ecommerce`.`itemcarrello`
FOR EACH ROW
BEGIN
set new.dataaggiunta=current_timestamp();
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemcarrello_BEFORE_UPDATE_3` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemcarrello_BEFORE_UPDATE_3`
BEFORE UPDATE ON `ecommerce`.`itemcarrello`
FOR EACH ROW
begin
if (select iduser from carrello where carrello.idcarrello=new.idcarrello)=(select iduserstore from prodotto where prodotto.idprodotto=new.idprodotto) then 
SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'IL VENDITORE NON PUO COMPRARE DA SE STESSO';
END IF;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemcarrello_BEFORE_UPDATE_4` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemcarrello_BEFORE_UPDATE_4`
BEFORE UPDATE ON `ecommerce`.`itemcarrello`
FOR EACH ROW
begin
declare k int;
if old.quantita<>new.quantita then
	set k = (select prodotto.quantitadisponibile from prodotto where prodotto.idprodotto=new.idprodotto);
	if k > 0 then
		if new.quantita > k then
			set new.quantita = k ;
		end if;
	end if;
    if k < 0 then
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'il prodotto è esaurito';
	end if;
end if;
if (select prodotto.prodottoeliminato from prodotto where prodotto.idprodotto=new.idprodotto)=1 then
SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'il prodotto è esaurito';
end if;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`ordine_BEFORE_DELETE` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`ordine_BEFORE_DELETE`
BEFORE DELETE ON `ecommerce`.`ordine`
FOR EACH ROW
BEGIN

SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'ordine immutabile';

END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemordine_AFTER_DELETE` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemordine_AFTER_DELETE`
AFTER DELETE ON `ecommerce`.`itemordine`
FOR EACH ROW
BEGIN
update userstore set userstore.totaleordini=(userstore.totaleordini-1) where userstore.iduserstore= (select prodotto.iduserstore from prodotto where old.idprodotto=prodotto.idprodotto);
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemordine_AFTER_DELETE_1` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemordine_AFTER_DELETE_1`
AFTER DELETE ON `ecommerce`.`itemordine`
FOR EACH ROW
BEGIN
update ordine set ordine.totale = ordine.totale - old.totalecosto where ordine.idordine = old.idordine;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemordine_AFTER_DELETE_2` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemordine_AFTER_DELETE_2`
AFTER DELETE ON `ecommerce`.`itemordine`
FOR EACH ROW
BEGIN
delete from commenti where commenti.iduser=(select iduser from ordine where ordine.idordine=old.idordine) and commenti.idprodotto=old.idprodotto;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemordine_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemordine_AFTER_INSERT`
AFTER INSERT ON `ecommerce`.`itemordine`
FOR EACH ROW
BEGIN
update userstore set userstore.totaleordini=userstore.totaleordini +1 where userstore.iduserstore= (select prodotto.iduserstore from prodotto where new.idprodotto=prodotto.idprodotto);
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemordine_AFTER_INSERT_1` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemordine_AFTER_INSERT_1`
AFTER INSERT ON `ecommerce`.`itemordine`
FOR EACH ROW
begin
update ordine set ordine.totale = ordine.totale + new.totalecosto where ordine.idordine = new.idordine;
end$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemordine_BEFORE_INSERT` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemordine_BEFORE_INSERT`
BEFORE INSERT ON `ecommerce`.`itemordine`
FOR EACH ROW
BEGIN
if (select iduser from ordine where ordine.idordine=new.idordine)=(select iduserstore from prodotto where prodotto.idprodotto=new.idprodotto) then 
SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'IL VENDITORE NON PUO COMPRARE DA SE STESSO';
END IF;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemordine_BEFORE_INSERT_1` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemordine_BEFORE_INSERT_1`
BEFORE INSERT ON `ecommerce`.`itemordine`
FOR EACH ROW
BEGIN
if (select prodotto.prodottoeliminato from prodotto where prodotto.idprodotto=new.idprodotto)=1 then
		SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'il prodotto è esaurito';
	end if;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemordine_BEFORE_INSERT_2` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemordine_BEFORE_INSERT_2`
BEFORE INSERT ON `ecommerce`.`itemordine`
FOR EACH ROW
BEGIN
set new.totalecosto= new.prodottitotale+new.spedizionetotale;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemordine_BEFORE_UPDATE` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemordine_BEFORE_UPDATE`
BEFORE UPDATE ON `ecommerce`.`itemordine`
FOR EACH ROW
BEGIN

if (select iduser from ordine where ordine.idordine=new.idordine)=(select iduserstore from prodotto where prodotto.idprodotto=new.idprodotto) then 
SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'IL VENDITORE NON PUO COMPRARE DA SE STESSO';
END IF;
end$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemordine_BEFORE_UPDATE_1` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemordine_BEFORE_UPDATE_1`
BEFORE UPDATE ON `ecommerce`.`itemordine`
FOR EACH ROW
BEGIN
if (select prodotto.prodottoeliminato from prodotto where prodotto.idprodotto=new.idprodotto)=1 then
		SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'il prodotto è esaurito';
	end if;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`itemordine_BEFORE_UPDATE_2` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`itemordine_BEFORE_UPDATE_2`
BEFORE UPDATE ON `ecommerce`.`itemordine`
FOR EACH ROW
BEGIN
set new.totalecosto= new.prodottitotale+new.spedizionetotale;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`pagamento_AFTER_DELETE` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`pagamento_AFTER_DELETE`
AFTER DELETE ON `ecommerce`.`pagamento`
FOR EACH ROW
BEGIN
if (old.idpagamento = (select utente.pagamentopreferito from utente where utente.iduser=old.iduser)) then
	update utente set utente.pagamentopreferito=0 where utente.iduser=old.iduser;
end if;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`pagamento_BEFORE_INSERT` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`pagamento_BEFORE_INSERT`
BEFORE INSERT ON `ecommerce`.`pagamento`
FOR EACH ROW
BEGIN
if (new.scadenza < date(current_timestamp())) then 
	SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'la carta è scaduta';
end if;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`pagamento_BEFORE_INSERT_1` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`pagamento_BEFORE_INSERT_1`
BEFORE INSERT ON `ecommerce`.`pagamento`
FOR EACH ROW
begin
declare k boolean;
declare c int;
if not new.idpagamento=1 then
set k = false;
set c = 0;
while not k do
set k =  not exists (select * from pagamento where pagamento.idpagamento=c+1 and pagamento.iduser=new.iduser);
set c = c+1;
end while;
set new.idpagamento=c;
end if;
END$$

SHOW WARNINGS$$

USE `ecommerce`$$
DROP TRIGGER IF EXISTS `ecommerce`.`pagamento_BEFORE_UPDATE` $$
SHOW WARNINGS$$
USE `ecommerce`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `ecommerce`.`pagamento_BEFORE_UPDATE`
BEFORE UPDATE ON `ecommerce`.`pagamento`
FOR EACH ROW
BEGIN
if (new.scadenza < date(current_timestamp())) then 
	SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'la carta è scaduta';
end if;
END$$

SHOW WARNINGS$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
