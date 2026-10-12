create table P_LEW_CORE.T_PRICE_CHANGE_ITEM
     (
client_id SMALLINT NOT NULL,
loc_sid_store INTEGER NOT NULL,
loc_sid_wh INTEGER NOT NULL,
account_id INTEGER NOT NULL,
receipt_type_id SMALLINT NOT NULL,
receipt_type_descr VARCHAR(100),
price_change_debit_val DECIMAL(18,5),
price_change_debit_net_val DECIMAL(18,5),
price_change_credit_val DECIMAL(18,5),
price_change_credit_net_val DECIMAL(18,5),
dayend_dt DATE NOT NULL,
dwh_cal_dt DATE NOT NULL,
item_sid INTEGER,
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(6) NOT NULL,
DWH_UPDATED TIMESTAMP_NTZ(6) NOT NULL)
/**** WARNING: PERFORMANCE REVIEW - CLUSTER BY ****/
/*CLUSTER BY(RANGE_N(dwh_cal_dt BETWEEN '2015-01-01' AND '2030-12-31' EACH INTERVAL '1 day' , NO RANGE), RANGE_N(client_id BETWEEN 1 AND 40 EACH 1 , NO RANGE))*/;