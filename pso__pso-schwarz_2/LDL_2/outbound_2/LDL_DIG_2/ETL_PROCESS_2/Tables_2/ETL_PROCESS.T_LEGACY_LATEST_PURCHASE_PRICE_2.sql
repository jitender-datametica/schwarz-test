CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_legacy_latest_purchase_price_2 (
matnr STRING(30) NOT NULL,
letzter_ekp BIGNUMERIC(38,5),
tmsp_insert TIMESTAMP,
tmsp_update TIMESTAMP,
PRIMARY KEY (matnr) NOT ENFORCED
);