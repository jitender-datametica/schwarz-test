--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.art_wup_gp_tmp_2 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER,
    nb_id INTEGER,
    bezugsweg_id INTEGER,
    art_id INTEGER,
    gp_id INTEGER,
    einkaufsorganisation_id INTEGER,
    dat DATE NOT NULL,
    verarbeitet_fg INTEGER
);
