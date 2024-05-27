/*
  Warnings:

  - The primary key for the `ProductsOnCart` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_ProductsOnCart" (
    "productId" TEXT NOT NULL,
    "prod_amount" INTEGER,
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