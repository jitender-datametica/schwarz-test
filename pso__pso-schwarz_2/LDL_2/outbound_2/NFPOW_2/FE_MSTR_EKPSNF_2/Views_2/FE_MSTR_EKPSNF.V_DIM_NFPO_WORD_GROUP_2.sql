CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_word_group_2 (nfpo_word_grp_txt, nfpo_word_grp_type_cd,
nfpo_word_grp_type_name, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_tmsp) AS SELECT *
FROM nfpow_core.t_dim_nfpo_word_group_2;