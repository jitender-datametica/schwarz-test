--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    land_id,
    MAX(region_id)
FROM dbp_data.region_1
GROUP BY land_id;
