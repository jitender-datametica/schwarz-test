CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_owg_spr_zu_2 (owg_id, spr_id, arthiertyp_id, mandant_id, owg_bez)
AS SELECT owg_id,
 spr_id,
 arthiertyp_id,
 mandant_id,
 owg_bez
FROM kfl_production_dbp_view.v_owg_spr_zu_2
WHERE spr_id = 22
 AND mandant_id = 1
 AND owg_id NOT IN (1011, 1012, 1014);