--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    R.mandant_id,
    R.land_id,
    R.region_id,
    R.sap_region_id
FROM dbp_data.region AS R
INNER JOIN
    dbp_data.land AS L
    ON R.mandant_id = L.mandant_id AND R.land_id = L.land_id;
