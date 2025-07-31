
CREATE TABLE `usuario` (
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
    KEY `usertipo` (`usertipo`, `useremail`, `usercod`, `userest`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `roles` (
    `rolescod` varchar(128) NOT NULL,
    `rolesdsc` varchar(45) DEFAULT NULL,
    `rolesest` char(3) DEFAULT NULL,
    PRIMARY KEY (`rolescod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `roles_usuarios` (
    `usercod` bigint(10) NOT NULL,
    `rolescod` varchar(128) NOT NULL,
    `roleuserest` char(3) DEFAULT NULL,
    `roleuserfch` datetime DEFAULT NULL,
    `roleuserexp` datetime DEFAULT NULL,
    PRIMARY KEY (`usercod`, `rolescod`),
    KEY `rol_usuario_key_idx` (`rolescod`),
    CONSTRAINT `rol_usuario_key` FOREIGN KEY (`rolescod`) REFERENCES `roles` (`rolescod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `usuario_rol_key` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `funciones` (
    `fncod` varchar(255) NOT NULL,
    `fndsc` varchar(255) DEFAULT NULL,
    `fnest` char(3) DEFAULT NULL,
    `fntyp` char(3) DEFAULT NULL,
    PRIMARY KEY (`fncod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `funciones_roles` (
    `rolescod` varchar(128) NOT NULL,
    `fncod` varchar(255) NOT NULL,
    `fnrolest` char(3) DEFAULT NULL,
    `fnexp` datetime DEFAULT NULL,
    PRIMARY KEY (`rolescod`, `fncod`),
    KEY `rol_funcion_key_idx` (`fncod`),
    CONSTRAINT `funcion_rol_key` FOREIGN KEY (`rolescod`) REFERENCES `roles` (`rolescod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `rol_funcion_key` FOREIGN KEY (`fncod`) REFERENCES `funciones` (`fncod`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `bitacora` (
    `bitacoracod` int(11) NOT NULL AUTO_INCREMENT,
    `bitacorafch` datetime DEFAULT NULL,
    `bitprograma` varchar(255) DEFAULT NULL,
    `bitdescripcion` varchar(255) DEFAULT NULL,
    `bitobservacion` mediumtext,
    `bitTipo` char(3) DEFAULT NULL,
    `bitusuario` bigint(18) DEFAULT NULL,
    PRIMARY KEY (`bitacoracod`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE `categorias` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `nombre` VARCHAR(255) NOT NULL,
    `estado` CHAR(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `products` (
    `productId` INT(11) NOT NULL AUTO_INCREMENT,
    `productName` VARCHAR(255) NOT NULL,
    `productDescription` TEXT NOT NULL,
    `productPrice` DECIMAL(10,2) NOT NULL,
    `productImgUrl` VARCHAR(255) NOT NULL,
    `productStock` INT(11) NOT NULL DEFAULT 0,
    `productStatus` CHAR(3) NOT NULL,
    `categoriaId` INT NOT NULL,
    `productIngredients` TEXT,
    `productFeatures` TEXT,
    `productPresentation` VARCHAR(255),
    `productAllergens` VARCHAR(255),
    `productRecommendation` TEXT,
    `productStorage` VARCHAR(255),
    `productCustom` VARCHAR(5),
    PRIMARY KEY (`productId`),
    FOREIGN KEY (`categoriaId`) REFERENCES `categorias`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `carretilla` (
    `usercod` BIGINT(10) NOT NULL,
    `productId` int(11) NOT NULL,
    `crrctd` INT(5) NOT NULL,
    `crrprc` DECIMAL(12,2) NOT NULL,
    `crrfching` DATETIME NOT NULL,
    PRIMARY KEY (`usercod`, `productId`),
    INDEX `productId_idx` (`productId` ASC),
    CONSTRAINT `carretilla_user_key` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `carretilla_prd_key` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `carretillaanon` (
    `anoncod` varchar(128) NOT NULL,
    `productId` int(18) NOT NULL,
    `crrctd` int(5) NOT NULL,
    `crrprc` decimal(12,2) NOT NULL,
    `crrfching` datetime NOT NULL,
    PRIMARY KEY (`anoncod`, `productId`),
    INDEX `productId_idx` (`productId` ASC),
    CONSTRAINT `carretillaanon_prd_key` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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

--Roles
INSERT INTO roles (rolescod, rolesdsc, rolesest) VALUES ('ADMIN', 'Administrador', 'ACT');
INSERT INTO roles (rolescod, rolesdsc, rolesest) VALUES ('AUDIT', 'Auditor', 'ACT');
INSERT INTO roles (rolescod, rolesdsc, rolesest) VALUES ('OPADQ', 'Operador de Adquisiciones', 'ACT');

--Usuario
INSERT INTO `usuario` (
    `useremail`, `username`, `userpswd`, `userfching`,
    `userpswdest`, `userpswdexp`, `userest`,
    `useractcod`, `userpswdchg`, `usertipo`
) VALUES
('timdrake@gmail.com', 'Robin', SHA2('Soybatman123', 256), NOW(),
 'ACT', DATE_ADD(NOW(), INTERVAL 90 DAY), 'ACT',
 NULL, NULL, 'NOR'),
('brucewayne@gmail.com', 'Batman', SHA2('Soybatman123', 256), NOW(),
 'ACT', DATE_ADD(NOW(), INTERVAL 90 DAY), 'ACT',
 NULL, NULL, 'ADM'),
('dickgrayson@gmail.com', 'Nightwing', SHA2('Soybatman123', 256), NOW(),
 'ACT', DATE_ADD(NOW(), INTERVAL 90 DAY), 'ACT',
 NULL, NULL, 'NOR');

 --roles_usuarios
INSERT INTO roles_usuarios (usercod, rolescod, roleuserest, roleuserfch, roleuserexp) VALUES (1, 'ADMIN', 'ACT', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO roles_usuarios (usercod, rolescod, roleuserest, roleuserfch, roleuserexp) VALUES (2, 'AUDIT', 'ACT', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO roles_usuarios (usercod, rolescod, roleuserest, roleuserfch, roleuserexp) VALUES (3, 'OPADQ', 'ACT', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR));

--Funciones
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Products\\Product', 'Formulario de Productos', 'ACT', 'CTR');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Products\\Products', 'Lista de Productos', 'ACT', 'CTR');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Menu_Products', 'Menu_Products', 'ACT', 'MNU');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('categorias_DSP', 'Detalle de Categorías', 'ACT', 'FNC');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('categorias_UPD', 'Editar Categorías', 'ACT', 'FNC');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('categorias_DEL', 'Eliminar Categorías', 'ACT', 'FNC');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('categorias_INS', 'Agregar Categorías', 'ACT', 'FNC');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Mantenimientos\\Productos\\Categoria', 'Formulario de Categorías', 'ACT', 'CTR');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Mantenimientos\\Productos\\Categorias', 'Lista de Categorías', 'ACT', 'CTR');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Menu_Categorias', 'Menu_Categorias', 'ACT', 'MNU');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Destacados', 'Página de Productos Destacados', 'ACT', 'CTR');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Menu_Destacados', 'Menu_Destacados', 'ACT', 'MNU');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('role_DSP', 'Detalle de Roles', 'ACT', 'FNC');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('role_UPD', 'Editar Roles', 'ACT', 'FNC');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('role_DEL', 'Eliminar Roles', 'ACT', 'FNC');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('role_INS', 'Agregar Roles', 'ACT', 'FNC');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Roles\\Rol', 'Formulario de Roles', 'ACT', 'CTR');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Roles\\Roles', 'Lista de Roles', 'ACT', 'CTR');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Menu_Roles', 'Menu Roles', 'ACT', 'MNU');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Seguridad\\Usuario', 'Formulario de Usuarios', 'ACT', 'CTR');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Seguridad\\Usuarios', 'Lista de Usuarios', 'ACT', 'CTR');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Menu_Usuarios', 'Menu_Usuarios', 'ACT', 'MNU');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Usuario_DSP', 'Ver Detalle Usuario', 'ACT', 'PFL');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Usuario_INS', 'Crear Usuario', 'ACT', 'PFL');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Usuario_UPD', 'Editar Usuario', 'ACT', 'PFL');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Usuario_DEL', 'Eliminar Usuario', 'ACT', 'PFL');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Products_DSP', 'Ver Detalle Producto', 'ACT', 'PFL');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Products_INS', 'Crear Producto', 'ACT', 'PFL');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Products_UPD', 'Editar Producto', 'ACT', 'PFL');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Products_DEL', 'Eliminar Producto', 'ACT', 'PFL');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Historial\\Historial', 'Historial de Actividades', 'ACT', 'CTR');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Menu_Historial', 'Menu_Historial', 'ACT', 'MNU');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Sec\\Valores', 'Gestión de Valores del Sistema', 'ACT', 'CTR');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Menu_Valores', 'Menu_Valores', 'ACT', 'MNU');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Mantenimiento\\Funciones', 'Mantenimiento de Funciones', 'ACT', 'CTR');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Mantenimiento\\Funcion', 'Mantenimiento de Funcion', 'ACT', 'CTR');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Menu_Funciones', 'Menu_Funciones', 'ACT', 'MNU');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Funciones_DSP', 'Ver Detalle Función', 'ACT', 'PFL');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Funciones_INS', 'Crear Función', 'ACT', 'PFL');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Funciones_UPD', 'Editar Función', 'ACT', 'PFL');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Funciones_DEL', 'Eliminar Función', 'ACT', 'PFL');

