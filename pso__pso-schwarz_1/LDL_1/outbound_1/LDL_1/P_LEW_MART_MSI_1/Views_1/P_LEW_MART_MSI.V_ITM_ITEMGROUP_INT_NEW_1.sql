CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_itm_itemgroup_int_new_1 AS SELECT T1.itemgroup_int_id,
 T1.itemgroup_int_remark,
 T1.itemgroup_int_desc,
 T1.language_id
FROM ldl_p_lew_core_ac.v_wawi_itm_itemgroup_int_act_1 AS T1_1
 INNER JOIN ldl_p_lew_mart_msi.v_ref_user_language_1 AS T2 ON LOWER(SESSION_USER()) = LOWER(T2.db_user) AND T1.language_id
    = T2.language_id;