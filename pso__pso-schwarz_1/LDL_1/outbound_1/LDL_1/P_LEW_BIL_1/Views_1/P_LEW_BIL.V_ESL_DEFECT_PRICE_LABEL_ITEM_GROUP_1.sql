CREATE OR REPLACE VIEW ldl_p_lew_bil.v_esl_defect_price_label_item_group_1 (dat_formdate, price_label_sid,
item_grp_int_sid, sub_item_grp_sid) AS SELECT dat_formdate,
 price_label_sid,
 item_grp_int_sid,
 sub_item_grp_sid
FROM ldl_p_lew_bil.t_esl_defect_price_label_item_group_1;