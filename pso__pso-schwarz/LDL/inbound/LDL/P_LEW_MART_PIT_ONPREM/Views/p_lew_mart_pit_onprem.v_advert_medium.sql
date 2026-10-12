CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_ADVERT_MEDIUM
AS
SELECT
client_id
,adv_medium_sid
,adv_medium_descr
,adv_medium_sort_val
,dwh_created
FROM p_lew_mart_pit_onprem.t_advert_medium;