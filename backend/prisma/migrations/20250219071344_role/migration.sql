/*
  Warnings:

  - You are about to drop the column `admitted` on the `encounters` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `accounts` ADD COLUMN `role` VARCHAR(191) NOT NULL DEFAULT 'user';

-- AlterTable
ALTER TABLE `encounters` DROP COLUMN `admitted`;
