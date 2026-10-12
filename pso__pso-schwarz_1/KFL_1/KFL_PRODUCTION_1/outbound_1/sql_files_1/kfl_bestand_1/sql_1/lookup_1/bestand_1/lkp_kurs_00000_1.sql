SELECT
    kurstyp_id,
    von_wrg_id,
    nach_wrg_id,
    dat_von,
    dat_bis,
    umrechnungskurs
FROM dbp_data.kurs_1
GROUP BY
    kurstyp_id,
    von_wrg_id,
    dat_von,
    dat_bis,
    umrechnungskurs,
    nach_wrg_id
ORDER BY
    1 NULLS LAST,
    2 NULLS LAST,
    3 NULLS LAST,
    4 NULLS LAST,
    5 NULLS LAST;
