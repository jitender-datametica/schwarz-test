CREATE OR REPLACE VIEW p_lew_mart_pit_onprem.v_advert_medium_hist_1
AS
SELECT
client_id
,adv_medium_sid
,adv_medium_grp_sid
,adv_medium_ignore_fg
,adv_medium_delete_fg
,dwh_valid_from
,dwh_valid_to
,dwh_created
,dwh_upDATEd
FROM p_lew_mart_pit_onprem.t_advert_medium_hist_1;