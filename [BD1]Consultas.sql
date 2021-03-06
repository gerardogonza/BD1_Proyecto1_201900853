-- Mostrar  el  nombre,  apellido  y  teléfono  de  todos  los  empleados  y  la  cantidad de pacientes atendidos por cada empleado ordenados de mayor a menor
-- CONSULTA 1
SELECT EMPLEADO.NOMBRE_EMPLEADO,EMPLEADO.APELLIDO_EMPLEADO,EMPLEADO.TELEFONO_EMPLEADO, COUNT(DISTINCT ID_PACIENTE)AS CANTIDAD_ATENDIDOS FROM EVALUACION,EMPLEADO
WHERE EVALUACION.ID_EMPLEADO=EMPLEADO.ID_EMPLEADO
GROUP BY EMPLEADO.NOMBRE_EMPLEADO ,4 ,EMPLEADO.APELLIDO_EMPLEADO,EMPLEADO.TELEFONO_EMPLEADO
HAVING COUNT(DISTINCT ID_PACIENTE)>=1
ORDER BY 4 DESC ;

-- Mostrar el nombre, apellido, dirección y título de todos los empleados de sexo masculino que atendieron a más de 3 pacientes en el año 2016.
-- CONSULTA 2

SELECT EMPLEADO.NOMBRE_EMPLEADO,EMPLEADO.APELLIDO_EMPLEADO,EMPLEADO.DIRECCION_EMPLEADO,TITULO_EMPLEADO.TITULO ,COUNT(DISTINCT EVALUACION.ID_PACIENTE)AS CANTIDAD_ATENDIDOS FROM EMPLEADO,EVALUACION,TITULO_EMPLEADO
WHERE EVALUACION.ID_EMPLEADO=EMPLEADO.ID_EMPLEADO
  AND to_char(FECHA_EVALUACION,'YYYY') = 2016
  AND EMPLEADO.GENERO='1'
  AND EMPLEADO.TITULO_EMPLEADO=TITULO_EMPLEADO.ID_TITULO
GROUP BY EMPLEADO.NOMBRE_EMPLEADO,EMPLEADO.APELLIDO_EMPLEADO,TITULO_EMPLEADO.TITULO,5,EMPLEADO.DIRECCION_EMPLEADO
HAVING COUNT(DISTINCT EVALUACION.ID_PACIENTE)>3;

-- Mostrar el nombre y apellido de todos los pacientes que se están aplicando el tratamiento “Tabaco en polvo” y que tuvieron el síntoma “Dolor de cabeza”
-- CONSULTA 3
SELECT PACIENTE.NOMBRE_PACIENTE,PACIENTE.APELLIDO_PACIENTE FROM PACIENTE,TRATAMIENTO_APLICADO,SINTOMA_PACIENTE,EVALUACION
WHERE EVALUACION.ID_PACIENTE=PACIENTE.ID_PACIENTE
  AND EVALUACION.ID_TRATAMIENTO_APLICADO=TRATAMIENTO_APLICADO.ID_TRATAMIENTO
  AND TRATAMIENTO_APLICADO.TRATAMIENTO='Tabaco en polvo'
  AND EVALUACION.ID_SINTOMA_PACIENTE=SINTOMA_PACIENTE.ID_SINTOMA
  AND SINTOMA_PACIENTE.SINTOMA='Dolor de cabeza'
GROUP BY PACIENTE.NOMBRE_PACIENTE,PACIENTE.APELLIDO_PACIENTE;

-- Top  5  de  pacientes  que más  tratamientos  se  han  aplicado  del  tratamiento “Antidepresivos”.Mostrar nombre, apellido y la cantidad de tratamientos.
-- CONSULTA 4

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
-- CONSULTA 5

SELECT PACIENTE.NOMBRE_PACIENTE,PACIENTE.APELLIDO_PACIENTE,PACIENTE.DIRECCION_PACIENTE,COUNT(DISTINCT EVALUACION.ID_TRATAMIENTO_APLICADO)AS CANTIDAD_TRATAMIENTOS FROM PACIENTE,TRATAMIENTO_APLICADO,EVALUACION
WHERE  EVALUACION.ID_PACIENTE=PACIENTE.ID_PACIENTE
  AND EVALUACION.ID_TRATAMIENTO_APLICADO=TRATAMIENTO_APLICADO.ID_TRATAMIENTO
  AND EVALUACION.ID_EMPLEADO is null
