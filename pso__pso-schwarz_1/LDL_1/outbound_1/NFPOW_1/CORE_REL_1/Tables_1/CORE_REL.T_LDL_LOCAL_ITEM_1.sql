CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_local_item_1 (
ldl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='WAWI: P_LEW_MART_MSI_AC_MATERIALIZED.v_itm_orig_item_desc.client_id'),
ldl_item_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='WAWI: P_LEW_MART_MSI_AC_MATERIALIZED.v_itm_orig_item_desc.orig_item_nr'),
active_from_dt DATE NOT NULL
OPTIONS(description='WAWI: P_LEW_MART_MSI_AC_MATERIALIZED.v_itm_orig_item_desc.dat_valid_from'),
ldl_local_item_name STRING(100)
OPTIONS(description='WAWI: P_LEW_MART_MSI_AC_MATERIALIZED.v_itm_orig_item_desc.item_desc'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_client_id, ldl_item_nr, active_from_dt) NOT ENFORCED
)
OPTIONS(description='-Level WAWI-Artikel_1 wie im Mart: kurze WAWI-Artikelnummer + Geburtsdatum Artikelgeneration             WAWI: P_LEW_MART_MSI_AC_MATERIALIZED.v_itm_orig_item_desc_1');