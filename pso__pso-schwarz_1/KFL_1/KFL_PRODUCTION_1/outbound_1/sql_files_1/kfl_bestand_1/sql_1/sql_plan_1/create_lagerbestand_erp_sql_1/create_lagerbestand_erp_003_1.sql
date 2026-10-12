--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.bestand_mardh_mard_vz_log_1 (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL,
    dat DATE NOT NULL
);
