--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.art_wup_ek_datum_relevant_2 (dat_relevant,
--                                                 dat_ausstieg,
--                                                 rueckbewertung_fg)
--SELECT DATE AS dat_relevant,
--       DATE AS dat_ausstieg,
--       0 AS rueckbewertung_fg;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
INSERT INTO DBP_ETL.art_wup_ek_datum_relevant_2 (dat_relevant,
                                                 dat_ausstieg,
                                                 rueckbewertung_fg)
SELECT CURRENT_DATE AS dat_relevant,
       CURRENT_DATE AS dat_ausstieg,
       0 AS rueckbewertung_fg;

