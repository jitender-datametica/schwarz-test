CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_region_split_data_act_1 (client_id, rtl_id, rtl_lvl, per_id, lift_cat_id
, prom_id, region_split_id, raw_buyer_id, currency_iso_cd, meas_id, val, py_val, per_desc, per_desc_en, py_per_desc,
py_per_desc_en, prot_fg) AS SELECT *
FROM ldl_p_lew_mart_cm.v_lil_region_split_data_act_1;