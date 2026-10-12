CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_konditionsart_2 (system_id, mandant_id, kschl) AS SELECT
 system_id,
 mandant_id,
 konditionsart_id AS kschl
FROM kfl_production_dbp_view.v_l_konditionsart_2;