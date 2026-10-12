CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_agg_str_day_item_return (
client_id BIGNUMERIC(38,0) NOT NULL,
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
return_receipttype_id BIGNUMERIC(38,0),
return_reason_cd_ejr_sfo BIGNUMERIC(38,0),
qty_return_ejr_sfo NUMERIC(18,4),
val_return_ejr_sfo NUMERIC(18,4),
val_return_net_ejr_sfo NUMERIC(19,5),
timestamp_mod DATETIME NOT NULL
) CLUSTER BY dat_formdate;