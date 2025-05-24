/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _diagnosistoencounters
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_diagnosistoencounters`;
CREATE TABLE `_diagnosistoencounters` (
  `A` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `B` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `_DiagnosisToEncounters_AB_unique` (`A`, `B`),
  KEY `_DiagnosisToEncounters_B_index` (`B`),
  CONSTRAINT `_DiagnosisToEncounters_A_fkey` FOREIGN KEY (`A`) REFERENCES `diagnosis` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `_DiagnosisToEncounters_B_fkey` FOREIGN KEY (`B`) REFERENCES `encounters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _prisma_migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_prisma_migrations`;
CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logs` text COLLATE utf8mb4_unicode_ci,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `applied_steps_count` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: accounts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `passHash` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `menu` json DEFAULT NULL,
  `role` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `createdById` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updatedById` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: admission
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admission`;
CREATE TABLE `admission` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `encounter_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adm_date` datetime(3) DEFAULT NULL,
  `admitted_for` int DEFAULT NULL,
  `discharged_on` datetime(3) DEFAULT NULL,
  `nok_phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ward_matron` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Admission_encounter_id_key` (`encounter_id`),
  CONSTRAINT `Admission_encounter_id_fkey` FOREIGN KEY (`encounter_id`) REFERENCES `encounters` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: anc
# ------------------------------------------------------------

DROP TABLE IF EXISTS `anc`;
CREATE TABLE `anc` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `encounter_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ega` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fe_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fe_liq_vol` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fe_abnormality` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fe_diagnosis` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fe_live` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `placenta_pos` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `edd` datetime(3) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `anc_encounter_id_fkey` (`encounter_id`),
  CONSTRAINT `anc_encounter_id_fkey` FOREIGN KEY (`encounter_id`) REFERENCES `encounters` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: authhistory
# ------------------------------------------------------------

DROP TABLE IF EXISTS `authhistory`;
CREATE TABLE `authhistory` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `accountId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loggedInAt` datetime(3) DEFAULT NULL,
  `loggedOutAt` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `AuthHistory_accountId_fkey` (`accountId`),
  CONSTRAINT `AuthHistory_accountId_fkey` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: care
# ------------------------------------------------------------

DROP TABLE IF EXISTS `care`;
CREATE TABLE `care` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: delivery
# ------------------------------------------------------------

DROP TABLE IF EXISTS `delivery`;
CREATE TABLE `delivery` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `encounter_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parity` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_diag` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_outcome` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `labour_duration` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_date` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  `delivery_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `placenta_delivery` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apgar_score` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `baby_maturity` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `baby_weight` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `baby_sex` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `baby_outcome` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `congenital_no` int DEFAULT NULL,
  `midwife` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` int DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Delivery_encounter_id_fkey` (`encounter_id`),
  CONSTRAINT `Delivery_encounter_id_fkey` FOREIGN KEY (`encounter_id`) REFERENCES `encounters` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: diagnosis
# ------------------------------------------------------------

DROP TABLE IF EXISTS `diagnosis`;
CREATE TABLE `diagnosis` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: drugpurchases
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drugpurchases`;
CREATE TABLE `drugpurchases` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `drug_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price` int DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` int DEFAULT NULL,
  `date` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  `createdById` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `DrugPurchases_drug_id_fkey` (`drug_id`),
  KEY `DrugPurchases_createdById_fkey` (`createdById`),
  CONSTRAINT `DrugPurchases_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `DrugPurchases_drug_id_fkey` FOREIGN KEY (`drug_id`) REFERENCES `drugsinventory` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: drugsgiven
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drugsgiven`;
CREATE TABLE `drugsgiven` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` int DEFAULT '0',
  `price` int DEFAULT '0',
  `quantity` int DEFAULT '0',
  `drug_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `encounter_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `year` int DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `DrugsGiven_drug_id_fkey` (`drug_id`),
  KEY `DrugsGiven_encounter_id_fkey` (`encounter_id`),
  CONSTRAINT `DrugsGiven_drug_id_fkey` FOREIGN KEY (`drug_id`) REFERENCES `drugsinventory` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `DrugsGiven_encounter_id_fkey` FOREIGN KEY (`encounter_id`) REFERENCES `encounters` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: drugsinventory
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drugsinventory`;
CREATE TABLE `drugsinventory` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `drug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock_qty` int NOT NULL DEFAULT '0',
  `added` int DEFAULT '0',
  `rate` int DEFAULT '0',
  `createdById` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updatedById` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `DrugsInventory_updatedById_fkey` (`updatedById`),
  CONSTRAINT `DrugsInventory_updatedById_fkey` FOREIGN KEY (`updatedById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: encounters
# ------------------------------------------------------------

