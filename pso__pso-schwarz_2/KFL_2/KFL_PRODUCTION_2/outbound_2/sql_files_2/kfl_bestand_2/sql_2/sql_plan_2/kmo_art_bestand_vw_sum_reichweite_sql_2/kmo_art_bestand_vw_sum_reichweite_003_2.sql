--[OK] statement is translated correctly (syntax and type checks are fine)


-- begin subquery
SELECT COUNT(*)
FROM (
    SELECT
        mandant_id,
        COUNT(*),
        MIN(dat_buch),
        MAX(dat_buch)
    FROM dbp_etl.kmo_mseg_reichweite_2
    GROUP BY mandant_id -- end subquery
) AS t;
