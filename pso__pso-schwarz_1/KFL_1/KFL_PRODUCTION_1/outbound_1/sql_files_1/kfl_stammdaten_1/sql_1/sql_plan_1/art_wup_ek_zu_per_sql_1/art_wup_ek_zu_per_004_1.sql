--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE KFL_PRODUCTION.${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp_1 ,NO FALLBACK ,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--   mandant_id INTEGER NOT NULL
--  ,wup_id INTEGER
--  ,nb_id INTEGER
--  ,bezugsweg_id INTEGER
--  ,art_id INTEGER
--  ,gp_id INTEGER
--  ,einkaufsorganisation_id INTEGER
--  ,dat DATE FORMAT 'YYYYMMDD' NOT NULL
--  ,verarbeitet_fg INTEGER
--)
--PRIMARY INDEX NUPI_art_wup_gp_tmp (art_id ,wup_id );
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement


CREATE TABLE IF NOT EXISTS dbp_etl.art_wup_gp_tmp_1 (
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
