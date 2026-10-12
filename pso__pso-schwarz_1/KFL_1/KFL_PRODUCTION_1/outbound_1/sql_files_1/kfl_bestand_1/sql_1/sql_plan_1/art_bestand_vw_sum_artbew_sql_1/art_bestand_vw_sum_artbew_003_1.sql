--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.art_bestand_vw_sum_artbew_dat_1 (
    mandant_id INTEGER NOT NULL,
    dat DATE
);
