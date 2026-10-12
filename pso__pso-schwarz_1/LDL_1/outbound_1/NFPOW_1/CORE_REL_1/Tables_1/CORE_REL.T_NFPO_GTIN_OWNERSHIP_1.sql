CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_gtin_ownership_1 (
nfpo_gtin_ownership_cd STRING(100) NOT NULL
OPTIONS(description='PK EAN_1 Ownership;            CBX: Vendor.custCodeList1.code;            ESB: cbxItem.supplier.eanOwnership.code;'),
nfpo_gtin_ownership_descr STRING(250)
OPTIONS(description='EAN_1 Ownership;            CBX: Vendor.custCodeList1.name;            ESB: cbxItem.supplier.eanOwnership.name;'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_gtin_ownership_cd) NOT ENFORCED
)
OPTIONS(description='NFPO responsibilty of GTIN assignement to items             CBX:  CNT_CODELIST_1, code list\'LIDL_GTIN_OUTPUT\'');