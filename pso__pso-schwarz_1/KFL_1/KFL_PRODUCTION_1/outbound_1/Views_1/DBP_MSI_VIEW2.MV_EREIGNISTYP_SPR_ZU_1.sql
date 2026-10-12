CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_ereignistyp_spr_zu_1 (spr_id, ereignistyp_id, ereignistyp_bez) AS
SELECT spr_id,
 ereignistyp_id,
 ereignistyp_bez
FROM kfl_production_dbp_view.v_ereignistyp_spr_zu_1
WHERE spr_id = 22
 AND mandant_id = 1;