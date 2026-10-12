CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_lookup_cust_order_nr_r3_to_s4 (
lead_src_name STRING(5) NOT NULL OPTIONS(description='Source system from which the record was fetched (e.g. SEP)'),
lead_src_log_sys_cd STRING(5) NOT NULL OPTIONS(description='SAP MANDT code associated with the source system'),
src_cust_order_nr STRING(20) NOT NULL
OPTIONS(description='Initial cust_order_nr (SAP VBELN code) from the legacy system (i.e. SAP R3)'),
tgt_cust_order_nr STRING(20) OPTIONS(description='New cust_order_nr in the current system (i.e. SAP S4 Hana)'),
check_key STRING(40)
OPTIONS(description='Concatenated primary key (unique combination behind the cust_order_sid), for debugging and R3-to-S4 mapping performance'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source'),
PRIMARY KEY (src_cust_order_nr, lead_src_name, lead_src_log_sys_cd) NOT ENFORCED
);