--funciones_roles
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Products\\Product', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Controllers\\Products\\Product', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Controllers\\Products\\Product', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Products\\Products', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Controllers\\Products\\Products', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Controllers\\Products\\Products', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Menu_Products', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Menu_Products', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Menu_Products', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'categorias_DSP', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'categorias_UPD', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'categorias_DEL', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'categorias_INS', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'categorias_DSP', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'categorias_DSP', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'categorias_UPD', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Mantenimientos\\Productos\\Categoria', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Controllers\\Mantenimientos\\Productos\\Categoria', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Controllers\\Mantenimientos\\Productos\\Categoria', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Mantenimientos\\Productos\\Categorias', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Controllers\\Mantenimientos\\Productos\\Categorias', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Controllers\\Mantenimientos\\Productos\\Categorias', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Menu_Categorias', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Menu_Categorias', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Menu_Categorias', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Destacados', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Controllers\\Destacados', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Controllers\\Destacados', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Menu_Destacados', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Menu_Destacados', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Menu_Destacados', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'role_DSP', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'role_UPD', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'role_DEL', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'role_INS', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'role_DSP', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'role_DSP', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'role_UPD', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Roles\\Rol', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Controllers\\Roles\\Rol', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Controllers\\Roles\\Rol', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Roles\\Roles', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Controllers\\Roles\\Roles', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Controllers\\Roles\\Roles', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Menu_Roles', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Menu_Roles', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Menu_Roles', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Seguridad\\Usuario', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Controllers\\Seguridad\\Usuario', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Seguridad\\Usuarios', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Controllers\\Seguridad\\Usuarios', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Menu_Usuarios', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Menu_Usuarios', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Usuario_DSP', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Usuario_INS', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Usuario_UPD', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Usuario_DEL', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Products_DSP', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Products_INS', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Products_UPD', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Products_DEL', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Historial\\Historial', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Controllers\\Historial\\Historial', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Menu_Historial', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Menu_Historial', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Sec\\Valores', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Controllers\\Sec\\Valores', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Menu_Valores', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Menu_Valores', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Mantenimiento\\Funciones', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Mantenimiento\\Funcion', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Menu_Funciones', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Funciones_DSP', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Funciones_INS', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Funciones_UPD', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Funciones_DEL', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

