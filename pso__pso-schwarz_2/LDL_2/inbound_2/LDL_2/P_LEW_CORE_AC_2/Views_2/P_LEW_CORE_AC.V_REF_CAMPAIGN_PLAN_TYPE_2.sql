CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_CAMPAIGN_PLAN_TYPE_2
(
   campaign_element_plan_type_cd
 , campaign_element_plan_type_descr
 , dwh_load_id
 , dwh_created
 , dwh_updated
) 
AS
  SELECT
  campaign_element_plan_type_cd,
  campaign_element_plan_type_descr,
  dwh_load_id,
  dwh_created,
  dwh_updated
FROM p_lew_core.t_ref_campaign_plan_type_2
;