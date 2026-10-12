CREATE OR REPLACE VIEW p_lew_core_ac.v_store_to_store_group_hist_2
(
 client_id
,loc_sid_store
,store_grp_sid
,store_grp_type_cd
,campaign_store_grp_type_cd
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
loc_sid_store,
store_grp_sid,
store_grp_type_cd,
campaign_store_grp_type_cd,
deleted_fg,
dwh_valid_from,
dwh_valid_to,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_core.t_store_to_store_group_hist_2 ;


