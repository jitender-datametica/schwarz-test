CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_EJR_STORE_DAY_CASHIER_STAT
(
client_id
, store_id
, cashier_id
, dat_formdate
, val_shouldbe_turnover
, cnt_customer
, val_avg_purchase
, cnt_pos_total
, val_pos_per_minute
, val_pos_per_purchase
, val_servicetime
 )
AS
SELECT
client_id,
store_id,
cashier_id,
dat_formdate,
val_shouldbe_turnover,
cnt_customer,
val_avg_purchase,
cnt_pos_total,
val_pos_per_minute,
val_pos_per_purchase,
val_servicetime
FROM p_lew_mart_msi.v_ejr_store_day_cashier_stat;


