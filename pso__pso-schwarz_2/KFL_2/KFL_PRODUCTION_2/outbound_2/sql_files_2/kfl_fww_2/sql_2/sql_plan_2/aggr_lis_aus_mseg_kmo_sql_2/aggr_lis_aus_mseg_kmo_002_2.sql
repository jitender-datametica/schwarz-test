-- begin subquery
SELECT COUNT(*)
FROM (
    SELECT *
    FROM dbp_etl.kmo_mseg_dat_2
    GROUP BY
        dat_buch,
        mandant_id -- end subquery
) AS t;
