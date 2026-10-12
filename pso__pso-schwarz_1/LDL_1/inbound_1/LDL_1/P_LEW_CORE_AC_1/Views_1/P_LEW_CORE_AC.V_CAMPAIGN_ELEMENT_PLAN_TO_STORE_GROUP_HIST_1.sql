CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_CAMPAIGN_ELEMENT_PLAN_TO_STORE_GROUP_HIST_1
(
   client_id
 , campaign_elem_plan_sid
 , campaign_store_grp_sid
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
  campaign_store_grp_sid,
  deleted_fg,
  dwh_valid_from,
  dwh_valid_to,
  dwh_load_id,
  dwh_created,
  dwh_updated
FROM p_lew_core.t_campaign_element_plan_to_store_group_hist_1
;