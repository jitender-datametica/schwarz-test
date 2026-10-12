CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_supplier_shipping_terms_1 (
nfpo_sup_ship_terms_cd STRING(100) NOT NULL
OPTIONS(description='PK Supplier_1 shipping terms;            CBX: Vendor.custCodelist2.code;            ESB: cbxItem.supplier.shippingTerms.code;'),
nfpo_sup_ship_terms_name STRING(100)
OPTIONS(description='Shipping terms name;            CBX: Vendor.custCodelist2.name;            ESB: cbxItem.supplier.shippingTerms.name;'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_sup_ship_terms_cd) NOT ENFORCED
)
OPTIONS(description='NFPO supplier_1 related shipping terms             CBX:  CNT_CODELIST_1, code list\'LDL_WBP_CAL_PROFILE\'');