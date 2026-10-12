CREATE OR REPLACE TABLE ldl_p_lew_mart_lead.t_agg_wh_day_pch_ldlpl_loyalty_2 (
client_id INTEGER,
loc_sid_wh INTEGER,
wh_id INTEGER,
aspect_id INTEGER,
pcwo_reason_id INTEGER,
currency_iso_cd STRING(3) COLLATE 'und:ci',
dwh_cal_dt DATE,
discount_val_net BIGNUMERIC(38,11)
);