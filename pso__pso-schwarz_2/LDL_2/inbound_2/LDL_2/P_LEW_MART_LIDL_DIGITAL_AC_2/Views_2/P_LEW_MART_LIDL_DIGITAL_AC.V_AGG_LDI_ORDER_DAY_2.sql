CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_AGG_LDI_ORDER_DAY_2
(
 client_id
,client_id_online
,cy
,dat_calendar
,currency_iso_cd
,curr_tot_id
,order_cnt_day
,order_line_cnt_day
,turnover_net_val_day
,plan_turnover_net_val_day
,order_cnt_pyd
,order_line_cnt_pyd
,turnover_net_val_pyd
)
AS
SELECT
client_id,
client_id_online,
cy,
dat_calendar,
currency_iso_cd,
curr_tot_id,
order_cnt_day,
order_line_cnt_day,
turnover_net_val_day,
plan_turnover_net_val_day,
order_cnt_pyd,
order_line_cnt_pyd,
turnover_net_val_pyd
FROM p_lew_mart_lidl_digital.v_agg_ldi_order_day_2
;


