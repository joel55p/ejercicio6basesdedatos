--parte 3
-- departamento
CREATE TABLE DEPARTAMENTO_CLI (
    id_departamento SERIAL PRIMARY KEY, --aumenta cuando se hace INSERT entonces se usa para ids
    nombre          VARCHAR(100) NOT NULL,
    id_jefe         INTEGER
);
-- medico
CREATE TABLE MEDICO (
    no_colegiado    INTEGER PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    especialidad    VARCHAR(100) NOT NULL,
    telefono        VARCHAR(20) NOT NULL,
    id_departamento INTEGER NOT NULL,
    FOREIGN KEY (id_departamento) REFERENCES DEPARTAMENTO_CLI(id_departamento)
);
-- Tabla sala
CREATE TABLE SALA_CLI (
    numero      INTEGER PRIMARY KEY,
    descripcion VARCHAR(300) NOT NULL
);
-- paciente 
CREATE TABLE PACIENTE (
    no_expediente       INTEGER PRIMARY KEY,
    nombre              VARCHAR(100) NOT NULL,
    fecha_nacimiento    VARCHAR(20) NOT NULL,
    direccion           VARCHAR(200),
    no_seguro_medico    VARCHAR(50) NOT NULL
);
--  se tiene a la tabla telefono paciente ya que un paciente puede tener varios teléfonos
CREATE TABLE TELEFONO_PACIENTE (
    id_telefono     SERIAL PRIMARY KEY,
    no_expediente   INTEGER NOT NULL,
    numero          VARCHAR(20) NOT NULL,
    FOREIGN KEY (no_expediente) REFERENCES PACIENTE(no_expediente)
);
-- cita 
CREATE TABLE CITA (
    id_cita         SERIAL PRIMARY KEY,
    fecha           VARCHAR(20) NOT NULL,
    hora            VARCHAR(10) NOT NULL,
    motivo          VARCHAR(300) NOT NULL,
    estado          VARCHAR(20) NOT NULL CHECK(estado IN ('pendiente', 'completada', 'cancelada')), --el check comprueba si se introdujo unicamente estos valores
    no_expediente   INTEGER NOT NULL,
    no_colegiado    INTEGER NOT NULL,
    numero_sala     INTEGER NOT NULL,
    FOREIGN KEY (no_expediente) REFERENCES PACIENTE(no_expediente),
    FOREIGN KEY (no_colegiado)  REFERENCES MEDICO(no_colegiado),
    FOREIGN KEY (numero_sala)   REFERENCES SALA_CLI(numero)
);
-- diagnostico
CREATE TABLE DIAGNOSTICO (
    codigo_c10    VARCHAR(20) PRIMARY KEY,
    descripcion     VARCHAR(255) NOT NULL,
    fecha_emision   VARCHAR(20) NOT NULL
);
-- Tabla de la relacion entre cita y diagnostica  
CREATE TABLE CITA_DIAGNOSTICO ( --ya que la relacion es de muchos a muchos
    id_cita         INTEGER NOT NULL,
    codigo_c10    VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_cita, codigo_c10),
    FOREIGN KEY (id_cita)      REFERENCES CITA(id_cita),
    FOREIGN KEY (codigo_c10) REFERENCES DIAGNOSTICO(codigo_c10)
);
-- medicamento
CREATE TABLE MEDICAMENTO (
    id_medicamento    SERIAL PRIMARY KEY,
    nombre_generico   VARCHAR(100) NOT NULL,
    presentacion      VARCHAR(100) NOT NULL,
    dosis_recomendada VARCHAR(100) NOT NULL
);
-- tabla entre diagnostico y medicamento 
CREATE TABLE PRESCRIPCION ( --por lo mismo que la relacion de estas dos(diagnostico y medicamento ) es de muchos a muchos 
    codigo_c10    VARCHAR(20) NOT NULL,
    id_medicamento  INTEGER NOT NULL,
    cantidad        INTEGER NOT NULL CHECK(cantidad > 0),
    duracion_dias   INTEGER NOT NULL CHECK(duracion_dias > 0),
    PRIMARY KEY (codigo_c10, id_medicamento),
    FOREIGN KEY (codigo_c10)   REFERENCES DIAGNOSTICO(codigo_c10),
    FOREIGN KEY (id_medicamento) REFERENCES MEDICAMENTO(id_medicamento)
);