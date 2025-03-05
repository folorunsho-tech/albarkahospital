/*
  Warnings:

  - You are about to drop the column `deliveryId` on the `encounters` table. All the data in the column will be lost.
  - You are about to drop the `deliveries` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `encounters` DROP FOREIGN KEY `Encounters_deliveryId_fkey`;

-- DropIndex
DROP INDEX `Encounters_deliveryId_fkey` ON `encounters`;

-- AlterTable
ALTER TABLE `encounters` DROP COLUMN `deliveryId`,
    ADD COLUMN `delivery` JSON NULL;

-- DropTable
DROP TABLE `deliveries`;
