CREATE OR REPLACE VIEW ugs_aris_production_fe_mstr_aris.v_dim_change_to_int_lng (dwh_tenant_cd, process_sid, modell_guid
, orig_lvl_nr, country_org_nr, dwh_src_file_name, change_to_int_txt, `change_to_int_txt_bg-bg`, `change_to_int_txt_dk-dk`
, `change_to_int_txt_de-de`, `change_to_int_txt_en-us`, `change_to_int_txt_en-uk`, `change_to_int_txt_en-ie`,
`change_to_int_txt_ee-ee`, `change_to_int_txt_fi-fi`, `change_to_int_txt_fr-fr`, `change_to_int_txt_fr-be`,
`change_to_int_txt_gr-gr`, `change_to_int_txt_it-it`, `change_to_int_txt_hr-hr`, `change_to_int_txt_lv-lv`,
`change_to_int_txt_lt-lt`, `change_to_int_txt_nl-nl`, `change_to_int_txt_nl-be`, `change_to_int_txt_pl-pl`,
`change_to_int_txt_pt-_u0028_brasil_u0029_`, `change_to_int_txt_ro-ro`, `change_to_int_txt_se-se`,
`change_to_int_txt_rs-rs`, `change_to_int_txt_sk-sk`, `change_to_int_txt_si-si`, `change_to_int_txt_es-es`,
`change_to_int_txt_cz-cz`, `change_to_int_txt_hu-hu`, dwh_created_tmsp, dwh_updated_tmsp) AS SELECT *
FROM ugs_aris_production_fe_mstr_aris.t_dim_change_to_int_lng;