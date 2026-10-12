DROP TABLE IF EXISTS dbp_etl.bon_agg_kassenberichte_tmp;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.

--Comment from validation checker
--MESSAGE: SQL compilation error:


CREATE TABLE IF NOT EXISTS dbp_etl.bon_agg_kassenberichte_tmp (
    bon_id STRING(25) NOT NULL,
    bon_dat DATE NOT NULL,
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    kassensystem_name STRING(10),
    kasse_nr INTEGER NOT NULL,
    xml_name STRING(255)
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:


INSERT INTO dbp_etl.bon_agg_kassenberichte_tmp (
    bon_id, bon_dat, wup_id, mandant_id, kassensystem_name,
    kasse_nr, xml_name
)
(
    SELECT
        bon_id,
        bon_dat,
        wup_id,
        mandant_id,
        kassensystem_name,
        kasse_nr,
        datei_name AS xml_name
    FROM dbp_ods.ods_bon_transaction AS T2
    WHERE
        bon_dat BETWEEN DATE_SUB(
            CURRENT_DATE("Europe/Berlin"), INTERVAL 14 DAY
        ) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
);
