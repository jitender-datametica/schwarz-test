CREATE OR REPLACE TABLE szd_production_etl.t_lot_destination_metric_temp_2 (
lot_product_instance_group_sid INTEGER,
shipping_destination_cd STRING(50),
metric_type_cd STRING(50),
metric_qty NUMERIC(29,5),
metric_meas NUMERIC(29,5),
dwh_valid_from_tmsp TIMESTAMP,
rn INTEGER,
dwh_valid_to_tmsp TIMESTAMP
);