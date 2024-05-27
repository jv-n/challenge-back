/*
  Warnings:

  - You are about to drop the column `userId` on the `Order` table. All the data in the column will be lost.
  - Added the required column `orderUser` to the `Order` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `Cart` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Order" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "order_placed" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "order_total" REAL NOT NULL,
    "orderUser" TEXT NOT NULL,
    CONSTRAINT "Order_orderUser_fkey" FOREIGN KEY ("orderUser") REFERENCES "Cart" ("userEmail") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Order" ("id", "order_placed", "order_total") SELECT "id", "order_placed", "order_total" FROM "Order";
DROP TABLE "Order";
ALTER TABLE "new_Order" RENAME TO "Order";
CREATE UNIQUE INDEX "Order_orderUser_key" ON "Order"("orderUser");
CREATE TABLE "new_ProductsOnCart" (
    "productId" TEXT NOT NULL,
    "price_unic" REAL NOT NULL DEFAULT 0,
    "prod_amount" INTEGER NOT NULL DEFAULT 0,
    "price_total" REAL NOT NULL DEFAULT 0,
    "cartId" TEXT NOT NULL,
    "assignedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("cartId", "productId"),
    CONSTRAINT "ProductsOnCart_productId_fkey" FOREIGN KEY ("productId") REFERENCES "products" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "ProductsOnCart_cartId_fkey" FOREIGN KEY ("cartId") REFERENCES "Cart" ("userEmail") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_ProductsOnCart" ("assignedAt", "cartId", "price_total", "price_unic", "prod_amount", "productId") SELECT "assignedAt", "cartId", "price_total", "price_unic", "prod_amount", "productId" FROM "ProductsOnCart";
DROP TABLE "ProductsOnCart";
ALTER TABLE "new_ProductsOnCart" RENAME TO "ProductsOnCart";
CREATE TABLE "new_Cart" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userEmail" TEXT NOT NULL,
    CONSTRAINT "Cart_userEmail_fkey" FOREIGN KEY ("userEmail") REFERENCES "users" ("email") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Cart" ("userEmail") SELECT "userEmail" FROM "Cart";
DROP TABLE "Cart";
ALTER TABLE "new_Cart" RENAME TO "Cart";
CREATE UNIQUE INDEX "Cart_userEmail_key" ON "Cart"("userEmail");
PRAGMA foreign_key_check("Order");
PRAGMA foreign_key_check("ProductsOnCart");
PRAGMA foreign_key_check("Cart");
PRAGMA foreign_keys=ON;
