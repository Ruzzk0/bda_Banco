-- esta cosa deldemonio
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `proyecto_banco_bda` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `proyecto_banco_bda` ;
-- las tablas q hay blah blah blah, prometo no ejercer esto--
-- -----------------------------------------------------
-- Table `proyecto_banco_bda`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_banco_bda`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(200) NOT NULL,
  `apellido_paterno` VARCHAR(200) NOT NULL,
  `apellido_materno` VARCHAR(200) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `calle` VARCHAR(300) NOT NULL,
  `colonia` VARCHAR(200) NOT NULL,
  `numero_interior` VARCHAR(5) NULL DEFAULT NULL,
  `numero_exterior` VARCHAR(10) NULL DEFAULT '0',
  `codigo_postal` VARCHAR(5) NOT NULL,
  `correo_cliente` VARCHAR(250) NOT NULL,
  `contrasenia_cliente` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto_banco_bda`.`cuentas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_banco_bda`.`cuentas` (
  `id_cuenta` INT NOT NULL AUTO_INCREMENT,
  `numero_cuenta` VARCHAR(16) NOT NULL,
  `fecha_apertura` DATE NOT NULL,
  `saldo_en_pesos` DOUBLE NOT NULL,
  `id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_cuenta`),
  UNIQUE INDEX `numero_cuenta_UNIQUE` (`numero_cuenta` ASC) VISIBLE,
  INDEX `cuentas_ibfk_1_idx` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `cuentas_ibfk_1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `proyecto_banco_bda`.`clientes` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto_banco_bda`.`transacciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_banco_bda`.`transacciones` (
  `id_transaccion` INT NOT NULL,
  `monto` INT NOT NULL,
  PRIMARY KEY (`id_transaccion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto_banco_bda`.`cuentastransacciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_banco_bda`.`cuentastransacciones` (
  `id_cuenta_transaccion` INT NOT NULL,
  `id_cuenta` INT NOT NULL,
  `id_transaccion` INT NOT NULL,
  `fecha_hora_transaccion` DATETIME NOT NULL,
  PRIMARY KEY (`id_cuenta_transaccion`),
  INDEX `id_transaccion` (`id_transaccion` ASC) VISIBLE,
  INDEX `fk_cuentastransacciones_1_idx` (`id_cuenta` ASC) VISIBLE,
  CONSTRAINT `cuentastransacciones_ibfk_1`
    FOREIGN KEY (`id_transaccion`)
    REFERENCES `proyecto_banco_bda`.`transacciones` (`id_transaccion`),
  CONSTRAINT `id_cuenta`
    FOREIGN KEY (`id_cuenta`)
    REFERENCES `proyecto_banco_bda`.`cuentas` (`id_cuenta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto_banco_bda`.`transaccionesretirosintarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_banco_bda`.`transaccionesretirosintarjeta` (
  `id_transacciones_retiro_sin_tarjeta` INT NOT NULL,
  `folio` INT GENERATED ALWAYS AS ((`id_transacciones_retiro_sin_tarjeta` + 1000)) VIRTUAL,
  `contrasenia` INT GENERATED ALWAYS AS ((`id_transacciones_retiro_sin_tarjeta` * 2)) VIRTUAL,
  PRIMARY KEY (`id_transacciones_retiro_sin_tarjeta`),
  UNIQUE INDEX `folio_UNIQUE` (`folio` ASC) VISIBLE,
  UNIQUE INDEX `contrasenia_UNIQUE` (`contrasenia` ASC) VISIBLE,
  CONSTRAINT `id_transacciones_retiro_sin_tarjeta`
    FOREIGN KEY (`id_transacciones_retiro_sin_tarjeta`)
    REFERENCES `proyecto_banco_bda`.`transacciones` (`id_transaccion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto_banco_bda`.`transaccionestransferencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_banco_bda`.`transaccionestransferencia` (
  `idtransaccionesTransferencia` INT NOT NULL,
  `cuenta_destino` INT NOT NULL,
  PRIMARY KEY (`idtransaccionesTransferencia`),
  CONSTRAINT `idtransaccionesTransferencia`
    FOREIGN KEY (`idtransaccionesTransferencia`)
    REFERENCES `proyecto_banco_bda`.`transacciones` (`id_transaccion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
