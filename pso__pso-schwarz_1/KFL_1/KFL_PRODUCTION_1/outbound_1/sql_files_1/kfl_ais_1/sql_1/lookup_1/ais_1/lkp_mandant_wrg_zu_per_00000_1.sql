SELECT
    mandant_id,
    von_wrg_id,
    wrg_id,
    umrechnungskurs,
    dat_von,
    dat_bis
FROM dbp_data.mandant_wrg_zu_per_1
WHERE von_wrg_id IS NOT NULL
GROUP BY
    mandant_id,
    wrg_id,
    dat_von,
    dat_bis,
    von_wrg_id,
    umrechnungskurs
ORDER BY
    1 NULLS LAST,
    2 NULLS LAST,
    5 NULLS LAST,
    6 NULLS LAST;
