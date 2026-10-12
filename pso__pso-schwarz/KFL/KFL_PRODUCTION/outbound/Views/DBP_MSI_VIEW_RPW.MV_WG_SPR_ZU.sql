CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_wg_spr_zu (wg_id, spr_id, arthiertyp_id, mandant_id, wg_bez,
system_id) AS SELECT wg_id,
 spr_id,
 arthiertyp_id,
 mandant_id,
 wg_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_wg_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22
 AND arthiertyp_id = 2
 AND wg_id >= - 3;