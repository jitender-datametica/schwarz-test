--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT IFNULL(MAX(region_id), 0) AS min_region_id
FROM dbp_data.region_1;
