-- Active: 1750217631131@@127.0.0.1@3306@nwbd1
CREATE SCHEMA `ecommerce` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

INSERT INTO `usuario` (
    `useremail`, `username`, `userpswd`, `userfching`,
    `userpswdest`, `userpswdexp`, `userest`,
    `useractcod`, `userpswdchg`, `usertipo`
) VALUES
('timdrake@gmail.com', 'Robin', SHA2('Soybatman123', 256), NOW(),
 'ACT', DATE_ADD(NOW(), INTERVAL 90 DAY), 'ACT',
 NULL, NULL, 'NOR')
('brucewayne@gmail.com', 'Batman', SHA2('Soybatman123', 256), NOW(),
 'ACT', DATE_ADD(NOW(), INTERVAL 90 DAY), 'ACT',
 NULL, NULL, 'ADM'),

('dickgrayson@gmail.com', 'Nightwing', SHA2('Soybatman123', 256), NOW(),
 'ACT', DATE_ADD(NOW(), INTERVAL 90 DAY), 'ACT',
 NULL, NULL, 'NOR');


 INSERT INTO roles (rolescod, rolesdsc, rolesest) VALUES ('ADMIN', 'Administrador', 'ACT');
INSERT INTO roles (rolescod, rolesdsc, rolesest) VALUES ('AUDIT', 'Auditor', 'ACT');
INSERT INTO roles (rolescod, rolesdsc, rolesest) VALUES ('OPADQ', 'Operador de Adquisiciones', 'ACT');
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

INSERT INTO roles (rolescod, rolesdsc, rolesest) VALUES ('ADMIN', 'Administrador', 'ACT');
INSERT INTO roles (rolescod, rolesdsc, rolesest) VALUES ('AUDIT', 'Auditor', 'ACT');
INSERT INTO roles (rolescod, rolesdsc, rolesest) VALUES ('OPADQ', 'Operador de Adquisiciones', 'ACT');


