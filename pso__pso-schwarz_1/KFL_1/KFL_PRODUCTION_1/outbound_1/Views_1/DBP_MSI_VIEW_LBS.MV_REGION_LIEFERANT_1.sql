CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_region_lieferant_1 (land_id, region_id, mandant_id,
sap_region_id, region_name) AS SELECT V01.land_id,
 V01.region_id,
 V01.mandant_id,
 V01.sap_region_id,
 V01.region_name
FROM kfl_production_dbp_view.v_region_1 AS V01
 INNER JOIN (SELECT mandant_id,
    CASE
    WHEN mandant_id = 1
    THEN 'DE'
    ELSE mandant_kbez
    END AS land_id
  FROM kfl_production_dbp_view.v_mandant_1) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.land_id = v02.land_id;