SELECT
    mandant_id,
    dat_von,
    dat_bis,
    von_wrg_id,
    wrg_id,
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
    2 NULLS LAST;
