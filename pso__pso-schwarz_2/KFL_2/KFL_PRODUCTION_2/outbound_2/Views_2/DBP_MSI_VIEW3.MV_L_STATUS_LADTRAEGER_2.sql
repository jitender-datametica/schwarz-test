CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_status_ladtraeger_2 (mandant_id, status_ladtraeger) AS SELECT
 mandant_id,
 status_ladtraeger
FROM kfl_production_dbp_view.v_l_status_ladtraeger_2;