--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    ek_infosatz_id
FROM dbp_data.ek_infosatz_1
ORDER BY
    mandant_id NULLS LAST,
    ek_infosatz_id NULLS LAST;
