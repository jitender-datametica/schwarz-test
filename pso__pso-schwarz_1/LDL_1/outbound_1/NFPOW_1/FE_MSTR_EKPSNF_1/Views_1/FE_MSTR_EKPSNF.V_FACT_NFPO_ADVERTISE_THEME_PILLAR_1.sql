CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_fact_nfpo_advertise_theme_pillar_1 (nfpo_adv_theme_sid, nfpo_pillar_sid,
nfpo_main_pillar_cd, nfpo_item_cnt, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_tmsp) AS SELECT *
FROM nfpow_core.t_fact_nfpo_advertise_theme_pillar_1;