-- Asignación de menú Roles para ADMIN, AUDIT y OPADQ
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Menu_Roles', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Menu_Roles', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('OPADQ', 'Menu_Roles', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

    -- Inserta las funciones (acciones) relacionadas con la gestión de Roles
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('role_DSP', 'Detalle de Roles', 'ACT', 'FNC'); -- Ver detalle de rol
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('role_UPD', 'Editar Roles', 'ACT', 'FNC');        -- Editar rol
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('role_DEL', 'Eliminar Roles', 'ACT', 'FNC');      -- Eliminar rol
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('role_INS', 'Agregar Roles', 'ACT', 'FNC');       -- Agregar nuevo rol

-- Inserta las funciones tipo controlador y menú para la gestión de Roles
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Roles\\Rol', 'Formulario de Roles', 'ACT', 'CTR');  -- Controlador formulario rol
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Roles\\Roles', 'Lista de Roles', 'ACT', 'CTR');      -- Controlador lista de roles
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Menu_Roles', 'Menu Roles', 'ACT', 'MNU');                         -- Menú Roles
   
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

--Esquizofrenia de detalle de josselin
GRANT ALL PRIVILEGES ON nwbd1.* TO 'devuser'@'%';
FLUSH PRIVILEGES;
INSERT INTO products (
  productId, productName, productDescription, productPrice, productImgUrl,
  productStock, productStatus, categoriaId,
  productIngredients, productFeatures, productPresentation,
  productAllergens, productRecommendation, productStorage, productCustom
) VALUES
(1, 'Pastel de Chocolate', 'Delicioso pastel de chocolate con cobertura de ganache', 25.00, 'https://placehold.co/290x250?text=Pastel+Chocolate&font=roboto', 15, 'ACT', 1,
 'Harina, cacao, azúcar, huevos, mantequilla, ganache de chocolate',
 'Pastel húmedo con cobertura de ganache, ideal para cumpleaños.',
 '8 porciones (23 cm de diámetro)',
 'Gluten, huevo, lácteos',
 'Ideal para cumpleaños y celebraciones con café.',
 'Mantener en refrigeración hasta 5 días.',
 'Sí'),

(2, 'Pastel Red Velvet', 'Pastel red velvet con crema de queso', 28.00, 'https://placehold.co/290x250?text=Red+Velvet&font=roboto', 12, 'ACT', 1,
 'Harina, cacao, azúcar, crema de queso, colorante rojo',
 'Textura suave, con crema de queso y un toque elegante.',
 '8 porciones (23 cm) – también disponible mini',
 'Gluten, lácteos, colorantes',
 'Perfecto para eventos románticos o aniversarios.',
 'Refrigerar y consumir en 4 días.',
 'Sí'),

(3, 'Pastel de Zanahoria', 'Pastel de zanahoria con glaseado de queso crema', 24.00, 'https://placehold.co/290x250?text=Pastel+Zanahoria&font=roboto', 10, 'ACT', 1,
 'Harina, zanahoria rallada, azúcar, huevos, glaseado de queso crema',
 'Sabor casero, glaseado dulce, buena opción para la merienda.',
 '6 porciones (20 cm) – versión sin nueces',
 'Gluten, huevo, lácteos',
 'Acompañar con té o leche caliente.',
 'A temperatura ambiente, hasta 3 días.',
 'No'),

(4, 'Cheesecake Clásico', 'Cheesecake cremoso con base de galleta', 30.00, 'https://placehold.co/290x250?text=Cheesecake+Clasico&font=roboto', 10, 'ACT', 2,
 'Queso crema, galletas molidas, mantequilla, azúcar',
 'Cremoso y clásico, una delicia fría.',
 'Molde redondo 18 cm – porciones individuales',
 'Lácteos, gluten',
 'Postre frío para después de almuerzos.',
 'Refrigerado hasta 7 días.',
 'Sí'),

(5, 'Cheesecake de Fresa', 'Cheesecake con topping de fresas frescas', 32.00, 'https://placehold.co/290x250?text=Cheesecake+Fresa&font=roboto', 8, 'ACT', 2,
 'Queso crema, fresas frescas, galletas, azúcar',
 'Con topping de fresas frescas, sabor equilibrado.',
 'Molde cuadrado – 9 porciones medianas',
 'Lácteos, gluten',
 'Excelente para reuniones familiares.',
 'Refrigerar – 5 días máximo.',
 'Sí'),

(6, 'Cheesecake de Chocolate Blanco', 'Cheesecake con chocolate blanco y base de galleta', 33.00, 'https://placehold.co/290x250?text=Cheesecake+Choco+Blanco&font=roboto', 6, 'ACT', 2,
 'Queso crema, chocolate blanco, galletas, azúcar',
 'Para amantes del chocolate blanco, textura cremosa.',
 '10 porciones pequeñas',
 'Lácteos, gluten',
 'Delicioso con vino blanco dulce.',
 'Refrigeración obligatoria – consumir en 4 días.',
 'No'),

(7, 'Cupcake Vainilla', 'Cupcake esponjoso de vainilla con glaseado de mantequilla', 5.00, 'https://placehold.co/290x250?text=Cupcake+Vainilla&font=roboto', 50, 'ACT', 3,
 'Harina, vainilla, azúcar, huevos, mantequilla',
 'Dulce ligero, ideal para eventos infantiles.',
 'Individual – caja de 6 o 12',
 'Huevo, gluten, lácteos',
 'Perfecto para fiestas infantiles.',
 'Temperatura ambiente – 2 días.',
 'Sí'),

(8, 'Cupcake de Chocolate', 'Cupcake de chocolate con glaseado de crema de chocolate', 6.00, 'https://placehold.co/290x250?text=Cupcake+Chocolate&font=roboto', 45, 'ACT', 3,
 'Harina, cacao, azúcar, crema de chocolate, huevos',
 'Intenso sabor a chocolate con cobertura suave.',
 'Individual – presentación en caja de 6',
 'Gluten, huevo',
 'Para amantes del chocolate, con café expreso.',
 'Refrigerar – 3 días máximo.',
 'Sí'),

(9, 'Cupcake Red Velvet', 'Cupcake red velvet con crema de queso', 6.50, 'https://placehold.co/290x250?text=Cupcake+Red+Velvet&font=roboto', 40, 'ACT', 3,
 'Harina, cacao, azúcar, crema de queso, colorante rojo',
 'Mini versión del pastel Red Velvet con toque elegante.',
 'Individual – presentación gourmet',
 'Gluten, colorantes, lácteos',
 'Excelente para brunch o bodas.',
 'Refrigerado – ideal consumir antes de 3 días.',
 'Sí');

--Usuarios Crud y menu
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Seguridad\\Usuario', 'Formulario de Usuarios', 'ACT', 'CTR');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Controllers\\Seguridad\\Usuarios', 'Lista de Usuarios', 'ACT', 'CTR');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Menu_Usuarios', 'Menu_Usuarios', 'ACT', 'MNU');

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Seguridad\\Usuario', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Controllers\\Seguridad\\Usuario', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Controllers\\Seguridad\\Usuarios', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Controllers\\Seguridad\\Usuarios', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Menu_Usuarios', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('AUDIT', 'Menu_Usuarios', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Usuario_DSP', 'Ver Detalle Usuario', 'ACT', 'PFL');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Usuario_INS', 'Crear Usuario', 'ACT', 'PFL');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Usuario_UPD', 'Editar Usuario', 'ACT', 'PFL');
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES ('Usuario_DEL', 'Eliminar Usuario', 'ACT', 'PFL');

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Usuario_DSP', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Usuario_INS', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Usuario_UPD', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES ('ADMIN', 'Usuario_DEL', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));