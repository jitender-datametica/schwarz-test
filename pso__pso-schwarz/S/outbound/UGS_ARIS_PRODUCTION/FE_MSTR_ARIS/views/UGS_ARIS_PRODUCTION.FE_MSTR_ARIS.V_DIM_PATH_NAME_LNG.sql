CREATE OR REPLACE VIEW ugs_aris_production_fe_mstr_aris.v_dim_path_name_lng (dwh_tenant_cd, process_sid, modell_guid,
orig_lvl_nr, country_org_nr, dwh_src_file_name, path_name, `path_name_bg-bg`, `path_name_dk-dk`, `path_name_de-de`,
`path_name_en-us`, `path_name_en-uk`, `path_name_en-ie`, `path_name_ee-ee`, `path_name_fi-fi`, `path_name_fr-fr`,
`path_name_fr-be`, `path_name_gr-gr`, `path_name_it-it`, `path_name_hr-hr`, `path_name_lv-lv`, `path_name_lt-lt`,
`path_name_nl-nl`, `path_name_nl-be`, `path_name_pl-pl`, `path_name_pt-_u0028_brasil_u0029_`, `path_name_ro-ro`,
`path_name_se-se`, `path_name_rs-rs`, `path_name_sk-sk`, `path_name_si-si`, `path_name_es-es`, `path_name_cz-cz`,
`path_name_hu-hu`, dwh_created_tmsp, dwh_updated_tmsp) AS SELECT *
FROM ugs_aris_production_fe_mstr_aris.t_dim_path_name_lng;