CREATE TABLE categorias (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    estado CHAR(3) NOT NULL
);

CREATE TABLE products (
    productId INT(11) NOT NULL AUTO_INCREMENT,
    productName VARCHAR(255) NOT NULL,
    productDescription TEXT NOT NULL,
    productPrice DECIMAL(10, 2) NOT NULL,
    productImgUrl VARCHAR(255) NOT NULL,
    productStock INT(11) NOT NULL DEFAULT 0,
    productStatus CHAR(3) NOT NULL,
    categoriaId INT NOT NULL,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoriaId) REFERENCES categorias(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;


CREATE TABLE
    `carretilla` (
        `usercod` BIGINT(10) NOT NULL,
        `productId` int(11) NOT NULL,
        `crrctd` INT(5) NOT NULL,
        `crrprc` DECIMAL(12, 2) NOT NULL,
        `crrfching` DATETIME NOT NULL,
        PRIMARY KEY (`usercod`, `productId`),
        INDEX `productId_idx` (`productId` ASC),
        CONSTRAINT `carretilla_user_key` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT `carretilla_prd_key` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION
    );

CREATE TABLE
    `carretillaanon` (
        `anoncod` varchar(128) NOT NULL,
        `productId` int(18) NOT NULL,
        `crrctd` int(5) NOT NULL,
        `crrprc` decimal(12, 2) NOT NULL,
        `crrfching` datetime NOT NULL,
        PRIMARY KEY (`anoncod`, `productId`),
        INDEX `productId_idx` (`productId` ASC),
        CONSTRAINT `carretillaanon_prd_key` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION
    );