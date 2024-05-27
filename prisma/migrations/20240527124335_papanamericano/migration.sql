/*
  Warnings:

  - You are about to drop the column `pric_total` on the `ProductsOnCart` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_ProductsOnCart" (
    "productId" TEXT NOT NULL,
    "price_unic" REAL,
    "prod_amount" INTEGER NOT NULL DEFAULT 0,
    "price_total" REAL,
    "cartId" TEXT NOT NULL,
    "assignedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "ProductsOnCart_productId_fkey" FOREIGN KEY ("productId") REFERENCES "products" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "ProductsOnCart_cartId_fkey" FOREIGN KEY ("cartId") REFERENCES "Cart" ("userEmail") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_ProductsOnCart" ("assignedAt", "cartId", "prod_amount", "productId") SELECT "assignedAt", "cartId", "prod_amount", "productId" FROM "ProductsOnCart";
DROP TABLE "ProductsOnCart";
ALTER TABLE "new_ProductsOnCart" RENAME TO "ProductsOnCart";
CREATE UNIQUE INDEX "ProductsOnCart_productId_cartId_key" ON "ProductsOnCart"("productId", "cartId");
PRAGMA foreign_key_check("ProductsOnCart");
PRAGMA foreign_keys=ON;
