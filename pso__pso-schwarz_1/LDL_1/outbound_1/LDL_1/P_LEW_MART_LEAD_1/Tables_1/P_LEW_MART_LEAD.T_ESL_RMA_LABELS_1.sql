CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_esl_rma_labels_1 (
int_id STRING(1),
client_id BIGNUMERIC(38,0),
move_to_store_id BIGNUMERIC(38,0),
wh_id BIGNUMERIC(38,0),
aspect_id BIGNUMERIC(38,0),
price_label_producer_name STRING(100),
electronic_price_label_type_cd_fe STRING(100),
dat_formdate DATE,
analysed_labels INTEGER,
defect_labels INTEGER,
notdefect_labels INTEGER,
warranty_labels INTEGER,
defectprice_usd BIGNUMERIC(38,5),
defectprice_cur NUMERIC(30,4),
currency_iso_cd STRING(160)
);