CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_subitemgroup_act_2 (subitemgroup_id, mainitemgroup_id,
itemgroup_int_id, statisticgroup_id) AS SELECT subitemgroup_id,
 mainitemgroup_id,
 itemgroup_int_id,
 statisticgroup_id
FROM ldl_p_lew_core.t_wawi_itm_subitemgroup_act_2;