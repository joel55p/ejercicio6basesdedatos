-- Joel Nerio, 24253

-- Tabla carrera
CREATE TABLE CARRERA (
    codigo      VARCHAR(20) PRIMARY KEY, --esta es la primary key
    nombre      VARCHAR(100) NOT NULL
);

-- Tabla departamento
CREATE TABLE DEPARTAMENTO (
    id_dept     VARCHAR(20) PRIMARY KEY,
    nombre      VARCHAR(100) NOT NULL
);

-- Tabla estudiante
CREATE TABLE ESTUDIANTE (
    carnet      VARCHAR(20) PRIMARY KEY,
    nombre      VARCHAR(100) NOT NULL,
    email       VARCHAR(100) NOT NULL,
    codigo_carrera VARCHAR(20) NOT NULL,
    CONSTRAINT fk_estudiante_carrera FOREIGN KEY (codigo_carrera)
        REFERENCES CARRERA(codigo)
);

-- Tabla profesro
CREATE TABLE PROFESOR (
    id_prof         VARCHAR(20) PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    especialidad    VARCHAR(100),
    id_dept         VARCHAR(20) NOT NULL,
    CONSTRAINT fk_profesor_departamento FOREIGN KEY (id_dept)
        REFERENCES DEPARTAMENTO(id_dept)
);

-- relacion dirige: un profe dirige un depar osea de uno a uno (1:1)
ALTER TABLE DEPARTAMENTO
    ADD COLUMN id_prof_director VARCHAR(20),
    ADD CONSTRAINT fk_departamento_director FOREIGN KEY (id_prof_director)
        REFERENCES PROFESOR(id_prof);

-- tabla salon
CREATE TABLE SALON (
    numero      VARCHAR(20) PRIMARY KEY,
    capacidad   INT NOT NULL,
    edificio    VARCHAR(50) NOT NULL
);

-- tabla curso
CREATE TABLE CURSO (
    codigo      VARCHAR(20) PRIMARY KEY,
    nombre      VARCHAR(100) NOT NULL,
    creditos    INT NOT NULL,
    numero_salon VARCHAR(20) NOT NULL,
    CONSTRAINT fk_curso_salon FOREIGN KEY (numero_salon)
        REFERENCES SALON(numero)
);

-- Relacion inscrito: estudiante (N) - curso (M) de muchos a muchos
CREATE TABLE INSCRITO (
    carnet      VARCHAR(20) NOT NULL,
    codigo_curso VARCHAR(20) NOT NULL,
    PRIMARY KEY (carnet, codigo_curso),
    CONSTRAINT fk_inscrito_estudiante FOREIGN KEY (carnet)
        REFERENCES ESTUDIANTE(carnet),
    CONSTRAINT fk_inscrito_curso FOREIGN KEY (codigo_curso)
        REFERENCES CURSO(codigo)
);

-- Relacion imparte: profe (1) - curso (N) de uno a muchos
CREATE TABLE IMPARTE (
    id_prof     VARCHAR(20) NOT NULL,
    codigo_curso VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_prof, codigo_curso),
    CONSTRAINT fk_imparte_profesor FOREIGN KEY (id_prof)
        REFERENCES PROFESOR(id_prof),
    CONSTRAINT fk_imparte_curso FOREIGN KEY (codigo_curso)
        REFERENCES CURSO(codigo)
);