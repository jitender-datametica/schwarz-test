--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    abschriftart_id
FROM dbp_data.l_abschriftart_2
WHERE mandant_id > 1
ORDER BY
    mandant_id NULLS LAST,
    abschriftart_id NULLS LAST;
