
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Users` (
  `user_id` INT NOT NULL,
  `user_email` VARCHAR(90) NOT NULL,
  `user_Password` VARCHAR(400) NOT NULL,
  `date_of_joining` INT NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  `JSON_token` JSON NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_email_UNIQUE` (`user_email` ASC) VISIBLE,
  UNIQUE INDEX `user_name_UNIQUE` (`user_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Listings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Listings` (
  `listing_id` INT NOT NULL,
  `title` VARCHAR(2000) NOT NULL,
  `location` JSON NOT NULL,
  `date_of_posting` INT NOT NULL,
  `price` INT NOT NULL,
  `categoryId` INT NOT NULL,
  `ImageURI` LONGTEXT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`listing_id`),
  INDEX `fk_Listings_Users_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_Listings_Users`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Messages` (
  `messages_id` INT NOT NULL,
  PRIMARY KEY (`messages_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Group` (
  `Group_id` INT NOT NULL,
  PRIMARY KEY (`Group_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Contents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Contents` (
  `content_id` VARCHAR(45) NOT NULL,
  `Sender_Id` INT NOT NULL,
  `Reciever_Id` INT NOT NULL,
  `Content` VARCHAR(500) NULL,
  `date_of_posting` INT NOT NULL,
  `Status` ENUM("Read", "Unrecieved", "Recieved", "Not_sent") NOT NULL,
  `messages_id` INT NOT NULL,
  PRIMARY KEY (`content_id`, `messages_id`),
  UNIQUE INDEX `Sender_Id_UNIQUE` (`Sender_Id` ASC) VISIBLE,
  UNIQUE INDEX `Reciever_Id_UNIQUE` (`Reciever_Id` ASC) VISIBLE,
  INDEX `fk_Contents_Messages1_idx` (`messages_id` ASC) VISIBLE,
  UNIQUE INDEX `date_of_posting_UNIQUE` (`date_of_posting` ASC) VISIBLE,
  CONSTRAINT `fk_Contents_Messages1`
    FOREIGN KEY (`messages_id`)
    REFERENCES `mydb`.`Messages` (`messages_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Users_has_Messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Users_has_Messages` (
  `user_id` INT NOT NULL,
  `messages_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `messages_id`),
  INDEX `fk_Users_has_Messages_Messages1_idx` (`messages_id` ASC) VISIBLE,
  INDEX `fk_Users_has_Messages_Users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_Users_has_Messages_Users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_has_Messages_Messages1`
    FOREIGN KEY (`messages_id`)
    REFERENCES `mydb`.`Messages` (`messages_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Listings_found`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Listings_found` (
  `Finder_id` INT NOT NULL,
  `listing_id` INT NULL,
  `claimer_id` INT NULL,
  `time_stamp_of_claim` INT NULL,
  PRIMARY KEY (`Finder_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Listings_has_Listings_found`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Listings_has_Listings_found` (
  `Listings_listing_id` INT NOT NULL,
  `Listings_found_Finder_id` INT NOT NULL,
  PRIMARY KEY (`Listings_listing_id`, `Listings_found_Finder_id`),
  INDEX `fk_Listings_has_Listings_found_Listings_found1_idx` (`Listings_found_Finder_id` ASC) VISIBLE,
  INDEX `fk_Listings_has_Listings_found_Listings1_idx` (`Listings_listing_id` ASC) VISIBLE,
  CONSTRAINT `fk_Listings_has_Listings_found_Listings1`
    FOREIGN KEY (`Listings_listing_id`)
    REFERENCES `mydb`.`Listings` (`listing_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Listings_has_Listings_found_Listings_found1`
    FOREIGN KEY (`Listings_found_Finder_id`)
    REFERENCES `mydb`.`Listings_found` (`Finder_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
