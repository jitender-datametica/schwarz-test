--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    leist_id
FROM dbp_data.artkz_leist_2
ORDER BY
    mandant_id NULLS LAST,
    leist_id NULLS LAST;
