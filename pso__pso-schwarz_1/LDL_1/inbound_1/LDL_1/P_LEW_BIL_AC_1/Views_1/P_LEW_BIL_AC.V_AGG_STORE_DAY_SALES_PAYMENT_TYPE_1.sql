CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_AGG_STORE_DAY_SALES_PAYMENT_TYPE_1
(
      client_id
    , dat_formdate
    , cy_month
    , loc_sid
    , orig_store_nr
    , currency_iso_cd
    , sales_net_val_pos
    , return_net_val_pos
    , cnt_customer
    , sales_payment_type
)
AS
SELECT
client_id,
dat_formdate,
cy_month,
loc_sid,
orig_store_nr,
currency_iso_cd,
sales_net_val_pos,
return_net_val_pos,
cnt_customer,
sales_payment_type
FROM p_lew_bil.t_agg_store_day_sales_payment_type_1;


