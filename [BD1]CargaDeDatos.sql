INSERT INTO GENERO (GENERO)  (SELECT DISTINCT GENERO_EMPLEADO FROM temporal WHERE GENERO_EMPLEADO IS NOT NULL ) ;
INSERT INTO TITULO_EMPLEADO (TITULO)  SELECT DISTINCT TITULO_DEL_EMPLEADO FROM temporal WHERE TITULO_DEL_EMPLEADO IS NOT NULL ;
INSERT INTO SINTOMA_PACIENTE (SINTOMA)  SELECT DISTINCT SINTOMA_DEL_PACIENTE FROM temporal WHERE SINTOMA_DEL_PACIENTE IS NOT NULL;
INSERT INTO TRATAMIENTO_APLICADO (TRATAMIENTO,FECHA_TRATAMIENTO)  SELECT DISTINCT TRATAMIENTO_APLICADO,FECHA_TRATAMIENTO FROM temporal;
INSERT INTO DIAGNOSICO_SINTOMA (DIAGNOSTICO,RANGO_DIAGNOSTICO)  SELECT DISTINCT DIAGNOSTICO_DEL_SINTOMA,RANGO_DEL_DIAGNOSTICO FROM temporal WHERE RANGO_DEL_DIAGNOSTICO IS NOT NULL AND DIAGNOSTICO_DEL_SINTOMA IS NOT NULL ;

INSERT INTO EMPLEADO (NOMBRE_EMPLEADO, APELLIDO_EMPLEADO, TELEFONO_EMPLEADO, GENERO, FECHA_NACIMIENTO, TITULO_EMPLEADO, DIRECCION_EMPLEADO)
SELECT DISTINCT
                NOMBRE_EMPLEADO,
                APELLIDO_EMPLEADO,
                TELEFONO_EMPLEADO,
                (SELECT ID_GENERO FROM GENERO WHERE GENERO=GENERO_EMPLEADO),
                FECHA_NACIMIENTO_EMPLEADO,
                (SELECT ID_TITULO FROM TITULO_EMPLEADO WHERE TITULO=TITULO_DEL_EMPLEADO),
                DIRECCION_EMPLEADO
FROM TEMPORAL WHERE FECHA_NACIMIENTO_EMPLEADO IS NOT NULL ;

INSERT INTO PACIENTE (NOMBRE_PACIENTE, APELLIDO_PACIENTE, TELEFONO_PACIENTE, FECHA_NACIMIENTO, PESO, ALTURA, GENERO,DIRECCION_PACIENTE)
SELECT
    DISTINCT
    NOMBRE_PACIENTE,
    APELLIDO_PACIENTE,
    TELEFONO_PACIENTE,
    FECHA_NACIMIENTO_PACIENTE,
    PESO,
    ALTURA,
    (SELECT ID_GENERO FROM GENERO WHERE GENERO=GENERO_PACIENTE),
    DIRECCION_PACIENTE
FROM TEMPORAL WHERE NOMBRE_PACIENTE IS NOT NULL;

INSERT INTO EVALUACION(id_empleado, id_paciente, id_tratamiento_aplicado, id_diagnostico_sintoma, id_sintoma_paciente, fecha_evaluacion)
SELECT
       DISTINCT
    (SELECT ID_EMPLEADO FROM EMPLEADO E WHERE E.NOMBRE_EMPLEADO=TEMPORAL.NOMBRE_EMPLEADO AND E.APELLIDO_EMPLEADO=TEMPORAL.APELLIDO_EMPLEADO ),
    (SELECT ID_PACIENTE FROM PACIENTE P WHERE P.NOMBRE_PACIENTE=TEMPORAL.NOMBRE_PACIENTE AND P.APELLIDO_PACIENTE=TEMPORAL.APELLIDO_PACIENTE),
    (SELECT ID_TRATAMIENTO FROM TRATAMIENTO_APLICADO T WHERE TEMPORAL.TRATAMIENTO_APLICADO = T.TRATAMIENTO and TEMPORAL.FECHA_TRATAMIENTO = T.FECHA_TRATAMIENTO),
    (SELECT ID_DIAGNOSTICO FROM DIAGNOSICO_SINTOMA D WHERE TEMPORAL.DIAGNOSTICO_DEL_SINTOMA = D.DIAGNOSTICO AND TEMPORAL.RANGO_DEL_DIAGNOSTICO=D.RANGO_DIAGNOSTICO),
    (SELECT ID_SINTOMA FROM SINTOMA_PACIENTE S WHERE TEMPORAL.SINTOMA_DEL_PACIENTE = S.SINTOMA ),
    FECHA_EVALUACION
FROM TEMPORAL  ;



select * from TITULO_EMPLEADO;
select * from SINTOMA_PACIENTE;
select * from TRATAMIENTO_APLICADO;
select * from DIAGNOSICO_SINTOMA;
select *from EMPLEADO;
select * from PACIENTE;
select * from EVALUACION;
select * FROM GENERO;

