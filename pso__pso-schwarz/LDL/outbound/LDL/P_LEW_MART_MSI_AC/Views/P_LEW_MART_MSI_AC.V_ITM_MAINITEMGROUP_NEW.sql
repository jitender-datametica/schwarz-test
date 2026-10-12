CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_itm_mainitemgroup_new (mainitemgroup_id, mainitemgroup_desc,
mainitemgroup_short_desc, mainitemgroup_sortterm, language_id) AS SELECT *
FROM ldl_p_lew_mart_msi.v_itm_mainitemgroup_new;