CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_wug_spr_zu_2 AS SELECT mandant_id,
 wg_id,
 wug_id,
 arthiertyp_id,
 wug_bez,
 spr_id
FROM kfl_production_dbp_view.v_wug_spr_zu_2 AS V01
WHERE mandant_id <> 1
 AND arthiertyp_id = 2;