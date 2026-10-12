CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_konditionsart_spr_zu_2 (system_id, mandant_id, konditionsart_id
, spr_id, konditionsart_bez) AS SELECT 7 AS system_id,
 mandant_id,
 konditionsart_id,
 spr_id,
 konditionsart_bez
FROM kfl_production_dbp_view.v_konditionsart_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22;