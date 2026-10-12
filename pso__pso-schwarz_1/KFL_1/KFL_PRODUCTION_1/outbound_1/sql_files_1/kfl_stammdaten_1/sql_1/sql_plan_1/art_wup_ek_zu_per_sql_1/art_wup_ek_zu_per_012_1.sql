--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--SELECT COUNT(*) FROM (
--
----begin subquery
--SELECT *
--FROM KFL_PRODUCTION.${DWH_COMMON_DBX_LOAD}.art_wup_ek_datum_relevant_1
--WHERE rueckbewertung_fg = 1
----end subquery
--
--);
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement


SELECT COUNT(*)
FROM dbp_etl.art_wup_ek_datum_relevant_1
WHERE rueckbewertung_fg = 1;
