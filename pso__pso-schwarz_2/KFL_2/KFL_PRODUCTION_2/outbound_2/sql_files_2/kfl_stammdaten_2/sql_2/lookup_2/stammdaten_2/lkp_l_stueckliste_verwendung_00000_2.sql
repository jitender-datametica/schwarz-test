--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    stueckliste_verwendung_id
FROM dbp_data.l_stueckliste_verwendung_2
ORDER BY
    mandant_id NULLS LAST,
    stueckliste_verwendung_id NULLS LAST;
