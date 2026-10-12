CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_transportstatus_2 (mandant_id, transportstatus_id) AS SELECT
 mandant_id,
 transportstatus_id
FROM kfl_production_dbp_view.v_l_transportstatus_2;