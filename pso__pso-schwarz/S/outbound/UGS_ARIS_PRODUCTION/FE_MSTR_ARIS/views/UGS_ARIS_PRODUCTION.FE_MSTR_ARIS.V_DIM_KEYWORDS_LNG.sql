CREATE OR REPLACE VIEW ugs_aris_production_fe_mstr_aris.v_dim_keywords_lng (dwh_tenant_cd, process_sid, modell_guid,
orig_lvl_nr, country_org_nr, dwh_src_file_name, keywords_txt, `keywords_txt_bg-bg`, `keywords_txt_dk-dk`,
`keywords_txt_de-de`, `keywords_txt_en-us`, `keywords_txt_en-uk`, `keywords_txt_en-ie`, `keywords_txt_ee-ee`,
`keywords_txt_fi-fi`, `keywords_txt_fr-fr`, `keywords_txt_fr-be`, `keywords_txt_gr-gr`, `keywords_txt_it-it`,
`keywords_txt_hr-hr`, `keywords_txt_lv-lv`, `keywords_txt_lt-lt`, `keywords_txt_nl-nl`, `keywords_txt_nl-be`,
`keywords_txt_pl-pl`, `keywords_txt_pt-_u0028_brasil_u0029_`, `keywords_txt_ro-ro`, `keywords_txt_se-se`,
`keywords_txt_rs-rs`, `keywords_txt_sk-sk`, `keywords_txt_si-si`, `keywords_txt_es-es`, `keywords_txt_cz-cz`,
`keywords_txt_hu-hu`, dwh_created_tmsp, dwh_updated_tmsp) AS SELECT *
FROM ugs_aris_production_fe_mstr_aris.t_dim_keywords_lng;