-- Mostrar  el  nombre,  apellido  y  teléfono  de  todos  los  empleados  y  la  cantidad de pacientes atendidos por cada empleado ordenados de mayor a menor

SELECT COUNT(DISTINCT ID_PACIENTE),ID_EMPLEADO FROM EVALUACION  group by 1 ,ID_EMPLEADO;

SELECT EMPLEADO.NOMBRE_EMPLEADO,EMPLEADO.APELLIDO_EMPLEADO,EMPLEADO.TELEFONO_EMPLEADO, COUNT(DISTINCT ID_PACIENTE)AS CANTIDAD_ATENDIDOS FROM EVALUACION,EMPLEADO
WHERE EVALUACION.ID_EMPLEADO=EMPLEADO.ID_EMPLEADO
GROUP BY EMPLEADO.NOMBRE_EMPLEADO ,4 ,EMPLEADO.APELLIDO_EMPLEADO,EMPLEADO.TELEFONO_EMPLEADO
ORDER BY 4 DESC ;

-- Mostrar el nombre, apellido, dirección y título de todos los empleados de sexo masculino que atendieron a más de 3 pacientes en el año 2016.

SELECT EMPLEADO.NOMBRE_EMPLEADO,EMPLEADO.APELLIDO_EMPLEADO,EMPLEADO.DIRECCION_EMPLEADO,TITULO_EMPLEADO.TITULO ,COUNT(DISTINCT EVALUACION.ID_PACIENTE)AS CANTIDAD_ATENDIDOS FROM EMPLEADO,EVALUACION,TITULO_EMPLEADO
WHERE EVALUACION.ID_EMPLEADO=EMPLEADO.ID_EMPLEADO AND to_char(FECHA_EVALUACION,'YYYY') = 2016 AND EMPLEADO.GENERO='1' AND EMPLEADO.TITULO_EMPLEADO=TITULO_EMPLEADO.ID_TITULO
    GROUP BY EMPLEADO.NOMBRE_EMPLEADO,EMPLEADO.APELLIDO_EMPLEADO,TITULO_EMPLEADO.TITULO,4,EMPLEADO.DIRECCION_EMPLEADO
HAVING COUNT(DISTINCT EVALUACION.ID_PACIENTE)>3;

-- Mostrar el nombre y apellido de todos los pacientes que se están aplicando el tratamiento “Tabaco en polvo” y que tuvieron el síntoma “Dolor de cabeza”
SELECT PACIENTE.NOMBRE_PACIENTE,PACIENTE.APELLIDO_PACIENTE FROM PACIENTE,TRATAMIENTO_APLICADO,SINTOMA_PACIENTE,EVALUACION
WHERE EVALUACION.ID_PACIENTE=PACIENTE.ID_PACIENTE
  AND EVALUACION.ID_TRATAMIENTO_APLICADO=TRATAMIENTO_APLICADO.ID_TRATAMIENTO
  AND TRATAMIENTO_APLICADO.TRATAMIENTO='Tabaco en polvo'
  AND EVALUACION.ID_SINTOMA_PACIENTE=SINTOMA_PACIENTE.ID_SINTOMA
  AND SINTOMA_PACIENTE.SINTOMA='Dolor de cabeza'
GROUP BY PACIENTE.NOMBRE_PACIENTE,PACIENTE.APELLIDO_PACIENTE;

-- Top  5  de  pacientes  que más  tratamientos  se  han  aplicado  del  tratamiento “Antidepresivos”.Mostrar nombre, apellido y la cantidad de tratamientos.
SELECT * FROM (
SELECT PACIENTE.NOMBRE_PACIENTE,PACIENTE.APELLIDO_PACIENTE,COUNT(DISTINCT EVALUACION.ID_TRATAMIENTO_APLICADO)AS CANTIDAD_TRATAMIENTOS FROM PACIENTE,TRATAMIENTO_APLICADO,EVALUACION
WHERE  EVALUACION.ID_PACIENTE=PACIENTE.ID_PACIENTE
  AND EVALUACION.ID_TRATAMIENTO_APLICADO=TRATAMIENTO_APLICADO.ID_TRATAMIENTO
  AND TRATAMIENTO_APLICADO.TRATAMIENTO='Antidepresivos'
GROUP BY PACIENTE.NOMBRE_PACIENTE,PACIENTE.APELLIDO_PACIENTE
ORDER BY 3 DESC) WHERE ROWNUM <= 5;

-- Mostrar el nombre, apellido y dirección de todos los pacientes que se hayan aplicado   más   de   3   tratamientos   y   no
-- hayan   sido   atendidos por   un empleado.Debe  mostrar  la  cantidad  de  tratamientos  que  se  aplicó  el paciente.
-- Ordenar los resultados de mayor a menor utilizando la cantidad de tratamientos
SELECT PACIENTE.NOMBRE_PACIENTE,PACIENTE.APELLIDO_PACIENTE,PACIENTE.DIRECCION_PACIENTE,COUNT(DISTINCT EVALUACION.ID_TRATAMIENTO_APLICADO)AS CANTIDAD_TRATAMIENTOS FROM PACIENTE,TRATAMIENTO_APLICADO,EVALUACION
WHERE  EVALUACION.ID_PACIENTE=PACIENTE.ID_PACIENTE
  AND EVALUACION.ID_TRATAMIENTO_APLICADO=TRATAMIENTO_APLICADO.ID_TRATAMIENTO
  AND EVALUACION.ID_EMPLEADO is null
