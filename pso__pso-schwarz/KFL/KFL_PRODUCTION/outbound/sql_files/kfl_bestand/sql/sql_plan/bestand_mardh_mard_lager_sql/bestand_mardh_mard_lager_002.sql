--[OK] statement is translated correctly (syntax and type checks are fine)


-- begin subquery
SELECT COUNT(*)
FROM (
    SELECT
        mandant_id,
        COUNT(*)
    FROM dbp_etl.bestand_mardh_mard_vz_log
    GROUP BY mandant_id -- end subquery
) AS t;
