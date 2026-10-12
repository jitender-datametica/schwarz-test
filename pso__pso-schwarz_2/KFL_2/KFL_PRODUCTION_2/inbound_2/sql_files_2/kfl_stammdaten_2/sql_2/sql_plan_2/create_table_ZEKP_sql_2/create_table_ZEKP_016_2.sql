--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--original statement
--CREATE SET TABLE ${DWH_COMMON_DBX_LOAD}.art_gp_zu_per_tmp_2
--,NO FALLBACK
--,NO BEFORE JOURNAL
--,NO AFTER JOURNAL
--(
--art_id          INTEGER NOT NULL
--,mandant_id     BYTEINT NOT NULL
--,gp_id          INTEGER NOT NULL
--,dat_von        DATE FORMAT 'YYYY-MM_2-DD'
--,herst_id       INTEGER
--,einkaufsorganisation_id SMALLINT NOT NULL
--,gp_art_id      VARCHAR(6) CHARACTER SET LATIN NOT CASESPECIFIC
--,mhd_zeitraum_dz SMALLINT
--,dat_bis        DATE FORMAT 'YYYY-MM_2-DD'
--)
--PRIMARY INDEX ( art_id )
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.art_gp_zu_per_tmp_2  (
art_id          INTEGER NOT NULL
,mandant_id     BYTEINT NOT NULL
,gp_id          INTEGER NOT NULL
,dat_von        DATE
,herst_id       INTEGER
,einkaufsorganisation_id SMALLINT NOT NULL
,gp_art_id      VARCHAR(6) COLLATE 'de-ci'
,mhd_zeitraum_dz SMALLINT
,dat_bis        DATE
)
;

