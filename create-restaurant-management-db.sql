-- MySQL Script generated by MySQL Workbench
-- Mon Nov  7 13:06:54 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema restaurant_management
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema restaurant_management
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `restaurant_management` DEFAULT CHARACTER SET utf8 ;
USE `restaurant_management` ;

-- -----------------------------------------------------
-- Table `restaurant_management`.`addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant_management`.`addresses` ;

CREATE TABLE IF NOT EXISTS `restaurant_management`.`addresses` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `street_1` VARCHAR(45) NOT NULL,
  `street_2` VARCHAR(45) NULL,
  `city` VARCHAR(40) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `zip_code` DECIMAL(5,0) NOT NULL,
  PRIMARY KEY (`address_id`),
  UNIQUE INDEX `Id_franchise_UNIQUE` (`address_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant_management`.`franchises`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant_management`.`franchises` ;

CREATE TABLE IF NOT EXISTS `restaurant_management`.`franchises` (
  `franchise_id` INT NOT NULL AUTO_INCREMENT,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`franchise_id`),
  UNIQUE INDEX `franchise_id_UNIQUE` (`franchise_id` ASC),
  INDEX `fk_franchises_addresses1_idx` (`address_id` ASC),
  CONSTRAINT `fk_franchises_addresses1`
    FOREIGN KEY (`address_id`)
    REFERENCES `restaurant_management`.`addresses` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant_management`.`people`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant_management`.`people` ;

CREATE TABLE IF NOT EXISTS `restaurant_management`.`people` (
  `person_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `dob` DATE NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`person_id`),
  UNIQUE INDEX `people_id_UNIQUE` (`person_id` ASC),
  INDEX `fk_people_addresses1_idx` (`address_id` ASC),
  CONSTRAINT `fk_people_addresses1`
    FOREIGN KEY (`address_id`)
    REFERENCES `restaurant_management`.`addresses` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant_management`.`inspections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant_management`.`inspections` ;

CREATE TABLE IF NOT EXISTS `restaurant_management`.`inspections` (
  `inspection_id` INT NOT NULL AUTO_INCREMENT,
  `inspection_date` DATE NOT NULL,
  `inspection_score` TINYINT(1) NULL DEFAULT NULL,
  `franchise_id` INT NOT NULL,
  `inspector_person_id` INT NOT NULL,
  PRIMARY KEY (`inspection_id`),
  UNIQUE INDEX `inspection_id_UNIQUE` (`inspection_id` ASC),
  INDEX `fk_inspections_franchises_idx` (`franchise_id` ASC),
  INDEX `fk_inspections_people1_idx` (`inspector_person_id` ASC),
  CONSTRAINT `fk_inspections_franchises`
    FOREIGN KEY (`franchise_id`)
    REFERENCES `restaurant_management`.`franchises` (`franchise_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inspections_people1`
    FOREIGN KEY (`inspector_person_id`)
    REFERENCES `restaurant_management`.`people` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant_management`.`dishes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant_management`.`dishes` ;

