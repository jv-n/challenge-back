/*
  Warnings:

  - A unique constraint covering the columns `[cartId]` on the table `ProductsOnCart` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "ProductsOnCart_cartId_key" ON "ProductsOnCart"("cartId");
