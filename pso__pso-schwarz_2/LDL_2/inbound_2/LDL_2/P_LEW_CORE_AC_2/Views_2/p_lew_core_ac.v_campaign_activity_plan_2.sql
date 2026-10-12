CREATE OR REPLACE VIEW p_lew_core_ac.v_campaign_activity_plan_2
(
 client_id
,campaign_activity_plan_sid
,src_srcinst_cd
,src_pvpac_id
,src_pvpap_salestype
,src_pvpap_valid_from
,src_advmed_id
,src_strplm_id
,campaign_elem_sid
,campaign_activity_type_cd
,plan_status_cd
,dwh_load_id
,dwh_created
,dwh_updated
)
AS
SELECT
client_id,
campaign_activity_plan_sid,
src_srcinst_cd,
src_pvpac_id,
src_pvpap_salestype,
src_pvpap_valid_from,
src_advmed_id,
src_strplm_id,
campaign_elem_sid,
campaign_activity_type_cd,
plan_status_cd,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_core.t_campaign_activity_plan
;





