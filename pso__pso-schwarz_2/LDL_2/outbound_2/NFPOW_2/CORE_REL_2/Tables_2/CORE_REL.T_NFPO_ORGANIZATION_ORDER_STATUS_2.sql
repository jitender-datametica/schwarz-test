CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_organization_order_status_2 (
nfpo_org_order_status_cd STRING(100) NOT NULL
OPTIONS(description='PK Buying status_2;            CBX: Item.ldlCountryOrderStatus.code;            ESB: cbxItem.countryOrderStatus.code;'),
nfpo_org_order_status_descr_de STRING(250) NOT NULL
OPTIONS(description='Buying status_2;            CBX: Item.ldlCountryOrderStatus.name;            ESB: cbxItem.countryOrderStatus.name;'),
nfpo_org_order_status_descr_en STRING(250) NOT NULL
OPTIONS(description='Buying status_2 description;            CBX: Item.ldlCountryOrderStatus.custText1;            ESB: cbxItem.countryOrderStatus.description;'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_org_order_status_cd) NOT ENFORCED
)
OPTIONS(description='NFPO status_2 codes related to the order quantity definition process for the local NFPO\'s of items             CBX:  CNT_CODELIST_2, code list\'LIDL_CO_STATUS\'');