GROUP BY PACIENTE.NOMBRE_PACIENTE,PACIENTE.APELLIDO_PACIENTE,PACIENTE.DIRECCION_PACIENTE
HAVING COUNT(DISTINCT EVALUACION.ID_TRATAMIENTO_APLICADO)>3
ORDER BY 3 DESC;

-- Mostrar el nombre del diagnóstico y la cantidad de síntomas a los que ha sido asignado  donde  el  rango  ha  sido  de  9.
-- Ordene  sus  resultados  de  mayor  a menor en base a la cantidad de síntomas
SELECT DIAGNOSICO_SINTOMA.DIAGNOSTICO, COUNT(DISTINCT SINTOMA_PACIENTE.SINTOMA)AS CANTIDAD_SINTOMAS FROM DIAGNOSICO_SINTOMA,EVALUACION,SINTOMA_PACIENTE
WHERE EVALUACION.ID_DIAGNOSTICO_SINTOMA=DIAGNOSICO_SINTOMA.ID_DIAGNOSTICO
  AND DIAGNOSICO_SINTOMA.RANGO_DIAGNOSTICO='9'
  AND EVALUACION.ID_SINTOMA_PACIENTE=SINTOMA_PACIENTE.ID_SINTOMA
GROUP BY  DIAGNOSICO_SINTOMA.DIAGNOSTICO
ORDER BY 2 DESC;

-- Mostrar   el   nombre,   apellido   y   dirección   de   todos   los   pacientes   que presentaron  un  síntoma
-- que  al  que  le  fue  asignado  un  diagnóstico  con  un rango  mayor  a  5.Debe  mostrar  los  resultados  en
-- orden  alfabético  tomando en cuenta el nombre y apellido del paciente
SELECT PACIENTE.NOMBRE_PACIENTE,PACIENTE.APELLIDO_PACIENTE,PACIENTE.DIRECCION_PACIENTE FROM PACIENTE,EVALUACION,DIAGNOSICO_SINTOMA
WHERE  EVALUACION.ID_PACIENTE=PACIENTE.ID_PACIENTE
  AND EVALUACION.ID_DIAGNOSTICO_SINTOMA=DIAGNOSICO_SINTOMA.ID_DIAGNOSTICO
  AND DIAGNOSICO_SINTOMA.RANGO_DIAGNOSTICO>'5'
GROUP BY PACIENTE.NOMBRE_PACIENTE,PACIENTE.APELLIDO_PACIENTE,PACIENTE.DIRECCION_PACIENTE
ORDER BY 1 ,2 ;

-- Mostrar el nombre, apellido y fecha de nacimiento de todos los empleados de sexo  femenino  cuya  dirección
-- es  “1475  Dryden  Crossing”  y  hayan  atendido por lo  menos  a  2  pacientes.Mostrar  la  cantidad  de
-- pacientes  atendidos  por el empleado y ordénelos de mayor a menor
SELECT EMPLEADO.NOMBRE_EMPLEADO,EMPLEADO.APELLIDO_EMPLEADO ,EMPLEADO.FECHA_NACIMIENTO,COUNT(DISTINCT EVALUACION.ID_PACIENTE)AS CANTIDAD_ATENDIDOS FROM EMPLEADO,EVALUACION,TITULO_EMPLEADO
WHERE EVALUACION.ID_EMPLEADO=EMPLEADO.ID_EMPLEADO
  AND EMPLEADO.DIRECCION_EMPLEADO='1475 Dryden Crossing'
GROUP BY EMPLEADO.NOMBRE_EMPLEADO,EMPLEADO.APELLIDO_EMPLEADO,4,EMPLEADO.FECHA_NACIMIENTO
HAVING COUNT(DISTINCT EVALUACION.ID_TRATAMIENTO_APLICADO)>=2;



SELECT NOMBRE_EMPLEADO,APELLIDO_EMPLEADO,TELEFONO_EMPLEADO,COUNT(DISTINCT NOMBRE_PACIENTE) FROM TEMPORAL
GROUP BY NOMBRE_EMPLEADO,APELLIDO_EMPLEADO,TELEFONO_EMPLEADO ORDER BY 4 DESC ;

SELECT NOMBRE_EMPLEADO,TITULO_DEL_EMPLEADO,COUNT(DISTINCT NOMBRE_PACIENTE) FROM TEMPORAL
WHERE to_char(FECHA_EVALUACION,'YYYY') = 2016 AND GENERO_EMPLEADO='M'
GROUP BY NOMBRE_EMPLEADO,TITULO_DEL_EMPLEADO HAVING COUNT(DISTINCT NOMBRE_PACIENTE)>3;

