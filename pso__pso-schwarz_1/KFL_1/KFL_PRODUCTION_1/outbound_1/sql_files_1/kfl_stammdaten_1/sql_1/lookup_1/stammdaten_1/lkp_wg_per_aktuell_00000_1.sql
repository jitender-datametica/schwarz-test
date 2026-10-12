--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    wg_id
FROM dbp_data.wg_per_1
WHERE
    dat_bis = PARSE_DATE('%F', '9999-12-31')
    AND owg_id <> -1;
