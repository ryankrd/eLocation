-- MySQL Script create.sql

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb`;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`utilisateur`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`utilisateur`;

CREATE TABLE IF NOT EXISTS `mydb`.`utilisateur` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pseudo` VARCHAR(45) NOT NULL,
  `mdp` VARCHAR(45) NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(45) NOT NULL,
  `adresse` VARCHAR(45) NOT NULL,
  `sexe` ENUM('H', 'F') NOT NULL,
  `mail` VARCHAR(45) NOT NULL,
  `cp` CHAR(5) NOT NULL,
  `ville` VARCHAR(45) NOT NULL,
  `statut` ENUM('utilisateur', 'admin') NOT NULL,
  `etat` ENUM('fidele', 'lambda') NOT NULL,
  PRIMARY KEY (`id`))


-- -----------------------------------------------------
-- Table `mydb`.`article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`article`;

CREATE TABLE IF NOT EXISTS `mydb`.`article` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `prix_journee` CHAR(5) NOT NULL,
  `lien_photo` VARCHAR(45) NOT NULL,
  `statut` ENUM('dispo', 'loue', 'reserve') NOT NULL,
  `etat` ENUM('neuf', 'abime') NOT NULL,
  PRIMARY KEY (`id`))


-- -----------------------------------------------------
-- Table `mydb`.`action`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`action`;

CREATE TABLE IF NOT EXISTS `mydb`.`action` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `article_id` INT NOT NULL,
  `utilisateur_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_action_article1`
    FOREIGN KEY (`article_id`)
    REFERENCES `mydb`.`article` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_action_utilisateur1`
    FOREIGN KEY (`utilisateur_id`)
    REFERENCES `mydb`.`utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

CREATE INDEX `fk_action_article1_idx` ON `mydb`.`action` (`article_id` ASC);

CREATE INDEX `fk_action_utilisateur1_idx` ON `mydb`.`action` (`utilisateur_id` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`point_relais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`point_relais`;

CREATE TABLE IF NOT EXISTS `mydb`.`point_relais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `adresse` VARCHAR(45) NOT NULL,
  `horaire` VARCHAR(45) NOT NULL,
  `cp` CHAR(5) NOT NULL,
  `ville` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))

CREATE UNIQUE INDEX `adresse_UNIQUE` ON `mydb`.`point_relais` (`adresse` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`louer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`louer`;

CREATE TABLE IF NOT EXISTS `mydb`.`louer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date_location` DATE NULL,
  `date_butoire` DATE NULL,
  `date_reelle` DATE NULL,
  `note` CHAR(1) NULL,
  `commentaire` VARCHAR(45) NULL,
  `action_id` INT NOT NULL,
  `point_relais_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_location_action1`
    FOREIGN KEY (`action_id`)
    REFERENCES `mydb`.`action` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location_point_relais1`
    FOREIGN KEY (`point_relais_id`)
    REFERENCES `mydb`.`point_relais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

CREATE INDEX `fk_location_action1_idx` ON `mydb`.`louer` (`action_id` ASC);

CREATE INDEX `fk_location_point_relais1_idx` ON `mydb`.`louer` (`point_relais_id` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`avis`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`avis`;

CREATE TABLE IF NOT EXISTS `mydb`.`avis` (
  `id` INT NOT NULL,
  `note` VARCHAR(45) NULL,
  `commentaire` VARCHAR(45) NULL,
  `id_utilisateur` VARCHAR(45) NULL,
  `id_article` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))


-- -----------------------------------------------------
-- Table `mydb`.`categorie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`categorie`;

CREATE TABLE IF NOT EXISTS `mydb`.`categorie` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `promo` INT NULL,
  PRIMARY KEY (`id`))


-- -----------------------------------------------------
-- Table `mydb`.`appartenir`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`appartenir`;

CREATE TABLE IF NOT EXISTS `mydb`.`appartenir` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `categorie_id` INT NOT NULL,
  `article_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_appartenir_categorie`
    FOREIGN KEY (`categorie_id`)
    REFERENCES `mydb`.`categorie` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appartenir_article1`
    FOREIGN KEY (`article_id`)
    REFERENCES `mydb`.`article` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

CREATE INDEX `fk_appartenir_categorie_idx` ON `mydb`.`appartenir` (`categorie_id` ASC);

CREATE INDEX `fk_appartenir_article1_idx` ON `mydb`.`appartenir` (`article_id` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`vendre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`vendre`;

CREATE TABLE IF NOT EXISTS `mydb`.`vendre` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date_vente` DATE NOT NULL,
  `action_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_vente_action1`
    FOREIGN KEY (`action_id`)
    REFERENCES `mydb`.`action` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

CREATE INDEX `fk_vente_action1_idx` ON `mydb`.`vendre` (`action_id` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`num_proposition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`num_proposition`;

CREATE TABLE IF NOT EXISTS `mydb`.`num_proposition` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `date_propo` DATE NOT NULL,
  `utilisateur_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_num_proposition_utilisateur1`
    FOREIGN KEY (`utilisateur_id`)
    REFERENCES `mydb`.`utilisateur` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

CREATE INDEX `fk_num_proposition_utilisateur1_idx` ON `mydb`.`num_proposition` (`utilisateur_id` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`ligne_proposition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ligne_proposition`;

CREATE TABLE IF NOT EXISTS `mydb`.`ligne_proposition` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `prix` INT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `photo` BLOB NOT NULL,
  `stade` ENUM('proposition', 'offre', 'valide') NOT NULL,
  `num_proposition_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ligne_proposition_num_proposition1`
    FOREIGN KEY (`num_proposition_id`)
    REFERENCES `mydb`.`num_proposition` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

CREATE INDEX `fk_ligne_proposition_num_proposition1_idx` ON `mydb`.`ligne_proposition` (`num_proposition_id` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`ligne_vente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ligne_vente`;

CREATE TABLE IF NOT EXISTS `mydb`.`ligne_vente` (
   `id` INT NOT NULL AUTO_INCREMENT,
)


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
