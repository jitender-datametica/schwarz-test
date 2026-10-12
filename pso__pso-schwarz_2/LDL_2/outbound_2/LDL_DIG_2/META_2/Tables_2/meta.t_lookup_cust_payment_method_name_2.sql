CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_lookup_cust_payment_method_name_2 (
cust_paym_method_cd STRING(5) NOT NULL,
cust_paym_method_descr STRING(250),
cust_paym_method_name STRING(250),
tmsp_insert TIMESTAMP,
tmsp_update TIMESTAMP,
PRIMARY KEY (cust_paym_method_cd) NOT ENFORCED
);