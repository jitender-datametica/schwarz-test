CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_itemgroup_int_act (itemgroup_int_id, itemgroup_int_remark,
itemgroup_int_desc, language_id) AS SELECT itemgroup_int_id,
 itemgroup_int_remark,
 itemgroup_int_desc,
 language_id
FROM ldl_p_lew_core.t_wawi_itm_itemgroup_int_act;