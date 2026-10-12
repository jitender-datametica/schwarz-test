/*
#===============================================================================

#===============================================================================
# History
#  1.0 2021-05-28 Pawel Wieczorek   SF: adding new view
#===============================================================================
#
*/

/* ==============================================================================
   View DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_lidlplus_config_client_1 (client_id, country_cd, rollout_start_dt
, full_client_rollout_dt, reporting_start_dt, dwh_load_id, dwh_created, dwh_updated)
OPTIONS(DESCRIPTION = `LIDLPLUS : CONFIG TABLE`) AS SELECT client_id,
 country_cd,
 rollout_start_dt,
 full_client_rollout_dt,
 reporting_start_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process.t_lidlplus_config_client_1;