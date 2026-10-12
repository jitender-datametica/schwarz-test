CREATE OR REPLACE TABLE ldl_p_lew_mart_lead.t_esl_price_label_store_1 (
int_id STRING(1),
client_id INTEGER,
wh_id INTEGER,
move_to_store_id INTEGER,
aspect_id INTEGER,
price_label_producer_name STRING(100),
electronic_price_label_type_cd_fe STRING(100),
dat_formdate DATE,
currency_iso_cd STRING(160),
active_labels INTEGER,
rma_labels INTEGER,
issue_fg INTEGER
);