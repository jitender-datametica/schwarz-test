CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_agg_nvgtn_tm_2 (cy_month, cy_week, byr, tm_lvl_id, tm_ele_link,
tm_brdcrum, load_id, dwh_inserted, dwh_updated) AS SELECT cy_month,
 cy_week,
 byr,
 tm_lvl_id,
 tm_ele_link,
 tm_brdcrum,
 load_id,
 dwh_inserted,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_agg_nvgtn_tm_2;