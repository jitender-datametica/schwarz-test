CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_AGG_LDI_ORDER_MTH_1
(
 client_id
,client_id_online
,cy
,cy_month
,currency_iso_cd
,curr_tot_id
,order_cnt_mth
,order_line_cnt_mth
,turnover_net_val_mth
,plan_turnover_net_val_mth
,order_cnt_pym
,order_line_cnt_pym
,turnover_net_val_pym
)
AS
SELECT
client_id,
client_id_online,
cy,
cy_month,
currency_iso_cd,
curr_tot_id,
order_cnt_mth,
order_line_cnt_mth,
turnover_net_val_mth,
plan_turnover_net_val_mth,
order_cnt_pym,
order_line_cnt_pym,
turnover_net_val_pym
FROM p_lew_mart_lidl_digital.v_agg_ldi_order_mth_1
;


