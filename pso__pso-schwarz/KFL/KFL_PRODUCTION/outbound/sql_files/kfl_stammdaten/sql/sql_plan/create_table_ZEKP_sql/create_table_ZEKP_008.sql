--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--original statement
--CREATE SET TABLE KFL_PRODUCTION.${DWH_COMMON_DBX_LOAD}.art_herst_tmp
--,NO FALLBACK
--,NO BEFORE JOURNAL
--,NO AFTER JOURNAL
--(
-- art_id         INTEGER NOT NULL
--,herst_id       INTEGER
--,mhd_zeitraum_dz INTEGER
--,gp_art_id      STRING(40) CHARACTER SET UNICODE NOT CASESPECIFIC
--)
--PRIMARY INDEX ( art_id )
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


CREATE TABLE IF NOT EXISTS dbp_etl.art_herst_tmp (
    art_id INTEGER NOT NULL,
    herst_id INTEGER,
    mhd_zeitraum_dz INTEGER,
    gp_art_id STRING(40) COLLATE 'und:ci'
);
