CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_problemmeldung_obj_spr_zu_2 (system_id, mandant_id, spr_id,
zus_obj_id, zus_obj_bez) AS SELECT 7 AS system_id,
 mandant_id,
 spr_id,
 zus_obj_id,
 zus_obj_bez
FROM kfl_production_dbp_view.v_problemmeldung_obj_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22;