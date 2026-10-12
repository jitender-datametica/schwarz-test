CREATE OR REPLACE VIEW p_lew_core_ac.v_despatch_advice_usage_plan_hist_2
(
    client_id
  , bus_year
  , advice_usage_target_rate
  , advice_edi_target_rate
  , advice_avail_edi_target_rate
  , advice_avail_target_rate
  , advice_target_rate
  , deleted_fg
  , dwh_valid_from
  , dwh_valid_to
  , dwh_load_id
  , dwh_created
  , dwh_updated
) AS
SELECT
    client_id
  , bus_year
  , advice_usage_target_rate
  , advice_edi_target_rate
  , advice_avail_edi_target_rate
  , advice_avail_target_rate
  , advice_target_rate
  , deleted_fg
  , dwh_valid_from
  , dwh_valid_to
  , dwh_load_id
  , dwh_created
  , dwh_updated
FROM p_lew_core.t_despatch_advice_usage_plan_hist_2;