GROUP BY PACIENTE.NOMBRE_PACIENTE,PACIENTE.APELLIDO_PACIENTE,PACIENTE.DIRECCION_PACIENTE
HAVING COUNT(DISTINCT EVALUACION.ID_TRATAMIENTO_APLICADO)>3
ORDER BY 3 DESC;

-- Mostrar el nombre del diagnóstico y la cantidad de síntomas a los que ha sido asignado  donde  el  rango  ha  sido  de  9.
-- Ordene  sus  resultados  de  mayor  a menor en base a la cantidad de síntomas
-- CONSULTA 6

SELECT DIAGNOSICO_SINTOMA.DIAGNOSTICO, COUNT(DISTINCT SINTOMA_PACIENTE.SINTOMA)AS CANTIDAD_SINTOMAS FROM DIAGNOSICO_SINTOMA,EVALUACION,SINTOMA_PACIENTE
WHERE EVALUACION.ID_DIAGNOSTICO_SINTOMA=DIAGNOSICO_SINTOMA.ID_DIAGNOSTICO
  AND DIAGNOSICO_SINTOMA.RANGO_DIAGNOSTICO='9'
  AND EVALUACION.ID_SINTOMA_PACIENTE=SINTOMA_PACIENTE.ID_SINTOMA
GROUP BY  DIAGNOSICO_SINTOMA.DIAGNOSTICO
ORDER BY 2 DESC;

-- Mostrar   el   nombre,   apellido   y   dirección   de   todos   los   pacientes   que presentaron  un  síntoma
-- que  al  que  le  fue  asignado  un  diagnóstico  con  un rango  mayor  a  5.Debe  mostrar  los  resultados  en
-- orden  alfabético  tomando en cuenta el nombre y apellido del paciente
-- CONSULTA 7

SELECT PACIENTE.NOMBRE_PACIENTE,PACIENTE.APELLIDO_PACIENTE,PACIENTE.DIRECCION_PACIENTE FROM PACIENTE,EVALUACION,DIAGNOSICO_SINTOMA
WHERE  EVALUACION.ID_PACIENTE=PACIENTE.ID_PACIENTE
  AND EVALUACION.ID_DIAGNOSTICO_SINTOMA=DIAGNOSICO_SINTOMA.ID_DIAGNOSTICO
  AND DIAGNOSICO_SINTOMA.RANGO_DIAGNOSTICO>'5'
GROUP BY PACIENTE.NOMBRE_PACIENTE,PACIENTE.APELLIDO_PACIENTE,PACIENTE.DIRECCION_PACIENTE
ORDER BY 1 ,2 ;

-- Mostrar el nombre, apellido y fecha de nacimiento de todos los empleados de sexo  femenino  cuya  dirección
-- es  “1475  Dryden  Crossing”  y  hayan  atendido por lo  menos  a  2  pacientes.Mostrar  la  cantidad  de
-- pacientes  atendidos  por el empleado y ordénelos de mayor a menor
-- CONSULTA 8

SELECT EMPLEADO.NOMBRE_EMPLEADO,EMPLEADO.APELLIDO_EMPLEADO ,EMPLEADO.FECHA_NACIMIENTO,COUNT(DISTINCT EVALUACION.ID_PACIENTE)AS CANTIDAD_ATENDIDOS FROM EMPLEADO,EVALUACION,TITULO_EMPLEADO
WHERE EVALUACION.ID_EMPLEADO=EMPLEADO.ID_EMPLEADO
  AND EMPLEADO.DIRECCION_EMPLEADO='1475 Dryden Crossing'
GROUP BY EMPLEADO.NOMBRE_EMPLEADO,EMPLEADO.APELLIDO_EMPLEADO,4,EMPLEADO.FECHA_NACIMIENTO
HAVING COUNT(DISTINCT EVALUACION.ID_TRATAMIENTO_APLICADO)>=2;

-- Mostrar  el  porcentaje  de  pacientes  que  ha  atendido  cada  empleado  a  partir del año 2017 y
-- mostrarlos de mayor a menor en base al porcentaje calculado
-- CONSULTA 9


