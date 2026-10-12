--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.artbew_wg_wechsel_tmp_1;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--WARNING : UNIQUE PRIMARY INDEX applied on the table. Use PRIMARY KEY or UNIQUE constraint.


CREATE TABLE IF NOT EXISTS dbp_etl.artbew_wg_wechsel_tmp_1 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    arthiertyp_id INTEGER NOT NULL,
    alt_neu_kz INTEGER NOT NULL,
    wg_id INTEGER NOT NULL,
    wg_art_fg INTEGER
);
