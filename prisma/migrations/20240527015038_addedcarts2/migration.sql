/*
  Warnings:

  - You are about to drop the `:userEmail` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropIndex
DROP INDEX ":userEmail_userEmail_key";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE ":userEmail";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Cart" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userEmail" TEXT NOT NULL,
    CONSTRAINT "Cart_userEmail_fkey" FOREIGN KEY ("userEmail") REFERENCES "users" ("email") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_ProductsOnCart" (
    "productId" TEXT NOT NULL,
    "cartId" TEXT NOT NULL,
    "assignedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "assignedBy" TEXT NOT NULL,

    PRIMARY KEY ("productId", "cartId"),
    CONSTRAINT "ProductsOnCart_productId_fkey" FOREIGN KEY ("productId") REFERENCES "products" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "ProductsOnCart_cartId_fkey" FOREIGN KEY ("cartId") REFERENCES "Cart" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_ProductsOnCart" ("assignedAt", "assignedBy", "cartId", "productId") SELECT "assignedAt", "assignedBy", "cartId", "productId" FROM "ProductsOnCart";
DROP TABLE "ProductsOnCart";
ALTER TABLE "new_ProductsOnCart" RENAME TO "ProductsOnCart";
PRAGMA foreign_key_check("ProductsOnCart");
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "Cart_userEmail_key" ON "Cart"("userEmail");
