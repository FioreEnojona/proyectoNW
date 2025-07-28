CREATE SCHEMA `ecommerce` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

INSERT INTO `usuario` (
    `useremail`, `username`, `userpswd`, `userfching`,
    `userpswdest`, `userpswdexp`, `userest`,
    `useractcod`, `userpswdchg`, `usertipo`
) VALUES
('brucewayne@gmail.com', 'Batman', SHA2('Soybatman123', 256), NOW(),
 'ACT', DATE_ADD(NOW(), INTERVAL 90 DAY), 'ACT',
 NULL, NULL, 'ADM'),

('dickgrayson@gmail.com', 'Nightwing', SHA2('Soybatman123', 256), NOW(),
 'ACT', DATE_ADD(NOW(), INTERVAL 90 DAY), 'ACT',
 NULL, NULL, 'NOR'),

('timdrake@gmail.com', 'Robin', SHA2('Soybatman123', 256), NOW(),
 'ACT', DATE_ADD(NOW(), INTERVAL 90 DAY), 'ACT',
 NULL, NULL, 'NOR');
INSERT INTO roles_usuarios (usercod, rolescod, roleuserest, roleuserfch, roleuserexp) VALUES (1, 'ADMIN', 'ACT', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO roles_usuarios (usercod, rolescod, roleuserest, roleuserfch, roleuserexp) VALUES (2, 'AUDIT', 'ACT', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO roles_usuarios (usercod, rolescod, roleuserest, roleuserfch, roleuserexp) VALUES (3, 'OPADQ', 'ACT', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR));

INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Products\\Product', 'Formulario de Productos', 'ACT', 'CTR');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Products\\Products', 'Lista de Productos', 'ACT', 'CTR');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Menu_Products', 'Menu_Products', 'ACT', 'MNU');

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Products\\Product', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Controllers\\Products\\Product', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Controllers\\Products\\Product', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Products\\Products', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Controllers\\Products\\Products', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Controllers\\Products\\Products', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Menu_Products', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Menu_Products', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Menu_Products', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

INSERT INTO categorias (nombre, estado) VALUES
('Pastel', 'ACT'),
('Cheesecake', 'ACT'),
('Cupcake', 'ACT');

INSERT INTO products (productName, productDescription, productPrice, productImgUrl, productStock, productStatus, categoriaId) VALUES
('Pastel de Chocolate', 'Delicioso pastel de chocolate con cobertura de ganache', 25.00, 'https://placehold.co/290x250?text=Pastel+Chocolate&font=roboto', 15, 'ACT', 1),
('Pastel Red Velvet', 'Pastel red velvet con crema de queso', 28.00, 'https://placehold.co/290x250?text=Red+Velvet&font=roboto', 12, 'ACT', 1),
('Pastel de Zanahoria', 'Pastel de zanahoria con glaseado de queso crema', 24.00, 'https://placehold.co/290x250?text=Pastel+Zanahoria&font=roboto', 10, 'ACT', 1),
('Cheesecake Clásico', 'Cheesecake cremoso con base de galleta', 30.00, 'https://placehold.co/290x250?text=Cheesecake+Clasico&font=roboto', 10, 'ACT', 2),
('Cheesecake de Fresa', 'Cheesecake con topping de fresas frescas', 32.00, 'https://placehold.co/290x250?text=Cheesecake+Fresa&font=roboto', 8, 'ACT', 2),
('Cheesecake de Chocolate Blanco', 'Cheesecake con chocolate blanco y base de galleta', 33.00, 'https://placehold.co/290x250?text=Cheesecake+Choco+Blanco&font=roboto', 6, 'ACT', 2),
('Cupcake Vainilla', 'Cupcake esponjoso de vainilla con glaseado de mantequilla', 5.00, 'https://placehold.co/290x250?text=Cupcake+Vainilla&font=roboto', 50, 'ACT', 3),
('Cupcake de Chocolate', 'Cupcake de chocolate con glaseado de crema de chocolate', 6.00, 'https://placehold.co/290x250?text=Cupcake+Chocolate&font=roboto', 45, 'ACT', 3),
('Cupcake Red Velvet', 'Cupcake red velvet con crema de queso', 6.50, 'https://placehold.co/290x250?text=Cupcake+Red+Velvet&font=roboto', 40, 'ACT', 3);


INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('categorias_DSP', 'Detalle de Categorías', 'ACT', 'FNC');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('categorias_UPD', 'Editar Categorías', 'ACT', 'FNC');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('categorias_DEL', 'Eliminar Categorías', 'ACT', 'FNC');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('categorias_INS', 'Agregar Categorías', 'ACT', 'FNC');

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'categorias_DSP', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'categorias_UPD', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'categorias_DEL', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'categorias_INS', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'categorias_DSP', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'categorias_DSP', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'categorias_UPD', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

-- Funciones para controladores y menú de categorías
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Mantenimientos\\Productos\\Categoria', 'Formulario de Categorías', 'ACT', 'CTR');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Mantenimientos\\Productos\\Categorias', 'Lista de Categorías', 'ACT', 'CTR');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Menu_Categorias', 'Menu_Categorias', 'ACT', 'MNU');

-- Roles para el controlador de formulario de categoría
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Mantenimientos\\Productos\\Categoria', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Controllers\\Mantenimientos\\Productos\\Categoria', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Controllers\\Mantenimientos\\Productos\\Categoria', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

-- Roles para el controlador de listado de categoría
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Mantenimientos\\Productos\\Categorias', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Controllers\\Mantenimientos\\Productos\\Categorias', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Controllers\\Mantenimientos\\Productos\\Categorias', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

-- Roles para el ítem de menú de Categorías
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Menu_Categorias', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Menu_Categorias', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Menu_Categorias', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));


INSERT INTO funciones (fncod, fndsc, fnest, fntyp) 
VALUES ('Controllers\\Destacados', 'Página de Productos Destacados', 'ACT', 'CTR');
-- Para ADMIN
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) 
VALUES ('ADMIN', 'Controllers\\Destacados', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

-- Para AUDIT
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) 
VALUES ('AUDIT', 'Controllers\\Destacados', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

-- Para OPADQ
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) 
VALUES ('OPADQ', 'Controllers\\Destacados', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Menu_Destacados', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Menu_Destacados', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Menu_Destacados', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));


