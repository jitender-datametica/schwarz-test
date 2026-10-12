CREATE OR REPLACE TABLE ldl_p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_values (
client_id INTEGER NOT NULL,
dwh_cal_dt DATE NOT NULL,
item_id INTEGER NOT NULL,
currency_iso_cd STRING(3) NOT NULL,
m1401 NUMERIC(29,5),
m1102pvs NUMERIC(29,5),
m1201bnl NUMERIC(29,5)
);