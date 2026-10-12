CREATE OR REPLACE VIEW p_lew_precore_ac.v_cache_v_promotion_sales_planning_hist_1
(
  client_id
, psalpln_srcinst_id
, psalpln_srcinst_code
, psalpln_pvpit_id
, pvpap_salestype_value
, psalpln_valid_from
, psalpln_valid_to
, psalpln_sales_quota
, psalpln_sales_amount
, psalpln_is_writeoff
, psalpln_reduction_amount
, psalpln_standard_planning
, psalpln_change_system
, psalpln_update_process
, psalpln_update_date
, deleted_fg
, dwh_valid_from
, dwh_valid_to
, dwh_load_id
, dwh_created
, dwh_updated
)
AS
SELECT
client_id,
psalpln_srcinst_id,
psalpln_srcinst_code,
psalpln_pvpit_id,
pvpap_salestype_value,
psalpln_valid_from,
psalpln_valid_to,
psalpln_sales_quota,
psalpln_sales_amount,
psalpln_is_writeoff,
psalpln_reduction_amount,
psalpln_standard_planning,
psalpln_change_system,
psalpln_update_process,
psalpln_update_date,
deleted_fg,
dwh_valid_from,
dwh_valid_to,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_precore.t_cache_v_promotion_sales_planning_hist_1 ;




