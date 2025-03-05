/*
  Warnings:

  - Made the column `test_id` on table `labtest` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE `labtest` DROP FOREIGN KEY `LabTest_test_id_fkey`;

-- DropIndex
DROP INDEX `LabTest_test_id_fkey` ON `labtest`;

-- AlterTable
ALTER TABLE `labtest` MODIFY `test_id` VARCHAR(191) NOT NULL;

-- AddForeignKey
ALTER TABLE `LabTest` ADD CONSTRAINT `LabTest_test_id_fkey` FOREIGN KEY (`test_id`) REFERENCES `Tests`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
