CREATE OR REPLACE VIEW s_conl.v_location_organization_2
AS
(SELECT
client_id
    , loc_sid_wh
    , loc_sid_store
    , sales_manager_id
    , sales_manager_name
    , account_manager_id
    , account_manager_name
    , general_manager_id
    , general_manager_name
    , organisation_id
    , district_cd
    , active_from_dt
    , active_to_dt
    , deleted_fg
    , dwh_valid_from
    , dwh_valid_to
    , dwh_actual_fg
    , active_fg
FROM p_lew_bil_ac.v_location_organization_2
WHERE client_id IN
	(SELECT
client_id
FROM s_conl.t_user_mapping_2 WHERE lower(user_name) = lower(current_user))
);

/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_wawi_org_account_manager_mrg_act_2", "p_lew_core_ac.v_location_2", "p_lew_core_ac.v_wawi_ref_client_country_2", "p_lew_core_ac.v_wawi_ref_country_2" ***/

