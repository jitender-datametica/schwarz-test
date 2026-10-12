--[OK] statement is translated correctly (syntax and type checks are fine)


-- begin subquery
SELECT COUNT(*)
FROM (
    SELECT
        mandant_id,
        COUNT(*) AS anzsaetze,
        MIN(gjmo) AS min_gjmo
    FROM dbp_etl.vis_monat_bestand_wg_log_2
    GROUP BY mandant_id -- end subquery
) AS t;