WITH TOTAl AS (
    SELECT SUM(SUMAPACIENTE) AS SUMATOTAL
    FROM (
             SELECT COUNT(DISTINCT ID_PACIENTE) AS SUMAPACIENTE
             FROM EVALUACION,
                  EMPLEADO
             WHERE EMPLEADO.ID_EMPLEADO = EVALUACION.ID_EMPLEADO
             GROUP BY  EMPLEADO.ID_EMPLEADO
         )
)
SELECT NOMBRE_EMPLEADO,APELLIDO_EMPLEADO,TELEFONO_EMPLEADO, CAST(COUNT(DISTINCT ID_PACIENTE)*100 /SUMATOTAL AS decimal(10,2)) AS Porcentaje  FROM EMPLEADO,EVALUACION,TOTAl
WHERE EVALUACION.ID_EMPLEADO=EMPLEADO.ID_EMPLEADO
  AND to_char(FECHA_EVALUACION,'YYYY') >= 2017
GROUP BY  NOMBRE_EMPLEADO,APELLIDO_EMPLEADO,TELEFONO_EMPLEADO,SUMATOTAL
ORDER BY 4 DESC;

-- Mostrar  el  porcentaje  del  título  de  empleado  más  común  de  la  siguiente manera:   nombre   del   título,
-- porcentaje   de   empleados   que   tienen   ese título.Debe ordenar los resultados en base al porcentaje de mayor a meno
-- CONSULTA 10

WITH TOTAl AS (
    SELECT SUM(JEJE) AS SUMATOTAL
    FROM (
             SELECT COUNT(EMPLEADO.TITULO_EMPLEADO) AS JEJE
             FROM EMPLEADO,
                  TITULO_EMPLEADO
             WHERE EMPLEADO.TITULO_EMPLEADO = TITULO_EMPLEADO.ID_TITULO
             GROUP BY TITULO_EMPLEADO.TITULO
         )
)
    SELECT TITULO_EMPLEADO.TITULO,CAST(COUNT( EMPLEADO.TITULO_EMPLEADO )*100/SUMATOTAL AS DECIMAL(10,1)) AS PORCENTAJE FROM EMPLEADO,TITULO_EMPLEADO,TOTAl
    WHERE EMPLEADO.TITULO_EMPLEADO=TITULO_EMPLEADO.ID_TITULO
    GROUP BY TITULO_EMPLEADO.TITULO,SUMATOTAL
    ORDER BY 2 DESC;

-- Mostrar  el  año  y  mes  (de  la  fecha de  evaluación)  junto  con  el  nombre  y apellido  de  los  pacientes  que
-- más  tratamientos  se  han  aplicado  y  los  que
-- menos.  (Todo  en  una  sola  consulta).Nota: debe  tomar  como  cantidad mínima 1 tratamiento.
-- CONSULTA 11

WITH TOTAl AS (
    SELECT to_char(FECHA_EVALUACION, 'YYYY') AS ANIO ,TO_CHAR(FECHA_EVALUACION,'MM')  AS MES,PACIENTE.NOMBRE_PACIENTE,PACIENTE.APELLIDO_PACIENTE, COUNT(DISTINCT TRATAMIENTO_APLICADO.ID_TRATAMIENTO) AS TRATAMIENTOS  FROM EVALUACION,PACIENTE,TRATAMIENTO_APLICADO
    WHERE  EVALUACION.ID_PACIENTE=PACIENTE.ID_PACIENTE
      AND TRATAMIENTO_APLICADO.ID_TRATAMIENTO=EVALUACION.ID_TRATAMIENTO_APLICADO
    GROUP BY to_char(FECHA_EVALUACION, 'YYYY'),TO_CHAR(FECHA_EVALUACION,'MM'),PACIENTE.NOMBRE_PACIENTE,PACIENTE.APELLIDO_PACIENTE
)SELECT * FROM TOTAl
WHERE TRATAMIENTOS=(SELECT MAX(TRATAMIENTOS) FROM TOTAl)
OR TRATAMIENTOS=(SELECT MIN(TRATAMIENTOS) FROM TOTAl)
AND TRATAMIENTOS>=1
ORDER BY TRATAMIENTOS DESC;