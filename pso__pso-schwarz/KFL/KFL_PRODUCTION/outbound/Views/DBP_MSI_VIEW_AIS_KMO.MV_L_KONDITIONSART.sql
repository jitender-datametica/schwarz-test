CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_konditionsart (mandant_id, konditionsart_id) AS SELECT
 mandant_id,
 konditionsart_id
FROM kfl_production_dbp_view.v_l_konditionsart AS V01
WHERE mandant_id <> 1;