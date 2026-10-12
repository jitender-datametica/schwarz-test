--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    wg_id,
    wug_id,
    arthiertyp_id
FROM dbp_data.wug_2
ORDER BY
    mandant_id NULLS LAST,
    wg_id NULLS LAST,
    wug_id NULLS LAST,
    arthiertyp_id NULLS LAST;
