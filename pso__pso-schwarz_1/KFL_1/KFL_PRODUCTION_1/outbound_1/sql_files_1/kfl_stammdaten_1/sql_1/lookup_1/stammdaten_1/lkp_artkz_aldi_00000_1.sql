--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    aldi_id
FROM dbp_data.artkz_aldi_1
ORDER BY
    mandant_id NULLS LAST,
    aldi_id NULLS LAST;
