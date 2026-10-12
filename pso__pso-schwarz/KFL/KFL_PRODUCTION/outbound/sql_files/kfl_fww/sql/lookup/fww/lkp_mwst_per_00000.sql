SELECT
    mandant_id,
    mwst_id,
    dat_von,
    dat_bis,
    mwst
FROM dbp_data.mwst_per
GROUP BY
    mwst_id,
    dat_von,
    mandant_id,
    mwst,
    dat_bis
ORDER BY
    1 NULLS LAST,
    2 NULLS LAST,
    3 NULLS LAST;
