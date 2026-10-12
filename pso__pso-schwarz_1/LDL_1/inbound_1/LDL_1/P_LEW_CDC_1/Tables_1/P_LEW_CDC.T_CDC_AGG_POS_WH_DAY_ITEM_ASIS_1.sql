CREATE TABLE P_LEW_CDC.T_CDC_AGG_POS_WH_DAY_ITEM_ASIS_1
(
client_id INTEGER,
loc_sid_wh INTEGER,
item_sid INTEGER,
dwh_cal_dt DATE /*** MSC-WARNING - MSCEWI2040 - FORMAT 'YY/MM_1/DD' NOT SUPPORTED ***/,
discount_sid INTEGER,
log_operation CHAR(1) COLLATE 'en-ci',
log_ts TIMESTAMP(6));


