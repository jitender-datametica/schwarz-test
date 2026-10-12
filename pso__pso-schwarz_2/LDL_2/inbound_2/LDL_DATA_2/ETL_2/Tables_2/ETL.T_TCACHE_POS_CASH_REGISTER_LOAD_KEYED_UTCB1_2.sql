CREATE TABLE ETL.T_TCACHE_POS_CASH_REGISTER_LOAD_KEYED_UTCB1_2 (
    src_country_cd VARCHAR(20),
    src_orig_store_nr NUMBER(38,0),
    src_cash_register_nr NUMBER(38,0),
    src_pos_type VARCHAR(3),
    cash_register_type_cd VARCHAR(3),
    country_org_cd VARCHAR(2),
    curr_cd VARCHAR(3),
    cash_register_sid NUMBER(38,0),
    country_org_sid NUMBER(38,0),
    real_estate_sid NUMBER(38,0),
    store_sid NUMBER(38,0),
    extraction_ts TIMESTAMP_LTZ(9),
    dwh_created_tmsp TIMESTAMP_LTZ(9) NOT NULL,
    dwh_updated_tmsp TIMESTAMP_LTZ(9) NOT NULL,
    dwh_load_id NUMBER(38,0) NOT NULL,
    dwh_node_cd VARCHAR(20) NOT NULL
 );
