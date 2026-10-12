CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_area_2 (dic_area_id, dic_active, mod_date, dic_area_nr
, dic_area_wh, country_2, dic_area_name, source_extraction_tmsp, snflk_insert_tmsp, snflk_update_tmsp) AS SELECT *
FROM ldl_autodispo_core.t_oracle_v_dic_area_new_2;