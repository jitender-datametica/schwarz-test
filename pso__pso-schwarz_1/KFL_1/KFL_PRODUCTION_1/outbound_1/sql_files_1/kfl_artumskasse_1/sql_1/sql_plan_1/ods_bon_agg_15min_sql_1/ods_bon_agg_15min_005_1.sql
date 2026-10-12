--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.bon_agg_kassenberichte_1;


CREATE TABLE IF NOT EXISTS dbp_etl.bon_agg_kassenberichte_1 (
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    kassensystem_name STRING(10),
    kasse_nr INTEGER NOT NULL,
    bon_dat DATE NOT NULL
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO dbp_etl.bon_agg_kassenberichte_1 (
    wup_id, mandant_id, kassensystem_name, kasse_nr, bon_dat
)
(
    SELECT
        wup_id,
        mandant_id,
        kassensystem_name,
        kasse_nr,
        bon_dat
    FROM dbp_etl.bon_agg_kassenberichte_tmp_1 AS T1_1
    GROUP BY
        bon_dat,
        wup_id,
        mandant_id,
        kassensystem_name,
        kasse_nr
);
