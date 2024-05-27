/*
  Warnings:

  - The primary key for the `Cart` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Cart` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Cart" (
    "userEmail" TEXT NOT NULL,
    CONSTRAINT "Cart_userEmail_fkey" FOREIGN KEY ("userEmail") REFERENCES "users" ("email") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Cart" ("userEmail") SELECT "userEmail" FROM "Cart";
DROP TABLE "Cart";
ALTER TABLE "new_Cart" RENAME TO "Cart";
CREATE UNIQUE INDEX "Cart_userEmail_key" ON "Cart"("userEmail");
CREATE TABLE "new_ProductsOnCart" (
    "productId" TEXT NOT NULL,
    "cartId" TEXT NOT NULL,
    "assignedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "assignedBy" TEXT NOT NULL,

    PRIMARY KEY ("productId", "cartId"),
    CONSTRAINT "ProductsOnCart_productId_fkey" FOREIGN KEY ("productId") REFERENCES "products" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "ProductsOnCart_cartId_fkey" FOREIGN KEY ("cartId") REFERENCES "Cart" ("userEmail") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_ProductsOnCart" ("assignedAt", "assignedBy", "cartId", "productId") SELECT "assignedAt", "assignedBy", "cartId", "productId" FROM "ProductsOnCart";
DROP TABLE "ProductsOnCart";
ALTER TABLE "new_ProductsOnCart" RENAME TO "ProductsOnCart";
PRAGMA foreign_key_check("Cart");
PRAGMA foreign_key_check("ProductsOnCart");
PRAGMA foreign_keys=ON;
