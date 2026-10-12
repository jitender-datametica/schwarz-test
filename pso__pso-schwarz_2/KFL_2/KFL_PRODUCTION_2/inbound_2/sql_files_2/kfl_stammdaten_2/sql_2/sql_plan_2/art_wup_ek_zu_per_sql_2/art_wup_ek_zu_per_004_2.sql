--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp_2 ,NO FALLBACK ,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--   mandant_id BYTEINT NOT NULL
--  ,wup_id INTEGER
--  ,nb_id SMALLINT
--  ,bezugsweg_id BYTEINT
--  ,art_id INTEGER
--  ,gp_id INTEGER
--  ,einkaufsorganisation_id SMALLINT
--  ,dat DATE FORMAT 'YYYYMMDD' NOT NULL
--  ,verarbeitet_fg BYTEINT
--)
--PRIMARY INDEX NUPI_art_wup_gp_tmp (art_id ,wup_id );
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.art_wup_gp_tmp_2  (
   mandant_id BYTEINT NOT NULL
  ,wup_id INTEGER
  ,nb_id SMALLINT
  ,bezugsweg_id BYTEINT
  ,art_id INTEGER
  ,gp_id INTEGER
  ,einkaufsorganisation_id SMALLINT
  ,dat DATE NOT NULL
  ,verarbeitet_fg BYTEINT
)
;

