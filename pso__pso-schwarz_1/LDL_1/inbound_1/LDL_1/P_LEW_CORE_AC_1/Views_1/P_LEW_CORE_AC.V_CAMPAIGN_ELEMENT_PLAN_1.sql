CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_CAMPAIGN_ELEMENT_PLAN_1
(
    campaign_elem_plan_sid
  , src_srcinst_cd
  , src_proplan_id
  , src_pvpac_id
  , src_pvpit_id
  , src_salestype_value
  , src_pvpgp_no
  , src_valid_from
  , src_advmed_id
  , src_strplm_id
  , campaign_plan_type_cd
  , campaign_activity_type_cd
  , dwh_load_id
  , dwh_created
  , dwh_updated
) 
AS
SELECT
  campaign_elem_plan_sid,
  src_srcinst_cd,
  src_proplan_id,
  src_pvpac_id,
  src_pvpit_id,
  src_salestype_value,
  src_pvpgp_no,
  src_valid_from,
  src_advmed_id,
  src_strplm_id,
  campaign_plan_type_cd,
  campaign_activity_type_cd,
  dwh_load_id,
  dwh_created,
  dwh_updated
FROM p_lew_core.t_campaign_element_plan_1
;