DROP TABLE IF EXISTS `encounters`;
CREATE TABLE `encounters` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `patient_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` int DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enc_date` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  `time` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admitted` tinyint(1) NOT NULL DEFAULT '0',
  `outcome` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `care_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdById` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updatedById` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Encounters_patient_id_fkey` (`patient_id`),
  KEY `Encounters_care_id_fkey` (`care_id`),
  KEY `Encounters_updatedById_fkey` (`updatedById`),
  CONSTRAINT `Encounters_care_id_fkey` FOREIGN KEY (`care_id`) REFERENCES `care` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `Encounters_patient_id_fkey` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `Encounters_updatedById_fkey` FOREIGN KEY (`updatedById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: fees
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fees`;
CREATE TABLE `fees` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: followups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `followups`;
CREATE TABLE `followups` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `encounter_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` int DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Followups_encounter_id_fkey` (`encounter_id`),
  CONSTRAINT `Followups_encounter_id_fkey` FOREIGN KEY (`encounter_id`) REFERENCES `encounters` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: immunization
# ------------------------------------------------------------

DROP TABLE IF EXISTS `immunization`;
CREATE TABLE `immunization` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `encounter_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime(3) DEFAULT NULL,
  `next_date` datetime(3) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Immunization_encounter_id_fkey` (`encounter_id`),
  CONSTRAINT `Immunization_encounter_id_fkey` FOREIGN KEY (`encounter_id`) REFERENCES `encounters` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: labtest
# ------------------------------------------------------------

DROP TABLE IF EXISTS `labtest`;
CREATE TABLE `labtest` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `encounter_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `test_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `result` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rate` int DEFAULT NULL,
  `info` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `year` int DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `LabTest_encounter_id_fkey` (`encounter_id`),
  KEY `LabTest_test_id_fkey` (`test_id`),
  CONSTRAINT `LabTest_encounter_id_fkey` FOREIGN KEY (`encounter_id`) REFERENCES `encounters` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `LabTest_test_id_fkey` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: operations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `operations`;
CREATE TABLE `operations` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `encounter_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `procedureId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `proc_date` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `surgeon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assistant` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `outcome` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `anaesthesia` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` int DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Operations_encounter_id_fkey` (`encounter_id`),
  KEY `Operations_procedureId_fkey` (`procedureId`),
  CONSTRAINT `Operations_encounter_id_fkey` FOREIGN KEY (`encounter_id`) REFERENCES `encounters` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `Operations_procedureId_fkey` FOREIGN KEY (`procedureId`) REFERENCES `procedures` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: patients
# ------------------------------------------------------------

DROP TABLE IF EXISTS `patients`;
CREATE TABLE `patients` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hosp_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `year` int DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sex` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `age` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `occupation` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `religion` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reg_date` datetime(3) DEFAULT NULL,
  `createdById` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updatedById` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  `group_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `townId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Patients_updatedById_fkey` (`updatedById`),
  KEY `Patients_group_id_fkey` (`group_id`),
  KEY `Patients_townId_fkey` (`townId`),
  CONSTRAINT `Patients_group_id_fkey` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `Patients_townId_fkey` FOREIGN KEY (`townId`) REFERENCES `town` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `Patients_updatedById_fkey` FOREIGN KEY (`updatedById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: payment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `itemId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paid` int NOT NULL,
  `method` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'payment',
  `year` int DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  `tnxId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdById` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Payment_itemId_fkey` (`itemId`),
  KEY `Payment_tnxId_fkey` (`tnxId`),
  KEY `Payment_createdById_fkey` (`createdById`),
  CONSTRAINT `Payment_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `Payment_itemId_fkey` FOREIGN KEY (`itemId`) REFERENCES `tnxitem` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Payment_tnxId_fkey` FOREIGN KEY (`tnxId`) REFERENCES `transaction` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: prescriptionhist
# ------------------------------------------------------------

DROP TABLE IF EXISTS `prescriptionhist`;
CREATE TABLE `prescriptionhist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `drug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hosp_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `rate` int DEFAULT '0',
  `price` int DEFAULT '0',
  `stock_remain` int DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `time` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` int DEFAULT NULL,
  `given_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enc_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `prescriptionHist_given_id_fkey` (`given_id`),
  KEY `prescriptionHist_enc_id_fkey` (`enc_id`),
  CONSTRAINT `prescriptionHist_enc_id_fkey` FOREIGN KEY (`enc_id`) REFERENCES `encounters` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `prescriptionHist_given_id_fkey` FOREIGN KEY (`given_id`) REFERENCES `drugsgiven` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 17 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: procedures
# ------------------------------------------------------------

DROP TABLE IF EXISTS `procedures`;
CREATE TABLE `procedures` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: reciept
# ------------------------------------------------------------

DROP TABLE IF EXISTS `reciept`;
CREATE TABLE `reciept` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tnxId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `year` int NOT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  `createdById` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `items` json NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Reciept_tnxId_fkey` (`tnxId`),
  KEY `Reciept_createdById_fkey` (`createdById`),
  CONSTRAINT `Reciept_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `Reciept_tnxId_fkey` FOREIGN KEY (`tnxId`) REFERENCES `transaction` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: snapshot
# ------------------------------------------------------------

DROP TABLE IF EXISTS `snapshot`;
CREATE TABLE `snapshot` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` json DEFAULT NULL,
  `year` int DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: stockshistory
# ------------------------------------------------------------

DROP TABLE IF EXISTS `stockshistory`;
CREATE TABLE `stockshistory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `drug_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock_qty` int DEFAULT NULL,
  `added` int DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` int DEFAULT NULL,
  `updatedById` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `StocksHistory_drug_id_fkey` (`drug_id`),
  KEY `StocksHistory_updatedById_fkey` (`updatedById`),
  CONSTRAINT `StocksHistory_drug_id_fkey` FOREIGN KEY (`drug_id`) REFERENCES `drugsinventory` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `StocksHistory_updatedById_fkey` FOREIGN KEY (`updatedById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: tests
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tests`;
CREATE TABLE `tests` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: tnxitem
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tnxitem`;
CREATE TABLE `tnxitem` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transactionId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int NOT NULL,
  `paid` int NOT NULL,
  `year` int DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  `balance` int NOT NULL,
  `feeId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `TnxItem_transactionId_fkey` (`transactionId`),
  KEY `TnxItem_feeId_fkey` (`feeId`),
  CONSTRAINT `TnxItem_feeId_fkey` FOREIGN KEY (`feeId`) REFERENCES `fees` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `TnxItem_transactionId_fkey` FOREIGN KEY (`transactionId`) REFERENCES `transaction` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: town
# ------------------------------------------------------------

DROP TABLE IF EXISTS `town`;
CREATE TABLE `town` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: transaction
# ------------------------------------------------------------

DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` int NOT NULL,
  `balance` int NOT NULL,
  `year` int NOT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdById` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updatedById` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  `patientId` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Transaction_updatedById_fkey` (`updatedById`),
  KEY `Transaction_patientId_fkey` (`patientId`),
  CONSTRAINT `Transaction_patientId_fkey` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `Transaction_updatedById_fkey` FOREIGN KEY (`updatedById`) REFERENCES `accounts` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: _diagnosistoencounters
# ------------------------------------------------------------

INSERT INTO
  `_diagnosistoencounters` (`A`, `B`)
VALUES
  (
    'cm5futgxg003puqowdki7wszk',
    '348af011-6898-4c40-9e26-de063ac6cfba'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: _prisma_migrations
# ------------------------------------------------------------

INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    '1e382176-1f6f-4dfd-a44e-25056b61f76e',
    'ca81b3417ac8651ea957d7bc70babd9d5e5e43d8764663f251903b49c94183ac',
    '2025-03-31 10:22:33.810',
    '20250331102233_updated_tnx',
    NULL,
    NULL,
    '2025-03-31 10:22:33.541',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    '4e85e3a6-2155-4cbb-ab3d-9962e9a78039',
    'a2ec3c069bb66b529acd4a0a6d4d414cd2e7be9c618b295ed1017aedaaf86e26',
    '2025-04-06 10:25:50.569',
    '20250406102550_no',
    NULL,
    NULL,
    '2025-04-06 10:25:50.432',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    '5f7e73c8-1005-4ff6-950f-62a3df7adf3c',
    'a1009dfee3cdb32569f49a7d1a0367a013608139a9035fa859d10877a3de5938',
    '2025-04-02 10:31:15.214',
    '20250402103114_balance',
    NULL,
    NULL,
    '2025-04-02 10:31:14.822',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    '81772ccc-b5ab-4ccd-8508-930cffd4cbfd',
    '38a7408997b572ba96b78a7f12e8529aaad558fa6416ae95167aa8f489397f78',
    '2025-03-24 09:09:18.638',
    '20250324090917_tnx',
    NULL,
    NULL,
    '2025-03-24 09:09:17.371',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    '9f031a4c-ea7b-45e9-a595-81dc3ac1cbce',
    'c8ad7c12f3d16362d10c292bfbfe24ae09316d1c14a4440d6364106b9ba121f1',
    '2025-03-16 11:09:25.282',
    '20250316110919_init_again',
    NULL,
    NULL,
    '2025-03-16 11:09:19.192',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'a01062fb-d93e-4b1b-ade2-fe89f84273d1',
    '479db4214dbe268306605d104e1c803f8aca14cda6eddb06402095cc7e88f70e',
    '2025-03-29 14:11:56.110',
    '20250329141155_payments',
    NULL,
    NULL,
    '2025-03-29 14:11:55.783',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'beb6fc0d-2179-4556-9126-b86e6668a364',
    'e74d60bb00f8a06d2a2b7e948e44b88509946a20e8e05c6eece7080ee88a6fe1',
    '2025-05-21 09:49:28.151',
    '20250521094928_snapshot',
    NULL,
    NULL,
    '2025-05-21 09:49:28.119',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'c47ec79c-29e5-4eeb-a3d4-79a6ddd6302b',
    '1002b4d7cfe6efdb90e499add07e71e13894f17669a993dd73241ac729edc21d',
    '2025-03-28 11:37:45.231',
    '20250328113743_tnxid',
    NULL,
    NULL,
    '2025-03-28 11:37:43.303',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'fca168fe-ecc4-48db-a021-b14c9b210e4b',
    '350136ab76b2c21358eeab6d259c553dc0efcd46ca2547813f106bf8af432a18',
    '2025-04-03 21:37:32.323',
    '20250403213731_pcreated_by',
    NULL,
    NULL,
    '2025-04-03 21:37:31.702',
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: accounts
# ------------------------------------------------------------

INSERT INTO
  `accounts` (
    `id`,
    `username`,
    `passHash`,
    `menu`,
    `role`,
    `status`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '73526e3d-11c5-4997-b954-1e9da37b9809',
    'dr',
    '5d90143d22d34eb9b82182ea06c3a4ed2fb10e28b2ddb7f087063f014a2eaedc',
    '\"[{\\\"label\\\":\\\"accounts\\\",\\\"link\\\":\\\"accounts\\\"},{\\\"label\\\":\\\"backup\\\",\\\"link\\\":\\\"backup\\\"},{\\\"label\\\":\\\"drugs\\\",\\\"link\\\":\\\"drugs\\\"},{\\\"label\\\":\\\"encounters\\\",\\\"link\\\":\\\"encounters\\\"},{\\\"label\\\":\\\"patients\\\",\\\"link\\\":\\\"patients\\\"},{\\\"label\\\":\\\"reports\\\",\\\"link\\\":\\\"reports\\\"},{\\\"label\\\":\\\"settings\\\",\\\"link\\\":\\\"settings\\\"},{\\\"label\\\":\\\"transactions\\\",\\\"link\\\":\\\"transactions\\\"}]\"',
    'admin',
    1,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '73526e3d-11c5-4997-b954-1e9da37b9809',
    '2025-02-23 16:57:16.457',
    '2025-04-06 11:01:16.353'
  );
INSERT INTO
  `accounts` (
    `id`,
    `username`,
    `passHash`,
    `menu`,
    `role`,
    `status`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    'tacheyon',
    '00a49fa200fb624f879f26b296fa89f0f3676f1f2ba10de2b5f39b800b34fcb4',
    '\"[{\\\"label\\\":\\\"accounts\\\",\\\"link\\\":\\\"accounts\\\"},{\\\"label\\\":\\\"backup\\\",\\\"link\\\":\\\"backup\\\"},{\\\"label\\\":\\\"drugs\\\",\\\"link\\\":\\\"drugs\\\"},{\\\"label\\\":\\\"encounters\\\",\\\"link\\\":\\\"encounters\\\"},{\\\"label\\\":\\\"patients\\\",\\\"link\\\":\\\"patients\\\"},{\\\"label\\\":\\\"reports\\\",\\\"link\\\":\\\"reports\\\"},{\\\"label\\\":\\\"settings\\\",\\\"link\\\":\\\"settings\\\"},{\\\"label\\\":\\\"transactions\\\",\\\"link\\\":\\\"transactions\\\"}]\"',
    'admin',
    1,
    NULL,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-02-15 14:54:51.664',
    '2025-03-18 15:33:58.844'
  );
INSERT INTO
  `accounts` (
    `id`,
    `username`,
    `passHash`,
    `menu`,
    `role`,
    `status`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'fef20d62-9845-4fae-8910-03021317759a',
    'unbounded',
    'fb532b80a2d80f869b5bf43c2b2c789fe9415c3f5a3e8e812fe9b20229bb28d0',
    '\"[{\\\"label\\\":\\\"reports\\\",\\\"link\\\":\\\"reports\\\"},{\\\"label\\\":\\\"transactions\\\",\\\"link\\\":\\\"transactions\\\"}]\"',
    'user',
    1,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-04-06 11:02:29.479',
    '2025-04-06 11:02:29.479'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: admission
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: anc
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: authhistory
# ------------------------------------------------------------

INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm95fnyqg0003uqpgtxpr6i89',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-06 09:21:34.359',
    '2025-04-06 09:21:55.306'
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm95fouxw0005uqpgbuql0c1y',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-06 09:22:16.102',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm95kgjgv0001uqlk8pu9n169',
    'fef20d62-9845-4fae-8910-03021317759a',
    '2025-04-06 11:35:46.053',
    '2025-04-06 11:36:03.928'
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm95kpxuc0001uq2c7i4kxp68',
    'fef20d62-9845-4fae-8910-03021317759a',
    '2025-04-06 11:43:04.588',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm95ltml50003uq2c4f4tavrs',
    'fef20d62-9845-4fae-8910-03021317759a',
    '2025-04-06 12:13:56.242',
    '2025-04-06 12:14:56.598'
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm95lvcg40005uq2ctvezkuez',
    'fef20d62-9845-4fae-8910-03021317759a',
    '2025-04-06 12:15:16.418',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm95ly54e0001uq3o99zg5q2k',
    'fef20d62-9845-4fae-8910-03021317759a',
    '2025-04-06 12:17:26.891',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm95lze9e0003uq3odsac8rn5',
    'fef20d62-9845-4fae-8910-03021317759a',
    '2025-04-06 12:18:25.393',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm95m16530001uqm8nj5b22zs',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-06 12:19:48.179',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm972mqj10001uqtsi1l8fx5y',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-07 12:52:14.409',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm972porh0001uqgsl7qk6s1i',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-07 12:54:32.092',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm9731juj0003uqgsd3y3wc9t',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-07 13:03:45.594',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm97379k80005uqgsj7sqhc7c',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-07 13:08:12.199',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm98jn2n90001uq98073bizq4',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-08 13:36:09.761',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm98lbur50003uq98t9f0au1v',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-08 14:23:25.551',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm98vk0fg0001uqn8ho8pcom1',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-08 19:09:42.313',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm98x2pcy0003uqn8o8wh52qs',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-08 19:52:14.046',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm98xd8g60005uqn8dvbpeg5n',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-08 20:00:25.349',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm98xdmrj0007uqn8xkfs87m1',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-08 20:00:43.902',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm99067010001uqowkl71ffd2',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-08 21:18:55.715',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm99081m00003uqowsngtotlu',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-08 21:20:22.055',
    '2025-04-08 21:20:28.276'
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm99089jk0005uqow6efpq5vb',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-08 21:20:32.332',
    '2025-04-08 21:21:50.127'
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm990a7t40007uqow01gr7r7s',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-08 21:22:03.399',
    '2025-04-08 21:24:23.098'
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm990mrq90009uqowobdd7qpe',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-08 21:31:49.087',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm990nhw4000buqowecuurfog',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-08 21:32:22.994',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm990ohaw000duqowoa6qqx6d',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-08 21:33:08.887',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm9a4jxb40001uq7w8lb5qs2h',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-09 16:09:20.989',
    '2025-04-09 16:28:19.183'
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cm9a5pysy0001uqeszohapy8q',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-09 16:42:02.479',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cmaxomyj80001uq5kto85x8hj',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-05-21 08:29:59.248',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cmazrd0xw0001uqh4ru46h1jt',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-05-22 19:21:47.009',
    '2025-05-22 21:38:34.858'
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cmb1yy8lh0001uq3cptz3u8b4',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-05-24 08:29:46.369',
    '2025-05-24 08:49:00.506'
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cmb1zuan00003uq3c6gxj1etx',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-05-24 08:54:42.011',
    '2025-05-24 09:12:45.791'
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cmb20i1mz0001uql4znnbull7',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-05-24 09:13:10.087',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cmb20j1yb0001uqs8svhmzgej',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-05-24 09:13:57.152',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cmb20jm880001uqy0i4f66u0a',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-05-24 09:14:23.430',
    NULL
  );
INSERT INTO
  `authhistory` (`id`, `accountId`, `loggedInAt`, `loggedOutAt`)
VALUES
  (
    'cmb20kc9q0003uqy0sfn82b4w',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-05-24 09:14:57.181',
    '2025-05-24 10:10:58.052'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: care
# ------------------------------------------------------------

INSERT INTO
  `care` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fjwh0y0000uqs8yspvb285',
    'ANC',
    '2025-01-02 16:39:02.191'
  );
INSERT INTO
  `care` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk12fi0001uqyobcu2a2gp',
    'Family Card',
    '2025-01-02 16:42:36.558'
  );
INSERT INTO
  `care` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk1hdm0003uqyoss9e87cf',
    'Immunization',
    '2025-01-02 16:42:55.930'
  );
INSERT INTO
  `care` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk1nnq0004uqyo7s1gwi5b',
    'Individual Card',
    '2025-01-02 16:43:04.070'
  );
INSERT INTO
  `care` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8h5irfb0001uqj86r257p8w',
    'KSHIS',
    '2025-03-20 09:31:07.213'
  );
INSERT INTO
  `care` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8h5jdlf0002uqj8qkzq8024',
    'PNC',
    '2025-03-20 09:31:35.955'
  );
INSERT INTO
  `care` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8h5jps00003uqj8skqzzv4x',
    'NHIA',
    '2025-03-20 09:31:51.743'
  );
INSERT INTO
  `care` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8h5jz1z0004uqj8fuxekuj6',
    'Delivery',
    '2025-03-20 09:32:03.767'
  );
INSERT INTO
  `care` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8puusl20004uq00ty6zciq3',
    'Operation',
    '2025-03-26 11:42:28.406'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: delivery
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: diagnosis
# ------------------------------------------------------------

INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgk20000uqowmym6sjve',
    'Abortion spont',
    '2025-01-02 21:44:37.376'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgk20001uqowxib5rqc4',
    'Abortion missed',
    '2025-01-02 21:44:37.373'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgk30002uqowkdcqgu0x',
    'Abdomen swelling',
    '2025-01-02 21:44:37.370'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgk30003uqow2uvwppk3',
    'Abortion threatening',
    '2025-01-02 21:44:37.379'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgk90004uqowb8y1pviy',
    'Acute otitis media',
    '2025-01-02 21:44:37.393'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgk90005uqowzfad7w7g',
    'Abortion induced',
    '2025-01-02 21:44:37.393'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgl10006uqowbl5x1gws',
    'Allergy',
    '2025-01-02 21:44:37.430'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgl40007uqows206sde3',
    'Anaemia',
    '2025-01-02 21:44:37.432'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgl90008uqowgig6n4h5',
    'Anal bleeding',
    '2025-01-02 21:44:37.437'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futglc0009uqowtpgtdc1o',
    'Ankle oedema',
    '2025-01-02 21:44:37.440'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futglf000auqoweoj0wujc',
    'Anorexia',
    '2025-01-02 21:44:37.444'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgli000buqowdjvbal6d',
    'Anxiety',
    '2025-01-02 21:44:37.446'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futglq000cuqowasdae8is',
    'APH abruption',
    '2025-01-02 21:44:37.454'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futglt000duqowzixdjkaj',
    'APH placen praevia',
    '2025-01-02 21:44:37.458'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futglv000euqow4tljbdm3',
    'Appendicitis',
    '2025-01-02 21:44:37.459'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futglz000fuqow8py2dn4b',
    'Arthritis',
    '2025-01-02 21:44:37.463'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgm0000guqow1ckop8os',
    'Asthma',
    '2025-01-02 21:44:37.465'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgm4000huqowydryjz7f',
    'Atrial fibrillation',
    '2025-01-02 21:44:37.468'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgm9000iuqowjrxw71zb',
    'Batholinitis',
    '2025-01-02 21:44:37.473'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgmd000juqowt6355dt4',
    'Bell\'s palsy',
    '2025-01-02 21:44:37.478'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgmf000kuqowiemppzl1',
    'BPH',
    '2025-01-02 21:44:37.479'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgmh000luqow3elqfucn',
    'Bite insect',
    '2025-01-02 21:44:37.482'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgmk000muqowtx74d9ih',
    'Bite snake',
    '2025-01-02 21:44:37.485'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgmr000nuqowb1ulswzz',
    'Bleeding',
    '2025-01-02 21:44:37.491'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgmx000ouqowlp8sou8y',
    'Blindness',
    '2025-01-02 21:44:37.497'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgn0000puqow17ovmrvw',
    'Boil',
    '2025-01-02 21:44:37.500'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgn2000quqownfi9s0pq',
    'Bronchitis chronic',
    '2025-01-02 21:44:37.503'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgn5000ruqow1br8havm',
    'Broncho pneumonia',
    '2025-01-02 21:44:37.506'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgn9000suqowxc0toaci',
    'Bruises',
    '2025-01-02 21:44:37.509'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgne000tuqow968xovdl',
    'Burns',
    '2025-01-02 21:44:37.514'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgnh000uuqown0yet2q5',
    'candidiasis',
    '2025-01-02 21:44:37.517'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgnj000vuqowunmc766z',
    'Candidiasis',
    '2025-01-02 21:44:37.520'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgnp000wuqowqdmzxoet',
    'Cardiac arythmia',
    '2025-01-02 21:44:37.526'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgnt000xuqowoc971rbo',
    'Cataract',
    '2025-01-02 21:44:37.529'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgnw000yuqowcmr58wif',
    'Cathar',
    '2025-01-02 21:44:37.532'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgo0000zuqowgk0vl5zd',
    'Cervical carcinoma',
    '2025-01-02 21:44:37.536'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgo50010uqowu77u1oy7',
    'Cervical erosion',
    '2025-01-02 21:44:37.541'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgo80011uqowpqgsn4dp',
    'Cervicitis',
    '2025-01-02 21:44:37.545'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgod0012uqowrawn812e',
    'Chest pain',
    '2025-01-02 21:44:37.550'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgof0013uqow0t9ok4i5',
    'Chickenpox',
    '2025-01-02 21:44:37.551'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgoh0014uqowu3m0obs9',
    'Cholera',
    '2025-01-02 21:44:37.553'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgoj0015uqow1l891iu0',
    'Chronic ulcer skin',
    '2025-01-02 21:44:37.555'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgon0016uqow2t8bih9x',
    'COAD',
    '2025-01-02 21:44:37.559'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgop0017uqowy30hyczf',
    'Coma',
    '2025-01-02 21:44:37.561'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgox0018uqow0q9tmwr0',
    'Compliance problem diet',
    '2025-01-02 21:44:37.569'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgp60019uqow1v7ec6r5',
    'Compliance problem drug',
    '2025-01-02 21:44:37.579'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgp8001auqow0qu3ih04',
    'Congenital anomallies',
    '2025-01-02 21:44:37.581'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgpc001buqowsbdm0n5w',
    'Congenital heart disease',
    '2025-01-02 21:44:37.584'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgpe001cuqowha0yo5p4',
    'Conjuctivitis',
    '2025-01-02 21:44:37.586'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgpg001duqowwh19i24c',
    'Contraception injectable',
    '2025-01-02 21:44:37.588'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgpk001euqow4pttw200',
    'Contraception IUCD',
    '2025-01-02 21:44:37.592'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgpp001fuqow8fi6tuvi',
    'Contraception oral',
    '2025-01-02 21:44:37.598'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgps001guqowci08idy9',
    'Convulsion/seizures',
    '2025-01-02 21:44:37.600'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgpu001huqowojr90n2e',
    'Cough',
    '2025-01-02 21:44:37.602'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgq0001iuqowe1gwg6z2',
    'Death',
    '2025-01-02 21:44:37.608'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgq4001juqowtgoafbxx',
    'Dehydration',
    '2025-01-02 21:44:37.612'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgq7001kuqowhf2ohqet',
    'Delivery breech',
    '2025-01-02 21:44:37.616'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgqd001luqow4fkfxi4i',
    'Delivery multiple',
    '2025-01-02 21:44:37.621'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgqf001muqowwomw9zgf',
    'Delivery SVD',
    '2025-01-02 21:44:37.623'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgqi001nuqow0oxqy91x',
    'Delivery vacuum',
    '2025-01-02 21:44:37.626'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgqk001ouqowsdbvs72l',
    'Dental carries',
    '2025-01-02 21:44:37.628'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgqn001puqowt30wa45y',
    'Depression',
    '2025-01-02 21:44:37.631'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgqr001quqowdusvnupi',
    'Dermatitis',
    '2025-01-02 21:44:37.636'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgqv001ruqowi8bg5hye',
    'Dermatophytosis',
    '2025-01-02 21:44:37.639'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgqx001suqowul894rts',
    'DM gestational',
    '2025-01-02 21:44:37.642'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgr3001tuqownzj091r6',
    'DM type1',
    '2025-01-02 21:44:37.648'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgr7001uuqowgt4xlx5t',
    'DM type2',
    '2025-01-02 21:44:37.651'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgr8001vuqowdap0fvsm',
    'Diarrhoea',
    '2025-01-02 21:44:37.653'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgre001wuqowxd8o7f8n',
    'Discharges urethal',
    '2025-01-02 21:44:37.659'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgrh001xuqow4quffgau',
    'Discharges vaginal',
    '2025-01-02 21:44:37.662'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgrl001yuqow6yx793m0',
    'Dizziness',
    '2025-01-02 21:44:37.665'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgrr001zuqow5o2ow3y4',
    'Drug abuse',
    '2025-01-02 21:44:37.671'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgru0020uqow48oxjzaa',
    'Dysmenorrhoea',
    '2025-01-02 21:44:37.674'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgrx0021uqowcc3432xy',
    'Dysphagia',
    '2025-01-02 21:44:37.677'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgs00022uqowz8hp1e16',
    'Dyspnoea',
    '2025-01-02 21:44:37.680'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgs40023uqow09a6likz',
    'Dysuria',
    '2025-01-02 21:44:37.684'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgs70024uqownst0h1du',
    'Ear ache',
    '2025-01-02 21:44:37.687'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgsb0025uqowvcu6e19x',
    'Ear discharges',
    '2025-01-02 21:44:37.692'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgsh0026uqown9f32go7',
    'Eclampsia',
    '2025-01-02 21:44:37.697'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgsj0027uqowbcuhl8p6',
    'Ectopic gestation',
    '2025-01-02 21:44:37.699'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgsm0028uqowkv6vwsw6',
    'Emesis gravidarum',
    '2025-01-02 21:44:37.702'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgsw0029uqow3ceojuql',
    'Epigastric pain',
    '2025-01-02 21:44:37.712'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgsz002auqowa8jkjtfq',
    'Epilepsy',
    '2025-01-02 21:44:37.715'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgt1002buqow2uq9j5do',
    'Epistaxis',
    '2025-01-02 21:44:37.717'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgt3002cuqowz5dr1ppj',
    'Eye ache',
    '2025-01-02 21:44:37.719'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgt5002duqowl6rwcwj3',
    'Fainting',
    '2025-01-02 21:44:37.721'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgt7002euqowek6e62wc',
    'Fears',
    '2025-01-02 21:44:37.724'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgtd002fuqow6fniqvvc',
    'Fever',
    '2025-01-02 21:44:37.729'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgth002guqow926wp5ld',
    'Fibromyoma uterus',
    '2025-01-02 21:44:37.733'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgtl002huqow12pje9w8',
    'Fractures',
    '2025-01-02 21:44:37.737'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgtp002iuqowkuivknfl',
    'Gastroenteritis',
    '2025-01-02 21:44:37.742'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgtr002juqowwde1dmf5',
    'Gen body pains',
    '2025-01-02 21:44:37.743'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgts002kuqowx728qnj4',
    'Glaucoma',
    '2025-01-02 21:44:37.744'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgtu002luqowr49lork7',
    'Glomerulonephritis',
    '2025-01-02 21:44:37.746'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgty002muqowenf64i7c',
    'Goitre',
    '2025-01-02 21:44:37.750'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgu5002nuqowqk8n2o0e',
    'Gonorhoea female',
    '2025-01-02 21:44:37.758'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgu8002ouqow5tv2zwzz',
    'Gonorhoea male',
    '2025-01-02 21:44:37.760'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgub002puqowsx0617tp',
    'Haemathemesis',
    '2025-01-02 21:44:37.763'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgud002quqowq2thy9lg',
    'Haematuria',
    '2025-01-02 21:44:37.765'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futguf002ruqow8oxpl9ou',
    'Haemorrhoids',
    '2025-01-02 21:44:37.767'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgui002suqowghgu2nas',
    'Headache',
    '2025-01-02 21:44:37.770'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futguo002tuqow5lxa3ar8',
    'Hearing defect',
    '2025-01-02 21:44:37.777'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgur002uuqowlfj1xinu',
    'Heart failure',
    '2025-01-02 21:44:37.779'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgut002vuqowiqj86dg4',
    'Hepatomegally',
    '2025-01-02 21:44:37.782'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futguv002wuqowjqk5vfeq',
    'Hernia',
    '2025-01-02 21:44:37.784'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgux002xuqowv81a7yke',
    'Herpes simplex',
    '2025-01-02 21:44:37.785'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futguz002yuqow1scc3fct',
    'HIV/AIDS',
    '2025-01-02 21:44:37.787'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgv3002zuqow6tf2mno4',
    'Chronic otitis media',
    '2025-01-02 21:44:37.792'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgv90030uqowgtrzgsa0',
    'Herpes zoster',
    '2025-01-02 21:44:37.797'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgvb0031uqow6vuepmnt',
    'Hydrocele',
    '2025-01-02 21:44:37.800'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgve0032uqowimis7kf0',
    'Hydrocele congenital',
    '2025-01-02 21:44:37.802'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgvg0033uqowuj47rhxd',
    'Hypertension',
    '2025-01-02 21:44:37.804'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgvi0034uqow9x5c6dei',
    'Hypertension severe',
    '2025-01-02 21:44:37.806'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgvo0035uqowfa65tkyj',
    'Hypoglycaemia',
    '2025-01-02 21:44:37.813'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgvq0036uqowwly22xhy',
    'Impetigo',
    '2025-01-02 21:44:37.814'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgvz0037uqow3q3q0e7s',
    'Infertility female primary',
    '2025-01-02 21:44:37.823'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgw10038uqow6l02nzny',
    'Infertility female secondary',
    '2025-01-02 21:44:37.825'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgw30039uqowi5nt5alp',
    'Infertility male',
    '2025-01-02 21:44:37.827'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgw6003auqowv7fvdjp2',
    'Ingrowing nail',
    '2025-01-02 21:44:37.830'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgw8003buqow8mcrtqa7',
    'Injuries',
    '2025-01-02 21:44:37.832'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgwd003duqowvhovk6dc',
    'Insomnia',
    '2025-01-02 21:44:37.838'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgwk003euqowlbdz9uoj',
    'Ischaemic IHD Angina',
    '2025-01-02 21:44:37.844'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgwm003fuqowr8f7mvgb',
    'Jaundice',
    '2025-01-02 21:44:37.846'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgwp003guqowyj7vmtqn',
    'Lacerations',
    '2025-01-02 21:44:37.850'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgwr003huqow34d8ibb7',
    'Laryngitis',
    '2025-01-02 21:44:37.851'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgwt003iuqows5ps219u',
    'Libido reduced',
    '2025-01-02 21:44:37.853'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgwv003juqowbsefwjwz',
    'Live birth',
    '2025-01-02 21:44:37.855'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgx1003kuqow28rmduch',
    'Low back pain',
    '2025-01-02 21:44:37.862'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgx5003luqoweq1yyya0',
    'LMNL (Neuron)',
    '2025-01-02 21:44:37.865'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgx6003muqowhy5tm4gk',
    'Lump',
    '2025-01-02 21:44:37.867'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgx9003nuqow88ioh8sd',
    'Lump beast',
    '2025-01-02 21:44:37.870'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgxb003ouqow6vqafv7l',
    'Lymphadenitis',
    '2025-01-02 21:44:37.872'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgxg003puqowdki7wszk',
    'Malaria',
    '2025-01-02 21:44:37.876'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgxi003quqow4l9t1khk',
    'Measles',
    '2025-01-02 21:44:37.878'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgxm003ruqow9byze3zc',
    'Meningitis/encephalitis',
    '2025-01-02 21:44:37.882'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgxq003suqowy1kpv1by',
    'Menorrhagia',
    '2025-01-02 21:44:37.887'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgxs003tuqowzxnfmyi9',
    'Mental retardation',
    '2025-01-02 21:44:37.889'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgxy003uuqowb6k95oyc',
    'Migraine',
    '2025-01-02 21:44:37.894'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgyg003vuqow78uaxq66',
    'Molar gestation',
    '2025-01-02 21:44:37.912'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgyo003wuqow0xn7jndg',
    'Nausea',
    '2025-01-02 21:44:37.920'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgyv003xuqowyze7l2md',
    'Neoplasm',
    '2025-01-02 21:44:37.928'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgyx003yuqow3rrhpm46',
    'No disease',
    '2025-01-02 21:44:37.930'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgz1003zuqow5ir0macs',
    'Obecity',
    '2025-01-02 21:44:37.934'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgz40040uqowgi12iqr1',
    'Oligomenorrhoea',
    '2025-01-02 21:44:37.937'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgz90041uqowdw2z1dsr',
    'Orchitis',
    '2025-01-02 21:44:37.941'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgze0042uqow2srma9vg',
    'Osteoarthritis',
    '2025-01-02 21:44:37.947'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgzk0043uqowgeaikr1g',
    'Osteoarthrosis hip',
    '2025-01-02 21:44:37.952'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgzl0044uqowr55r4dmw',
    'Osteoarthrosis knee',
    '2025-01-02 21:44:37.954'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgzq0045uqowt2nzz99d',
    'Osteomyelitis acute',
    '2025-01-02 21:44:37.958'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgzt0046uqow1icfqa8r',
    'Osteomyelitis chronic',
    '2025-01-02 21:44:37.962'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futgzy0047uqowu41brdl2',
    'Osteoporosis',
    '2025-01-02 21:44:37.966'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh010048uqow21xzb03m',
    'Otitis external',
    '2025-01-02 21:44:37.969'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh020049uqowl4a5nwkf',
    'Ovarian cyst',
    '2025-01-02 21:44:37.970'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh06004auqow08v5cxo0',
    'Palpitation',
    '2025-01-02 21:44:37.975'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh0b004buqow1iw7yqbg',
    'Paraesthesia',
    '2025-01-02 21:44:37.980'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh0d004cuqowc7v0otnd',
    'Paralysis/weakness',
    '2025-01-02 21:44:37.982'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh0h004duqowb5cm0xdn',
    'Parkinsonism',
    '2025-01-02 21:44:37.985'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh0j004euqow8juntyiw',
    'Peptic ulcer disease',
    '2025-01-02 21:44:37.987'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh0n004fuqowh8fe1dvt',
    'Perinatal morbidity',
    '2025-01-02 21:44:37.992'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh0v004guqowclosjyue',
    'Perinatal mortality',
    '2025-01-02 21:44:37.999'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh0w004huqow1m6if41x',
    'Periphe neuriti/neuropathys',
    '2025-01-02 21:44:38.001'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh0y004iuqowm1yix7x7',
    'Peuperal sepsis',
    '2025-01-02 21:44:38.002'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh10004juqow3t0c0zcl',
    'PID acute',
    '2025-01-02 21:44:38.004'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh12004kuqowcuv4z25u',
    'PID chronic',
    '2025-01-02 21:44:38.007'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh16004luqowmdgac9mc',
    'Pleural effusion',
    '2025-01-02 21:44:38.010'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh1a004muqowav2j3iqz',
    'Pleurisy',
    '2025-01-02 21:44:38.014'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh1g004nuqowqi4osuzp',
    'Pneumonia',
    '2025-01-02 21:44:38.021'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh1i004ouqowj63qke9e',
    'Poisoning',
    '2025-01-02 21:44:38.022'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh1k004puqowg5qydvr1',
    'Polydipsea',
    '2025-01-02 21:44:38.025'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh1l004quqowamlt9ehe',
    'Polymenorrhoea',
    '2025-01-02 21:44:38.026'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh1n004ruqowaj5v22hc',
    'Polyurea',
    '2025-01-02 21:44:38.027'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh1o004suqownkrwb8m1',
    'PPH primary',
    '2025-01-02 21:44:38.028'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh1r004tuqowthvh9ehf',
    'PPH seconary',
    '2025-01-02 21:44:38.031'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh1s004uuqowy35qvih2',
    'Preeclampsia',
    '2025-01-02 21:44:38.033'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh1t004vuqow37007h5q',
    'Pregnancy',
    '2025-01-02 21:44:38.034'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh1z004wuqow8vsjsqti',
    'Pregnancy high risk',
    '2025-01-02 21:44:38.039'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh21004xuqow9hcfp77e',
    'Protatitis',
    '2025-01-02 21:44:38.042'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh23004yuqowgls2m3p9',
    'Pruritus',
    '2025-01-02 21:44:38.043'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh27004zuqowf9d52bal',
    'Psychosis',
    '2025-01-02 21:44:38.047'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh290050uqowj18de8sg',
    'Pulmonary heart disease',
    '2025-01-02 21:44:38.050'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh2b0051uqowfksjyaog',
    'pyelonephritis',
    '2025-01-02 21:44:38.052'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh2d0052uqowdngi26mb',
    'Rashes',
    '2025-01-02 21:44:38.053'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh2i0053uqowirjhfsva',
    'Red eye',
    '2025-01-02 21:44:38.059'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh2l0054uqow33quz96p',
    'Refractive error',
    '2025-01-02 21:44:38.061'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh2m0055uqowjikb8gkx',
    'Rheumatic heart disease',
    '2025-01-02 21:44:38.063'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh2p0056uqowp4w7r9bh',
    'Rheumatism',
    '2025-01-02 21:44:38.066'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh2t0057uqowykxmqeqi',
    'Scald',
    '2025-01-02 21:44:38.069'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh2y0058uqowsjg42mhs',
    'Splenomegally',
    '2025-01-02 21:44:38.074'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh310059uqowdh6m7344',
    'SSD',
    '2025-01-02 21:44:38.077'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh33005auqowx16dutcg',
    'Sterillization BTL',
    '2025-01-02 21:44:38.079'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh34005buqowg3ydg19x',
    'Sterillization male',
    '2025-01-02 21:44:38.080'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh36005cuqowpuud9l9a',
    'Stillbirth',
    '2025-01-02 21:44:38.082'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh38005duqowycw1du0p',
    'Stroke haemorrhagic',
    '2025-01-02 21:44:38.084'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh39005euqowfbxj7rs6',
    'Stroke ischaemic',
    '2025-01-02 21:44:38.085'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh3c005fuqowq9mkf0d3',
    'Swelling',
    '2025-01-02 21:44:38.089'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh3e005guqow4oh5tmmb',
    'Syphillis female',
    '2025-01-02 21:44:38.090'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh3m005huqowrg7ht8ya',
    'Syphillis male',
    '2025-01-02 21:44:38.098'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh3n005iuqowa60kwrjj',
    'Tetanus',
    '2025-01-02 21:44:38.100'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh3q005juqow8mdbxzb7',
    'Tingling fingers/feet',
    '2025-01-02 21:44:38.102'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh3s005kuqowavsr1bdt',
    'Tinitus',
    '2025-01-02 21:44:38.104'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh3w005luqowagr11e04',
    'Tonsilitis',
    '2025-01-02 21:44:38.108'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh3z005muqowqhsnmhua',
    'Transient cerebral ischaemia',
    '2025-01-02 21:44:38.111'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh42005nuqowwi6cd5b7',
    'Tremor involuntary',
    '2025-01-02 21:44:38.115'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh45005ouqowwu3mrdfp',
    'Tremor voluntary',
    '2025-01-02 21:44:38.117'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh47005puqowe9zqa1x1',
    'Trichomoniasis',
    '2025-01-02 21:44:38.120'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh4a005quqow9vmhvc13',
    'Trigeminal neuralgia',
    '2025-01-02 21:44:38.123'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh4d005ruqowin6qr4r4',
    'Typhoid fever',
    '2025-01-02 21:44:38.125'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh4h005suqowpfir8a9o',
    'Uper motor neuro lesion(UMNL)',
    '2025-01-02 21:44:38.129'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh4i005tuqow75cxmxd3',
    'Urine retension',
    '2025-01-02 21:44:38.131'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh4l005uuqowyqmy3s5e',
    'Urine urgency',
    '2025-01-02 21:44:38.134'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh4p005vuqowtu71wp3r',
    'URTI',
    '2025-01-02 21:44:38.138'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh4s005wuqowqgfjuen2',
    'Urticaria',
    '2025-01-02 21:44:38.140'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh4w005xuqowah2kbpuv',
    'Uterovaginal prolapse',
    '2025-01-02 21:44:38.144'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh4z005yuqow4a7iypxk',
    'Vaginal bleeding post coital',
    '2025-01-02 21:44:38.147'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh50005zuqowqchg0zqd',
    'Vaginal bleeding post menopausal',
    '2025-01-02 21:44:38.149'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh520060uqowl9jm5k2u',
    'Vomitng',
    '2025-01-02 21:44:38.151'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh540061uqowdllfpqkr',
    'Vulvitis',
    '2025-01-02 21:44:38.152'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh560062uqowqyfb6ny3',
    'Weight lost',
    '2025-01-02 21:44:38.154'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh590063uqowyn9plghx',
    'Worms infestation',
    '2025-01-02 21:44:38.158'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh5c0064uqowgkz8e9sz',
    'Abortionincomplete',
    '2025-01-02 21:44:38.160'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh5g0065uqowpllrfj3l',
    'Anaemia in pregnancy',
    '2025-01-02 21:44:38.165'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh5j0066uqownhng5xtm',
    'Anaemia malaria',
    '2025-01-02 21:44:38.168'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh5m0067uqowdtvfr9xq',
    'Anaemia SSD',
    '2025-01-02 21:44:38.171'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh5r0068uqow2chohso1',
    'Appendix abscess',
    '2025-01-02 21:44:38.175'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh5t0069uqowaiiyjjpa',
    'Appendix mass',
    '2025-01-02 21:44:38.177'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh5x006auqow5h8usu76',
    'Contraception inplant',
    '2025-01-02 21:44:38.181'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh61006buqowcrpqoqn2',
    'Encephalopathy DM',
    '2025-01-02 21:44:38.185'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh64006cuqowqfdfaaot',
    'Encephalopathy HIE birth',
    '2025-01-02 21:44:38.188'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh68006duqow3nduu3e6',
    'Encephalopathy HTN',
    '2025-01-02 21:44:38.193'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh6a006euqowto7nrwer',
    'Malaria cerebral',
    '2025-01-02 21:44:38.195'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh6d006fuqow3klneyz3',
    'Malaria in pregnancy',
    '2025-01-02 21:44:38.198'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh6g006guqowmyrdsrx6',
    'Malaria severe',
    '2025-01-02 21:44:38.201'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh6k006huqowdcx7zhtb',
    'Ovarian cyst twisted',
    '2025-01-02 21:44:38.204'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh6n006iuqowavzvhe4x',
    'Pneumonia CAP',
    '2025-01-02 21:44:38.208'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh6q006juqow1w0tcmud',
    'Pneumonia HAP',
    '2025-01-02 21:44:38.211'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh6s006kuqowluxq3rpd',
    'Pregnancy(ANC)',
    '2025-01-02 21:44:38.212'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh6w006luqowyg2hzhi4',
    'PUD',
    '2025-01-02 21:44:38.216'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh6z006muqow1diy8vew',
    'PUD bleeding',
    '2025-01-02 21:44:38.220'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh72006nuqowdgh9lnwq',
    'PUD perforation',
    '2025-01-02 21:44:38.223'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh74006ouqowfcs8ulod',
    'Radiculopathy',
    '2025-01-02 21:44:38.224'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5futh77006puqowcb7hhnrx',
    'Sepsis',
    '2025-01-02 21:44:38.227'
  );
INSERT INTO
  `diagnosis` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8k0o5wx0000uq44eigernpc',
    'TB',
    '2025-03-22 09:38:39.726'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: drugpurchases
# ------------------------------------------------------------

INSERT INTO
  `drugpurchases` (
    `id`,
    `drug_id`,
    `name`,
    `quantity`,
    `price`,
    `month`,
    `time`,
    `year`,
    `date`,
    `createdAt`,
    `updatedAt`,
    `createdById`
  )
VALUES
  (
    '6666cba2-5b0b-443f-a016-2ca2e469840b',
    '9b87b7b5-9296-4a90-b64a-0eadee2c8b34',
    'Adrenaline inj',
    20,
    20000,
    'May',
    NULL,
    2025,
    '2025-05-22 00:00:00.000',
    '2025-05-22 20:37:17.988',
    '2025-05-22 20:37:17.988',
    '8e945d62-8991-420a-82f1-9a6c3740329d'
  );
INSERT INTO
  `drugpurchases` (
    `id`,
    `drug_id`,
    `name`,
    `quantity`,
    `price`,
    `month`,
    `time`,
    `year`,
    `date`,
    `createdAt`,
    `updatedAt`,
    `createdById`
  )
VALUES
  (
    '8d00ebd2-bd5b-4ae3-917f-1ac43a7072a0',
    '1f8db447-1227-4dad-802e-cc200a0fa978',
    'ACT',
    20,
    20000,
    'May',
    NULL,
    2025,
    '2025-05-22 00:00:00.000',
    '2025-05-22 20:37:00.465',
    '2025-05-22 20:37:00.465',
    '8e945d62-8991-420a-82f1-9a6c3740329d'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: drugsgiven
# ------------------------------------------------------------

INSERT INTO
  `drugsgiven` (
    `id`,
    `rate`,
    `price`,
    `quantity`,
    `drug_id`,
    `name`,
    `encounter_id`,
    `date`,
    `year`,
    `month`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'cmazu7wsw0000uq7oahkklx7a',
    2000,
    2000,
    1,
    '9b87b7b5-9296-4a90-b64a-0eadee2c8b34',
    'Adrenaline inj',
    '348af011-6898-4c40-9e26-de063ac6cfba',
    '2025-05-22 00:00:00.000',
    2025,
    'May',
    '2025-05-22 20:41:47.214',
    '2025-05-22 21:36:53.739'
  );
INSERT INTO
  `drugsgiven` (
    `id`,
    `rate`,
    `price`,
    `quantity`,
    `drug_id`,
    `name`,
    `encounter_id`,
    `date`,
    `year`,
    `month`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'cmazu7wsz0001uq7o9g8mqvzi',
    1500,
    1500,
    1,
    '1f8db447-1227-4dad-802e-cc200a0fa978',
    'ACT',
    '348af011-6898-4c40-9e26-de063ac6cfba',
    '2025-05-22 00:00:00.000',
    2025,
    'May',
    '2025-05-22 20:41:47.214',
    '2025-05-22 21:36:53.739'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: drugsinventory
# ------------------------------------------------------------

INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '0003ff42-12ce-43b4-8f75-75c147fc0150',
    'Infusion set',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:32:06.294',
    '2025-02-21 11:32:06.294'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '012713d5-394a-4e36-9f05-65a2cacfc797',
    'Utility&Others',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:45:17.199',
    '2025-02-21 11:45:17.199'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '018dcf7f-dce9-42fd-8294-f6e10c4cd638',
    'Dutasteride tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:27:00.858',
    '2025-02-21 11:27:00.858'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '05a68284-677a-4a02-8572-96f071c90b07',
    'Chromic 1',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:21:49.166',
    '2025-02-21 11:21:49.166'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '06cae31e-9d55-4634-b252-c41042f95012',
    'Mefenamic acid tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:34:47.385',
    '2025-02-21 11:34:47.385'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '07f69684-cd54-4a31-b23b-cf35c7edc0df',
    'HBV drugs',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:30:03.212',
    '2025-02-21 11:30:03.212'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '09771d18-98a1-4a27-aca9-f67e1447c127',
    'My boy',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:37:25.965',
    '2025-02-21 11:37:25.965'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '0c2f3741-8c64-4fe4-a98d-932680890ba8',
    'Diclofenac Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:26:14.355',
    '2025-02-21 11:26:14.355'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '0da84fef-873f-4a51-9736-c4db004b81bc',
    'HB Cellulose Paper',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:29:55.476',
    '2025-02-21 11:29:55.476'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '110de27e-e6da-4fb3-beb0-77cb8b5f6cf7',
    'VDRL Strip',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:45:30.739',
    '2025-02-21 11:45:30.739'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '116aeea3-f884-4a96-b3e6-354b65bce60b',
    'Latex glove',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:33:20.247',
    '2025-02-21 11:33:20.247'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '1492c941-769c-4ef1-91c8-bc53aa919fb5',
    'Nylon 2',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:39:04.766',
    '2025-02-21 11:39:04.766'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '156b6888-baf6-4809-b82d-f403c29c8ff7',
    'Cefuroxime Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:21:19.228',
    '2025-02-21 11:21:19.228'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '163559f3-41a3-4e96-8184-9073c0b1920a',
    'Blood Giving set',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:18:34.890',
    '2025-02-21 11:18:34.890'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '17926e33-acc8-4773-b73b-cb6a30e0fcfb',
    'Antisera B',
    0,
    0,
    100,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-15 16:30:46.336',
    '2025-05-22 20:31:37.843'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '19ca8f3d-1e86-4fee-8170-13d63c3aa673',
    'Aminophyline inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-02-15 16:01:12.422',
    '2025-02-15 16:01:12.422'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '1bcea3e9-b1e3-430c-8ccf-2f526263f6ff',
    'Digoxin Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:26:31.475',
    '2025-02-21 11:26:31.475'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '1c032e5a-c26f-42f2-b6c0-70809301136a',
    'Dexamethazone Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:25:02.270',
    '2025-02-21 11:25:02.270'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '1ca5530e-c43d-47a3-a30a-2cc917a709f8',
    'Povidone Iodine',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:41:28.517',
    '2025-02-21 11:41:28.517'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '1df7a955-a776-4fdf-aeec-c35ad920c149',
    'Paracetamol Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:40:00.151',
    '2025-02-21 11:40:00.151'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '1e4f7f68-8c17-45b3-98ae-c2bf01c17836',
    'Plaster',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:41:20.594',
    '2025-02-21 11:41:20.594'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '1f8db447-1227-4dad-802e-cc200a0fa978',
    'ACT',
    9,
    10,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-02-15 16:01:12.422',
    '2025-05-22 21:36:53.764'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '1fc17141-b32f-4bf1-9310-c17b96ae7404',
    'Mist Pottasium Syrup',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:35:37.577',
    '2025-02-21 11:35:37.577'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '20e3dc56-c470-4432-8dc3-1d4b0ab069c3',
    'Antisera A',
    0,
    0,
    100,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-15 16:29:11.649',
    '2025-05-22 20:31:37.843'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '20ee4dd1-3f94-48d7-983d-7022f53feedf',
    'Laxative Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:33:29.991',
    '2025-02-21 11:33:29.991'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '21637b78-dfee-443d-b7ac-b2cc327eac66',
    'Oxytocine Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:39:51.988',
    '2025-02-21 11:39:51.988'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '223c9122-5f1e-4411-9098-59f909d11749',
    'Leishman Stain',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:33:39.103',
    '2025-02-21 11:33:39.103'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '23e96e2f-aa8a-41f8-8358-ea5e56d05b29',
    'Blood Bag',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:18:19.860',
    '2025-02-21 11:18:19.860'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '24c2c367-2206-474c-8353-e90ab176307f',
    'Arteether inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-15 16:35:30.338',
    '2025-05-22 20:31:37.843'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '2581f759-b54b-429e-808e-20d8626ccb5e',
    'Gelucil Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:28:38.990',
    '2025-02-21 11:28:38.990'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '26574fb7-4b79-463d-891a-aab6bc453eea',
    'Amoxycillin dispersible',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-02-15 16:01:12.422',
    '2025-02-15 16:01:12.422'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '2873b227-545f-4af2-b065-f4121f299b3d',
    'Crysterpen Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:24:10.341',
    '2025-02-21 11:24:10.341'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '290cd293-0809-44be-ad0d-2ec31aeca14e',
    'Folic Acid',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:28:06.991',
    '2025-02-21 11:28:06.991'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '2a5e8ad0-87a2-4398-9c14-300a23e65d32',
    'Flagyl Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:27:46.883',
    '2025-02-21 11:27:46.883'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '2ae668fc-135e-4a6d-815c-bf96747cb518',
    'Ketamine Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:32:55.454',
    '2025-02-21 11:32:55.454'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '2bbf2663-bc6e-4f15-a10e-32371a0763fb',
    'Manitol 15%',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:34:38.371',
    '2025-02-21 11:34:38.371'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '2bd70615-592a-4222-98be-482d1ff51e14',
    'Amilordipine 10mg Tablet',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-02-15 16:01:12.422',
    '2025-02-15 16:01:12.422'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '2e97f9bd-3f68-4e33-a5d8-19bdbaf0922c',
    'Neurovite tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:37:34.805',
    '2025-02-21 11:37:34.805'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '31b9c137-c85e-4048-9f00-75f55a72f218',
    'Infusion Glucose 50%',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:31:58.087',
    '2025-02-21 11:31:58.087'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '324a8169-0538-4c84-b3e2-ae150de15a32',
    'Amoxycillin Suspension',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-02-15 16:01:12.422',
    '2025-02-15 16:01:12.422'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '331ba62f-6067-4ed2-bf01-97d477acd081',
    'Primolut Depot',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:41:59.595',
    '2025-02-21 11:41:59.595'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '34204371-fe0e-4d6b-99b4-1eee9170e3ed',
    'Proguanil',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:42:08.104',
    '2025-02-21 11:42:08.104'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '374f5e8b-5af7-445b-a5ee-f63ce62ef888',
    'Micronutrient powder',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:35:11.712',
    '2025-02-21 11:35:11.712'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '3846f364-d65e-431d-83f2-d46476cdc7f0',
    'Frusemide Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:28:23.071',
    '2025-02-21 11:28:23.071'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '392688d9-7ead-4612-82c2-22ae3b43ee1e',
    'Lamivudine Lenovovor',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:33:11.671',
    '2025-02-21 11:33:11.671'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '39854387-0dc8-4b44-ac83-66c67646168d',
    'Dextrose50%',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:25:49.458',
    '2025-02-21 11:25:49.458'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '3a29b28c-29d2-483a-b333-a6f3e1128e16',
    'Atropine inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-15 16:52:34.469',
    '2025-02-15 16:52:34.469'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '3a6599cc-54d1-40c3-9af3-65d2d0b74d20',
    'KY Gel',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:33:02.667',
    '2025-02-21 11:33:02.667'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '3b978ae7-7f06-4089-8b45-80a4ca203d58',
    'Spironolacton Tablet',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:44:02.713',
    '2025-02-21 11:44:02.713'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '3bd34093-1045-480d-8ece-55fbc04521c6',
    'Piroxicam Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:41:02.418',
    '2025-02-21 11:41:02.418'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '3eab3ac1-bda7-430f-9513-32a77e807a06',
    'Arthrotec tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-15 16:42:01.266',
    '2025-02-15 16:42:01.266'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '44b05a02-de70-4ad9-b63f-00468d146029',
    'Hydrochlorothiazide Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:30:47.478',
    '2025-02-21 11:30:47.478'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '44b9f794-b849-40f3-81a8-3df75f9c69b1',
    'Gauze',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:28:31.649',
    '2025-02-21 11:28:31.649'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '478897ac-35a7-463f-8883-926467d84d16',
    'Hydralazin Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:30:39.917',
    '2025-02-21 11:30:39.917'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '4988ff12-fe33-45e6-827d-acfe762c45ba',
    'Glucomete',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:29:17.441',
    '2025-02-21 11:29:17.441'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '4a10e874-4e20-48d1-8434-a81300c604a3',
    'HCV Strip',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:30:21.114',
    '2025-02-21 11:30:21.114'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '4c9a8aca-2703-404f-b0f9-5d9594b41853',
    'Darrow (1/2 Strength)',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:24:35.187',
    '2025-02-21 11:24:35.187'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '4d3fc47a-2657-45fb-b777-3db471fcd86e',
    'Metformin Tablet',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:34:56.233',
    '2025-02-21 11:34:56.233'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '52ef783d-f1e5-4850-94af-873c5c2c2b24',
    'Salbutamol Syrup',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:43:04.650',
    '2025-02-21 11:43:04.650'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '53503ae9-becc-4fcf-8090-371bd7a9b212',
    'Vasoprin Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:45:24.641',
    '2025-02-21 11:45:24.641'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '55239516-2ee4-4e65-a307-10d75c885b29',
    'Multivite Syrup',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:36:23.247',
    '2025-02-21 11:36:23.247'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '567f1447-9022-4855-b28b-f7002d8c2293',
    'Hydrogen peroxide Lotion',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:31:03.376',
    '2025-02-21 11:31:03.376'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '58ee475a-7f91-479c-b47d-5cea9a44d20f',
    'Metoclopramide Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:35:04.168',
    '2025-02-21 11:35:04.168'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '596a094a-3a01-4f44-89f5-df50a4518abb',
    'Glucokate Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:29:07.979',
    '2025-02-21 11:29:07.979'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '5be6600b-acfa-45fe-b83d-bee1b861ee72',
    'Antisera D',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-15 16:31:27.090',
    '2025-05-22 20:31:37.843'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '5dc2327b-1d42-4f93-bec6-fce1b2177777',
    'Cannula (Blue)',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:20:04.246',
    '2025-02-21 11:20:04.246'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '5e5755d8-b26c-455d-bbb7-8fdb10afc8e9',
    'Insuline Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:32:22.730',
    '2025-02-21 11:32:22.730'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '62a81aeb-4f82-415f-b8ed-0bae7f038964',
    'Dextrose4.3%in 0.18Saline',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:25:41.491',
    '2025-02-21 11:25:41.491'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '633ec20e-6791-4ab7-ab30-b9cc9286df73',
    'Dexamethazone Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:25:12.742',
    '2025-02-21 11:25:12.742'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '638badf0-6622-43ee-91e8-efdc38d9e12e',
    'Cimetidine Tablet',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:22:42.375',
    '2025-02-21 11:22:42.375'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '6420bdaa-209c-472f-86ac-43e72fc8282e',
    'Ciprofloxacin I V',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:22:55.367',
    '2025-02-21 11:22:55.367'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '66856357-6bc7-4e2b-81d1-5915f88104fd',
    'Plasil Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:41:11.867',
    '2025-02-21 11:41:11.867'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '6834e32f-d629-435f-b40a-acbff8f67b72',
    'Ultrasound gel',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:44:32.329',
    '2025-02-21 11:44:32.329'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '69289783-79c2-4452-821d-95c88c0fc67d',
    'Amoxycillin Capsules',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-02-15 16:01:12.422',
    '2025-02-15 16:01:12.422'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '6966b8f2-8dc9-4a63-9112-c8647c6a68da',
    'Sodamint Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:43:48.724',
    '2025-02-21 11:43:48.724'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '6accebee-bac8-4b42-95eb-7a109c894339',
    'CQ Syrup',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:24:00.876',
    '2025-02-21 11:24:00.876'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '6b4aec1e-7d55-4cbd-92b5-30f17806f83c',
    'Artesunate Injection',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-15 16:38:35.227',
    '2025-05-22 20:31:37.843'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '6c01e820-1b6f-4db2-8bd7-6ddb5264cfc0',
    'Tranexamic acid inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:44:24.695',
    '2025-02-21 11:44:24.695'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '6dd59dad-b684-4e33-921b-309b36ced08f',
    'xylocaine 5% spinal',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:47:00.237',
    '2025-02-21 11:47:00.237'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '70bcdb7c-4913-423e-b40d-68436730c2e5',
    'Vit B.co',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:45:36.646',
    '2025-02-21 11:45:36.646'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '717c2bbe-9069-41da-9fe8-28c19c3728d9',
    'Chromic 2/0',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:22:07.766',
    '2025-02-21 11:22:07.766'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '73095f96-947c-46b1-ba3c-6afd7a80c2eb',
    'Frusemide Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:28:15.200',
    '2025-02-21 11:28:15.200'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '738338ec-5dea-4792-b387-44b29519934d',
    'Gentamycin inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:28:51.429',
    '2025-02-21 11:28:51.429'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '7469d5b8-4eef-4eb9-86d7-fcb45d00a9e1',
    'Family planning combination pills',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:27:17.651',
    '2025-02-21 11:27:17.651'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '78b8d5ee-645c-42f2-b9f0-b97decac9be1',
    'Albendazole tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-02-15 16:01:12.422',
    '2025-02-15 16:01:12.422'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '79498239-711b-41af-8b8e-df33e892a4ee',
    'Vit C Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:46:14.455',
    '2025-02-21 11:46:14.455'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '7a98fc2f-2af5-4971-96f0-6a35ad26221f',
    'Calcium Gluconate',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:19:47.885',
    '2025-02-21 11:19:47.885'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '7aa970d3-7bbe-4de6-a7c5-6ffcc2ee2f0e',
    'Catheter 18',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:20:49.554',
    '2025-02-21 11:20:49.554'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '7aba6eb7-691d-428c-9837-fe685b22d67c',
    'Fluconazole Tablet',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:27:58.066',
    '2025-02-21 11:27:58.066'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '7b9258ed-1dcb-4074-b227-42f5ed2c0482',
    'Urinalysis strip',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:44:57.045',
    '2025-02-21 11:44:57.045'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '7bf8c912-5f03-495b-bc49-ae9bb9647473',
    'WBC Diluent',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:46:37.590',
    '2025-02-21 11:46:37.590'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '7cf22616-39d1-44fc-9c3e-99dda2872f07',
    'Rhogam Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:42:34.551',
    '2025-02-21 11:42:34.551'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '8125e6b9-f44e-4f9c-950f-636035fd0b33',
    'Artemether Injection',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-15 16:36:18.792',
    '2025-05-22 20:31:37.843'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '8310c2b4-47da-450b-af90-05c01eb7e630',
    'Malaria (RMP)Strip',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:34:30.226',
    '2025-02-21 11:34:30.226'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '83303858-1d71-4d90-8433-e8a3fd666c4e',
    'Salbutamol Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:43:16.604',
    '2025-02-21 11:43:16.604'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '85aeb50b-824e-4248-a7dd-a54e72f61a1e',
    'Chromic 2',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:21:58.317',
    '2025-02-21 11:21:58.317'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '866d4b61-afe9-4694-b073-818fb8315a92',
    'Praxiquatel Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:41:36.725',
    '2025-02-21 11:41:36.725'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '873982db-faec-4b37-9f10-eebb37c84341',
    'HyoscineButylBromide Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:31:24.568',
    '2025-02-21 11:31:24.568'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '8963a668-bbfe-456b-a49f-a8c906ac487d',
    'Lindocain Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:33:47.456',
    '2025-02-21 11:33:47.456'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '897e2379-3848-4071-9b97-be692c5f268a',
    'Injection Amoxycillin',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:32:14.429',
    '2025-02-21 11:32:14.429'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '8aad337d-0d78-4c23-bc28-c2ad26ce14de',
    'Urine Bag',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:45:04.846',
    '2025-02-21 11:45:04.846'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '8b3014e7-a158-4ff0-b79c-efc891d452cb',
    'Nylon 1',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:38:56.381',
    '2025-02-21 11:38:56.381'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '8b608afc-4c79-4db9-a782-03c219b3e169',
    'Phenobarb Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:40:30.030',
    '2025-02-21 11:40:30.030'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '8d0c83e2-a6da-4a52-b727-3ddd804bae6f',
    'Salbutamol Nebule',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:42:50.120',
    '2025-02-21 11:42:50.120'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '8df735f7-516d-4599-92e3-8a55e3e09c0b',
    'Calcium Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:19:56.572',
    '2025-02-21 11:19:56.572'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '8ffac5cd-517f-4379-8647-8310cb0f401f',
    'Aldomet tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-02-15 16:01:12.422',
    '2025-02-15 16:01:12.422'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '913cbd45-d769-4bd4-9412-356f718ff8da',
    'zinc sulphate',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:47:16.393',
    '2025-02-21 11:47:16.393'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '92bc367c-a771-4d6e-b339-47d18c31c71e',
    'Bco syr',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:17:56.052',
    '2025-02-21 11:17:56.052'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '95a14ce8-273f-4645-bda1-694a1661d5dd',
    'CQ inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:23:52.858',
    '2025-02-21 11:23:52.858'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '9744d02d-51f2-419b-9286-4612905e100d',
    'GV Lotion',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:29:48.173',
    '2025-02-21 11:29:48.173'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '97ad3168-48b1-4c6c-9d4f-07e804330428',
    'Magnesium Sulphate Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:34:14.025',
    '2025-02-21 11:34:14.025'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '97ae7357-8f85-45ae-96c4-dea28fa2e506',
    'Darrow (Full Strength)',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:24:43.854',
    '2025-02-21 11:24:43.854'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '98829f88-636b-4708-abe1-82c48a4829f3',
    'Ciprofloxacin Tablet',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:23:03.747',
    '2025-02-21 11:23:03.747'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '9941adaa-c5ce-459e-86a7-2118501494ee',
    'Bco Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:18:11.282',
    '2025-02-21 11:18:11.282'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '9a183846-d90c-45f7-a3b6-66c9bc630a25',
    'Multivite Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:36:38.162',
    '2025-02-21 11:36:38.162'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '9ac7818d-55cc-4f9a-ba7c-2ddacd739853',
    'Pentazocine Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:40:22.701',
    '2025-02-21 11:40:22.701'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '9b1af085-67c6-4654-81f5-fc7f82366fff',
    'O.R.S',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:39:29.758',
    '2025-02-21 11:39:29.758'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '9b802cc8-f48e-45f4-b460-057e27c1739a',
    'Paracetamol Syrup',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:40:06.938',
    '2025-02-21 11:40:06.938'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '9b87b7b5-9296-4a90-b64a-0eadee2c8b34',
    'Adrenaline inj',
    6,
    -3,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-02-15 16:01:12.422',
    '2025-05-22 20:41:47.260'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '9c501196-f127-4b22-abc9-2769296daf7b',
    'EDTA BOTTLE',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:27:07.660',
    '2025-02-21 11:27:07.660'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '9d463504-ff42-40e5-b2a4-344e95b889d1',
    'Nylon Envelop',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:39:12.998',
    '2025-02-21 11:39:12.998'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '9d90e616-cb30-4d45-9c88-d9499cfcd887',
    'Amitriptyline tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-02-15 16:01:12.422',
    '2025-02-15 16:01:12.422'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '9f418ccc-1cd2-4782-8329-a44ed5d2d932',
    'Detergent',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:24:54.949',
    '2025-02-21 11:24:54.949'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '9fae3d8a-4ec5-4ff2-b877-b5fc54a5e494',
    'Consultation Fee',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:23:14.289',
    '2025-02-21 11:23:14.289'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '9fd63d13-12b6-401b-8dca-85f65d5617e9',
    'Ibuprofen',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:31:43.831',
    '2025-02-21 11:31:43.831'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'a0a54566-ec08-4028-9bc8-c86163689584',
    'AtS inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:16:44.325',
    '2025-02-21 11:16:44.325'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'a306788e-cd8c-4f28-bd19-79ef2542e8ff',
    'Diazepam Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:26:04.079',
    '2025-02-21 11:26:04.079'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'a310815f-0298-4093-bec2-8cf78c0cbfae',
    'Chlorpromazine Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:21:28.558',
    '2025-02-21 11:21:28.558'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'a567f815-b46a-491b-9e31-63108475b1b3',
    'jik',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:32:46.974',
    '2025-02-21 11:32:46.974'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'a7403cba-e114-4ae4-b74c-8b73387ad33e',
    'Piriton Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:40:47.183',
    '2025-02-21 11:40:47.183'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'a8ea3d41-9f1c-4ac2-acdc-c581974c22c5',
    'Normal Saline Infusion',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:38:49.256',
    '2025-02-21 11:38:49.256'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'ad4c0db9-d1e9-4594-bd92-eff0045e9354',
    'Hydrocortisone Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:30:55.629',
    '2025-02-21 11:30:55.629'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'aeaae2a6-a93b-4baf-a2d0-54e179ad1357',
    'Nylon o',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:39:20.402',
    '2025-02-21 11:39:20.402'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'aec0231a-e606-4d84-b537-dc13269d45a0',
    'Chymoral tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:22:16.554',
    '2025-02-21 11:22:16.554'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'b10f56ea-6847-4aad-8d87-43a01afb4676',
    'Paracetamol Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:40:14.335',
    '2025-02-21 11:40:14.335'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'b161965e-b11b-46a4-a9e8-8784ba2756aa',
    'Diazepam Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:25:57.100',
    '2025-02-21 11:25:57.100'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'b2f91c7d-04f0-432d-b439-aba0d2af88c8',
    'Vit B.co inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:45:45.379',
    '2025-02-21 11:45:45.379'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'b33b0677-c437-4451-809a-a1f1c2a7857f',
    'Lisinopril tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:33:55.381',
    '2025-02-21 11:33:55.381'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'b485e495-05b9-4b24-b637-a4b0ca29b0ba',
    'Glucometer Strip',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:29:26.230',
    '2025-02-21 11:29:26.230'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'b56519f5-a529-4c6a-ba17-4a9a5278bd66',
    'Septrim Syrup',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:43:33.261',
    '2025-02-21 11:43:33.261'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'b762e2f4-57c5-449a-a5d5-08876e912ea9',
    'Septrim Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:43:40.156',
    '2025-02-21 11:43:40.156'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'b76b704e-5364-4695-b5fa-3c8cdf0819f4',
    'Azythromycin tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:17:23.654',
    '2025-02-21 11:17:23.654'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'b9258b0e-da90-4148-ba55-320d0a82a9b8',
    'Ultrasound SCAN',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:44:41.343',
    '2025-02-21 11:44:41.343'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'ba0e26d6-50ff-4501-91c8-bf35ea8e0457',
    'Cefuroxime Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:21:04.059',
    '2025-02-21 11:21:04.059'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'bbe9eb5d-5b2c-4e9c-80e5-f64592749004',
    'Thermal paper',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:44:18.370',
    '2025-02-21 11:44:18.370'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'bf7be981-e8ae-4d02-8ad4-ac3f28b97af1',
    'Moduretics tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:35:45.816',
    '2025-02-21 11:35:45.816'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'c2ea0e19-623b-404c-b113-1d9e80a61bfe',
    'Izal',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:32:39.688',
    '2025-02-21 11:32:39.688'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'c2ef3bf6-ab4e-4cb0-b11f-cd5d002e806e',
    'Spirit lotion',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:43:56.139',
    '2025-02-21 11:43:56.139'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'c4a5f0c0-9766-4e2f-965f-31f36db5251d',
    'ASV Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-15 16:44:20.375',
    '2025-02-15 16:44:20.375'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'c504e670-f2dc-4442-9258-98eb3960648c',
    'Noristerat Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:38:41.249',
    '2025-02-21 11:38:41.249'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'c6606cc9-ec72-4179-a969-342ee9faa93f',
    'Vit E Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:46:21.806',
    '2025-02-21 11:46:21.806'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'c6ce08e5-2a8e-47e4-b3c0-38cbf5eff757',
    'Cotton wool',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:23:45.015',
    '2025-02-21 11:23:45.015'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'c8336bde-e9c0-45a7-9a60-71d8e0c43b2a',
    'Magnesium Trisilicate Susp.',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:34:22.046',
    '2025-02-21 11:34:22.046'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'ca26d33e-fc74-431f-bbfa-789adfed7b7e',
    'ASPIRIN 75mg',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-15 16:42:47.721',
    '2025-02-15 16:42:47.721'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'ca8ee0ab-2b07-4035-b1fe-e84f6be606ea',
    'Omeprazole injection',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:39:36.076',
    '2025-02-21 11:39:36.076'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'cbfe58b8-038f-4329-8ba9-e1da5e16cf94',
    'S P Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:42:41.947',
    '2025-02-21 11:42:41.947'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'cd7c5eb4-e8f4-4847-b849-288233aa5785',
    'Vit B.co Syr',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:46:02.112',
    '2025-02-21 11:46:02.112'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'ce15a56c-b3f8-4313-9adb-9af01574f6da',
    'Glibenclamide Tablet',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:28:59.800',
    '2025-02-21 11:28:59.800'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'cfea32cd-c578-4c1f-a185-cca44f13a5e9',
    'Diclofenac Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:26:23.551',
    '2025-02-21 11:26:23.551'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'd0dc006c-f88a-4ed3-a211-2e97c2f3939b',
    'HBV Strip',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:30:11.324',
    '2025-02-21 11:30:11.324'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'd0fd99af-b40d-4130-94e7-d39504003c4c',
    'HyoscineButylBromide Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:31:32.900',
    '2025-02-21 11:31:32.900'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'd320ce74-fc97-4e1b-a46e-fbb31cf9a56a',
    'Ceftriaxone Injection',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:20:56.191',
    '2025-02-21 11:20:56.191'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'd5f24466-8e26-452e-9213-fc2111244582',
    'Bamicide tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:17:36.243',
    '2025-02-21 11:17:36.243'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'd6ad20d4-0bd5-4b36-a3b9-95eff243a069',
    'Misoprostol  tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:35:28.163',
    '2025-02-21 11:35:28.163'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'd8081f72-27be-4723-9c09-819a7638e9be',
    'Piriton Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:40:40.560',
    '2025-02-21 11:40:40.560'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'd906321e-bb92-4fec-84f7-d9fb22c32653',
    'Savlon lotion',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:43:25.145',
    '2025-02-21 11:43:25.145'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'da9374e7-d21d-4c24-9fee-816b2555ab5e',
    'Piroxicam Cap',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:40:54.243',
    '2025-02-21 11:40:54.243'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'dce08af3-6ff3-44ee-be71-624a36e48101',
    'Pregnancy Test Strip',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:41:51.164',
    '2025-02-21 11:41:51.164'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'dd54af69-c271-4640-a2fe-ccc30a1cfcee',
    'Cimetidine Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:22:25.332',
    '2025-02-21 11:22:25.332'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'dfead3ff-3db3-46d6-9972-9f5eb51a6ced',
    'Nitrofurantoin Tablet',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:38:33.088',
    '2025-02-21 11:38:33.088'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'e043ba84-5087-42f4-aa86-4be782b6fe06',
    'Widal Kit',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:46:46.452',
    '2025-02-21 11:46:46.452'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'e07f543f-b2fa-4180-a3e0-b8247f7595b9',
    'Cannula (yellow)',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:20:32.627',
    '2025-02-21 11:20:32.627'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'e08cae93-a804-4cd9-b6ef-a8848bd4b0bb',
    'Dextrose 5%',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:25:30.284',
    '2025-02-21 11:25:30.284'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'e1c05934-9dbd-4fbc-8fb0-ce9c5d3a1b10',
    'Cannula (pink)',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:20:25.003',
    '2025-02-21 11:20:25.003'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'e33282a8-9050-4cdd-9891-de57b79ddb5a',
    'T.Toxoid inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:44:09.918',
    '2025-02-21 11:44:09.918'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'e4546ab2-51d4-467c-a7f8-4629c6d9777c',
    'test',
    0,
    0,
    0,
    '73526e3d-11c5-4997-b954-1e9da37b9809',
    NULL,
    '2025-03-06 16:34:10.072',
    '2025-03-06 16:34:10.072'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'e60ba95d-fde4-4eb6-9460-1d60b1cbe47b',
    'Ivamectin tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:32:32.012',
    '2025-02-21 11:32:32.012'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'e62ee44a-eaa8-42a6-9483-3ed4731de697',
    'Prednisolone Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:41:44.003',
    '2025-02-21 11:41:44.003'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'e6787ef5-517d-4f54-88ef-69698d2423eb',
    'xylocaine adrenaline inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:47:08.403',
    '2025-02-21 11:47:08.403'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'e69705c0-7907-4319-8564-56e2325269b1',
    'Blood Sugar Strip',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:19:33.924',
    '2025-02-21 11:19:33.924'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'eac98cd8-7be2-40cb-9fd8-c61eaf264c39',
    'xylocaine (plain) inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:46:53.322',
    '2025-02-21 11:46:53.322'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'eafc57d0-dd55-4a78-a6ee-4e51fcfe3b74',
    'Doxycycline Cap',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:26:41.382',
    '2025-02-21 11:26:41.382'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'eb169b2d-a2af-4083-9608-0b0bd4ad2dd2',
    'Correction pen',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:23:35.889',
    '2025-02-21 11:23:35.889'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'eb5f46ca-9bd4-40fe-94c9-a148f47a4491',
    'Atenolol Tablet',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-15 16:51:26.597',
    '2025-02-15 16:51:26.597'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'ecd1117a-1df5-42e2-9e2e-88f2ef8c6ed2',
    'Inferon Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:31:50.944',
    '2025-02-21 11:31:50.944'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'ed925159-39ce-4d06-91c0-17501490a8e4',
    'Micronutrient Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:35:20.097',
    '2025-02-21 11:35:20.097'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'ee36a74f-2a13-409a-9796-4dabacb097b0',
    'Mucours Extractor',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:36:13.420',
    '2025-02-21 11:36:13.420'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'eef34aaa-b29d-4c25-acad-f69231e78f7f',
    'Htv strip',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:30:32.337',
    '2025-02-21 11:30:32.337'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'ef96b06b-2a2c-4b06-89e8-c5dfe41ad916',
    'Purit Lotion',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:42:25.741',
    '2025-02-21 11:42:25.741'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'f2aaec57-8070-4406-bf66-2923a62e6e3e',
    'Bco inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:17:48.009',
    '2025-02-21 11:17:48.009'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'f380042e-16f4-4843-a84f-d91bf53192e1',
    'Fesolate',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:27:26.045',
    '2025-02-21 11:27:26.045'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'f3e93bc3-2690-45a3-93b8-5e9bc271e45c',
    'Promethazine Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:42:18.734',
    '2025-02-21 11:42:18.734'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'f4aaa6f8-743d-45e5-b6cb-986de9cd61dd',
    'Loratidine Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:34:04.700',
    '2025-02-21 11:34:04.700'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'f77daecc-5d1c-41af-9fbd-8f2ee76539ad',
    'Carbamazepine Tablet',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:20:40.242',
    '2025-02-21 11:20:40.242'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'f80cf03e-d320-4fae-a692-f26f45613d1b',
    'Cannula (Green)',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:20:15.513',
    '2025-02-21 11:20:15.513'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'f8df65ee-d09d-4830-bed8-bc30a4b6d879',
    'Flagyl Infusion',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:27:37.584',
    '2025-02-21 11:27:37.584'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'f90c6c8f-257e-41fc-9d2c-dfcc4a6bc158',
    'Chromic 0',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:21:37.001',
    '2025-02-21 11:21:37.001'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'fab8f5d9-2eef-4a60-8c51-49b7e20ccb18',
    'Omeprazole Tablet',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:39:44.574',
    '2025-02-21 11:39:44.574'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'faedb78e-2073-4ab3-b907-b200445132b6',
    'Daonil Tab',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:24:26.267',
    '2025-02-21 11:24:26.267'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'fd7ff9f9-a5c4-453e-848b-6714974dad66',
    'Vit k Inj',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:46:29.756',
    '2025-02-21 11:46:29.756'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'fdc91b3f-2933-414b-87b4-105a13b575e7',
    'Dextrose 10%',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:25:22.345',
    '2025-02-21 11:25:22.345'
  );
INSERT INTO
  `drugsinventory` (
    `id`,
    `drug`,
    `stock_qty`,
    `added`,
    `rate`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    'fe746dce-dd28-49b2-86f4-22c82196f56a',
    'Nifedipine Tablet',
    0,
    0,
    0,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-02-21 11:37:51.816',
    '2025-02-21 11:37:51.816'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: encounters
# ------------------------------------------------------------

INSERT INTO
  `encounters` (
    `id`,
    `patient_id`,
    `year`,
    `month`,
    `enc_date`,
    `time`,
    `admitted`,
    `outcome`,
    `care_id`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '348af011-6898-4c40-9e26-de063ac6cfba',
    'cm830mf160003uqy4zu792qvx',
    2025,
    'May',
    '2025-05-22 20:40:53.122',
    '9:41:46 PM',
    0,
    'Treated',
    'cm5fk1nnq0004uqyo7s1gwi5b',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-05-22 20:41:47.214',
    '2025-05-22 20:41:47.214'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: fees
# ------------------------------------------------------------

INSERT INTO
  `fees` (`id`, `name`, `amount`, `createdAt`)
VALUES
  (
    'cm8lntp6a0000uqn0enjayopx',
    'Card',
    0,
    '2025-03-23 13:14:35.312'
  );
INSERT INTO
  `fees` (`id`, `name`, `amount`, `createdAt`)
VALUES
  (
    'cm8lntxzh0001uqn0f71n4zk3',
    'Consultation',
    0,
    '2025-03-23 13:14:46.734'
  );
INSERT INTO
  `fees` (`id`, `name`, `amount`, `createdAt`)
VALUES
  (
    'cm8lnu3ta0002uqn0e51dlg2h',
    'Lab Tests',
    0,
    '2025-03-23 13:14:54.286'
  );
INSERT INTO
  `fees` (`id`, `name`, `amount`, `createdAt`)
VALUES
  (
    'cm8lnu9r40003uqn0igkskoyc',
    'Bld Bag/Col',
    0,
    '2025-03-23 13:15:01.984'
  );
INSERT INTO
  `fees` (`id`, `name`, `amount`, `createdAt`)
VALUES
  (
    'cm8lnui0b0004uqn0kuy0fjlg',
    'USS',
    0,
    '2025-03-23 13:15:12.683'
  );
INSERT INTO
  `fees` (`id`, `name`, `amount`, `createdAt`)
VALUES
  (
    'cm8lnuosw0005uqn084gtoxfa',
    'Admission',
    0,
    '2025-03-23 13:15:21.488'
  );
INSERT INTO
  `fees` (`id`, `name`, `amount`, `createdAt`)
VALUES
  (
    'cm8lnv78w0006uqn0nkqsi5j5',
    'Delivery',
    0,
    '2025-03-23 13:15:45.392'
  );
INSERT INTO
  `fees` (`id`, `name`, `amount`, `createdAt`)
VALUES
  (
    'cm8lnvg0w0007uqn0xanj7acd',
    'Operation',
    0,
    '2025-03-23 13:15:56.768'
  );
INSERT INTO
  `fees` (`id`, `name`, `amount`, `createdAt`)
VALUES
  (
    'cm8lnvo7w0008uqn0jvv1aqgq',
    'Drug/Disposable',
    0,
    '2025-03-23 13:16:07.388'
  );
INSERT INTO
  `fees` (`id`, `name`, `amount`, `createdAt`)
VALUES
  (
    'cm8lnvvp80009uqn06ha5g7w1',
    'Utility/Others',
    0,
    '2025-03-23 13:16:17.084'
  );
INSERT INTO
  `fees` (`id`, `name`, `amount`, `createdAt`)
VALUES
  (
    'cm8pus7bc0002uq00ukochlr9',
    'Xray',
    0,
    '2025-03-26 11:40:27.528'
  );
INSERT INTO
  `fees` (`id`, `name`, `amount`, `createdAt`)
VALUES
  (
    'cm8puskpy0003uq00nybtblhv',
    'ECG',
    0,
    '2025-03-26 11:40:44.903'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: followups
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: groups
# ------------------------------------------------------------

INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk4yee0008uqyob6tmw186',
    'Family',
    '2025-01-02 16:45:37.958'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk55fk0009uqyoyc55c44n',
    'Personal',
    '2025-01-02 16:45:47.072'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk5ghq000auqyoypf3jl93',
    'Private',
    '2025-01-02 16:46:01.406'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk5n9k000buqyot18m45dj',
    'Antenatal',
    '2025-01-02 16:46:10.185'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk5ti7000cuqyonxtryn48',
    'KSHIS',
    '2025-01-02 16:46:18.271'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk5yy0000duqyomgsnlzyu',
    'NHIS',
    '2025-01-02 16:46:25.320'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk69zq000euqyomh8xnpy2',
    'Staff',
    '2025-01-02 16:46:39.638'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk6ia5000fuqyo4hfa3ioa',
    'Emergency',
    '2025-01-02 16:46:50.381'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk71yc000guqyonvt0df75',
    'Premier Medicaid Nig. Ltd',
    '2025-01-02 16:47:15.876'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk7afq000huqyo7at2u56y',
    'ExpatCare Health Int. Ltd',
    '2025-01-02 16:47:26.866'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk7j6p000iuqyo02zly7x7',
    'Premium Health Ltd',
    '2025-01-02 16:47:38.209'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk7p2a000juqyodrtvl316',
    'Total Health Trust Ltd',
    '2025-01-02 16:47:45.826'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk7wrl000kuqyovte2lhol',
    'Managed Health Care Ltd',
    '2025-01-02 16:47:55.809'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk83jl000luqyo5xurzxvc',
    'Princeton Health Ltd',
    '2025-01-02 16:48:04.593'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk89au000muqyoonol9csg',
    'HealthCare Int. Ltd',
    '2025-01-02 16:48:12.054'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk8et3000nuqyo93agsfgk',
    'MultiShield Limited',
    '2025-01-02 16:48:19.192'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk8kta000ouqyozo8164hg',
    'WiseHealth',
    '2025-01-02 16:48:26.974'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk8qtx000puqyotdaketjj',
    'Songhai Health Trust',
    '2025-01-02 16:48:34.773'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk8wkg000quqyoizlwv746',
    'RonsBerger Nig. Ltd',
    '2025-01-02 16:48:42.208'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk91qk000ruqyo91q1s3g8',
    'Avon Healthcare',
    '2025-01-02 16:48:48.909'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk97lw000suqyowtbmdmys',
    'Clearline Int.',
    '2025-01-02 16:48:56.516'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk9dik000tuqyouirszojg',
    'Defence HealthMaintenance',
    '2025-01-02 16:49:04.172'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fk9x42000uuqyoe6flg233',
    'Hygeia HMO',
    '2025-01-02 16:49:29.570'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkatrh000vuqyol9z8nmiu',
    'Int. Health ManagementServices',
    '2025-01-02 16:50:11.885'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkb06o000wuqyo8v5junrq',
    'Integrated Healthcare',
    '2025-01-02 16:50:20.208'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkbnst000xuqyo2utzkqk7',
    'Maayoit Healthcare',
    '2025-01-02 16:50:50.813'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkbssy000yuqyovg6jb7bz',
    'Mediplan Healthcare',
    '2025-01-02 16:50:57.298'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkc243000zuqyo631s82ca',
    'Nonsuch Medicaid',
    '2025-01-02 16:51:09.363'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkc6y10010uqyo7gjq8l06',
    'Regenix Healthcare',
    '2025-01-02 16:51:15.626'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkcc890011uqyobciv3prs',
    'Ultimate HealthcareMaintenance',
    '2025-01-02 16:51:22.474'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkchrh0012uqyos0ir1wn9',
    'UnitedHealthcare Int.',
    '2025-01-02 16:51:29.645'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkcp1n0013uqyoux4mkpao',
    'UnitedHealthcare Capitated',
    '2025-01-02 16:51:39.083'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkcz750014uqyoi0xd7r4l',
    'Wellness Health Service',
    '2025-01-02 16:51:52.241'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkd93b0015uqyoocv9fcrq',
    'Wetlands Health Int.',
    '2025-01-02 16:52:05.064'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkdhpo0016uqyow5hf0xdc',
    'Zuma Health Trust  ',
    '2025-01-02 16:52:16.236'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkdoly0017uqyopkrifds7',
    'Anchor HMO (FFS)',
    '2025-01-02 16:52:25.174'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkdtgy0018uqyo4f8wb21z',
    'Total Health Trust (FFS)',
    '2025-01-02 16:52:31.468'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkdzec0019uqyoz7zfcbyk',
    'AXA Mansard (FFS)',
    '2025-01-02 16:52:39.156'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fke9j1001auqyobmnl26z4',
    'Health Partners (FFS)',
    '2025-01-02 16:52:52.285'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fken2l001buqyounc0rsbs',
    'KBL (FFS)',
    '2025-01-02 16:53:09.837'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkeudj001cuqyorjo1n50p',
    'Lifecare Partners (FFS)',
    '2025-01-02 16:53:19.303'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkf2w8001duqyoyrpwm4km',
    'Novo Health Africa (FFS)',
    '2025-01-02 16:53:30.344'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkf8ld001euqyosde44n12',
    'Prepaid Medicare (FFS)',
    '2025-01-02 16:53:37.729'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkfeag001fuqyo0cwkpyt5',
    'Roding Healthcare (FFS)',
    '2025-01-02 16:53:45.113'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkfjwx001guqyoxqafgwjt',
    'Zenith Medicare (FFS)',
    '2025-01-02 16:53:52.401'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkfrbb001huqyolj1nw2nh',
    'VenusMedicare (FFS)',
    '2025-01-02 16:54:01.992'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkfye6001iuqyoksgil3jg',
    'Altak Industries (FFS)',
    '2025-01-02 16:54:11.166'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkg3xz001juqyowa33l0n4',
    'Zartech Limited (FFS)',
    '2025-01-02 16:54:18.359'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkgahi001kuqyopc0bxygk',
    'Manage Healthcare (FFS)',
    '2025-01-02 16:54:26.838'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkggzr001luqyohj14owsj',
    'Healthcare Int. (FFS)',
    '2025-01-02 16:54:35.272'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkhsmq001muqyozdn9fiae',
    'Hygeia HMO (FFS)',
    '2025-01-02 16:55:37.010'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkhyeg001nuqyoqulrsd4l',
    'UnitedHealthcare (FFS)',
    '2025-01-02 16:55:44.489'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fki498001ouqyocayoby7g',
    'Ultimate Health Trust (FFS)',
    '2025-01-02 16:55:52.077'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkia34001puqyo33q05r0l',
    'Molete Baptist Chur/Grp Schl (FFS)',
    '2025-01-02 16:55:59.632'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkigd4001quqyo5hqbwchw',
    'IBEDC (FFS)',
    '2025-01-02 16:56:07.768'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkilnj001ruqyo9q2s5jri',
    'Clearline Int. (FFS)',
    '2025-01-02 16:56:14.624'
  );
INSERT INTO
  `groups` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fkiulp001suqyojuten9os',
    'Inspiration FM (FFS)',
    '2025-01-02 16:56:26.221'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: immunization
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: labtest
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: operations
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: patients
# ------------------------------------------------------------

INSERT INTO
  `patients` (
    `id`,
    `hosp_no`,
    `year`,
    `month`,
    `name`,
    `sex`,
    `age`,
    `occupation`,
    `religion`,
    `phone_no`,
    `reg_date`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`,
    `group_id`,
    `townId`,
    `no`
  )
VALUES
  (
    'cm830mf160003uqy4zu792qvx',
    '2025/1',
    2025,
    'March',
    'Folorunsho Ibrahim',
    'Male',
    '23y',
    'Software Engineer',
    'Islam',
    '08119513281',
    '2025-03-10 00:00:00.000',
    '73526e3d-11c5-4997-b954-1e9da37b9809',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-03-10 12:05:13.242',
    '2025-05-21 08:36:19.705',
    'cm5fk55fk0009uqyoyc55c44n',
    'cm8aggrwt0032uq84zb2fetrp',
    1
  );
INSERT INTO
  `patients` (
    `id`,
    `hosp_no`,
    `year`,
    `month`,
    `name`,
    `sex`,
    `age`,
    `occupation`,
    `religion`,
    `phone_no`,
    `reg_date`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`,
    `group_id`,
    `townId`,
    `no`
  )
VALUES
  (
    'cm830tahw0005uqy4kr3j6i3t',
    '2025/2',
    2025,
    'March',
    'Test',
    '',
    '2d',
    '',
    '',
    '',
    '2025-03-10 00:00:00.000',
    '73526e3d-11c5-4997-b954-1e9da37b9809',
    NULL,
    '2025-03-10 12:10:33.956',
    '2025-04-06 10:27:15.759',
    'cm5fk55fk0009uqyoyc55c44n',
    NULL,
    2
  );
INSERT INTO
  `patients` (
    `id`,
    `hosp_no`,
    `year`,
    `month`,
    `name`,
    `sex`,
    `age`,
    `occupation`,
    `religion`,
    `phone_no`,
    `reg_date`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`,
    `group_id`,
    `townId`,
    `no`
  )
VALUES
  (
    'cm8agscwc004xuq84enizthcv',
    '2025/3',
    2025,
    'March',
    'Test234',
    'Male',
    '23y',
    'Developer',
    'Islam',
    '08119513281',
    '2025-03-15 00:00:00.000',
    '73526e3d-11c5-4997-b954-1e9da37b9809',
    NULL,
    '2025-03-15 17:12:07.496',
    '2025-04-06 10:27:15.759',
    'cm5fk55fk0009uqyoyc55c44n',
    'cm8aggrwp000guq84qh58p1uk',
    3
  );
INSERT INTO
  `patients` (
    `id`,
    `hosp_no`,
    `year`,
    `month`,
    `name`,
    `sex`,
    `age`,
    `occupation`,
    `religion`,
    `phone_no`,
    `reg_date`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`,
    `group_id`,
    `townId`,
    `no`
  )
VALUES
  (
    'cm8jzxjng0003uqm0dehpcdla',
    '2025/4',
    2025,
    'March',
    'test4',
    '',
    '5d',
    '',
    '',
    '',
    '2025-03-22 00:00:00.000',
    '73526e3d-11c5-4997-b954-1e9da37b9809',
    '73526e3d-11c5-4997-b954-1e9da37b9809',
    '2025-03-22 09:17:57.810',
    '2025-04-06 10:27:15.759',
    'cm5fk55fk0009uqyoyc55c44n',
    'cm8aggrwt0032uq84zb2fetrp',
    4
  );
INSERT INTO
  `patients` (
    `id`,
    `hosp_no`,
    `year`,
    `month`,
    `name`,
    `sex`,
    `age`,
    `occupation`,
    `religion`,
    `phone_no`,
    `reg_date`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`,
    `group_id`,
    `townId`,
    `no`
  )
VALUES
  (
    'cm8k003vh0005uqm0i1tci9aw',
    '2025/5',
    2025,
    'March',
    'tes12345',
    '',
    '7d',
    '',
    'Islam',
    '08119513281',
    '2025-03-22 00:00:00.000',
    '73526e3d-11c5-4997-b954-1e9da37b9809',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-03-22 09:19:57.341',
    '2025-04-06 10:27:15.759',
    'cm5fk55fk0009uqyoyc55c44n',
    'cm8aggrwp0001uq84sz0s0b9i',
    5
  );
INSERT INTO
  `patients` (
    `id`,
    `hosp_no`,
    `year`,
    `month`,
    `name`,
    `sex`,
    `age`,
    `occupation`,
    `religion`,
    `phone_no`,
    `reg_date`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`,
    `group_id`,
    `townId`,
    `no`
  )
VALUES
  (
    'cm95gx0270001uq5s91fd29lw',
    '2025/4321',
    2025,
    'April',
    'Victoria Nnaji',
    'Female',
    '27y',
    'student',
    'Christianity',
    '',
    '2025-04-06 00:00:00.000',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-04-06 09:56:35.594',
    '2025-04-06 10:59:22.507',
    'cm5fk55fk0009uqyoyc55c44n',
    'cm8aggrwt0032uq84zb2fetrp',
    4321
  );
INSERT INTO
  `patients` (
    `id`,
    `hosp_no`,
    `year`,
    `month`,
    `name`,
    `sex`,
    `age`,
    `occupation`,
    `religion`,
    `phone_no`,
    `reg_date`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`,
    `group_id`,
    `townId`,
    `no`
  )
VALUES
  (
    'cm95i9j6a0001uqkgxsh4qv1c',
    '2025/6322',
    2025,
    'April',
    'tacheyon',
    '',
    '',
    '',
    'Islam',
    '',
    '2025-04-06 00:00:00.000',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-04-06 10:34:19.852',
    '2025-04-06 10:34:19.852',
    'cm5fk5ghq000auqyoypf3jl93',
    'cm8aggrwp000guq84qh58p1uk',
    6322
  );
INSERT INTO
  `patients` (
    `id`,
    `hosp_no`,
    `year`,
    `month`,
    `name`,
    `sex`,
    `age`,
    `occupation`,
    `religion`,
    `phone_no`,
    `reg_date`,
    `createdById`,
    `updatedById`,
    `createdAt`,
    `updatedAt`,
    `group_id`,
    `townId`,
    `no`
  )
VALUES
  (
    'cm95ife870003uqkgjrsjvuep',
    '2025/2000',
    2025,
    'April',
    'reader',
    'Male',
    '',
    '',
    '',
    '',
    '2025-04-06 00:00:00.000',
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    NULL,
    '2025-04-06 10:38:53.383',
    '2025-04-06 10:38:53.383',
    'cm5fk4yee0008uqyob6tmw186',
    'cm8aggrwp0001uq84sz0s0b9i',
    2000
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: payment
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: prescriptionhist
# ------------------------------------------------------------

INSERT INTO
  `prescriptionhist` (
    `id`,
    `drug`,
    `hosp_no`,
    `quantity`,
    `rate`,
    `price`,
    `stock_remain`,
    `month`,
    `date`,
    `time`,
    `year`,
    `given_id`,
    `enc_id`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    13,
    'Adrenaline inj',
    '2025/1',
    1,
    2000,
    2000,
    6,
    'May',
    '2025-05-22 00:00:00.000',
    '9:41:46 PM',
    2025,
    'cmazu7wsw0000uq7oahkklx7a',
    '348af011-6898-4c40-9e26-de063ac6cfba',
    '2025-05-22 20:41:47.260',
    '2025-05-22 20:41:47.260'
  );
INSERT INTO
  `prescriptionhist` (
    `id`,
    `drug`,
    `hosp_no`,
    `quantity`,
    `rate`,
    `price`,
    `stock_remain`,
    `month`,
    `date`,
    `time`,
    `year`,
    `given_id`,
    `enc_id`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    14,
    'ACT',
    '2025/1',
    2,
    1500,
    3000,
    8,
    'May',
    '2025-05-22 00:00:00.000',
    '9:41:46 PM',
    2025,
    'cmazu7wsz0001uq7o9g8mqvzi',
    '348af011-6898-4c40-9e26-de063ac6cfba',
    '2025-05-22 20:41:47.260',
    '2025-05-22 20:41:47.260'
  );
INSERT INTO
  `prescriptionhist` (
    `id`,
    `drug`,
    `hosp_no`,
    `quantity`,
    `rate`,
    `price`,
    `stock_remain`,
    `month`,
    `date`,
    `time`,
    `year`,
    `given_id`,
    `enc_id`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    15,
    'ACT',
    '2025/1',
    -1,
    1500,
    1500,
    9,
    'May',
    '2025-05-22 00:00:00.000',
    '10:36:53 PM',
    2025,
    'cmazu7wsz0001uq7o9g8mqvzi',
    '348af011-6898-4c40-9e26-de063ac6cfba',
    '2025-05-22 21:36:53.765',
    '2025-05-22 21:36:53.765'
  );
INSERT INTO
  `prescriptionhist` (
    `id`,
    `drug`,
    `hosp_no`,
    `quantity`,
    `rate`,
    `price`,
    `stock_remain`,
    `month`,
    `date`,
    `time`,
    `year`,
    `given_id`,
    `enc_id`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    16,
    'Adrenaline inj',
    '2025/1',
    0,
    2000,
    2000,
    NULL,
    'May',
    '2025-05-22 00:00:00.000',
    '10:36:53 PM',
    2025,
    'cmazu7wsw0000uq7oahkklx7a',
    '348af011-6898-4c40-9e26-de063ac6cfba',
    '2025-05-22 21:36:53.765',
    '2025-05-22 21:36:53.765'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: procedures
# ------------------------------------------------------------

INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fu2cq60000uqfcm4jg4w4e',
    'Abdominocentesis',
    '2025-01-02 21:23:32.718'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fu3w8q0002uqfcilmctgv7',
    'ANC',
    '2025-01-02 21:24:44.667'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fu42nz0003uqfcbujejc9i',
    'Anterior colporrhaphy',
    '2025-01-02 21:24:52.992'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fu48z90004uqfcl5b6b5og',
    'Appendectomy',
    '2025-01-02 21:25:01.174'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fu4flk0005uqfcxvqvmr8i',
    'Bld transfusion',
    '2025-01-02 21:25:09.751'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fu4l860006uqfcqc42erl2',
    'Caesarean section',
    '2025-01-02 21:25:17.046'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fu4rrw0007uqfc0xaqvbrw',
    'Circumcision',
    '2025-01-02 21:25:25.532'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fu4zrj0008uqfc934dgnw5',
    'Circumcision/removal',
    '2025-01-02 21:25:35.887'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fu56li0009uqfcb5pet9bg',
    'Cu T insertion/removal',
    '2025-01-02 21:25:44.742'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fu5e4e000auqfc78cr7rof',
    'CV Canulation',
    '2025-01-02 21:25:54.494'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm6w4t7fj0003uqesgoupm9tk',
    'Cystotomy',
    '2025-02-08 11:48:22.879'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7ejrak40001uq4gffbajfe8',
    'None',
    '2025-02-21 09:06:39.029'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7enzr680000uq307sschqoq',
    'Delivery',
    '2025-02-21 11:05:12.271'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo05v00001uq30tbm92jam',
    'Destructive vag del',
    '2025-02-21 11:05:31.308'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo0jv30002uq30m3gtbn87',
    'Discharge',
    '2025-02-21 11:05:49.455'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo0wpu0003uq30w3hk6vrl',
    'Ectopic rupture lap',
    '2025-02-21 11:06:06.114'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo165p0004uq300t6925j7',
    'Fissurectomy',
    '2025-02-21 11:06:18.350'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo1d9b0005uq30nf1xtixz',
    'FP services',
    '2025-02-21 11:06:27.550'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo1lkb0006uq300ub3v7a3',
    'Ganglionectectomy',
    '2025-02-21 11:06:38.315'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo1ssx0007uq30ioqkkgrb',
    'Haemorrhoidectomy',
    '2025-02-21 11:06:47.697'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo2e0l0008uq30uqzvp044',
    'Herniorrhaphy',
    '2025-02-21 11:07:15.189'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo2kwo0009uq30n6mtdcrb',
    'Herniotomy',
    '2025-02-21 11:07:24.121'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo2ryb000auq30hxqdlhah',
    'Hydrocoelectomy',
    '2025-02-21 11:07:33.251'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo2yzu000buq30bml350g0',
    'Hysterectomy abd subtotal',
    '2025-02-21 11:07:42.379'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo36jc000cuq309pm0qeph',
    'Hysterectomy abd total',
    '2025-02-21 11:07:52.152'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo3cy8000duq30sg1vl76l',
    'I&D',
    '2025-02-21 11:08:00.464'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo3j0z000euq30owyqd8ml',
    'Immunization',
    '2025-02-21 11:08:08.339'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo3pi6000fuq30q38f1iw2',
    'In-grown toe nail',
    '2025-02-21 11:08:16.735'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo3vgg000guq302jl7tief',
    'IVF',
    '2025-02-21 11:08:24.447'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo48eu000huq30l029doxt',
    'Laps infective abd',
    '2025-02-21 11:08:41.238'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo4vhb000iuq30anhnxx4f',
    'Laps Intestinal obstruction',
    '2025-02-21 11:09:11.135'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo58uf000juq30tbfcu6g5',
    'Laps Intestinal perforation',
    '2025-02-21 11:09:28.450'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo5g8v000kuq30audalo7f',
    'Low fistulectomy',
    '2025-02-21 11:09:38.047'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo5mqu000luq3004n90bif',
    'Marsupialisation',
    '2025-02-21 11:09:46.470'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo5sbc000muq30ljc9sov4',
    'Myomectomy',
    '2025-02-21 11:09:53.689'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo5xd1000nuq300w4c9mce',
    'Neonatal care',
    '2025-02-21 11:10:00.230'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo6448000ouq30gp7f43ip',
    'NG tube-aspiration',
    '2025-02-21 11:10:08.984'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo6ebd000puq30zs7m8epx',
    'NG tube-feed',
    '2025-02-21 11:10:22.201'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo6kvi000quq30614c22pg',
    'Norplant insetion/removal',
    '2025-02-21 11:10:30.702'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo6q9p000ruq30mp9o7fvh',
    'O2 therapy',
    '2025-02-21 11:10:37.693'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo6vkh000suq30sd9q7474',
    'Oophorectomy',
    '2025-02-21 11:10:44.561'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo757c000tuq30dd3lu8os',
    'Orchidectomy',
    '2025-02-21 11:10:57.047'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo7bw6000uuq30egqr200s',
    'Orchidopexy',
    '2025-02-21 11:11:05.719'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo7i0l000vuq301aozwyn0',
    'Out Pt treatment',
    '2025-02-21 11:11:13.653'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo7o3n000wuq30c5jtkzss',
    'Ovarian cystectomy',
    '2025-02-21 11:11:21.539'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo7tvo000xuq30k8tqnqkc',
    'Perineal tear repair',
    '2025-02-21 11:11:29.028'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo82fr000yuq3062hwxpg9',
    'Physiotherapy',
    '2025-02-21 11:11:40.119'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo88jt000zuq30opl0icqn',
    'Prostatectomy open',
    '2025-02-21 11:11:48.041'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo8e0f0010uq30p3da5nrp',
    'Referred',
    '2025-02-21 11:11:55.119'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo8jcf0011uq30070nvf6t',
    'SVD',
    '2025-02-21 11:12:02.031'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo8p4x0012uq30o73ea4lz',
    'Thoracentesis',
    '2025-02-21 11:12:09.537'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo8wcw0013uq301k42yqvq',
    'Urethral bouginage',
    '2025-02-21 11:12:18.896'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo9emo0014uq30g4vno19k',
    'Urethral catheterization',
    '2025-02-21 11:12:42.576'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo9kmk0015uq305fi8ecau',
    'Vacuum delivery',
    '2025-02-21 11:12:50.348'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eo9ute0016uq30sqwf003i',
    'Vag Hysterectomy',
    '2025-02-21 11:13:03.554'
  );
INSERT INTO
  `procedures` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm7eoa09q0017uq30cgg3qeye',
    'Venous cutdown',
    '2025-02-21 11:13:10.622'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: reciept
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: snapshot
# ------------------------------------------------------------

INSERT INTO
  `snapshot` (
    `id`,
    `type`,
    `data`,
    `year`,
    `month`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    '1faf6a03-a4d1-4f3f-8aa6-9cf9e40971f4',
    'drugs',
    '[{\"name\": \"ACT\", \"curr_stock\": 9, \"totalSGain\": 10, \"totalSLoss\": 0, \"prescriptions\": 1, \"totalPurchaseQty\": 20}, {\"name\": \"Adrenaline inj\", \"curr_stock\": 6, \"totalSGain\": 10, \"totalSLoss\": -3, \"prescriptions\": 1, \"totalPurchaseQty\": 20}, {\"name\": \"Albendazole tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Aldomet tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Amilordipine 10mg Tablet\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Aminophyline inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Amitriptyline tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Amoxycillin Capsules\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Amoxycillin dispersible\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Amoxycillin Suspension\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Antisera A\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Antisera B\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Antisera D\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Arteether inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Artemether Injection\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Artesunate Injection\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Arthrotec tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"ASPIRIN 75mg\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"ASV Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Atenolol Tablet\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Atropine inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"AtS inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Azythromycin tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Bamicide tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Bco inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Bco syr\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Bco Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Blood Bag\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Blood Giving set\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Blood Sugar Strip\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Calcium Gluconate\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Calcium Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Cannula (Blue)\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Cannula (Green)\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Cannula (pink)\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Cannula (yellow)\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Carbamazepine Tablet\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Catheter 18\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Ceftriaxone Injection\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Cefuroxime Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Cefuroxime Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Chlorpromazine Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Chromic 0\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Chromic 1\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Chromic 2\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Chromic 2/0\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Chymoral tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Cimetidine Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Cimetidine Tablet\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Ciprofloxacin I V\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Ciprofloxacin Tablet\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Consultation Fee\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Correction pen\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Cotton wool\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"CQ inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"CQ Syrup\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Crysterpen Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Daonil Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Darrow (1/2 Strength)\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Darrow (Full Strength)\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Detergent\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Dexamethazone Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Dexamethazone Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Dextrose 10%\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Dextrose 5%\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Dextrose4.3%in 0.18Saline\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Dextrose50%\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Diazepam Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Diazepam Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Diclofenac Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Diclofenac Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Digoxin Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Doxycycline Cap\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Dutasteride tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"EDTA BOTTLE\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Family planning combination pills\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Fesolate\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Flagyl Infusion\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Flagyl Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Fluconazole Tablet\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Folic Acid\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Frusemide Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Frusemide Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Gauze\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Gelucil Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Gentamycin inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Glibenclamide Tablet\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Glucokate Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Glucomete\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Glucometer Strip\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"GV Lotion\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"HB Cellulose Paper\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"HBV drugs\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"HBV Strip\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"HCV Strip\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Htv strip\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Hydralazin Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Hydrochlorothiazide Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Hydrocortisone Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Hydrogen peroxide Lotion\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"HyoscineButylBromide Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"HyoscineButylBromide Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Ibuprofen\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Inferon Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Infusion Glucose 50%\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Infusion set\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Injection Amoxycillin\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Insuline Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Ivamectin tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Izal\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"jik\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Ketamine Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"KY Gel\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Lamivudine Lenovovor\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Latex glove\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Laxative Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Leishman Stain\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Lindocain Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Lisinopril tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Loratidine Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Magnesium Sulphate Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Magnesium Trisilicate Susp.\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Malaria (RMP)Strip\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Manitol 15%\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Mefenamic acid tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Metformin Tablet\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Metoclopramide Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Micronutrient powder\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Micronutrient Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Misoprostol  tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Mist Pottasium Syrup\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Moduretics tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Mucours Extractor\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Multivite Syrup\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Multivite Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"My boy\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Neurovite tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Nifedipine Tablet\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Nitrofurantoin Tablet\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Noristerat Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Normal Saline Infusion\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Nylon 1\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Nylon 2\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Nylon Envelop\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Nylon o\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"O.R.S\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Omeprazole injection\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Omeprazole Tablet\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Oxytocine Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Paracetamol Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Paracetamol Syrup\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Paracetamol Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Pentazocine Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Phenobarb Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Piriton Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Piriton Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Piroxicam Cap\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Piroxicam Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Plasil Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Plaster\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Povidone Iodine\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Praxiquatel Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Prednisolone Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Pregnancy Test Strip\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Primolut Depot\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Proguanil\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Promethazine Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Purit Lotion\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Rhogam Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"S P Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Salbutamol Nebule\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Salbutamol Syrup\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Salbutamol Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Savlon lotion\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Septrim Syrup\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Septrim Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Sodamint Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Spirit lotion\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Spironolacton Tablet\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"T.Toxoid inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"test\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Thermal paper\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Tranexamic acid inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Ultrasound gel\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Ultrasound SCAN\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Urinalysis strip\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Urine Bag\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Utility&Others\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Vasoprin Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"VDRL Strip\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Vit B.co\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Vit B.co inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Vit B.co Syr\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Vit C Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Vit E Tab\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Vit k Inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"WBC Diluent\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"Widal Kit\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"xylocaine (plain) inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"xylocaine 5% spinal\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"xylocaine adrenaline inj\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}, {\"name\": \"zinc sulphate\", \"curr_stock\": 0, \"totalSGain\": 0, \"totalSLoss\": 0, \"prescriptions\": 0, \"totalPurchaseQty\": 0}]',
    2025,
    'May',
    '2025-05-22 20:57:40.683',
    '2025-05-24 21:00:00.360'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: stockshistory
# ------------------------------------------------------------

INSERT INTO
  `stockshistory` (
    `id`,
    `drug_id`,
    `name`,
    `type`,
    `stock_qty`,
    `added`,
    `month`,
    `year`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    3,
    '1f8db447-1227-4dad-802e-cc200a0fa978',
    'ACT',
    'gain',
    0,
    10,
    'May',
    2025,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-05-22 20:35:52.764',
    '2025-05-22 00:00:00.000'
  );
INSERT INTO
  `stockshistory` (
    `id`,
    `drug_id`,
    `name`,
    `type`,
    `stock_qty`,
    `added`,
    `month`,
    `year`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    4,
    '9b87b7b5-9296-4a90-b64a-0eadee2c8b34',
    'Adrenaline inj',
    'gain',
    0,
    10,
    'May',
    2025,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-05-22 20:36:06.566',
    '2025-05-22 00:00:00.000'
  );
INSERT INTO
  `stockshistory` (
    `id`,
    `drug_id`,
    `name`,
    `type`,
    `stock_qty`,
    `added`,
    `month`,
    `year`,
    `updatedById`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    5,
    '9b87b7b5-9296-4a90-b64a-0eadee2c8b34',
    'Adrenaline inj',
    'loss',
    10,
    -3,
    'May',
    2025,
    '8e945d62-8991-420a-82f1-9a6c3740329d',
    '2025-05-22 20:37:54.895',
    '2025-05-22 00:00:00.000'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: tests
# ------------------------------------------------------------

INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffe9130002uqysl0c2vyx3',
    'AFB sputum',
    '2025-01-02 14:32:53.556'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffef280003uqyszk2zs4dm',
    'Bil (uri)',
    '2025-01-02 14:33:01.376'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffgoni0004uqyslds12xy7',
    'Bili (bld)',
    '2025-01-02 14:34:47.118'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffh1jx0005uqyseyt91crg',
    'Bld Grp',
    '2025-01-02 14:35:03.837'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffh8nr0006uqyskofd1p3n',
    'BLD SUG',
    '2025-01-02 14:35:13.048'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffhduf0007uqysxqz3app8',
    'Choles(bld)',
    '2025-01-02 14:35:19.767'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffhl0v0008uqysbreqzvzm',
    'Cl- (bld)',
    '2025-01-02 14:35:29.071'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffhrk80009uqys8zg70tfn',
    'Creatinine (bld)',
    '2025-01-02 14:35:37.544'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffhwun000auqysu28vjmjq',
    'Clotting time',
    '2025-01-02 14:35:44.399'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffi0w3000buqysvgg36i87',
    'E&U',
    '2025-01-02 14:35:49.636'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffi4ic000cuqysqwab1dsq',
    'ECG',
    '2025-01-02 14:35:54.324'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffi8yc000duqysbjengf8q',
    'Epith cels(u)',
    '2025-01-02 14:36:00.084'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fficoc000euqysmnmkxqf7',
    'FBC',
    '2025-01-02 14:36:04.909'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffigha000fuqysgzifozo9',
    'G&M',
    '2025-01-02 14:36:09.838'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffk0ma000guqystcdmtsho',
    'Glu(uri)',
    '2025-01-02 14:37:22.588'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffk4jy000huqysxxugeit2',
    'GRAN %',
    '2025-01-02 14:37:27.694'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffk9pb000iuqys6f0dsxtc',
    'GRAN count',
    '2025-01-02 14:37:34.367'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffkf54000juqysqm0x3kip',
    'Hb genotype',
    '2025-01-02 14:37:41.416'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffkus3000kuqys6fnqmcju',
    'HBV',
    '2025-01-02 14:38:01.683'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffkyfg000luqys9puynrtk',
    'HCV',
    '2025-01-02 14:38:06.413'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffl2ec000muqysdgign3mi',
    'HGB',
    '2025-01-02 14:38:11.557'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffl73q000nuqysu4j9andj',
    'K+ (bld)',
    '2025-01-02 14:38:17.654'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fflbu6000ouqys1ln2tv14',
    'Ket(uri)',
    '2025-01-02 14:38:23.791'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fflrq7000puqysxzhgghib',
    'Leu(uri)',
    '2025-01-02 14:38:44.383'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5fflwi6000quqysaxadvtfu',
    'LFT',
    '2025-01-02 14:38:50.574'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffm1eu000ruqysz6x0hb5z',
    'LYM %',
    '2025-01-02 14:38:56.935'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffm6ab000suqysxlz6mg0m',
    'LYM count',
    '2025-01-02 14:39:03.251'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffmb2g000tuqyswl7k7qx5',
    'M/C/S',
    '2025-01-02 14:39:09.448'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffmfng000uuqysmyq3eofp',
    'MID %',
    '2025-01-02 14:39:15.388'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffmkl3000vuqysrsu9jn0v',
    'MID count',
    '2025-01-02 14:39:21.783'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffmox2000wuqysepmpv23w',
    'MP',
    '2025-01-02 14:39:27.399'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffmw7f000xuqyswujgjlwk',
    'Na+ (bld)',
    '2025-01-02 14:39:36.842'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffn1eu000yuqys56ez66zr',
    'Nitrite(u)',
    '2025-01-02 14:39:43.590'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffn727000zuqysjleavrwi',
    'pcv',
    '2025-01-02 14:39:50.911'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffnbf10010uqysbqq2ah5m',
    'PH(uri)',
    '2025-01-02 14:39:56.557'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffnftf0011uqysuezzto5i',
    'PLT',
    '2025-01-02 14:40:02.259'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffnkk50012uqysktom9s16',
    'Prote(uri)',
    '2025-01-02 14:40:08.406'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffno710013uqysn7ntf31y',
    'PT',
    '2025-01-02 14:40:13.117'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffnswf0014uqyso65bcm6z',
    'Pus cels(u)',
    '2025-01-02 14:40:19.216'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffnxe60015uqysfm3wom55',
    'rbc(uri)',
    '2025-01-02 14:40:25.038'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffo2410016uqyst4tazh50',
    'RVS',
    '2025-01-02 14:40:31.152'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffo7h40017uqysy3g780px',
    'S.G(uri)',
    '2025-01-02 14:40:38.104'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffoc9r0018uqysg5j0qd2f',
    'Urea (bld)',
    '2025-01-02 14:40:44.319'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffogam0019uqyss97c7jwy',
    'Urinalysis',
    '2025-01-02 14:40:49.534'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffokgt001auqysqpyf2ai4',
    'Urine Mic',
    '2025-01-02 14:40:54.941'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffoor1001buqys1b58mw9x',
    'Uro(uri)',
    '2025-01-02 14:41:00.494'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffosr3001cuqysx3grdj0p',
    'USS',
    '2025-01-02 14:41:05.679'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffovz0001duqysbu7g6s3w',
    'WBC',
    '2025-01-02 14:41:09.853'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffozou001euqysoh5kk6pj',
    'Xexpert',
    '2025-01-02 14:41:14.670'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffp3yt001fuqyssa8u6xn6',
    'Xray',
    '2025-01-02 14:41:20.213'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffq974001guqysp8fbutrs',
    'Epith cel (ur)',
    '2025-01-02 14:42:13.648'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffrkx20000uql8ygbw657x',
    'BP',
    '2025-01-02 14:43:15.494'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffrsb60001uql8ezkxrkg6',
    'Pain',
    '2025-01-02 14:43:25.074'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffrwmt0002uql8wmxvv4ao',
    'Po2',
    '2025-01-02 14:43:30.677'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffrzz80003uql8rdgo04fn',
    'Pulse',
    '2025-01-02 14:43:35.013'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm5ffs4l10004uql87e3zp3rl',
    'Temp',
    '2025-01-02 14:43:40.981'
  );
INSERT INTO
  `tests` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8k0pgc00001uq44eedj3mzn',
    'HIV/AIDS',
    '2025-03-22 09:39:39.888'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: tnxitem
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: town
# ------------------------------------------------------------

INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwn0000uq84m8xtzuyq',
    'Aboki',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwp0001uq84sz0s0b9i',
    'Adera',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwp0002uq84k7q3v1bo',
    'Agwara',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwp0003uq84zwzl6dwg',
    'Anfani',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwp0004uq84h4u4op4x',
    'Arende',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwp0005uq84zxgepqk3',
    'Ashauwa',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwp0006uq84rhcqp68f',
    'Audufari',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwp0007uq84o0ap0jnk',
    'Awuru',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwp0008uq84lh1y6lhc',
    'Ayaba',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwp0009uq84kx0xd3fp',
    'Ayagu',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwp000auq840cmaoe33',
    'Babana',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwp000buq84x8gk5h4r',
    'Baburasa',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwp000cuq84h9021228',
    'Bakomisan',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwp000duq84qougn0th',
    'Bakwa',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwp000euq845pdkwfm0',
    'Bani',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwp000fuq843k11grwe',
    'Bode sadu',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwp000guq84qh58p1uk',
    'Bussa',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwp000huq84fch1u20k',
    'Daba',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq000iuq84dbtryh24',
    'Daja',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq000juq84z209f933',
    'Dandafi',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq000kuq84n8cu425f',
    'Degeji',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq000luq84u0u1f4gv',
    'Demo',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq000muq84udt07bv5',
    'Dogon gona',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq000nuq8490atus4g',
    'Dogongari',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq000ouq8407z0clwf',
    'Duga',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq000puq84xxj9nmdu',
    'Fakawa',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq000quq844vs8ell1',
    'Faridusi',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq000ruq84mb0asrqg',
    'Farinsone',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq000suq84v0ene3gb',
    'Gada olli',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq000tuq84dlrhk7lo',
    'Galla',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq000uuq842as766g2',
    'Gando',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq000vuq84fi43cq8c',
    'Garafini',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq000wuq84a6kgaxfs',
    'Gbasolo',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq000xuq84xbl3rbkz',
    'Gberia',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq000yuq84ssmqzh6m',
    'Gofanti',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq000zuq84w8n67n6g',
    'Gorobani',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq0010uq84r1i6unhe',
    'Gugan',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq0011uq84v1hb5d1j',
    'Guna',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq0012uq84qi88c1ij',
    'Gungawa',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq0013uq84s6hgihxs',
    'Gurya',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq0014uq84fxmvsf75',
    'Gwagude',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq0015uq842zr3blhb',
    'Gwajibo',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq0016uq84avnhym5l',
    'Gwangware',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq0017uq84zh6hzcyk',
    'Ibeto',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq0018uq84jhrfg6j4',
    'Ibgoho',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq0019uq84izblabz6',
    'Igbeti',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwq001auq848cu0lpzh',
    'Igori',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001buq84yv1r7lop',
    'Jarbagu',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001cuq84zmbnx2dq',
    'Jebba',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001duq84k0pqigc4',
    'Jika',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001euq84c5lxfzsq',
    'Kabe',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001fuq84qkb7l7m6',
    'Kaboji',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001guq84cygunxtu',
    'Kaiama',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001huq84vmlbaxtx',
    'Kainji',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001iuq8409gcsjm2',
    'Kale',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001juq84fziycuvc',
    'Kampo',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001kuq84gfn6ef52',
    'kangon garafini',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001luq84yumpx443',
    'Kanpu',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001muq84wp0roe1k',
    'kanti',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001nuq84fxky29ki',
    'kanya',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001ouq84cb4x9l8y',
    'Kara Jebba',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001puq84t1eybley',
    'kemanji',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001quq84hs6pekqa',
    'Kere',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001ruq84anidflqg',
    'Kerengin',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001suq84zdiisf0z',
    'kilmo',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001tuq84kljuvpea',
    'Kisi',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001uuq84u8x1do00',
    'Kolo',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001vuq84okrds0bu',
    'Konkoji',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001wuq84g259ihpa',
    'Kontagora',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001xuq843nembiyr',
    'kpura',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001yuq842ul3chfb',
    'Kuble',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr001zuq84nlfa30jh',
    'Kudu',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr0020uq843d66f71d',
    'Kuliwaya',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr0021uq84320fd2j8',
    'Kura',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr0022uq84d5bs8tlw',
    'kurmi Adama',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr0023uq846lako9em',
    'kurwasa',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr0024uq84pil73bfc',
    'kusa',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr0025uq84aok5h17n',
    'kwana',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr0026uq84ruhbg0qn',
    'kwana loda',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwr0027uq843yg9atb5',
    'kwawo',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws0028uq84l79nfwx2',
    'lafiagi',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws0029uq84dxzezmye',
    'Laka',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002auq84fq10i3iw',
    'lambu',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002buq842drdaq4h',
    'Lamu',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002cuq84kjgm4nw4',
    'Lema',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002duq84lhct1cq0',
    'lesha',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002euq849b75l7d6',
    'Leshigbe',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002fuq84o19wlsq6',
    'Loda',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002guq84ges1jjt2',
    'Lokon minna',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002huq849dlv4dby',
    'Lowa',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002iuq84gawwz00k',
    'Luma',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002juq84oyxan2mo',
    'luma bare',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002kuq84uef84ks7',
    'mabura',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002luq8403g8qjxa',
    'Mago',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002muq84skt3fd0j',
    'Mai godea',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002nuq84sjz2a0vg',
    'mai kade',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002ouq841tad2hgu',
    'Maje',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002puq84dlfs7tbo',
    'makera',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002quq84m3i6527b',
    'malale',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002ruq84q4e94z2i',
    'malami',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002suq841wfrsj0z',
    'Mawidi',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002tuq84cpknmkvr',
    'mokwa',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002uuq84v4fixrf8',
    'more',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002vuq84uyqs8izi',
    'Muse laru',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002wuq845gwwvisp',
    'mushe Gada',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002xuq84zony716v',
    'mushe Gofa',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrws002yuq84bk0t6c6s',
    'Nanu',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt002zuq84bews22ye',
    'Nasarawa',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt0030uq842p0oarsx',
    'Nasarawa koro',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt0031uq84e6cr5hjq',
    'Nasko',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt0032uq84zb2fetrp',
    'New Bussa',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt0033uq8490ycazc7',
    'Nuku',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt0034uq8408b0gt0o',
    'Okeode',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt0035uq84bihy0qkj',
    'Okeoyi',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt0036uq84r087vigg',
    'Okuta',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt0037uq84u593z3tj',
    'Osa',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt0038uq84rhqa43wz',
    'Papiri',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt0039uq84uuldlevj',
    'patigi',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003auq847j6410d3',
    'Pengbere',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003buq84x6bl0tpz',
    'Perengu',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003cuq84ljdlodfh',
    'poji',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003duq84vq971ade',
    'Rafin Goro',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003euq84w609t9eb',
    'Rafin madaci',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003fuq8488ptf7eq',
    'Rafin Maigudu',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003guq84j3aqwhzg',
    'rafin waya',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003huq84no68apy2',
    'Rofiya',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003iuq84zpsuuf31',
    'sabo yumu',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003juq84pa9cslwt',
    'sabon koko',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003kuq844482xy3b',
    'sabonfegi',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003luq841pqs23w2',
    'samunaka',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003muq8491531mnr',
    'sansani',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003nuq8411yxvcr2',
    'Sarabe',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003ouq84jzt6716i',
    'Saragi',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003puq844b4p5jar',
    'Sare',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003quq846gbzigok',
    'shafashi',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003ruq84px9bq41h',
    'Shafini',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003suq84y0j3cdt4',
    'shagunu',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003tuq84ewcnoz0u',
    'Shanga',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003uuq84ehju6ipm',
    'Sokobara',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003vuq84n968tqbd',
    'Sokonba',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003wuq84zo36hkjt',
    'Swashi',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwt003xuq848j1ukea9',
    'Tale',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu003yuq8415d7mt9f',
    'Tamanai',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu003zuq8491n209qw',
    'Tashan maje',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu0040uq844dbjorwu',
    'Tenibo',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu0041uq84ph54u9el',
    'Tese',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu0042uq84r3qvgv92',
    'Tese Kaiama',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu0043uq844qg48qs4',
    'Tunga Ayaba',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu0044uq846crxtwvu',
    'Tunga Boka',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu0045uq84fupr4j8s',
    'Tunga BORI',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu0046uq840civ5wau',
    'Tunga damala',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu0047uq84qrmdfvnf',
    'Tunga DAYA',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu0048uq842q6kt0oh',
    'Tunga Gado',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu0049uq84xzwk3a93',
    'Tunga giwa',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004auq84swbeptzz',
    'Tunga Hajia',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004buq84i2577vig',
    'Tunga Ibrahim',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004cuq84oo6lii2c',
    'Tunga Jagaba',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004duq841ba0e47n',
    'Tunga mangoro',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004euq84qddd83lj',
    'Tunga Nailo',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004fuq848r1ij0e0',
    'Tunga sule',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004guq84wwv4v4hn',
    'Tunga taya',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004huq843tssh3rd',
    'Tunga wakili',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004iuq84bbuf0her',
    'Udu',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004juq84oc9bzfqe',
    'Ukebe',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004kuq841bp13sse',
    'Ulakami',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004luq84p3krvum9',
    'utula',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004muq84mq0lqbif',
    'venra',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004nuq84ee0sxo8e',
    'Wawa',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004ouq84dal84t83',
    'woko',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004puq84zsdxx90y',
    'woro',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004quq84ibcum0t5',
    'yangalo',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004ruq84p0jleotf',
    'yangba',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004suq84hval078y',
    'yashikira',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004tuq844nzam1yt',
    'Yauri',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwu004uuq84qthglpfo',
    'yumu',
    '2025-03-15 17:03:07.068'
  );
INSERT INTO
  `town` (`id`, `name`, `createdAt`)
VALUES
  (
    'cm8aggrwv004vuq84c00qgb0s',
    'Zuguruma',
    '2025-03-15 17:03:07.068'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: transaction
# ------------------------------------------------------------


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
