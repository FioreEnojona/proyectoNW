-- Active: 1750217631131@@127.0.0.1@3306@nwbd1
-- Active: 1750217631131@@127.0.0.1@3306@nwbd1

CREATE TABLE
    `usuario` (
        `usercod` bigint(10) NOT NULL AUTO_INCREMENT,
        `useremail` varchar(80) DEFAULT NULL,
        `username` varchar(80) DEFAULT NULL,
        `userpswd` varchar(128) DEFAULT NULL,
        `userfching` datetime DEFAULT NULL,
        `userpswdest` char(3) DEFAULT NULL,
        `userpswdexp` datetime DEFAULT NULL,
        `userest` char(3) DEFAULT NULL,
        `useractcod` varchar(128) DEFAULT NULL,
        `userpswdchg` varchar(128) DEFAULT NULL,
        `usertipo` char(3) DEFAULT NULL COMMENT 'Tipo de Usuario, Normal, Consultor o Cliente',
        PRIMARY KEY (`usercod`),
        UNIQUE KEY `useremail_UNIQUE` (`useremail`),
        KEY `usertipo` (
            `usertipo`,
            `useremail`,
            `usercod`,
            `userest`
        )
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE
    `roles` (
        `rolescod` varchar(128) NOT NULL,
        `rolesdsc` varchar(45) DEFAULT NULL,
        `rolesest` char(3) DEFAULT NULL,
        PRIMARY KEY (`rolescod`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE
    `roles_usuarios` (
        `usercod` bigint(10) NOT NULL,
        `rolescod` varchar(128) NOT NULL,
        `roleuserest` char(3) DEFAULT NULL,
        `roleuserfch` datetime DEFAULT NULL,
        `roleuserexp` datetime DEFAULT NULL,
        PRIMARY KEY (`usercod`, `rolescod`),
        KEY `rol_usuario_key_idx` (`rolescod`),
        CONSTRAINT `rol_usuario_key` FOREIGN KEY (`rolescod`) REFERENCES `roles` (`rolescod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT `usuario_rol_key` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`) ON DELETE NO ACTION ON UPDATE NO ACTION
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE
    `funciones` (
        `fncod` varchar(255) NOT NULL,
        `fndsc` varchar(255) DEFAULT NULL,
        `fnest` char(3) DEFAULT NULL,
        `fntyp` char(3) DEFAULT NULL,
        PRIMARY KEY (`fncod`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE
    `funciones_roles` (
        `rolescod` varchar(128) NOT NULL,
        `fncod` varchar(255) NOT NULL,
        `fnrolest` char(3) DEFAULT NULL,
        `fnexp` datetime DEFAULT NULL,
        PRIMARY KEY (`rolescod`, `fncod`),
        KEY `rol_funcion_key_idx` (`fncod`),
        CONSTRAINT `funcion_rol_key` FOREIGN KEY (`rolescod`) REFERENCES `roles` (`rolescod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT `rol_funcion_key` FOREIGN KEY (`fncod`) REFERENCES `funciones` (`fncod`) ON DELETE NO ACTION ON UPDATE NO ACTION
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE
    `bitacora` (
        `bitacoracod` int(11) NOT NULL AUTO_INCREMENT,
        `bitacorafch` datetime DEFAULT NULL,
        `bitprograma` varchar(255) DEFAULT NULL,
        `bitdescripcion` varchar(255) DEFAULT NULL,
        `bitobservacion` mediumtext,
        `bitTipo` char(3) DEFAULT NULL,
        `bitusuario` bigint(18) DEFAULT NULL,
        PRIMARY KEY (`bitacoracod`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 10 DEFAULT CHARSET = utf8;

    
--alteracionn de tabla josselin

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET=utf8mb4;

ALTER TABLE products
ADD COLUMN productIngredients TEXT,
ADD COLUMN productFeatures TEXT,
ADD COLUMN productPresentation VARCHAR(255),
ADD COLUMN productAllergens VARCHAR(255),
ADD COLUMN productRecommendation TEXT,
ADD COLUMN productStorage VARCHAR(255),
ADD COLUMN productCustom VARCHAR(5);
>>>>>>> jossdetalle
