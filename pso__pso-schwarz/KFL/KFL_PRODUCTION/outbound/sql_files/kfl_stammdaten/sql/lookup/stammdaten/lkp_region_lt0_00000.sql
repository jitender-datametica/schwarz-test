--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    land_id,
    region_id,
    sap_region_id
FROM dbp_data.region
WHERE region_id < 0;