--Categorias
INSERT INTO categorias (nombre, estado) VALUES
('Pastel', 'ACT'),
('Cheesecake', 'ACT'),
('Cupcake', 'ACT');

-- Productos
(1, 'Pastel de Chocolate', 'Delicioso pastel de chocolate con cobertura de ganache', 25.00, '/public/imgs/url/chocolatecheesecake.jpg', 15, 'ACT', 1,
 'Harina, cacao, azúcar, huevos, mantequilla, ganache de chocolate',
 'Pastel húmedo con cobertura de ganache, ideal para cumpleaños.',
 '8 porciones (23 cm de diámetro)',
 'Gluten, huevo, lácteos',
 'Ideal para cumpleaños y celebraciones con café.',
 'Mantener en refrigeración hasta 5 días.',
 'Sí'),

(2, 'Pastel Red Velvet', 'Pastel red velvet con crema de queso', 28.00, '/public/imgs/url/cakered.jpg', 12, 'ACT', 1,
 'Harina, cacao, azúcar, crema de queso, colorante rojo',
 'Textura suave, con crema de queso y un toque elegante.',
 '8 porciones (23 cm) – también disponible mini',
 'Gluten, lácteos, colorantes',
 'Perfecto para eventos románticos o aniversarios.',
 'Refrigerar y consumir en 4 días.',
 'Sí'),

