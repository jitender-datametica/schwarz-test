--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.DE_MSEG_DELTA_2' does not exist or not authorized.


INSERT INTO dbp_etl.kmo_mseg_dat_2 (dat_buch, mandant_id)
(
    SELECT
        dat_buch,
        mandant_id
    FROM dbp_etl.de_mseg_delta_2
    WHERE
        mandant_id = 1
        AND (
            dat_buch, mandant_id) NOT IN (
            SELECT (dat_buch, mandant_id)
            FROM dbp_etl.kmo_mseg_dat_2
        )
    GROUP BY
        dat_buch,
        mandant_id
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.DE_MSEG_DELTA_2' does not exist or not authorized.


INSERT INTO dbp_etl.mseg_reichweite_2 (mandant_id, wup_id, nb_id, dat_buch)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat_buch
    FROM dbp_etl.de_mseg_delta_2
    WHERE
        mandant_id = 1
        AND (
            mandant_id, wup_id, nb_id, dat_buch) NOT IN (
            SELECT (mandant_id, wup_id, nb_id, dat_buch)
            FROM dbp_etl.mseg_reichweite_2
        )
    GROUP BY
        dat_buch,
        mandant_id,
        nb_id,
        wup_id
);
