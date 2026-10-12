CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_STORE_DAY_SALES_PAYMENT_TYPE
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
FROM p_lew_mart_lead.v_agg_store_day_sales_payment_type;