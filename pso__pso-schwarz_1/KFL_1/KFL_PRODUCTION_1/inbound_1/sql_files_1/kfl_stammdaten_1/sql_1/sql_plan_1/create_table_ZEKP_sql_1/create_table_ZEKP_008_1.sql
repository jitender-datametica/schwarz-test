--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--original statement
--CREATE SET TABLE ${DWH_COMMON_DBX_LOAD}.art_herst_tmp_1
--,NO FALLBACK
--,NO BEFORE JOURNAL
--,NO AFTER JOURNAL
--(
-- art_id         INTEGER NOT NULL
--,herst_id       INTEGER
--,mhd_zeitraum_dz SMALLINT
--,gp_art_id      VARCHAR(40) CHARACTER SET UNICODE NOT CASESPECIFIC
--)
--PRIMARY INDEX ( art_id )
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.art_herst_tmp_1  (
 art_id         INTEGER NOT NULL
,herst_id       INTEGER
,mhd_zeitraum_dz SMALLINT
,gp_art_id      VARCHAR(40) COLLATE 'de-ci'
)
;

