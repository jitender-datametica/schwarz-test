CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_itm_subitemgroup_desc_new_2 AS SELECT B.subitemgroup_id,
 B.subitemgroup_desc,
 B.subitemgroup_short_desc
FROM ldl_p_lew_core_ac.v_wawi_itm_subitemgroup_desc_act_2 AS B
 INNER JOIN ldl_p_lew_mart_msi.v_ref_user_language_2 AS LG ON LOWER(SESSION_USER()) = LOWER(LG.db_user) AND B.language_id
   = LG.language_id;