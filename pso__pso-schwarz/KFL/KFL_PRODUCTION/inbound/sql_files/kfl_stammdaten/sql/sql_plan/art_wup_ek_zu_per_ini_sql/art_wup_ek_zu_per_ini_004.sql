--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE ${DWH_COMMON_DBX_LOAD}.art_wup_ek_datum_relevant ,NO FALLBACK ,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--   dat_relevant DATE FORMAT 'YYYYMMDD' NOT NULL,
--   dat_ausstieg DATE FORMAT 'YYYYMMDD' NOT NULL,
--   rueckbewertung_fg BYTEINT NOT NULL
--)
--PRIMARY INDEX NUPI_art_wup_ek_datum_relevant (dat_relevant);
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.art_wup_ek_datum_relevant  (
   dat_relevant DATE NOT NULL,
   dat_ausstieg DATE NOT NULL,
   rueckbewertung_fg BYTEINT NOT NULL
)
;

