CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_abt_spr_zu_hr_1 (mandant_id, arthiertyp_id, abt_id, abt_bez,
spr_id) AS SELECT mandant_id,
 arthiertyp_id,
 abt_id,
 abt_bez,
 spr_id
FROM kfl_production_dbp_view.v_abt_spr_zu_1 AS V01
WHERE arthiertyp_id = 2
 AND spr_id = 65
 AND mandant_id = 6;