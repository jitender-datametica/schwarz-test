CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_diff_spr_zu_2 (mandant_id, diff_id, spr_id, diff_bez) AS SELECT
 mandant_id,
 diff_id,
 spr_id,
 diff_bez
FROM kfl_production_dbp_view.v_diff_spr_zu_2 AS V01
WHERE mandant_id = 1;