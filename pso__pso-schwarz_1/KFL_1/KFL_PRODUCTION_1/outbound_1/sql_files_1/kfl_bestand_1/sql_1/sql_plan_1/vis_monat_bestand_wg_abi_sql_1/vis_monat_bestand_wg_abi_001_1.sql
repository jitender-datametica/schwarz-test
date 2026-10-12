--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.VIS_MONAT_BESTAND_WG_LOG_1' does not exist or not authorized.


-- begin subquery
SELECT COUNT(*)
FROM (
    SELECT
        mandant_id,
        COUNT(*) AS anzsaetze,
        MIN(gjmo) AS min_gjmo
    FROM dbp_etl_process.vis_monat_bestand_wg_log_1
    GROUP BY mandant_id -- end subquery
) AS t;
