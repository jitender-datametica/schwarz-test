CREATE OR REPLACE VIEW ugs_aris_production_fe_mstr_aris.v_dim_process_comment_lng_2 (dwh_tenant_cd, process_sid,
modell_guid, orig_lvl_nr, country_org_nr, dwh_src_file_name, process_comment_txt, `process_comment_txt_bg-bg`,
`process_comment_txt_dk-dk`, `process_comment_txt_de-de`, `process_comment_txt_en-us`, `process_comment_txt_en-uk`,
`process_comment_txt_en-ie`, `process_comment_txt_ee-ee`, `process_comment_txt_fi-fi`, `process_comment_txt_fr-fr`,
`process_comment_txt_fr-be`, `process_comment_txt_gr-gr`, `process_comment_txt_it-it`, `process_comment_txt_hr-hr`,
`process_comment_txt_lv-lv`, `process_comment_txt_lt-lt`, `process_comment_txt_nl-nl`, `process_comment_txt_nl-be`,
`process_comment_txt_pl-pl`, `process_comment_txt_pt-_u0028_brasil_u0029_`, `process_comment_txt_ro-ro`,
`process_comment_txt_se-se`, `process_comment_txt_rs-rs_2`, `process_comment_txt_sk-sk`, `process_comment_txt_si-si`,
`process_comment_txt_es-es`, `process_comment_txt_cz-cz`, `process_comment_txt_hu-hu`, dwh_created_tmsp,
dwh_updated_tmsp) AS SELECT *
FROM ugs_aris_production_fe_mstr_aris.t_dim_process_comment_lng_2;