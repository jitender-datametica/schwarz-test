--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    esb_id
FROM dbp_data.artkz_esb_2
ORDER BY
    mandant_id NULLS LAST,
    esb_id NULLS LAST;
