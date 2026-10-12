--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.


CREATE TABLE IF NOT EXISTS dbp_etl.mk_wupartcal_2 (
    mandant_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    art_id INTEGER,
    dat DATE,
    wtag_id INTEGER,
    aktion_fg INTEGER,
    saison_fg STRING(1) COLLATE 'und:ci'
);
