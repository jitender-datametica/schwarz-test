CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_markant_spr_zu_1 (mandant_id, markant_id, markant_bez) AS SELECT
 mandant_id,
 markant_id,
 markant_bez
FROM kfl_production_dbp_view.v_markant_spr_zu_1
WHERE mandant_id = 1
 AND spr_id = 22;