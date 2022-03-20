OPTIONS (SKIP=1)
    LOAD DATA
    CHARACTERSET UTF8
    INFILE 'BIG_SMOKE_DATA.csv'
    INTO TABLE temporal TRUNCATE
    FIELDS TERMINATED BY ';'
    OPTIONALLY ENCLOSED BY '"'
    TRAILING NULLCOLS
    (
        NOMBRE_EMPLEADO,
        APELLIDO_EMPLEADO,
        DIRECCION_EMPLEADO,
        TELEFONO_EMPLEADO,
        GENERO_EMPLEADO,
        FECHA_NACIMIENTO_EMPLEADO "to_date(:FECHA_NACIMIENTO_EMPLEADO,'YYYY-MM-DD')" ,
        TITULO_DEL_EMPLEADO,
        NOMBRE_PACIENTE,
        APELLIDO_PACIENTE,
        DIRECCION_PACIENTE,
        TELEFONO_PACIENTE ,
        GENERO_PACIENTE,
        FECHA_NACIMIENTO_PACIENTE "to_date(:FECHA_NACIMIENTO_PACIENTE,'YYYY-MM-DD')",
        ALTURA,
        PESO,
        FECHA_EVALUACION "to_date(:FECHA_EVALUACION,'YYYY-MM-DD')" ,
        SINTOMA_DEL_PACIENTE,
        DIAGNOSTICO_DEL_SINTOMA,
        RANGO_DEL_DIAGNOSTICO,
        FECHA_TRATAMIENTO "to_date(:FECHA_TRATAMIENTO,'YYYY-MM-DD')",
        TRATAMIENTO_APLICADO
    )