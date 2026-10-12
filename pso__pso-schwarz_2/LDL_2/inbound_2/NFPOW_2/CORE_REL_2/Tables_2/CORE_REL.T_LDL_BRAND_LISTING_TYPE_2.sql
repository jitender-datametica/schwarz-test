CREATE TABLE CORE_REL.T_LDL_BRAND_LISTING_TYPE_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_brand_list_type_id              NUMBER(38,0)     NOT NULL COMMENT 'WAWI:P_LEW_MART_MSI_AC_MATERIALIZED.v_ref_itm_list_type_buylist.buying_list_type_desc',
   ldl_brand_list_type_name            VARCHAR(100)     COMMENT 'WAWI:P_LEW_MART_MSI_AC_MATERIALIZED.v_ref_itm_list_type_buylist.buying_list_type_desc',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_BRAND_LISTING_TYPE PRIMARY KEY (ldl_brand_list_type_id) NOT ENFORCED 
)  COMMENT = 'WAWI:P_LEW_MART_MSI_AC_MATERIALIZED.v_ref_itm_list_type_buylist_2';
