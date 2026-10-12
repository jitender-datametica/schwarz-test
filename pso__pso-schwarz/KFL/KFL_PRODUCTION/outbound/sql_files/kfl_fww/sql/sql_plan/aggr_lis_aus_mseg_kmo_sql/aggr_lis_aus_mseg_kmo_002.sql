-- begin subquery
SELECT COUNT(*)
FROM (
    SELECT *
    FROM dbp_etl.kmo_mseg_dat
    GROUP BY
        dat_buch,
        mandant_id -- end subquery
) AS t;
