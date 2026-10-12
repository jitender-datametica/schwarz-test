--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.L_BACK_DREHKLASSE_TEMP' does not exist or not authorized.


DELETE FROM dbp_data.l_back_drehklasse_2 AS T1_2
WHERE EXISTS (
    SELECT *
    FROM ${TEMP_TABLE} AS T2
    WHERE T1.mandant_id = mandant_id
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.L_BACK_DREHKLASSE_TEMP' does not exist or not authorized.


/* DBP_ETL.l_back_drehklasse_temp */ INSERT INTO dbp_data.l_back_drehklasse_2 (
    mandant_id,
    back_drehklasse_id, menge_min
)
(
    SELECT
        mandant_id,
        back_drehklasse_id,
        MIN(menge_min) AS menge_min
    FROM ${TEMP_TABLE}
    GROUP BY
        mandant_id,
        back_drehklasse_id
);
