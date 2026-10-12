CREATE OR REPLACE VIEW ugs_aris_production_fe_mstr_aris.v_dim_change_of_int_to_prev_ver_lng (dwh_tenant_cd, process_sid
, modell_guid, orig_lvl_nr, country_org_nr, dwh_src_file_name, change_of_int_to_prev_ver_txt,
`change_of_int_to_prev_ver_txt_bg-bg`, `change_of_int_to_prev_ver_txt_dk-dk`, `change_of_int_to_prev_ver_txt_de-de`,
`change_of_int_to_prev_ver_txt_en-us`, `change_of_int_to_prev_ver_txt_en-uk`, `change_of_int_to_prev_ver_txt_en-ie`,
`change_of_int_to_prev_ver_txt_ee-ee`, `change_of_int_to_prev_ver_txt_fi-fi`, `change_of_int_to_prev_ver_txt_fr-fr`,
`change_of_int_to_prev_ver_txt_fr-be`, `change_of_int_to_prev_ver_txt_gr-gr`, `change_of_int_to_prev_ver_txt_it-it`,
`change_of_int_to_prev_ver_txt_hr-hr`, `change_of_int_to_prev_ver_txt_lv-lv`, `change_of_int_to_prev_ver_txt_lt-lt`,
`change_of_int_to_prev_ver_txt_nl-nl`, `change_of_int_to_prev_ver_txt_nl-be`, `change_of_int_to_prev_ver_txt_pl-pl`,
`change_of_int_to_prev_ver_txt_pt-_u0028_brasil_u0029_`, `change_of_int_to_prev_ver_txt_ro-ro`,
`change_of_int_to_prev_ver_txt_se-se`, `change_of_int_to_prev_ver_txt_rs-rs`, `change_of_int_to_prev_ver_txt_sk-sk`,
`change_of_int_to_prev_ver_txt_si-si`, `change_of_int_to_prev_ver_txt_es-es`, `change_of_int_to_prev_ver_txt_cz-cz`,
`change_of_int_to_prev_ver_txt_hu-hu`, dwh_created_tmsp, dwh_updated_tmsp) AS SELECT *
FROM ugs_aris_production_fe_mstr_aris.t_dim_change_of_int_to_prev_ver_lng;