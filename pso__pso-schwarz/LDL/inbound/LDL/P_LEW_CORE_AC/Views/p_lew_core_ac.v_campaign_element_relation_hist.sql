CREATE OR REPLACE VIEW p_lew_core_ac.v_campaign_element_relation_hist
(
 client_id
,campaign_elem_sid
,campaign_elem_sid_rel
,campaign_elem_rel_type_cd
,deleted_fg
,dwh_valid_from
,dwh_valid_to
,dwh_load_id
,dwh_created
,dwh_updated
)
AS
SELECT
client_id,
campaign_elem_sid,
campaign_elem_sid_rel,
campaign_elem_rel_type_cd,
deleted_fg,
dwh_valid_from,
dwh_valid_to,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_core.t_campaign_element_relation_hist
;





