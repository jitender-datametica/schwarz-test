--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    region_name,
    MAX(region_id) AS region_id
FROM dbp_data.region
GROUP BY
    mandant_id,
    region_name;
