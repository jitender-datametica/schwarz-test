CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_abt_spr_zu_ro_2 (mandant_id, arthiertyp_id, abt_id, abt_bez,
spr_id) AS SELECT mandant_id,
 arthiertyp_id,
 abt_id,
 abt_bez,
 spr_id
FROM kfl_production_dbp_view.v_abt_spr_zu_2 AS V01
WHERE arthiertyp_id = 2
 AND spr_id = 95
 AND mandant_id = 7;