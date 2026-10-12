CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_subitemgroup_desc_act_1 (subitemgroup_id, subitemgroup_desc,
subitemgroup_short_desc, language_id, subitemgroup_sortterm) AS SELECT subitemgroup_id,
 subitemgroup_desc,
 subitemgroup_short_desc,
 language_id,
 subitemgroup_sortterm
FROM ldl_p_lew_core.t_wawi_itm_subitemgroup_desc_act_1;