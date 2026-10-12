CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_CAMPAIGN_ELEMENT_ACTIVITY_PLAN_HIST_2
(
   client_id
 , campaign_elem_plan_sid
 , campaign_elem_sid
 , campaign_activity_type_cd
 , plan_status_cd
 , price_active_from_dt
 , price_active_to_dt
 , sales_channel_sid
 , curr_cd
 , plan_gross_sales_price
 , std_gross_sales_price
 , price_comment_txt
 , store_placement_dt
 , store_placement_loc_cd
 , adv_dt
 , adv_channel_sid
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
  campaign_activity_type_cd,
  plan_status_cd,
  price_active_from_dt,
  price_active_to_dt,
  sales_channel_sid,
  curr_cd,
  plan_gross_sales_price,
  std_gross_sales_price,
  price_comment_txt,
  store_placement_dt,
  store_placement_loc_cd,
  adv_dt,
  adv_channel_sid,
  deleted_fg,
  dwh_valid_from,
  dwh_valid_to,
  dwh_load_id,
  dwh_created,
  dwh_updated
FROM p_lew_core.t_campaign_element_activity_plan_hist_2
;