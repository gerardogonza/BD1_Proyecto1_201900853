
-- consulta para eliminar tabla si esta existe

DROP TABLE  temporal;
TRUNCATE TABLE temporal;
SELECT * FROM temporal;
SELECT COUNT(*) FROM TEMPORAL;
-- SELECT distinct nombre_empleado,apellido_empleado FROM temporal;

create table temporal(
                         nombre_empleado varchar(300),
                         apellido_empleado varchar(250),
                         direccion_empleado varchar(250),
                         telefono_empleado varchar(250),
                         genero_empleado varchar(250),
                         fecha_nacimiento_empleado date,
                         titulo_del_empleado varchar(250),
                         nombre_paciente varchar(250),
                         apellido_paciente varchar(250),
                         direccion_paciente varchar(250),
                         telefono_paciente varchar(250),
                         genero_paciente varchar(250),
                         fecha_nacimiento_paciente date,
                         altura number,
                         peso number,
                         fecha_evaluacion date,
                         sintoma_del_paciente varchar(250),
                         diagnostico_del_sintoma varchar(250),
                         rango_del_diagnostico number,
                         fecha_tratamiento date,
                         tratamiento_aplicado varchar(250)
);
