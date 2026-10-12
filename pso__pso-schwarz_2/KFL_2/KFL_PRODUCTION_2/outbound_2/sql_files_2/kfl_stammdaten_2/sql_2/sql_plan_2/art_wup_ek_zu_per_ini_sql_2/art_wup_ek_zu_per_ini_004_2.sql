--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE KFL_PRODUCTION.${DWH_COMMON_DBX_LOAD}.art_wup_ek_datum_relevant_2 ,NO FALLBACK ,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--   dat_relevant DATE FORMAT 'YYYYMMDD' NOT NULL,
--   dat_ausstieg DATE FORMAT 'YYYYMMDD' NOT NULL,
--   rueckbewertung_fg INTEGER NOT NULL
--)
--PRIMARY INDEX NUPI_art_wup_ek_datum_relevant (dat_relevant);
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


CREATE TABLE IF NOT EXISTS dbp_etl.art_wup_ek_datum_relevant_2 (
    dat_relevant DATE NOT NULL,
    dat_ausstieg DATE NOT NULL,
    rueckbewertung_fg INTEGER NOT NULL
);
