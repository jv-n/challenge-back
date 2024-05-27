/*
  Warnings:

  - You are about to drop the column `orderUser` on the `Order` table. All the data in the column will be lost.
  - Added the required column `user` to the `Order` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Order" (
    "order_placed" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "order_total" REAL NOT NULL,
    "user" TEXT NOT NULL
);
INSERT INTO "new_Order" ("order_placed", "order_total") SELECT "order_placed", "order_total" FROM "Order";
DROP TABLE "Order";
ALTER TABLE "new_Order" RENAME TO "Order";
CREATE UNIQUE INDEX "Order_user_key" ON "Order"("user");
PRAGMA foreign_key_check("Order");
PRAGMA foreign_keys=ON;
