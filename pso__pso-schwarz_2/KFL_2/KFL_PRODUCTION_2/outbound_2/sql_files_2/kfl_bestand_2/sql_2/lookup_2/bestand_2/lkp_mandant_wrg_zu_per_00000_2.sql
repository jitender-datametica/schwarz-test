SELECT
    mandant_id,
    von_wrg_id,
    wrg_id,
    dat_von,
    dat_bis,
    umrechnungskurs
FROM dbp_data.mandant_wrg_zu_per_2
GROUP BY
    mandant_id,
    wrg_id,
    dat_von,
    dat_bis,
    von_wrg_id,
    umrechnungskurs
ORDER BY
    1 NULLS LAST,
    4 NULLS LAST,
    5 NULLS LAST;
