-- AlterTable
ALTER TABLE `drugsgiven` ADD COLUMN `price` INTEGER NULL DEFAULT 0;

-- AlterTable
ALTER TABLE `prescriptionhist` ADD COLUMN `price` INTEGER NULL DEFAULT 0;