(3, 'Pastel de Zanahoria', 'Pastel de zanahoria con glaseado de queso crema', 24.00, '/public/imgs/url/zanahoriapastel.jpg', 10, 'ACT', 1,
 'Harina, zanahoria rallada, azúcar, huevos, glaseado de queso crema',
 'Sabor casero, glaseado dulce, buena opción para la merienda.',
 '6 porciones (20 cm) – versión sin nueces',
 'Gluten, huevo, lácteos',
 'Acompañar con té o leche caliente.',
 'A temperatura ambiente, hasta 3 días.',
 'No'),

-- Cheesecakes
(4, 'Cheesecake Clásico', 'Cheesecake cremoso con base de galleta', 30.00, '/public/imgs/url/cheescakenormal.jpg', 10, 'ACT', 2,
 'Queso crema, galletas molidas, mantequilla, azúcar',
 'Cremoso y clásico, una delicia fría.',
 'Molde redondo 18 cm – porciones individuales',
 'Lácteos, gluten',
 'Postre frío para después de almuerzos.',
 'Refrigerado hasta 7 días.',
 'Sí'),

(5, 'Cheesecake de Fresa', 'Cheesecake con topping de fresas frescas', 32.00, '/public/imgs/url/cheesecakefres.jpg', 8, 'ACT', 2,
 'Queso crema, fresas frescas, galletas, azúcar',
 'Con topping de fresas frescas, sabor equilibrado.',
 'Molde cuadrado – 9 porciones medianas',
 'Lácteos, gluten',
 'Excelente para reuniones familiares.',
 'Refrigerar – 5 días máximo.',
 'Sí'),

(6, 'Cheesecake de Chocolate Blanco', 'Cheesecake con chocolate blanco y base de galleta', 33.00, '/public/imgs/url/cheesecakechoco.jpg', 6, 'ACT', 2,
 'Queso crema, chocolate blanco, galletas, azúcar',
 'Para amantes del chocolate blanco, textura cremosa.',
 '10 porciones pequeñas',
 'Lácteos, gluten',
 'Delicioso con vino blanco dulce.',
 'Refrigeración obligatoria – consumir en 4 días.',
 'No'),


(7, 'Cupcake Vainilla', 'Cupcake esponjoso de vainilla con glaseado de mantequilla', 5.00, '/public/imgs/url/vanillacupcake.jpg', 50, 'ACT', 3,
 'Harina, vainilla, azúcar, huevos, mantequilla',
 'Dulce ligero, ideal para eventos infantiles.',
 'Individual – caja de 6 o 12',
 'Huevo, gluten, lácteos',
 'Perfecto para fiestas infantiles.',
 'Temperatura ambiente – 2 días.',
 'Sí'),

(8, 'Cupcake de Chocolate', 'Cupcake de chocolate con glaseado de crema de chocolate', 6.00, '/public/imgs/url/cupcakeschoco.webp', 45, 'ACT', 3,
 'Harina, cacao, azúcar, crema de chocolate, huevos',
 'Intenso sabor a chocolate con cobertura suave.',
 'Individual – presentación en caja de 6',
 'Gluten, huevo',
 'Para amantes del chocolate, con café expreso.',
 'Refrigerar – 3 días máximo.',
 'Sí'),

