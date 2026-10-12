--[OK] statement is translated correctly (syntax and type checks are fine)


-- begin subquery
SELECT COUNT(*)
FROM (
    SELECT dat
    FROM dbp_data.artbew_agg_wt_1
    GROUP BY dat -- end subquery
) AS t;
