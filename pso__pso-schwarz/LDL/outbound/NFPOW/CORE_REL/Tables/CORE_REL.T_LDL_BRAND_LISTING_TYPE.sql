CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_brand_listing_type (
ldl_brand_list_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='WAWI:P_LEW_MART_MSI_AC_MATERIALIZED.v_ref_itm_list_type_buylist.buying_list_type_desc'),
ldl_brand_list_type_name STRING(100)
OPTIONS(description='WAWI:P_LEW_MART_MSI_AC_MATERIALIZED.v_ref_itm_list_type_buylist.buying_list_type_desc'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_brand_list_type_id) NOT ENFORCED
) OPTIONS(description='WAWI:P_LEW_MART_MSI_AC_MATERIALIZED.v_ref_itm_list_type_buylist');