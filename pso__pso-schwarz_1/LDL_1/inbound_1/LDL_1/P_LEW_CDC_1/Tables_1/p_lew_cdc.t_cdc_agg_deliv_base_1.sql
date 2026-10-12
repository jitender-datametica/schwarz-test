CREATE TABLE p_lew_cdc.t_cdc_agg_deliv_base_1
(
client_id SMALLINT NOT NULL,
item_sid INTEGER NOT NULL,
dat_formdate DATE NOT NULL,
loc_sid_store INTEGER NOT NULL,
deliverytype_id INTEGER NOT NULL,
log_operation CHAR(1) COLLATE 'en-ci',
log_ts TIMESTAMP(6));

