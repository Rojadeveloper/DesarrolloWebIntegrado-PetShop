CREATE DATABASE tienda_mascotas;
USE tienda_mascotas;

-- =========================
-- TABLA USUARIO
-- =========================
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    correo VARCHAR(150) UNIQUE,
    contraseña VARCHAR(255),
    telefono VARCHAR(20),
    direccion VARCHAR(200),
    rol VARCHAR(20) NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- TABLA CATEGORIA
-- =========================
CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion VARCHAR(200)
);

-- =========================
-- TABLA PRODUCTO
-- =========================
CREATE TABLE producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150),
    descripcion TEXT,
    precio DECIMAL(10,2),
    stock INT,
    imagen VARCHAR(255),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

-- =========================
-- TABLA CARRITO
-- =========================
CREATE TABLE carrito (
    id_carrito INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- =========================
-- TABLA DETALLE_CARRITO
-- =========================
CREATE TABLE detalle_carrito (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_carrito INT,
    id_producto INT,
    cantidad INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (id_carrito) REFERENCES carrito(id_carrito),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- =========================
-- TABLA PEDIDO
-- =========================
CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2),
    estado VARCHAR(50),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- =========================
-- TABLA DETALLE_PEDIDO
-- =========================
CREATE TABLE detalle_pedido (
    id_detalle_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- =========================
-- TABLA PAGO
-- =========================
CREATE TABLE pago (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    metodo_pago VARCHAR(50),
    fecha_pago DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado_pago VARCHAR(50),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

INSERT INTO usuario (
    nombre, apellido, correo, contraseña, telefono, direccion, rol
)
VALUE
('Jesus', 'Roja', 'adminroja@gmail.com', 'admin', '920575983', 'Lima','ADMIN'),
('Maria', 'Paredes', 'maria@gmail.com', 'maria', '953424555', 'Lima','CLIENTE');

-- =========================
-- TABLA PROVEEDOR
-- =========================
CREATE TABLE proveedor (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion VARCHAR(200),
    telefono VARCHAR(20),
    correo VARCHAR(150) UNIQUE,
    ruc VARCHAR(20) UNIQUE,
    estado VARCHAR(20));

-- =========================
-- ACTUALIZAR T PRODUCTO
-- =========================
ALTER TABLE producto
ADD id_proveedor INT;

ALTER TABLE producto
ADD FOREIGN KEY (id_proveedor)
REFERENCES proveedor(id_proveedor);
-- =========================
-- ACTUALIZAR T USUARIO
-- =========================
ALTER TABLE usuario
CHANGE contraseña password VARCHAR(255);

-- =========================
-- PROCEDURES
-- =========================
DELIMITER //

CREATE PROCEDURE sp_registrarUsuario(IN p_nombre VARCHAR(100),IN p_apellido VARCHAR(100),IN p_correo VARCHAR(150),IN p_password VARCHAR(255),IN p_telefono VARCHAR(20),IN p_direccion VARCHAR(200),IN p_rol VARCHAR(20))
BEGIN
INSERT INTO usuario(nombre,apellido,correo,password,telefono,direccion,rol)
VALUES(p_nombre,p_apellido,p_correo,p_password,p_telefono,p_direccion,p_rol);
END //

CREATE PROCEDURE sp_agregarCategoria(IN p_nombre VARCHAR(100),IN p_descripcion VARCHAR(200))
BEGIN
INSERT INTO categoria(nombre,descripcion)
VALUES(p_nombre,p_descripcion);
END //

CREATE PROCEDURE sp_agregarProveedor(IN p_nombre VARCHAR(100),IN p_descripcion VARCHAR(200),IN p_telefono VARCHAR(20),IN p_correo VARCHAR(150),IN p_ruc VARCHAR(20),IN p_estado VARCHAR(20))
BEGIN
INSERT INTO proveedor(nombre,descripcion,telefono,correo,ruc,estado)
VALUES(p_nombre,p_descripcion,p_telefono,p_correo,p_ruc,p_estado);
END //

CREATE PROCEDURE sp_agregarProducto(IN p_nombre VARCHAR(150),IN p_descripcion TEXT,IN p_precio DECIMAL(10,2),IN p_stock INT,IN p_imagen VARCHAR(255),IN p_id_categoria INT,IN p_id_proveedor INT)
BEGIN
INSERT INTO producto(nombre,descripcion,precio,stock,imagen,id_categoria,id_proveedor)
VALUES(p_nombre,p_descripcion,p_precio,p_stock,p_imagen,p_id_categoria,p_id_proveedor);
END //

CREATE PROCEDURE sp_crearCarrito(IN p_id_usuario INT)
BEGIN
INSERT INTO carrito(id_usuario)
VALUES(p_id_usuario);
END //

CREATE PROCEDURE sp_agregarDetalleCarrito(IN p_id_carrito INT,IN p_id_producto INT,IN p_cantidad INT,IN p_subtotal DECIMAL(10,2))
BEGIN
INSERT INTO detalle_carrito(id_carrito,id_producto,cantidad,subtotal)
VALUES(p_id_carrito,p_id_producto,p_cantidad,p_subtotal);
END //

CREATE PROCEDURE sp_crearPedido(IN p_id_usuario INT,IN p_total DECIMAL(10,2),IN p_estado VARCHAR(50))
BEGIN
INSERT INTO pedido(id_usuario,total,estado)
VALUES(p_id_usuario,p_total,p_estado);
END //

CREATE PROCEDURE sp_agregarDetallePedido(IN p_id_pedido INT,IN p_id_producto INT,IN p_cantidad INT,IN p_precio_unitario DECIMAL(10,2),IN p_subtotal DECIMAL(10,2))
BEGIN
INSERT INTO detalle_pedido(id_pedido,id_producto,cantidad,precio_unitario,subtotal)
VALUES(p_id_pedido,p_id_producto,p_cantidad,p_precio_unitario,p_subtotal);
END //

CREATE PROCEDURE sp_registrarPago(IN p_id_pedido INT,IN p_metodo_pago VARCHAR(50),IN p_estado_pago VARCHAR(50))
BEGIN
INSERT INTO pago(id_pedido,metodo_pago,estado_pago)
VALUES(p_id_pedido,p_metodo_pago,p_estado_pago);
END //

DELIMITER ;

-- =========================
-- INSERCIONES CATEGORIAS
-- =========================
CALL sp_agregarCategoria('Alimentos','Comida y nutricion para mascotas');
CALL sp_agregarCategoria('Accesorios','Productos de uso diario para mascotas');
CALL sp_agregarCategoria('Juguetes','Juguetes y entretenimiento para mascotas');
CALL sp_agregarCategoria('Higiene','Productos de limpieza y cuidado');
CALL sp_agregarCategoria('Salud','Vitaminas, antipulgas y suplementos');
CALL sp_agregarCategoria('Snacks y premios','Galletas, huesos y premios para mascotas');
CALL sp_agregarCategoria('Transporte','Mochilas, jaulas y transportadoras');

-- =========================
-- INSERCIONES PROVEEDORES
-- =========================
CALL sp_agregarProveedor('Purina Peru','Ofrece nutricion balanceada para mascotas','987654321','contacto@purina.pe','20111111111','activo');
CALL sp_agregarProveedor('Royal Canin Peru','Especializada en alimentacion premium','987654322','ventas@royalcanin.pe','20222222222','activo');
CALL sp_agregarProveedor('Pro Plan Peru','Formulas avanzadas para mascotas','987654323','contacto@proplan.pe','20333333333','activo');
CALL sp_agregarProveedor('Pedigree Peru','Alimentos completos para perros','987654324','ventas@pedigree.pe','20444444444','activo');
CALL sp_agregarProveedor('Pet Toys SAC','Distribuye juguetes interactivos','987654325','ventas@pettoys.pe','20555555555','activo');
CALL sp_agregarProveedor('Mascota Feliz Distribuciones','Accesorios y productos esenciales','987654326','contacto@mascotafeliz.pe','20666666666','activo');
CALL sp_agregarProveedor('VetCare Peru','Soluciones veterinarias','987654327','info@vetcare.pe','20777777777','activo');
CALL sp_agregarProveedor('Pet Snacks Company','Snacks y premios para mascotas','987654328','ventas@petsnacks.pe','20888888888','activo');
CALL sp_agregarProveedor('Travel Pets Peru','Productos de transporte para mascotas','987654329','contacto@travelpets.pe','20999999999','activo');

-- =========================
-- INSERCIONES PRODUCTOS
-- =========================
CALL sp_agregarProducto('Dog Chow Adultos 15KG','Alimento balanceado para perros adultos de razas medianas y grandes',129.90,25,'dogchow15kg.jpg',1,1);
CALL sp_agregarProducto('Cat Chow Gatitos 8KG','Nutricion especializada para gatitos en crecimiento',98.50,18,'catchow8kg.jpg',1,1);
CALL sp_agregarProducto('Dog Chow Cachorros 8KG','Formula rica en proteinas para cachorros en etapa de desarrollo',89.90,22,'dogchowcachorro.jpg',1,1);
CALL sp_agregarProducto('Royal Canin Mini Adult','Alimento premium para perros adultos de raza pequeña',165.90,12,'royalminiadult.jpg',1,2);
CALL sp_agregarProducto('Royal Canin Persian Adult','Formula especializada para gatos persas adultos',189.90,10,'royalpersian.jpg',1,2);
CALL sp_agregarProducto('Royal Canin Sterilised Cat','Nutricion diseñada para gatos esterilizados',176.80,11,'royalsterilised.jpg',1,2);
CALL sp_agregarProducto('Pro Plan Puppy Sensitive','Nutricion avanzada para cachorros con digestion sensible',154.90,16,'proplanpuppy.jpg',1,3);
CALL sp_agregarProducto('Pro Plan Adult Salmon','Alimento premium sabor salmon para perros adultos',172.50,14,'proplansalmon.jpg',1,3);
CALL sp_agregarProducto('Pro Plan Reduced Calorie','Control nutricional para perros adultos con sobrepeso',168.90,9,'proplanreduced.jpg',1,3);
CALL sp_agregarProducto('Pedigree Carne y Vegetales 15KG','Alimento completo para perros adultos activos',112.90,30,'pedigree15kg.jpg',1,4);
CALL sp_agregarProducto('Pedigree Cachorro Pollo 10KG','Formula para cachorros enriquecida con vitaminas y minerales',105.40,20,'pedigreecachorro.jpg',1,4);
CALL sp_agregarProducto('Pedigree Senior Razas Medianas','Nutricion especializada para perros mayores',118.70,13,'pedigreesenior.jpg',1,4);

CALL sp_agregarProducto('Correa Ajustable Roja','Correa resistente para perros medianos y grandes',35.90,40,'correaroja.jpg',2,6);
CALL sp_agregarProducto('Collar Antitirones','Collar comodo con ajuste de seguridad para paseos',42.50,30,'collarantitirones.jpg',2,6);
CALL sp_agregarProducto('Cama Acolchada Mediana','Cama suave y confortable para mascotas pequeñas',89.90,15,'camamediana.jpg',2,6);
CALL sp_agregarProducto('Plato Doble Acero','Comedero doble de acero inoxidable para agua y comida',48.90,25,'platodoble.jpg',2,6);
CALL sp_agregarProducto('Arnes Deportivo','Arnes ergonomico ideal para caminatas y entrenamiento',59.90,18,'arnesdeportivo.jpg',2,6);
CALL sp_agregarProducto('Rascador para Gato','Rascador vertical reforzado para gatos activos',95.00,12,'rascadorgato.jpg',2,6);
CALL sp_agregarProducto('Fuente de Agua Automatica','Dispensador automatico de agua para mascotas',120.50,10,'fuenteagua.jpg',2,6);
CALL sp_agregarProducto('Manta Termica para Mascotas','Manta suave diseñada para epocas frias',44.90,20,'mantatermica.jpg',2,6);
CALL sp_agregarProducto('Comedero Elevado','Comedero elevado que mejora la postura al alimentarse',68.90,14,'comederoelevado.jpg',2,6);
CALL sp_agregarProducto('Cama Premium XL','Cama acolchada grande para perros de gran tamaño',145.90,8,'camaxl.jpg',2,6);

CALL sp_agregarProducto('Pelota Mordedora','Pelota resistente diseñada para perros activos',24.90,50,'pelotamordedora.jpg',3,5);
CALL sp_agregarProducto('Raton Interactivo','Juguete interactivo para estimular gatos curiosos',29.90,35,'ratoninteractivo.jpg',3,5);
CALL sp_agregarProducto('Cuerda Dental','Juguete de cuerda que ayuda a limpiar los dientes',19.90,45,'cuerdadental.jpg',3,5);
CALL sp_agregarProducto('Disco Volador Canino','Frisbee flexible ideal para entrenamiento y juego',27.50,22,'discovolador.jpg',3,5);
CALL sp_agregarProducto('Tunel para Gatos','Tunel plegable para entretenimiento felino',54.90,16,'tunelgatos.jpg',3,5);
CALL sp_agregarProducto('Mordedor de Goma','Mordedor resistente con textura antiestrés',21.90,38,'mordedorgoma.jpg',3,5);
CALL sp_agregarProducto('Pelota Sonora','Pelota con sonido para estimular el juego',26.90,28,'pelotasonora.jpg',3,5);
CALL sp_agregarProducto('Juguete Dispensa Snacks','Juguete interactivo con compartimento para premios',39.90,19,'dispensasnacks.jpg',3,5);
CALL sp_agregarProducto('Varita con Plumas','Varita diseñada para entretenimiento de gatos',18.90,32,'varitaplumas.jpg',3,5);
CALL sp_agregarProducto('Hueso de Caucho','Juguete resistente para perros que aman morder',23.50,40,'huesocaucho.jpg',3,5);

CALL sp_agregarProducto('Shampoo Antipulgas','Shampoo especializado para eliminar pulgas y garrapatas',32.90,25,'shampooantipulgas.jpg',4,6);
CALL sp_agregarProducto('Arena Sanitaria Premium','Arena absorbente para gatos con control de olores',45.50,30,'arenapremium.jpg',4,6);
CALL sp_agregarProducto('Cepillo Desenredante','Cepillo diseñado para remover pelo muerto',28.90,20,'cepillodesenredante.jpg',4,6);
CALL sp_agregarProducto('Toallitas Humedas','Toallitas de limpieza rapida para mascotas',18.50,35,'toallitashumedas.jpg',4,6);
CALL sp_agregarProducto('Corta Uñas Profesional','Corta uñas seguro para perros y gatos',26.90,15,'cortaunas.jpg',4,6);
CALL sp_agregarProducto('Removedor de Olores','Elimina olores fuertes en ambientes de mascotas',34.90,18,'removedorolores.jpg',4,6);
CALL sp_agregarProducto('Shampoo Piel Sensible','Formula suave para mascotas con piel delicada',36.50,14,'shampoopielsensible.jpg',4,6);
CALL sp_agregarProducto('Pañales para Perro','Pañales absorbentes para mascotas',39.90,16,'panalesperro.jpg',4,6);
CALL sp_agregarProducto('Peine Antipulgas','Peine fino para limpieza y control de pulgas',17.90,28,'peineantipulgas.jpg',4,6);
CALL sp_agregarProducto('Limpiador de Oidos','Solucion especializada para higiene auditiva',24.50,12,'limpiadoroidos.jpg',4,6);

CALL sp_agregarProducto('Antipulgas Canino','Proteccion mensual contra pulgas y garrapatas',58.90,20,'antipulgascanino.jpg',5,7);
CALL sp_agregarProducto('Vitaminas para Gatos','Suplemento vitamínico para gatos adultos',42.50,18,'vitaminasgatos.jpg',5,7);
CALL sp_agregarProducto('Calcio para Cachorros','Complemento nutricional para desarrollo oseo',39.90,15,'calciocachorros.jpg',5,7);
CALL sp_agregarProducto('Jarabe Multivitaminico','Refuerza defensas y energia en mascotas',34.90,17,'jarabemultivitaminico.jpg',5,7);
CALL sp_agregarProducto('Protector Hepatico','Suplemento veterinario para salud hepática',62.90,10,'protectorhepatico.jpg',5,7);
CALL sp_agregarProducto('Desparasitante Interno','Control efectivo contra parasitos intestinales',29.90,25,'desparasitante.jpg',5,7);
CALL sp_agregarProducto('Suplemento Articular','Ayuda al cuidado de articulaciones en perros mayores',74.90,9,'suplementoarticular.jpg',5,7);
CALL sp_agregarProducto('Gotas Oftalmicas','Limpieza y cuidado ocular para mascotas',27.50,13,'gotasoftalmicas.jpg',5,7);
CALL sp_agregarProducto('Antiinflamatorio Veterinario','Apoyo para molestias musculares y articulares',68.90,8,'antiinflamatorio.jpg',5,7);
CALL sp_agregarProducto('Spray Cicatrizante','Ayuda en la recuperación de heridas leves',31.90,19,'spraycicatrizante.jpg',5,7);

CALL sp_agregarProducto('Galletas Caninas','Premios crocantes sabor carne para perros',16.90,40,'galletascaninas.jpg',6,8);
CALL sp_agregarProducto('Snack Dental','Snack que ayuda a mantener dientes limpios',22.50,32,'snackdental.jpg',6,8);
CALL sp_agregarProducto('Huesos de Carnaza','Premios masticables para perros activos',19.90,28,'huesoscarnaza.jpg',6,8);
CALL sp_agregarProducto('Premios para Gatos','Snacks sabor salmon para gatos',14.90,35,'premiosgatos.jpg',6,8);
CALL sp_agregarProducto('Bocaditos de Pollo','Snacks blandos ricos en proteina',18.50,26,'bocaditospollo.jpg',6,8);
CALL sp_agregarProducto('Mini Treats','Pequeños premios ideales para entrenamiento',12.90,30,'minitreats.jpg',6,8);
CALL sp_agregarProducto('Snack Natural','Premios elaborados con ingredientes naturales',21.90,22,'snacknatural.jpg',6,8);
CALL sp_agregarProducto('Barritas Nutritivas','Snack energetico para mascotas activas',17.50,20,'barritasnutritivas.jpg',6,8);
CALL sp_agregarProducto('Cubitos de Carne','Premios deshidratados sabor res',24.90,16,'cubitoscarne.jpg',6,8);
CALL sp_agregarProducto('Premios Crunchy','Snacks crocantes para perros pequeños',15.90,27,'premioscrunchy.jpg',6,8);

CALL sp_agregarProducto('Transportadora Mediana','Transportadora resistente para perros pequeños',129.90,10,'transportadoramediana.jpg',7,9);
CALL sp_agregarProducto('Mochila para Gatos','Mochila ventilada para transporte felino',145.50,8,'mochilagatos.jpg',7,9);
CALL sp_agregarProducto('Bolso de Viaje','Bolso acolchado para mascotas pequeñas',98.90,12,'bolsoviaje.jpg',7,9);
CALL sp_agregarProducto('Jaula Plegable','Jaula metalica facil de transportar',185.90,7,'jaulaplegable.jpg',7,9);
CALL sp_agregarProducto('Asiento para Auto','Asiento de seguridad para viajes en auto',112.90,9,'asientoauto.jpg',7,9);
CALL sp_agregarProducto('Correa de Seguridad','Correa diseñada para viajes seguros en vehiculos',34.90,20,'correaseguridad.jpg',7,9);
CALL sp_agregarProducto('Transportadora Premium','Modelo premium con ventilacion reforzada',210.50,5,'transportadorapremium.jpg',7,9);
CALL sp_agregarProducto('Mochila Expandible','Mochila amplia para viajes largos',168.90,6,'mochilaexpandible.jpg',7,9);
CALL sp_agregarProducto('Coche para Mascotas','Coche plegable para perros pequeños y gatos',320.90,4,'cochemascotas.jpg',7,9);
CALL sp_agregarProducto('Bolso Transparente','Bolso moderno con visor transparente',138.90,11,'bolsotransparente.jpg',7,9);




