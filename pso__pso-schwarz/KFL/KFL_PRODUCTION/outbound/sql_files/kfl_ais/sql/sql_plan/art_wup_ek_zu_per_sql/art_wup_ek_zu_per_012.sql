--[OK] statement is translated correctly (syntax and type checks are fine)


-- begin subquery
SELECT COUNT(*)
FROM dbp_etl.art_wup_ek_datum_relevant
WHERE rueckbewertung_fg = 1; -- end subquery
