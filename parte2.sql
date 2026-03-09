
-- parte2 Joel Nerio, 24253


-- Tabla categoria
CREATE TABLE CATEGORIA (
    id_categoria    VARCHAR(20) PRIMARY KEY,
    nombre_cat      VARCHAR(100) NOT NULL,
    descripcion     VARCHAR(500)
);

-- proveedor
CREATE TABLE PROVEEDOR (
    id_proveedor    VARCHAR(20) PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    pais            VARCHAR(50) NOT NULL
);

-- Product
CREATE TABLE PRODUCTO (
    id_producto     VARCHAR(20) PRIMARY KEY,
    nombre_prod     VARCHAR(100) NOT NULL,
    precio          FLOAT NOT NULL,
    stock           INT NOT NULL,
    id_categoria    VARCHAR(20) NOT NULL,
    CONSTRAINT fk_productoycategoria 
	FOREIGN KEY (id_categoria)
    REFERENCES CATEGORIA(id_categoria) --lo que esta haciendo es conectar a la tabla CATEGORIA 
);
--aprendi que CONSTRAINT lo que hace es que solo pone un nombre por si me da error
--osea que pone nombre a una regla de la tabla

-- empleado
CREATE TABLE EMPLEADO (
    id_empleado     VARCHAR(20) PRIMARY KEY,
    nombre_emp      VARCHAR(100) NOT NULL,
    salario         FLOAT NOT NULL,
    id_supervisor   VARCHAR(20),
    CONSTRAINT fk_empleadoysupervisor 
	FOREIGN KEY (id_supervisor)
    REFERENCES EMPLEADO(id_empleado)
);


CREATE TABLE CLIENTE (--tabla para el cliente
    id_cliente      VARCHAR(20) PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    apellido        VARCHAR(100) NOT NULL,
    calle           VARCHAR(150),
    ciudad          VARCHAR(100),
    cod_postal      VARCHAR(20)
);
--pedido
CREATE TABLE PEDIDO (
    id_pedido       VARCHAR(20) PRIMARY KEY,
    fecha           DATE NOT NULL,
    estado          VARCHAR(50) NOT NULL,
    total          	FLOAT	 NOT NULL,
    id_cliente      VARCHAR(20) NOT NULL,
    id_empleado     VARCHAR(20) NOT NULL,
    CONSTRAINT fk_pedido_cliente
	FOREIGN KEY (id_cliente)
    REFERENCES CLIENTE(id_cliente),
    CONSTRAINT fk_pedidoyempleado FOREIGN KEY (id_empleado)
    REFERENCES EMPLEADO(id_empleado)
);
--telefono
CREATE TABLE TELEFONO (
    id_tel          VARCHAR(20) PRIMARY KEY,
    numero          VARCHAR(20) NOT NULL,
    id_cliente      VARCHAR(20) NOT NULL,
    CONSTRAINT fk_telefonoycliente 
	FOREIGN KEY (id_cliente)
    REFERENCES CLIENTE(id_cliente)
);
--email
CREATE TABLE EMAIL (
    id_email        VARCHAR(20) PRIMARY KEY,
    correo          VARCHAR(150) NOT NULL,
    id_cliente      VARCHAR(20) NOT NULL,
    CONSTRAINT fk_emailycliente 
	FOREIGN KEY (id_cliente)
    REFERENCES CLIENTE(id_cliente)
);



-- tabla de relacion suministra que tendra sus atributos propios.
CREATE TABLE SUMINISTRA (--  es porque la relacion que tiene proveedor con producto es de muchos a muchos
    id_proveedor    VARCHAR(20) NOT NULL,
    id_producto     VARCHAR(20) NOT NULL,
    precio_costo    FLOAT NOT NULL,
    cantidad        INT NOT NULL,
    PRIMARY KEY (id_proveedor, id_producto),
    CONSTRAINT fk_suministrayproveedor 
	FOREIGN KEY (id_proveedor)
    REFERENCES PROVEEDOR(id_proveedor),
    CONSTRAINT fk_suministrayproducto 
	FOREIGN KEY (id_producto)
    REFERENCES PRODUCTO(id_producto)
);


--tabla de Contiene 
CREATE TABLE CONTIENE (--  es porque  la relacion que tiene producto con pedido tambine es de muchos a muchos
    id_producto     VARCHAR(20) NOT NULL,
    id_pedido       VARCHAR(20) NOT NULL,
    precio_unit     FLOAT NOT NULL,
    cantidad        INT NOT NULL,
    PRIMARY KEY (id_producto, id_pedido), --
    CONSTRAINT fk_contieneyproducto 
	FOREIGN KEY (id_producto)
    REFERENCES PRODUCTO(id_producto),
    CONSTRAINT fk_contieneypedido 
	FOREIGN KEY (id_pedido)
    REFERENCES PEDIDO(id_pedido)
);