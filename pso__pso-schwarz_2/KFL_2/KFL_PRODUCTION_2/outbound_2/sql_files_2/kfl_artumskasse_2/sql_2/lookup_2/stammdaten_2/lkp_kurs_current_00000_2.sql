--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    kurstyp_id,
    von_wrg_id,
    nach_wrg_id,
    dat_von,
    umrechnungskurs
FROM dbp_data.kurs_2
WHERE dat_bis = PARSE_DATE('%F', '9999-12-31')
ORDER BY
    1 NULLS LAST,
    2 NULLS LAST,
    3 NULLS LAST,
    4 NULLS LAST;
