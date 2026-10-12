CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_ADV_WEEK_RANGES
AS
SELECT
client_id
,range_id
,range_sid
,range_seq
,range_desc
,adv_week_seq
FROM p_lew_mart_pit_onprem.v_pit_adv_week_ranges;