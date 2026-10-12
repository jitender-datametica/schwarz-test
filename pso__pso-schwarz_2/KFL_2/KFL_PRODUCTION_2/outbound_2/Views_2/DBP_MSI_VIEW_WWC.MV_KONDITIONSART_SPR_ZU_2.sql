CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_konditionsart_spr_zu_2 (system_id, mandant_id, spr_id, kschl,
kschl_bez) AS SELECT system_id,
 mandant_id,
 spr_id,
 konditionsart_id AS kschl,
 konditionsart_bez AS kschl_bez
FROM kfl_production_dbp_view.v_konditionsart_spr_zu_2
WHERE spr_id = 22;