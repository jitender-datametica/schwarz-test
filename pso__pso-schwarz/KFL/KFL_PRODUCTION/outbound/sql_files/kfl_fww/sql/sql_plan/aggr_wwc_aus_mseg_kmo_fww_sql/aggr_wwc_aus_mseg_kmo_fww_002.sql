-- begin subquery
SELECT COUNT(*)
FROM (
    SELECT dat_buch, 
       mandant_id,
       kjmo,
       kjwo 
    FROM dbp_etl.kmo_mseg_dat_wwc
    GROUP BY
        dat_buch,
        mandant_id,
        kjmo,
        kjwo -- end subquery
) AS t;
