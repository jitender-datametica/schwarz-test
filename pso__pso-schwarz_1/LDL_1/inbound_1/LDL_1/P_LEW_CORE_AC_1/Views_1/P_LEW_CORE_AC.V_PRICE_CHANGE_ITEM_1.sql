CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_PRICE_CHANGE_ITEM_1
(
    client_id
    , loc_sid_store
    , loc_sid_wh
    , item_sid
    , account_id
    , receipt_type_id
    , receipt_type_descr
    , price_change_debit_val
    , price_change_debit_net_val
    , price_change_credit_val
    , price_change_credit_net_val
    , dayend_dt
    , dwh_cal_dt
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
   client_id,
   loc_sid_store,
   loc_sid_wh,
   item_sid,
   account_id,
   receipt_type_id,
   receipt_type_descr,
   price_change_debit_val,
   price_change_debit_net_val,
   price_change_credit_val,
   price_change_credit_net_val,
   dayend_dt,
   dwh_cal_dt,
   dwh_load_id,
   dwh_created,
   dwh_updated
   FROM p_lew_core.t_price_change_item_1
   ;