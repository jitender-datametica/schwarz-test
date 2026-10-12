--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    art_id,
    wg_id
FROM dbp_data.art_wg_zu_per
WHERE
    arthiertyp_id = 2
    AND dat_bis = PARSE_DATE('%F', '9999-12-31');
