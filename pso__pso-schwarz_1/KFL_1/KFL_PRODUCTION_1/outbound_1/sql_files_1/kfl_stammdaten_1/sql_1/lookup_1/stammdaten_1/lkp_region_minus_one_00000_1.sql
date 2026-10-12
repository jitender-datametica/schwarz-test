--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    land_id,
    sap_region_id,
    region_id
FROM dbp_data.region_1
WHERE sap_region_id = '-1';
