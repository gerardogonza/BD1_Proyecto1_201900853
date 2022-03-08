
-- consulta para eliminar tabla si esta existe

DROP TABLE  temporal;
SELECT * FROM temporal;
SELECT COUNT(*) FROM TEMPORAL;
create table temporal(
                         nombre_empleado varchar(50),
                         apellido_empleado varchar(50),
                         direccion_empleado varchar(50),
                         telefono_empleado varchar(50),
                         genero_empleado varchar(50),
                         fecha_nacimiento_empleado varchar(50),
                         titulo_del_empleado varchar(50),
                         nombre_paciente varchar(50),
                         apellido_paciente varchar(50),
                         direccion_paciente varchar(50),
                         telefono_paciente varchar(50),
                         genero_paciente varchar(50),
                         fecha_nacimiento_paciente varchar(50),
                         altura varchar(50),
                         peso varchar(50),
                         fecha_evaluacion varchar(50),
                         sintoma_del_paciente varchar(50),
                         diagnostico_del_sintoma varchar(50),
                         rango_del_diagnostico varchar(50),
                         fecha_tratamiento varchar(50),
                         tratamiento_aplicado varchar(50)
);
