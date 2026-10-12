--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    ereignis_id,
    sap_ereignis_id,
    ereignistyp_id,
    default_offen
FROM dbp_data.ereignis_1
WHERE sap_ereignis_id IS NOT NULL;
