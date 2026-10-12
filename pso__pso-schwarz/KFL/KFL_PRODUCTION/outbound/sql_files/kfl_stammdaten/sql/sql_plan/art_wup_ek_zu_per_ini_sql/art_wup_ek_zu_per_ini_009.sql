--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO KFL_PRODUCTION.${DWH_COMMON_DBX_LOAD}.art_wup_ek_datum_relevant (dat_relevant,
--                                                 dat_ausstieg,
--                                                 rueckbewertung_fg)
--SELECT DATE AS dat_relevant,
--       DATE AS dat_ausstieg,
--       0 AS rueckbewertung_fg;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


INSERT INTO dbp_etl.art_wup_ek_datum_relevant (
    dat_relevant, dat_ausstieg, rueckbewertung_fg
)
(
    SELECT
        CURRENT_DATE("Europe/Berlin") AS dat_relevant,
        CURRENT_DATE("Europe/Berlin") AS dat_ausstieg,
        0 AS rueckbewertung_fg
);
