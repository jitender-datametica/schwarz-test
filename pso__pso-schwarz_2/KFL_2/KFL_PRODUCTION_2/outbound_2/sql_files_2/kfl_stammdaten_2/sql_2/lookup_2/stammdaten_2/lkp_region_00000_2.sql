--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    land_id,
    region_id,
    TRIM(sap_region_id) AS sap_region_id,
    region_name
FROM dbp_data.region_2;
