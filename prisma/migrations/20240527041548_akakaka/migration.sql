/*
  Warnings:

  - Made the column `prod_amount` on table `ProductsOnCart` required. This step will fail if there are existing NULL values in that column.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_ProductsOnCart" (
    "productId" TEXT NOT NULL,
    "prod_amount" INTEGER NOT NULL,
    "cartId" TEXT NOT NULL,
    "assignedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("productId", "cartId"),
    CONSTRAINT "ProductsOnCart_productId_fkey" FOREIGN KEY ("productId") REFERENCES "products" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "ProductsOnCart_cartId_fkey" FOREIGN KEY ("cartId") REFERENCES "Cart" ("userEmail") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_ProductsOnCart" ("assignedAt", "cartId", "prod_amount", "productId") SELECT "assignedAt", "cartId", "prod_amount", "productId" FROM "ProductsOnCart";
DROP TABLE "ProductsOnCart";
ALTER TABLE "new_ProductsOnCart" RENAME TO "ProductsOnCart";
CREATE UNIQUE INDEX "ProductsOnCart_cartId_key" ON "ProductsOnCart"("cartId");
PRAGMA foreign_key_check("ProductsOnCart");
PRAGMA foreign_keys=ON;
