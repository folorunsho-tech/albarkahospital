/*
  Warnings:

  - You are about to drop the column `hosp_no` on the `encounters` table. All the data in the column will be lost.
  - You are about to drop the column `hosp_no` on the `transactions` table. All the data in the column will be lost.
  - Added the required column `patient_id` to the `Encounters` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `encounters` DROP FOREIGN KEY `Encounters_hosp_no_fkey`;

-- DropForeignKey
ALTER TABLE `transactions` DROP FOREIGN KEY `Transactions_hosp_no_fkey`;

-- DropIndex
DROP INDEX `Encounters_hosp_no_fkey` ON `encounters`;

-- DropIndex
DROP INDEX `Patients_hosp_no_key` ON `patients`;

-- DropIndex
DROP INDEX `Transactions_hosp_no_fkey` ON `transactions`;

-- AlterTable
ALTER TABLE `encounters` DROP COLUMN `hosp_no`,
    ADD COLUMN `patient_id` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `transactions` DROP COLUMN `hosp_no`,
    ADD COLUMN `patient_id` VARCHAR(191) NULL;

-- AddForeignKey
ALTER TABLE `Encounters` ADD CONSTRAINT `Encounters_patient_id_fkey` FOREIGN KEY (`patient_id`) REFERENCES `Patients`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transactions` ADD CONSTRAINT `Transactions_patient_id_fkey` FOREIGN KEY (`patient_id`) REFERENCES `Patients`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
