CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_we_anlieferbereich (client_id
OPTIONS(description='Indicator of country'), wh_id OPTIONS(description='Warehouse number'), wh_staging_area_cd
OPTIONS(description='Warehouse area number'), wh_staging_area_descr OPTIONS(description='Warehouse area description'))
AS SELECT *
FROM ldl_p_lew_mart_lead.v_ref_we_anlieferbereich
UNION DISTINCT
SELECT client_id,
 wh_id,
 '-1' AS wh_staging_area_cd,
 'Manuelle WE' AS wh_staging_area_descr
FROM ldl_p_lew_mart_lead.v_ref_we_anlieferbereich;