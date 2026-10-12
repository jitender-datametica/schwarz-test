CREATE TABLE P_LEW_CDC.T_CDC_AGG_POS_STORE_DAY_SIG_ASIS
(
client_id INTEGER,
loc_sid_store INTEGER,
sub_item_grp_sid INTEGER,
dwh_cal_dt DATE /*** MSC-WARNING - MSCEWI2040 - FORMAT 'YY/MM/DD' NOT SUPPORTED ***/,
cy_month INTEGER,
discount_sid INTEGER,
log_operation CHAR(1) COLLATE 'en-ci',
log_ts TIMESTAMP(6));


