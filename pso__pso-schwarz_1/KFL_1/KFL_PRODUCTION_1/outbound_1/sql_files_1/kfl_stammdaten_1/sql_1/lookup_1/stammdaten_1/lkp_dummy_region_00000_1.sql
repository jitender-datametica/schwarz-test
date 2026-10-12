--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    land_id,
    mandant_id,
    region_id
FROM dbp_data.region_1
WHERE sap_region_id IN ('-', '-1');
