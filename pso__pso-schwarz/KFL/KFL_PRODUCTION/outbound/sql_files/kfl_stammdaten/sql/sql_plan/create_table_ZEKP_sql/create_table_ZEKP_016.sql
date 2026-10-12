--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--original statement
--CREATE SET TABLE KFL_PRODUCTION.${DWH_COMMON_DBX_LOAD}.art_gp_zu_per_tmp
--,NO FALLBACK
--,NO BEFORE JOURNAL
--,NO AFTER JOURNAL
--(
--art_id          INTEGER NOT NULL
--,mandant_id     INTEGER NOT NULL
--,gp_id          INTEGER NOT NULL
--,dat_von        DATE FORMAT 'YYYY-MM-DD'
--,herst_id       INTEGER
--,einkaufsorganisation_id INTEGER NOT NULL
--,gp_art_id      STRING(6) CHARACTER SET LATIN NOT CASESPECIFIC
--,mhd_zeitraum_dz INTEGER
--,dat_bis        DATE FORMAT 'YYYY-MM-DD'
--)
--PRIMARY INDEX ( art_id )
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


CREATE TABLE IF NOT EXISTS dbp_etl.art_gp_zu_per_tmp (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    dat_von DATE,
    herst_id INTEGER,
    einkaufsorganisation_id INTEGER NOT NULL,
    gp_art_id STRING(6) COLLATE 'und:ci',
    mhd_zeitraum_dz INTEGER,
    dat_bis DATE
);
