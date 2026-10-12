CREATE OR REPLACE VIEW ldl_s_conl.v_location_organization_2 AS SELECT *
FROM ldl_p_lew_bil_ac.v_location_organization_2
WHERE client_id IN (SELECT client_id
   FROM ldl_s_conl.t_user_mapping_2
   WHERE LOWER(user_name) = LOWER(SESSION_USER()));


/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_wawi_org_account_manager_mrg_act_2", "p_lew_core_ac.v_location_2", "p_lew_core_ac.v_wawi_ref_client_country_2", "p_lew_core_ac.v_wawi_ref_country_2" ***/