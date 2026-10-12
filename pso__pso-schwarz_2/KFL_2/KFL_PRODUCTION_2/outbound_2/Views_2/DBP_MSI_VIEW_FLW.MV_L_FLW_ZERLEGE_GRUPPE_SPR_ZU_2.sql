CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_zerlege_gruppe_spr_zu_2 AS SELECT V01.mandant_id,
 V01.zerlege_gruppe_id,
 V01.zerlege_gruppe_bez
FROM kfl_production_dbp_view.v_flw_zerlege_gruppe_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_2 AS V02 ON V01.spr_id = V02.spr_id;