CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_wg_spr_zu_1 AS SELECT mandant_id,
 wg_id,
 arthiertyp_id,
 wg_bez,
 spr_id
FROM kfl_production_dbp_view.v_wg_spr_zu_1 AS V01
WHERE mandant_id <> 1
 AND arthiertyp_id = 2;