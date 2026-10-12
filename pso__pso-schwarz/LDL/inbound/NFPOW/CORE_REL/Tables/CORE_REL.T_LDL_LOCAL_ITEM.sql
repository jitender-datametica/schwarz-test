CREATE TABLE CORE_REL.T_LDL_LOCAL_ITEM DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'WAWI: P_LEW_MART_MSI_AC_MATERIALIZED.v_itm_orig_item_desc.client_id',
   ldl_item_nr                         NUMBER(38,0)     NOT NULL COMMENT 'WAWI: P_LEW_MART_MSI_AC_MATERIALIZED.v_itm_orig_item_desc.orig_item_nr',
   active_from_dt                      DATE             NOT NULL COMMENT 'WAWI: P_LEW_MART_MSI_AC_MATERIALIZED.v_itm_orig_item_desc.dat_valid_from',
   ldl_local_item_name                 VARCHAR(100)     COMMENT 'WAWI: P_LEW_MART_MSI_AC_MATERIALIZED.v_itm_orig_item_desc.item_desc',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_LOCAL_ITEM PRIMARY KEY (ldl_client_id, ldl_item_nr, active_from_dt) NOT ENFORCED 
)  COMMENT = '-Level WAWI-Artikel wie im Mart: kurze WAWI-Artikelnummer + Geburtsdatum Artikelgeneration
             WAWI: P_LEW_MART_MSI_AC_MATERIALIZED.v_itm_orig_item_desc';
