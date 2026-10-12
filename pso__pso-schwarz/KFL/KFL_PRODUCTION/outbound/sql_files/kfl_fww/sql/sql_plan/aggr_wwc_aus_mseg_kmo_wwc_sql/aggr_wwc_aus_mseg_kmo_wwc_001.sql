--[OK] statement is translated correctly (syntax and type checks are fine)


-- end subquery
-- begin subquery
SELECT COUNT(*)
FROM (
    SELECT dat_buch
    FROM dbp_data.lagerbew_det_delta
    LIMIT 1
) AS t0;
