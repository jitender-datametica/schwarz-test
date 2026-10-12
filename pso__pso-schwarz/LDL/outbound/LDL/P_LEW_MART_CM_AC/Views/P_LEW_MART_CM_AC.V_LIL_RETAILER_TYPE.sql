CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_retailer_type (rtl_tp_id, rtl_tp_desc, rtl_tp_desc_en, rtl_tp_other,
rtl_tp_other_en, rtl_tp_total_of_selected, rtl_tp_total_of_selected_en) AS SELECT *
FROM ldl_p_lew_mart_cm.v_lil_retailer_type;