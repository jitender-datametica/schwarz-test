CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_l_flag_aktiv_spr_zu_2 (flag_id, flag_bez) AS SELECT flag AS
 flag_id,
 flag_bez
FROM kfl_production_dbp_view.v_flag_spr_zu_2
WHERE flag_typ_id = 3
 AND spr_id = 22;