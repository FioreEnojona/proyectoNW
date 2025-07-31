CREATE TABLE `sales` (
    `saleId` int(11) NOT NULL AUTO_INCREMENT,
    `productId` int(11) NOT NULL,
    `salePrice` decimal(10,2) NOT NULL,
    `saleStart` datetime NOT NULL,
    `saleEnd` datetime NOT NULL,
    PRIMARY KEY (`saleId`),
    KEY `fk_sales_products_idx` (`productId`),
    CONSTRAINT `fk_sales_products` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE
  ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

  CREATE TABLE `highlights` (
    `highlightId` int(11) NOT NULL AUTO_INCREMENT,
    `productId` int(11) NOT NULL,
    `highlightStart` datetime NOT NULL,
    `highlightEnd` datetime NOT NULL,
    PRIMARY KEY (`highlightId`),
    KEY `fk_highlights_products_idx` (`productId`),
    CONSTRAINT `fk_highlights_products` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE
  ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

INSERT INTO `sales` (`productId`, `salePrice`, `saleStart`, `saleEnd`) VALUES
(1, 15.99, DATE_SUB(CURDATE(), INTERVAL 2 DAY), DATE_ADD(CURDATE(), INTERVAL 5 DAY)),
(2, 22.50, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY)),
(3, 35.75, DATE_SUB(CURDATE(), INTERVAL 1 DAY), DATE_ADD(CURDATE(), INTERVAL 3 DAY)),
(4, 42.99, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 10 DAY)),
(5, 18.25, DATE_SUB(CURDATE(), INTERVAL 3 DAY), DATE_ADD(CURDATE(), INTERVAL 2 DAY));

-- Ofertas que comenzarán pronto
INSERT INTO `sales` (`productId`, `salePrice`, `saleStart`, `saleEnd`) VALUES
(6, 29.99, DATE_ADD(CURDATE(), INTERVAL 2 DAY), DATE_ADD(CURDATE(), INTERVAL 9 DAY)),
(7, 55.00, DATE_ADD(CURDATE(), INTERVAL 1 DAY), DATE_ADD(CURDATE(), INTERVAL 7 DAY));

-- Ofertas recién terminadas (para pruebas)
INSERT INTO `sales` (`productId`, `salePrice`, `saleStart`, `saleEnd`) VALUES
(8, 19.99, DATE_SUB(CURDATE(), INTERVAL 5 DAY), DATE_SUB(CURDATE(), INTERVAL 1 DAY));
-- Destacados que comenzarán pronto
INSERT INTO `highlights` (`productId`, `highlightStart`, `highlightEnd`) VALUES
(2, DATE_ADD(CURDATE(), INTERVAL 1 DAY), DATE_ADD(CURDATE(), INTERVAL 8 DAY)),
(4, DATE_ADD(CURDATE(), INTERVAL 2 DAY), DATE_ADD(CURDATE(), INTERVAL 7 DAY));

-- Destacados recién terminados (para pruebas)
INSERT INTO `highlights` (`productId`, `highlightStart`, `highlightEnd`) VALUES
(6, DATE_SUB(CURDATE(), INTERVAL 4 DAY), DATE_SUB(CURDATE(), INTERVAL 1 DAY));