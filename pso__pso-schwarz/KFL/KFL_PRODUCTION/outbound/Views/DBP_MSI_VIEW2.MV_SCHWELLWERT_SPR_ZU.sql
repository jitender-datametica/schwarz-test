CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_schwellwert_spr_zu (mandant_id, sw_id, spr_id, sw_bez) AS SELECT
 mandant_id,
 sw_id,
 spr_id,
 sw_bez
FROM kfl_production_dbp_view.v_schwellwert_spr_zu
WHERE spr_id = 22
 AND mandant_id = 1;