CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_wg_spr_zu (wg_id, spr_id, arthiertyp_id,
mandant_id, wg_bez, wg_id_bez) AS SELECT V01.wg_id,
 V01.spr_id,
 V01.arthiertyp_id,
 V01.mandant_id,
 V01.wg_bez,
 V01.wg_id_bez
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_wg_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V02 ON V01.spr_id = V02.spr_id;