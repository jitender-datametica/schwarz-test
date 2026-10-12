CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_WTD_ADV_WEEK
AS
SELECT
adv_week_sid
,client_id
,adv_week_id
,wtd_adv_week_sid
,wtd_adv_week_id
,adv_week_rltd_type_id
FROM p_lew_mart_pit_onprem.v_pit_wtd_adv_week;