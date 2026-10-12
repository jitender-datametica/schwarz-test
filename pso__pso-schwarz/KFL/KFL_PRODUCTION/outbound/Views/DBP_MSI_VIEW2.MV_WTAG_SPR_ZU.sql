CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_wtag_spr_zu (wtag_id, spr_id, wtag_bez) AS SELECT wtag_id,
 spr_id,
 wtag_bez
FROM kfl_production_dbp_view.v_wtag_spr_zu
WHERE spr_id = 22;