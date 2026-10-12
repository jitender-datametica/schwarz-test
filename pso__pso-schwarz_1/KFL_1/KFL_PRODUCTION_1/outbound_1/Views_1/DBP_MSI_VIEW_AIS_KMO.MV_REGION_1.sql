CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_region_1 (land_id, region_id, mandant_id, sap_region_id,
region_name) AS SELECT V01.land_id,
 V01.region_id,
 V01.mandant_id,
 V01.sap_region_id,
 V01.region_name
FROM kfl_production_dbp_view.v_region_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.land_id = V02.mandant_kbez
   
WHERE V01.mandant_id <> 1;