--[OK] statement is translated correctly (syntax and type checks are fine)


-- begin subquery
SELECT COUNT(*)
FROM (
    SELECT
        mandant_id,
        COUNT(*),
        MIN(dat),
        MAX(dat)
    FROM dbp_etl.art_best_vw_sum_artbew_kmo_dat
    GROUP BY mandant_id -- end subquery
) AS t;
