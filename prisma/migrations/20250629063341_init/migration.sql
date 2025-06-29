-- CreateTable
CREATE TABLE `Customers` (
    `C_ID` VARCHAR(10) NOT NULL,
    `Cname` VARCHAR(30) NOT NULL,
    `Surname` VARCHAR(30) NOT NULL,
    `Tel` VARCHAR(11) NOT NULL,
    `Address` VARCHAR(50) NOT NULL,

    PRIMARY KEY (`C_ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Booking` (
    `Booking_ID` VARCHAR(10) NOT NULL,
    `Booking_date` DATETIME(3) NOT NULL,
    `BookingStatus` VARCHAR(10) NOT NULL,
    `C_ID` VARCHAR(10) NOT NULL,

    PRIMARY KEY (`Booking_ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Orders` (
    `Order_ID` VARCHAR(10) NOT NULL,
    `Orderdate` DATETIME(3) NOT NULL,
    `Emp_ID` VARCHAR(10) NOT NULL,
    `C_ID` VARCHAR(10) NOT NULL,
    `OrderStatus` VARCHAR(20) NOT NULL,

    PRIMARY KEY (`Order_ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Orders_detail` (
    `Ordt_ID` VARCHAR(10) NOT NULL,
    `Ordtprice` DECIMAL(65, 30) NOT NULL,
    `OrdtQty` INTEGER NOT NULL,
    `P_ID` VARCHAR(10) NOT NULL,
    `Order_ID` VARCHAR(10) NOT NULL,

    PRIMARY KEY (`Ordt_ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Products` (
    `P_ID` VARCHAR(10) NOT NULL,
    `PName` VARCHAR(30) NOT NULL,
    `PSalePrice` DECIMAL(65, 30) NOT NULL,
    `Pt_ID` VARCHAR(10) NOT NULL,
    `PInitialPrice` DECIMAL(65, 30) NOT NULL,
    `PStockQuantity` INTEGER NOT NULL,

    PRIMARY KEY (`P_ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ProductTypes` (
    `PT_ID` VARCHAR(10) NOT NULL,
    `PTName` VARCHAR(30) NOT NULL,

    PRIMARY KEY (`PT_ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Booking_detail` (
    `Bdt_ID` VARCHAR(10) NOT NULL,
    `BdtQty` INTEGER NOT NULL,
    `Booking_ID` VARCHAR(10) NOT NULL,
    `Pt_ID` VARCHAR(10) NOT NULL,
    `S_ID` VARCHAR(10) NOT NULL,

    PRIMARY KEY (`Bdt_ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Purchases` (
    `Pur_ID` VARCHAR(10) NOT NULL,
    `PurStatus` VARCHAR(20) NOT NULL,
    `PurDate` DATETIME(3) NOT NULL,
    `Sup_ID` VARCHAR(10) NOT NULL,
    `Emp_ID` VARCHAR(10) NOT NULL,

    PRIMARY KEY (`Pur_ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Suppliers` (
    `Sup_ID` VARCHAR(10) NOT NULL,
    `SupName` VARCHAR(30) NOT NULL,
    `Tel` VARCHAR(11) NOT NULL,
    `Address` VARCHAR(50) NOT NULL,
    `Email` VARCHAR(30) NOT NULL,

    PRIMARY KEY (`Sup_ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PurchasesDetail` (
    `PurDt_ID` VARCHAR(10) NOT NULL,
    `PurDtQuantity` INTEGER NOT NULL,
    `PurDtPrice` DECIMAL(65, 30) NOT NULL,
    `PurDtStatus` VARCHAR(10) NOT NULL,
    `Pur_ID` VARCHAR(10) NOT NULL,
    `P_ID` VARCHAR(10) NOT NULL,

    PRIMARY KEY (`PurDt_ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Services` (
    `S_ID` VARCHAR(10) NOT NULL,
    `SName` VARCHAR(30) NOT NULL,
    `SDescription` VARCHAR(191) NULL,
    `SPrice` DECIMAL(65, 30) NOT NULL,
    `SDuration` DATETIME(3) NOT NULL,

    PRIMARY KEY (`S_ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Employees` (
    `Emp_ID` VARCHAR(10) NOT NULL,
    `DOB` DATETIME(3) NOT NULL,
    `EmpName` VARCHAR(50) NOT NULL,
    `EmpSurname` VARCHAR(50) NOT NULL,
    `Address` VARCHAR(100) NOT NULL,
    `EmpRole` VARCHAR(20) NOT NULL,
    `EmpPass` VARCHAR(50) NOT NULL,
    `Gender` CHAR(1) NOT NULL,
    `Tel` VARCHAR(11) NOT NULL,

    PRIMARY KEY (`Emp_ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Booking` ADD CONSTRAINT `Booking_C_ID_fkey` FOREIGN KEY (`C_ID`) REFERENCES `Customers`(`C_ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Orders` ADD CONSTRAINT `Orders_Emp_ID_fkey` FOREIGN KEY (`Emp_ID`) REFERENCES `Employees`(`Emp_ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Orders` ADD CONSTRAINT `Orders_C_ID_fkey` FOREIGN KEY (`C_ID`) REFERENCES `Customers`(`C_ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Orders_detail` ADD CONSTRAINT `Orders_detail_P_ID_fkey` FOREIGN KEY (`P_ID`) REFERENCES `Products`(`P_ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Orders_detail` ADD CONSTRAINT `Orders_detail_Order_ID_fkey` FOREIGN KEY (`Order_ID`) REFERENCES `Orders`(`Order_ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Products` ADD CONSTRAINT `Products_Pt_ID_fkey` FOREIGN KEY (`Pt_ID`) REFERENCES `ProductTypes`(`PT_ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Booking_detail` ADD CONSTRAINT `Booking_detail_Booking_ID_fkey` FOREIGN KEY (`Booking_ID`) REFERENCES `Booking`(`Booking_ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Booking_detail` ADD CONSTRAINT `Booking_detail_Pt_ID_fkey` FOREIGN KEY (`Pt_ID`) REFERENCES `ProductTypes`(`PT_ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Booking_detail` ADD CONSTRAINT `Booking_detail_S_ID_fkey` FOREIGN KEY (`S_ID`) REFERENCES `Services`(`S_ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Purchases` ADD CONSTRAINT `Purchases_Sup_ID_fkey` FOREIGN KEY (`Sup_ID`) REFERENCES `Suppliers`(`Sup_ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Purchases` ADD CONSTRAINT `Purchases_Emp_ID_fkey` FOREIGN KEY (`Emp_ID`) REFERENCES `Employees`(`Emp_ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PurchasesDetail` ADD CONSTRAINT `PurchasesDetail_Pur_ID_fkey` FOREIGN KEY (`Pur_ID`) REFERENCES `Purchases`(`Pur_ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PurchasesDetail` ADD CONSTRAINT `PurchasesDetail_P_ID_fkey` FOREIGN KEY (`P_ID`) REFERENCES `Products`(`P_ID`) ON DELETE RESTRICT ON UPDATE CASCADE;
