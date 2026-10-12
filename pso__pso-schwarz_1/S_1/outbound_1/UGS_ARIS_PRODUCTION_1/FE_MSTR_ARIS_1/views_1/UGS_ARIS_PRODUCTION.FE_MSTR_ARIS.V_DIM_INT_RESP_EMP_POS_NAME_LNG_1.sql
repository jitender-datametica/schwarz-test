CREATE OR REPLACE VIEW ugs_aris_production_fe_mstr_aris.v_dim_int_resp_emp_pos_name_lng_1 (int_resp_emp_pos_name_sid,
int_resp_emp_pos_name, `int_resp_emp_pos_name_bg-bg`, `int_resp_emp_pos_name_dk-dk`, `int_resp_emp_pos_name_de-de`,
`int_resp_emp_pos_name_en-us`, `int_resp_emp_pos_name_en-uk`, `int_resp_emp_pos_name_en-ie`, `int_resp_emp_pos_name_ee-ee`
, `int_resp_emp_pos_name_fi-fi`, `int_resp_emp_pos_name_fr-fr`, `int_resp_emp_pos_name_fr-be`,
`int_resp_emp_pos_name_gr-gr`, `int_resp_emp_pos_name_it-it`, `int_resp_emp_pos_name_hr-hr`, `int_resp_emp_pos_name_lv-lv`
, `int_resp_emp_pos_name_lt-lt`, `int_resp_emp_pos_name_nl-nl`, `int_resp_emp_pos_name_nl-be`,
`int_resp_emp_pos_name_pl-pl`, `int_resp_emp_pos_name_pt-_u0028_brasil_u0029_`, `int_resp_emp_pos_name_ro-ro`,
`int_resp_emp_pos_name_se-se`, `int_resp_emp_pos_name_rs-rs_1`, `int_resp_emp_pos_name_sk-sk`, `int_resp_emp_pos_name_si-si`
, `int_resp_emp_pos_name_es-es`, `int_resp_emp_pos_name_cz-cz`, `int_resp_emp_pos_name_hu-hu`) AS SELECT DISTINCT
 PROCESS.resp_emp_pos_sid AS int_resp_emp_pos_sid,
 PROCESS.resp_emp_pos_name AS int_resp_emp_pos_name,
 LNG.`resp_emp_pos_name_bg-bg` AS `int_resp_emp_pos_name_bg-bg`,
 LNG.`resp_emp_pos_name_dk-dk` AS `int_resp_emp_pos_name_dk-dk`,
 LNG.`resp_emp_pos_name_de-de` AS `int_resp_emp_pos_name_de-de`,
 LNG.`resp_emp_pos_name_en-us` AS `int_resp_emp_pos_name_en-us`,
 LNG.`resp_emp_pos_name_en-uk` AS `int_resp_emp_pos_name_en-uk`,
 LNG.`resp_emp_pos_name_en-ie` AS `int_resp_emp_pos_name_en-ie`,
 LNG.`resp_emp_pos_name_ee-ee` AS `int_resp_emp_pos_name_ee-ee`,
 LNG.`resp_emp_pos_name_fi-fi` AS `int_resp_emp_pos_name_fi-fi`,
 LNG.`resp_emp_pos_name_fr-fr` AS `int_resp_emp_pos_name_fr-fr`,
 LNG.`resp_emp_pos_name_fr-be` AS `int_resp_emp_pos_name_fr-be`,
 LNG.`resp_emp_pos_name_gr-gr` AS `int_resp_emp_pos_name_gr-gr`,
 LNG.`resp_emp_pos_name_it-it` AS `int_resp_emp_pos_name_it-it`,
 LNG.`resp_emp_pos_name_hr-hr` AS `int_resp_emp_pos_name_hr-hr`,
 LNG.`resp_emp_pos_name_lv-lv` AS `int_resp_emp_pos_name_lv-lv`,
 LNG.`resp_emp_pos_name_lt-lt` AS `int_resp_emp_pos_name_lt-lt`,
 LNG.`resp_emp_pos_name_nl-nl` AS `int_resp_emp_pos_name_nl-nl`,
 LNG.`resp_emp_pos_name_nl-be` AS `int_resp_emp_pos_name_nl-be`,
 LNG.`resp_emp_pos_name_pl-pl` AS `int_resp_emp_pos_name_pl-pl`,
 LNG.`resp_emp_pos_name_pt-_u0028_brasil_u0029_` AS `int_resp_emp_pos_name_pt-_u0028_brasil_u0029_`,
 LNG.`resp_emp_pos_name_ro-ro` AS `int_resp_emp_pos_name_ro-ro`,
 LNG.`resp_emp_pos_name_se-se` AS `int_resp_emp_pos_name_se-se`,
 LNG.`resp_emp_pos_name_rs-rs_1` AS `int_resp_emp_pos_name_rs-rs_1`,
 LNG.`resp_emp_pos_name_sk-sk` AS `int_resp_emp_pos_name_sk-sk`,
 LNG.`resp_emp_pos_name_si-si` AS `int_resp_emp_pos_name_si-si`,
 LNG.`resp_emp_pos_name_es-es` AS `int_resp_emp_pos_name_es-es`,
 LNG.`resp_emp_pos_name_cz-cz` AS `int_resp_emp_pos_name_cz-cz`,
 LNG.`resp_emp_pos_name_hu-hu` AS `int_resp_emp_pos_name_hu-hu`
FROM ugs_aris_production_core.t_dim_process_1 AS PROCESS
 INNER JOIN ugs_aris_production_core.t_dim_resp_emp_pos_name_lng_1 AS LNG ON PROCESS.resp_emp_pos_name = LNG.resp_emp_pos_name
  
WHERE PROCESS.country_org_nr = 'INTEGER '
 AND PROCESS.resp_emp_pos_name IS NOT NULL;