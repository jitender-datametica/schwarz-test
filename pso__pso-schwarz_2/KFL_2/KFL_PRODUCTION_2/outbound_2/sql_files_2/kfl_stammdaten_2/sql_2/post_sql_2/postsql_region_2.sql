--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.region_2 SET
    region_name = 'Sachsen-Anhalt'
WHERE land_id = 'DE' AND sap_region_id = '13';


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.region_2 SET
    region_name = 'Thueringen'
WHERE land_id = 'DE' AND sap_region_id = '14';


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.region_2 SET
    region_name = 'Sachsen'
WHERE land_id = 'DE' AND sap_region_id = '16';


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.region_2 SET
    region_name = 'Mecklenburg-Vorpomm.'
WHERE land_id = 'DE' AND sap_region_id = '15';
