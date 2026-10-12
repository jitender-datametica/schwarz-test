--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    display_id
FROM dbp_data.artkz_display_1
ORDER BY
    mandant_id NULLS LAST,
    display_id NULLS LAST;
