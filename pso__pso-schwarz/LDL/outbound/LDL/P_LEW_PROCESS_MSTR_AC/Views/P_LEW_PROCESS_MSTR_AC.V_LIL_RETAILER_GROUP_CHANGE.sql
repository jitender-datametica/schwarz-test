CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_retailer_group_change (retailer_group_change_id,
src_retailer_grp_cd, src_retailer_chld_cd, src_retailer_chg_cd, active_fg, dwh_load_id, dwh_created, dwh_updated) AS
SELECT retailer_group_change_id,
 src_retailer_grp_cd,
 src_retailer_chld_cd,
 src_retailer_chg_cd,
 active_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_retailer_group_change;