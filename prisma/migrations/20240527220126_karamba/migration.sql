-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Order" (
    "order_placed" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "order_total" REAL NOT NULL,
    "orderUser" TEXT NOT NULL,
    CONSTRAINT "Order_orderUser_fkey" FOREIGN KEY ("orderUser") REFERENCES "Cart" ("userEmail") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Order" ("orderUser", "order_placed", "order_total") SELECT "orderUser", "order_placed", "order_total" FROM "Order";
DROP TABLE "Order";
ALTER TABLE "new_Order" RENAME TO "Order";
CREATE UNIQUE INDEX "Order_orderUser_key" ON "Order"("orderUser");
PRAGMA foreign_key_check("Order");
PRAGMA foreign_keys=ON;
