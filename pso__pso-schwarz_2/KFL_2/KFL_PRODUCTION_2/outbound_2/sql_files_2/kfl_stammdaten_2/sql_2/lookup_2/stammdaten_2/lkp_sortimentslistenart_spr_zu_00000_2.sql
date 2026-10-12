--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    spr_id,
    sortimentslistenart_id
FROM dbp_data.sortimentslistenart_spr_zu_2
ORDER BY
    mandant_id NULLS LAST,
    spr_id NULLS LAST,
    sortimentslistenart_id NULLS LAST;