CREATE TABLE IF NOT EXISTS `restaurant_management`.`dishes` (
  `dish_id` INT NOT NULL AUTO_INCREMENT,
  `dish_name` VARCHAR(30) NOT NULL,
  `dish_price` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`dish_id`),
  UNIQUE INDEX `dish_id_UNIQUE` (`dish_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant_management`.`ingredients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant_management`.`ingredients` ;

CREATE TABLE IF NOT EXISTS `restaurant_management`.`ingredients` (
  `ingredient_id` INT NOT NULL AUTO_INCREMENT,
  `ingredient_name` VARCHAR(30) NOT NULL,
  `ingredient_price` DECIMAL(5,2) NOT NULL,
  `ingredient_units` VARCHAR(30),
  `ingredient_units_plural` VARCHAR(30),
  PRIMARY KEY (`ingredient_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant_management`.`position`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant_management`.`position` ;

CREATE TABLE IF NOT EXISTS `restaurant_management`.`position` (
  `position_id` INT NOT NULL AUTO_INCREMENT,
  `position_name` VARCHAR(45) NOT NULL,
  `hourly_wage` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`position_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant_management`.`employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant_management`.`employees` ;

CREATE TABLE IF NOT EXISTS `restaurant_management`.`employees` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `position_id` INT NOT NULL,
  `person_id` INT NOT NULL,
  `franchise_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE INDEX `idemployees_UNIQUE` (`employee_id` ASC),
  INDEX `fk_employees_position_idx` (`position_id` ASC),
  INDEX `fk_employees_people1_idx` (`person_id` ASC),
  INDEX `fk_employees_franchises1_idx` (`franchise_id` ASC),
  CONSTRAINT `fk_employees_position`
    FOREIGN KEY (`position_id`)
    REFERENCES `restaurant_management`.`position` (`position_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_people1`
    FOREIGN KEY (`person_id`)
    REFERENCES `restaurant_management`.`people` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_franchises1`
    FOREIGN KEY (`franchise_id`)
    REFERENCES `restaurant_management`.`franchises` (`franchise_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant_management`.`inspections_employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant_management`.`inspections_employees` ;

CREATE TABLE IF NOT EXISTS `restaurant_management`.`inspections_employees` (
  `inspections_employees_id` INT NOT NULL AUTO_INCREMENT,
  `inspection_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`inspections_employees_id`),
  UNIQUE INDEX `inspections_employees_id_UNIQUE` (`inspections_employees_id` ASC),
  INDEX `fk_inspections_employees_inspections1_idx` (`inspection_id` ASC),
  INDEX `fk_inspections_employees_employees1_idx` (`employee_id` ASC),
  CONSTRAINT `fk_inspections_employees_inspections1`
    FOREIGN KEY (`inspection_id`)
    REFERENCES `restaurant_management`.`inspections` (`inspection_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inspections_employees_employees1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `restaurant_management`.`employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant_management`.`customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant_management`.`customers` ;

CREATE TABLE IF NOT EXISTS `restaurant_management`.`customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `person_id` INT NOT NULL,
  `favorite_dish_id` INT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `id_customer_UNIQUE` (`customer_id` ASC),
  INDEX `fk_customers_people1_idx` (`person_id` ASC),
  INDEX `fk_customers_dishes1_idx` (`favorite_dish_id` ASC),
  CONSTRAINT `fk_customers_people1`
    FOREIGN KEY (`person_id`)
    REFERENCES `restaurant_management`.`people` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customers_dishes1`
    FOREIGN KEY (`favorite_dish_id`)
    REFERENCES `restaurant_management`.`dishes` (`dish_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant_management`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant_management`.`orders` ;

CREATE TABLE IF NOT EXISTS `restaurant_management`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `franchise_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC),
  INDEX `fk_orders_franchises1_idx` (`franchise_id` ASC),
  INDEX `fk_orders_employees1_idx` (`employee_id` ASC),
  INDEX `fk_orders_customers1_idx` (`customer_id` ASC),
  CONSTRAINT `fk_orders_franchises1`
    FOREIGN KEY (`franchise_id`)
    REFERENCES `restaurant_management`.`franchises` (`franchise_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_employees1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `restaurant_management`.`employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `restaurant_management`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant_management`.`order_dishes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant_management`.`order_dishes` ;

CREATE TABLE IF NOT EXISTS `restaurant_management`.`order_dishes` (
  `order_dishes_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `dish_id` INT NOT NULL,
  PRIMARY KEY (`order_dishes_id`),
  UNIQUE INDEX `order_dishes_id_UNIQUE` (`order_dishes_id` ASC),
  INDEX `fk_order_dishes_orders1_idx` (`order_id` ASC),
  INDEX `fk_order_dishes_dishes1_idx` (`dish_id` ASC),
  CONSTRAINT `fk_order_dishes_orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `restaurant_management`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_dishes_dishes1`
    FOREIGN KEY (`dish_id`)
    REFERENCES `restaurant_management`.`dishes` (`dish_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant_management`.`dish_ingredients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant_management`.`dish_ingredients` ;

CREATE TABLE IF NOT EXISTS `restaurant_management`.`dish_ingredients` (
  `dish_ingredients_id` INT NOT NULL AUTO_INCREMENT,
  `dish_id` INT NOT NULL,
  `ingredient_id` INT NOT NULL,
  `ingredient_amount` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`dish_ingredients_id`),
  UNIQUE INDEX `dish_ingredients_id_UNIQUE` (`dish_ingredients_id` ASC),
  INDEX `fk_dish_ingredients_dishes1_idx` (`dish_id` ASC),
  INDEX `fk_dish_ingredients_ingredients1_idx` (`ingredient_id` ASC),
  CONSTRAINT `fk_dish_ingredients_dishes1`
    FOREIGN KEY (`dish_id`)
    REFERENCES `restaurant_management`.`dishes` (`dish_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dish_ingredients_ingredients1`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `restaurant_management`.`ingredients` (`ingredient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant_management`.`time_off_requests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant_management`.`time_off_requests` ;

CREATE TABLE IF NOT EXISTS `restaurant_management`.`time_off_requests` (
  `request_id` INT NOT NULL AUTO_INCREMENT,
  `date_requested_off` DATE NOT NULL,
  `date_when_requested` TIMESTAMP(2) NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`request_id`),
  UNIQUE INDEX `id_time_off_UNIQUE` (`request_id` ASC),
  INDEX `fk_time_off_requests_employees1_idx` (`employee_id` ASC),
  CONSTRAINT `fk_time_off_requests_employees1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `restaurant_management`.`employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant_management`.`payroll`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant_management`.`payroll` ;

CREATE TABLE IF NOT EXISTS `restaurant_management`.`payroll` (
  `payroll_id` INT NOT NULL AUTO_INCREMENT,
  `clock_in` TIMESTAMP(4) NOT NULL,
  `clock_out` TIMESTAMP(4) NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`payroll_id`),
  UNIQUE INDEX `idpayroll_UNIQUE` (`payroll_id` ASC),
  INDEX `fk_payroll_employees1_idx` (`employee_id` ASC),
  CONSTRAINT `fk_payroll_employees1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `restaurant_management`.`employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
