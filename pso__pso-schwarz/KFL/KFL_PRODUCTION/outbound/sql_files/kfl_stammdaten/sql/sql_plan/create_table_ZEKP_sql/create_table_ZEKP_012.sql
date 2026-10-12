--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--original statement
--CREATE SET TABLE KFL_PRODUCTION.${DWH_COMMON_DBX_LOAD}.art_muki_tmp
--,NO FALLBACK
--,NO BEFORE JOURNAL
--,NO AFTER JOURNAL
--(
--art_id   INTEGER NOT NULL
--,gp_id INTEGER
--,mutter_ek_id INTEGER
--)
--PRIMARY INDEX ( art_id )
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


CREATE TABLE IF NOT EXISTS dbp_etl.art_muki_tmp (
    art_id INTEGER NOT NULL,
    gp_id INTEGER,
    mutter_ek_id INTEGER
);
