CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_CAMPAIGN_ELEMENT_SALES_PLAN_HIST_2
(
   client_id
 , campaign_elem_plan_sid
 , campaign_elem_sid
 , sales_channel_sid
 , sales_period_from_dt
 , sales_period_to_dt
 , plan_status_cd
 , plan_sales_pct
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
  campaign_elem_plan_sid,
  campaign_elem_sid,
  sales_channel_sid,
  sales_period_from_dt,
  sales_period_to_dt,
  plan_status_cd,
  plan_sales_pct,
  deleted_fg,
  dwh_valid_from,
  dwh_valid_to,
  dwh_load_id,
  dwh_created,
  dwh_updated
FROM p_lew_core.t_campaign_element_sales_plan_hist_2
;