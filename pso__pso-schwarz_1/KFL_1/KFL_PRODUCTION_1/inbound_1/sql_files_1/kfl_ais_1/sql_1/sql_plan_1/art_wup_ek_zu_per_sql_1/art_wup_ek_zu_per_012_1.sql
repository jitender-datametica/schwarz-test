--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT COUNT(*) FROM (

--begin subquery
SELECT *
FROM DBP_ETL.art_wup_ek_datum_relevant_1
WHERE rueckbewertung_fg = 1
--end subquery

);

