--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.BAKE_FINAL_DE_1' does not exist or not authorized.


SELECT
    mandant_id,
    wup_id,
    nb_id,
    oventype,
    dat_von,
    dat_bis,
    anz_blech,
    anz_ofen,
    gp_backen_bez,
    ROW_NUMBER()
        OVER (PARTITION BY nb_id ORDER BY nb_id IS NULL, nb_id)
        AS zeile
FROM dbp_etl.bake_final_de_1
WHERE
    klart = 'Z30'
    AND mandant_id = 1;
