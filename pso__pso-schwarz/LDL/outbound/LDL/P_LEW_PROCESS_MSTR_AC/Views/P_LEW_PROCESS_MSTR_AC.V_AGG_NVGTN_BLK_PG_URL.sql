CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_agg_nvgtn_blk_pg_url (int_id, client_ctry_id, client_id, aspect_id,
wh_id, move_to_store_id, org_lvl_id, org_ele_link, cy_month, cy_week, byr, tm_ele_link, dsbrd_id, phy_doc_type_id,
blk_id, blk_id_prmpt, dsbrd_blk_ord, meas_group_id, dsbrd_meas_grp_ord, dspl_meas_grp_fl, blk_strt_pg_fl, prev_pg_no,
pg_no, next_pg_no, prev_pg_url, pg_url, act_pg_url, next_pg_url) AS SELECT *
FROM ldl_p_lew_process_mstr.v_agg_nvgtn_blk_pg_url;