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
    -------------------
    

CREATE TABLE
    `roles` (
        `rolescod` varchar(128) NOT NULL,
        `rolesdsc` varchar(45) DEFAULT NULL,
        `rolesest` char(3) DEFAULT NULL,
        PRIMARY KEY (`rolescod`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;
    --------
INSERT INTO roles (rolescod, rolesdsc, rolesest) VALUES ('ADMIN', 'Administrador', 'ACT');
INSERT INTO roles (rolescod, rolesdsc, rolesest) VALUES ('AUDIT', 'Auditor', 'ACT');
INSERT INTO roles (rolescod, rolesdsc, rolesest) VALUES ('OPADQ', 'Operador de Adquisiciones', 'ACT');

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
    -----------
-- Asignación de menú Roles para ADMIN, AUDIT y OPADQ
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Menu_Roles', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Menu_Roles', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Menu_Roles', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

CREATE TABLE
    `funciones` (
        `fncod` varchar(255) NOT NULL,
        `fndsc` varchar(255) DEFAULT NULL,
        `fnest` char(3) DEFAULT NULL,
        `fntyp` char(3) DEFAULT NULL,
        PRIMARY KEY (`fncod`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;
    ----------------------
    -- Inserta las funciones (acciones) relacionadas con la gestión de Roles
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('role_DSP', 'Detalle de Roles', 'ACT', 'FNC'); -- Ver detalle de rol
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('role_UPD', 'Editar Roles', 'ACT', 'FNC');        -- Editar rol
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('role_DEL', 'Eliminar Roles', 'ACT', 'FNC');      -- Eliminar rol
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('role_INS', 'Agregar Roles', 'ACT', 'FNC');       -- Agregar nuevo rol

-- Inserta las funciones tipo controlador y menú para la gestión de Roles
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Roles\\Rol', 'Formulario de Roles', 'ACT', 'CTR');  -- Controlador formulario rol
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Roles\\Roles', 'Lista de Roles', 'ACT', 'CTR');      -- Controlador lista de roles
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Menu_Roles', 'Menu Roles', 'ACT', 'MNU');                         -- Menú Roles
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
    -----------------
    -- Asignación de permisos de funciones para el rol ADMIN (acceso completo a todas las funciones)
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'role_DSP', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR)); 
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'role_UPD', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'role_DEL', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'role_INS', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

-- Permisos limitados para el rol AUDIT (solo ver detalle)
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'role_DSP', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

-- Permisos para OPADQ (ver y editar roles)
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'role_DSP', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'role_UPD', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

-- Asignación de controladores para los roles ADMIN, AUDIT y OPADQ
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Roles\\Rol', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Controllers\\Roles\\Rol', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Controllers\\Roles\\Rol', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Roles\\Roles', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Controllers\\Roles\\Roles', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Controllers\\Roles\\Roles', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

