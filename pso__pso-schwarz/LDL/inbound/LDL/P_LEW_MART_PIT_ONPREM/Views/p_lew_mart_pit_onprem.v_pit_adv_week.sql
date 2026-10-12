CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_ADV_WEEK

AS
   SELECT
   client_id
,   adv_week_id
,   adv_week_sid
,   adv_week_seq
,   adv_week_descr
,   adv_week_long_descr
,   adv_week_year_num
,   adv_week_week_num
,   adv_week_start_dt
,   adv_week_end_dt
,   dwh_created
,   dwh_upDATEd
   FROM p_lew_mart_pit_onprem.t_advert_week;