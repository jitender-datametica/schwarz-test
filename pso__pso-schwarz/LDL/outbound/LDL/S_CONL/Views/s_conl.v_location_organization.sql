CREATE OR REPLACE VIEW ldl_s_conl.v_location_organization AS SELECT *
FROM ldl_p_lew_bil_ac.v_location_organization
WHERE client_id IN (SELECT client_id
   FROM ldl_s_conl.t_user_mapping
   WHERE LOWER(user_name) = LOWER(SESSION_USER()));


/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_wawi_org_account_manager_mrg_act", "p_lew_core_ac.v_location", "p_lew_core_ac.v_wawi_ref_client_country", "p_lew_core_ac.v_wawi_ref_country" ***/