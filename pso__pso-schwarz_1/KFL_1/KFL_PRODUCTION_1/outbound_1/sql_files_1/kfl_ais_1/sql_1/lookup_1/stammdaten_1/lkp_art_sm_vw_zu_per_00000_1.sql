--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    art_id,
    vw_id,
    sm_id
FROM dbp_data.art_sm_vw_zu_per_1
WHERE
    dat_bis = (
        SELECT MAX(dat_bis)
        FROM dbp_data.art_sm_vw_zu_per_1
    )
ORDER BY
    1 NULLS LAST,
    2 NULLS LAST,
    3 NULLS LAST,
    4 NULLS LAST;
