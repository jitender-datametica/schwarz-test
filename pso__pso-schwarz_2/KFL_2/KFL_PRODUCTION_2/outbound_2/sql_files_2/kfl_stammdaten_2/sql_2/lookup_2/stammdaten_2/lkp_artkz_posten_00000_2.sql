--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    posten_id
FROM dbp_data.artkz_posten_2
ORDER BY
    mandant_id NULLS LAST,
    posten_id NULLS LAST;
