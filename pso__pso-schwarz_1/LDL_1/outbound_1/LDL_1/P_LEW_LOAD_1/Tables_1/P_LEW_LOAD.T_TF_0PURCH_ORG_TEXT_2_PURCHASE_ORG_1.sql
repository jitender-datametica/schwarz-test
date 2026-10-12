CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_0purch_org_text_2_purchase_org_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
purch_org_text_key1 STRING(120),
src_ekorg STRING(20),
pur_org_name STRING(100) COLLATE 'und:ci',
src_bukrs STRING(40),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);