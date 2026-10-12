--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.L_BACK_DREHKLASSE_TEMP' does not exist or not authorized.
DELETE FROM  DBP_DATA.l_back_drehklasse_1 t1_1
WHERE EXISTS (SELECT * FROM ${TEMP_TABLE} /*DBP_ETL.l_back_drehklasse_temp*/ t2
WHERE
     t1.mandant_id = t2.mandant_id
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.L_BACK_DREHKLASSE_TEMP' does not exist or not authorized.
INSERT INTO DBP_DATA.l_back_drehklasse_1
(
     mandant_id
    ,back_drehklasse_id
    ,menge_min
)
SELECT
     mandant_id
    ,back_drehklasse_id
    ,MIN(menge_min) AS menge_min
FROM ${TEMP_TABLE} /*DBP_ETL.l_back_drehklasse_temp*/
GROUP BY 1,2
;

