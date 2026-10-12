CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_itm_subitemgroup_1 (subitemgroup_id, mainitemgroup_id, itemgroup_int_id,
statisticgroup_id) AS SELECT subitemgroup_id,
 mainitemgroup_id,
 itemgroup_int_id,
 statisticgroup_id
FROM ldl_p_lew_mart_msi.t_itm_subitemgroup_1;