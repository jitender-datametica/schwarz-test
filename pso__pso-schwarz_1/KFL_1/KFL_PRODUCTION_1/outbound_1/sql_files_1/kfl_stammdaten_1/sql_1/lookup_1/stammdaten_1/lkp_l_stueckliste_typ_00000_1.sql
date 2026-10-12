--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    stueckliste_typ_id
FROM dbp_data.l_stueckliste_typ_1
ORDER BY
    mandant_id NULLS LAST,
    stueckliste_typ_id NULLS LAST;
