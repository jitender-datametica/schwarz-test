CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_nfpo_previous_item (nfpo_item_sid, nfpo_prev_item_lvl_nr,
nfpo_prev_item_sid, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_tmsp) AS SELECT *
FROM nfpow_core_rel.t_nfpo_previous_item;