(9, 'Cupcake Red Velvet', 'Cupcake red velvet con crema de queso', 6.50, '/public/imgs/url/cupcakered.jpg', 40, 'ACT', 3,
 'Harina, cacao, azúcar, crema de queso, colorante rojo',
 'Mini versión del pastel Red Velvet con toque elegante.',
 'Individual – presentación gourmet',
 'Gluten, colorantes, lácteos',
 'Excelente para brunch o bodas.',
 'Refrigerado – ideal consumir antes de 3 días.',
 'Sí'),

(10, 'Cheesecake de Zanahoria', 'Variante única de cheesecake con zanahoria', 29.00, '/public/imgs/url/cheesecakezanahoria.webp', 7, 'ACT', 2,
 'Queso crema, zanahoria rallada, galletas, especias',
 'Combinación innovadora con toque especiado.',
 '8 porciones medianas',
 'Lácteos, gluten',
 'Para quienes buscan algo diferente.',
 'Refrigerar 4 días máximo.',
 'No'),

(11, 'Colección de Cupcakes', 'Variedad de cupcakes para eventos', 35.00, '/public/imgs/url/colec.jpg', 15, 'ACT', 3,
 'Mezcla de sabores: chocolate, vainilla, red velvet',
 'Selección gourmet para eventos especiales.',
 'Caja de 12 unidades variadas',
 'Gluten, lácteos, huevo',
 'Ideal para regalos corporativos.',
 'Refrigerar 3 días.',
 'Sí'),

(12, 'Cupcake Chocolate-Fresa', 'Cupcake de chocolate con relleno de fresa', 6.50, '/public/imgs/url/cupcakechocofresa.jpg', 30, 'ACT', 3,
 'Chocolate, fresas naturales, harina, huevos',
 'Combinación clásica de chocolate y fresa.',
 'Individual - caja de 6 o 12',
 'Gluten, huevo',
 'Perfecto para aniversarios.',
 'Refrigerar 2 días.',
 'Sí'),

(13, 'Pastel de Fresas', 'Pastel ligero con fresas frescas', 26.00, '/public/imgs/url/fresa.jpg', 9, 'ACT', 1,
 'Harina, fresas, azúcar, crema batida, huevos',
 'Frescura y ligereza para días calurosos.',
 '6 porciones (20 cm)',
 'Gluten, lácteos, huevo',
 'Ideal para primavera y verano.',
 'Refrigerar 3 días.',
 'No'),

(14, 'Cupcake Genérico', 'Cupcake básico para decoración personalizada', 4.50, '/public/imgs/url/cupcakegenerico.jpg', 60, 'ACT', 3,
 'Harina, azúcar, huevos, leche, mantequilla',
 'Base neutra para decorar a gusto del cliente.',
 'Individual - mínimo pedido 6 unidades',
 'Gluten, lácteos, huevo',
 'Para eventos temáticos o personalizados.',
 '2 días a temperatura ambiente.',
 'Sí'),

(15, 'Pastel Clásico', 'Pastel tradicional para toda ocasión', 22.00, '/public/imgs/url/images.jpg', 11, 'ACT', 1,
 'Harina, huevos, azúcar, mantequilla, leche',
 'Versátil y delicioso para cualquier celebración.',
 '8 porciones (22 cm)',
 'Gluten, lácteos, huevo',
 'Acompañar con café o té.',
 '3 días a temperatura ambiente.',
 'Sí');

INSERT INTO `sales` (`saleId`, `productId`, `salePrice`, `saleStart`, `saleEnd`) VALUES
(1, 3, 500, '2023-08-01 00:00:00', '2023-10-31 23:59:59'),
(2, 5, 750, '2023-08-01 00:00:00', '2023-10-31 23:59:59'),
(3, 7, 1500, '2023-08-01 00:00:00', '2023-10-31 23:59:59');

INSERT INTO `highlights` (`highlightId`, `productId`, `highlightStart`, `highlightEnd`) VALUES
(1, 1, '2023-08-01 00:00:00', '2023-10-31 23:59:59'),
(2, 4, '2023-08-01 00:00:00', '2023-10-31 23:59:59');
