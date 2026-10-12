CREATE OR REPLACE VIEW p_lew_core_ac.v_ref_campaign_element_status_2
(
 campaign_elem_status_cd
,campaign_elem_status_descr
,dwh_load_id
,dwh_created
,dwh_updated
)
AS
SELECT
campaign_elem_status_cd,
campaign_elem_status_descr,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_core.t_ref_campaign_element_status_2
;



