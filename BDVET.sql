SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `DBVeterinaria` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `DBVeterinaria` ;

-- -----------------------------------------------------
-- Table `DBVeterinaria`.`Clientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DBVeterinaria`.`Clientes` ;

CREATE  TABLE IF NOT EXISTS `DBVeterinaria`.`Clientes` (
  `IDCLI` INT NOT NULL COMMENT 'Identificacion del cliente (Cedula, Pasaporte, Cedula Juridica)' ,
  `NOMCLI` VARCHAR(50) NOT NULL COMMENT 'Nombre del cliente' ,
  `APECLI` VARCHAR(100) NOT NULL COMMENT 'Apellido del cliente' ,
  `DNICLI` VARCHAR(20) NOT NULL COMMENT 'Identificacion del cliente (cedula, pasaporte, cedula juridica)' ,
  `DIRCLI` VARCHAR(150) NOT NULL COMMENT 'Direccion del cliente' ,
  `TELCLI` VARCHAR(10) NOT NULL COMMENT 'Numero telefono del cliente' ,
  PRIMARY KEY (`IDCLI`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBVeterinaria`.`TipoPago`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DBVeterinaria`.`TipoPago` ;

CREATE  TABLE IF NOT EXISTS `DBVeterinaria`.`TipoPago` (
  `IDPAG` INT NOT NULL COMMENT 'identificador' ,
  `DESCPAG` VARCHAR(45) NOT NULL COMMENT 'descripcion del tipo de pago' ,
  `COMPAG` VARCHAR(45) NOT NULL COMMENT 'comprobante del tipo de pago ' ,
  PRIMARY KEY (`IDPAG`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBVeterinaria`.`Loggin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DBVeterinaria`.`Loggin` ;

CREATE  TABLE IF NOT EXISTS `DBVeterinaria`.`Loggin` (
  `USER` VARCHAR(20) NOT NULL COMMENT 'Nombre de usuario' ,
  `PASS` VARCHAR(20) NOT NULL COMMENT 'Contraseña del usuario' ,
  `EMAIL` VARCHAR(50) NULL COMMENT 'Email del usuario (en un futuro modulo para recuperar contraseña)' ,
  `ROLL` VARCHAR(10) NOT NULL COMMENT 'Rol que desempeña el usuario en el sistema.' ,
  PRIMARY KEY (`USER`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBVeterinaria`.`Pedidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DBVeterinaria`.`Pedidos` ;

CREATE  TABLE IF NOT EXISTS `DBVeterinaria`.`Pedidos` (
  `IDPED` INT NOT NULL COMMENT 'Identificador del pedido' ,
  `FECPED` DATE NOT NULL COMMENT 'Fecha del pedido' ,
  `ESTPED` VARCHAR(25) NOT NULL COMMENT 'Estado del pedido\n' ,
  `IDVEND` INT NOT NULL COMMENT 'Identificacion del vendedor que genera el pedido.' ,
  `IDPAGO` VARCHAR(45) NOT NULL COMMENT 'id del tipo de pago, ya sea mediante un cheque o pago en efectivo.' ,
  `Clientes_IDCLI` INT NOT NULL COMMENT 'Relacion con la tabla cliente (IDCLI)' ,
  `TipoPago_IDPAG` INT NOT NULL ,
  `Loggin_USER` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`IDPED`) ,
  INDEX `fk_Pedidos_Clientes` (`Clientes_IDCLI` ASC) ,
  INDEX `fk_Pedidos_TipoPago1` (`TipoPago_IDPAG` ASC) ,
  INDEX `fk_Pedidos_Loggin1` (`Loggin_USER` ASC) ,
  CONSTRAINT `fk_Pedidos_Clientes`
    FOREIGN KEY (`Clientes_IDCLI` )
    REFERENCES `DBVeterinaria`.`Clientes` (`IDCLI` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_TipoPago1`
    FOREIGN KEY (`TipoPago_IDPAG` )
    REFERENCES `DBVeterinaria`.`TipoPago` (`IDPAG` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_Loggin1`
    FOREIGN KEY (`Loggin_USER` )
    REFERENCES `DBVeterinaria`.`Loggin` (`USER` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBVeterinaria`.`Proveedores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DBVeterinaria`.`Proveedores` ;

CREATE  TABLE IF NOT EXISTS `DBVeterinaria`.`Proveedores` (
  `IDPROV` INT NOT NULL COMMENT 'Numero de identificacion del proveedor.' ,
  `NOMPROV` VARCHAR(50) NOT NULL COMMENT 'Nombre de la empresa proveedora.\n' ,
  `TELPROV` VARCHAR(10) NOT NULL COMMENT 'Numero de telefono del proveedor.' ,
  `EMAILPROV` VARCHAR(45) NULL COMMENT 'Email del proveedor.' ,
  `DIRPROV` VARCHAR(100) NULL COMMENT 'Direccion fisica del proveedor.\n' ,
  `REPPROV` VARCHAR(50) NOT NULL COMMENT 'Representante del proveedor' ,
  `TELREPPROV` VARCHAR(10) NOT NULL COMMENT 'Numero del representante del proveeddor' ,
  PRIMARY KEY (`IDPROV`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBVeterinaria`.`productos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DBVeterinaria`.`productos` ;

CREATE  TABLE IF NOT EXISTS `DBVeterinaria`.`productos` (
  `IDPROD` INT NOT NULL COMMENT 'Codigo del producto\n' ,
  `DESCPROD` VARCHAR(100) NOT NULL COMMENT 'Descripcion o detalle del producto' ,
  `STOCKPROD` VARCHAR(10) NOT NULL COMMENT 'Cantidad de productos disponibles' ,
  `PREPROD` FLOAT NOT NULL COMMENT 'Precio unitario del producto' ,
  `Proveedores_IDPROV` INT NOT NULL ,
  PRIMARY KEY (`IDPROD`) ,
  INDEX `fk_productos_Proveedores1` (`Proveedores_IDPROV` ASC) ,
  CONSTRAINT `fk_productos_Proveedores1`
    FOREIGN KEY (`Proveedores_IDPROV` )
    REFERENCES `DBVeterinaria`.`Proveedores` (`IDPROV` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBVeterinaria`.`DetallePedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DBVeterinaria`.`DetallePedido` ;

CREATE  TABLE IF NOT EXISTS `DBVeterinaria`.`DetallePedido` (
  `IDDET` INT NOT NULL COMMENT 'Identificador del detalle de producto' ,
  `CANTPROD` INT NOT NULL COMMENT 'Cantidad de productos' ,
  `MONTPED` FLOAT NOT NULL COMMENT 'Monto del producto por la ccantidad' ,
  `Pedidos_IDPED` INT NOT NULL COMMENT 'Relacion con la tabla Pedidos IDPED' ,
  `Pedidos_Clientes_IDCLI` INT NOT NULL COMMENT 'Relacion con la tabla clientes (se jala de Pedido IDCLI)' ,
  `productos_IDPROD` INT NOT NULL COMMENT 'Relacion con la tabla productos IDPROD' ,
  PRIMARY KEY (`IDDET`) ,
  INDEX `fk_DetallePedido_Pedidos1` (`Pedidos_IDPED` ASC, `Pedidos_Clientes_IDCLI` ASC) ,
  INDEX `fk_DetallePedido_productos1` (`productos_IDPROD` ASC) ,
  CONSTRAINT `fk_DetallePedido_Pedidos1`
    FOREIGN KEY (`Pedidos_IDPED` , `Pedidos_Clientes_IDCLI` )
    REFERENCES `DBVeterinaria`.`Pedidos` (`IDPED` , `Clientes_IDCLI` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DetallePedido_productos1`
    FOREIGN KEY (`productos_IDPROD` )
    REFERENCES `DBVeterinaria`.`productos` (`IDPROD` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
