DROP TABLE IF EXISTS smp_production_eval.tmp_pos_receiptline_2;
CREATE OR REPLACE TABLE smp_production_eval.tmp_pos_receiptline_2 (
client_id INTEGER,
loc_sid INTEGER,
dwh_cal_dt DATE,
register_id INTEGER,
receipt_dt DATE,
receipt_id INTEGER,
receipt_tmsp DATETIME,
item_sid INTEGER,
ean_barcode STRING(100) COLLATE 'und:ci',
transaction_type_cd STRING(20),
sales_val NUMERIC(29,5),
sales_piece_qty NUMERIC(29,5),
discount_weight_qty NUMERIC(29,5),
discount_piece_qty NUMERIC(29,5),
weight_item_fg INTEGER,
bon_id STRING(90)
) CLUSTER BY bon_id;