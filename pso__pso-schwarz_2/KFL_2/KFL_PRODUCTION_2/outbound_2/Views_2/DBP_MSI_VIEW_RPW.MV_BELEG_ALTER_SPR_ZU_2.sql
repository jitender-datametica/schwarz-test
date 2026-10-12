CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_beleg_alter_spr_zu_2 (mandant_id, beleg_alter_id, spr_id,
beleg_alter_bez, system_id) AS SELECT mandant_id,
 beleg_alter_id,
 spr_id,
 beleg_alter_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_beleg_alter_spr_zu_2
WHERE spr_id = 22
 AND mandant_id = 1;