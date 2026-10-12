CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_flag_spr_zu_1 (flag, flag_bez) AS SELECT V01.flag,
 V01.flag_bez
FROM kfl_production_dbp_view.v_flag_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_1 AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.flag_typ_id = 1;