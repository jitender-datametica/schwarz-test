CREATE OR REPLACE VIEW p_lew_core_ac.v_campaign_element_1
(
 client_id
,campaign_elem_sid
,src_srcinst_cd
,src_pvpit_id
,campaign_sid
,item_sid
,campaign_elem_status_cd
,dwh_load_id
,dwh_created
,dwh_updated
)
AS
SELECT
client_id,
campaign_elem_sid,
src_srcinst_cd,
src_pvpit_id,
campaign_sid,
item_sid,
campaign_elem_status_cd,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_core.t_campaign_element_1
;





