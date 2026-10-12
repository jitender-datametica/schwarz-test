CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_list_type_1 (
nfpo_list_type_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO codes for list types of items
            CBX:  CNT_CODELIST.CODE, code list \'LIDL_ASSORTMENT_TYPE\''''),
nfpo_list_type_name STRING(100)
OPTIONS(description='''NFPO names for list types of items
            CBX:  CNT_CODELIST.NAME, code list \'LIDL_ASSORTMENT_TYPE\''''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_list_type_cd) NOT ENFORCED
)
OPTIONS(description='''NFPO codes for list types of items
             CBX:  CNT_CODELIST_1, code list \'LIDL_ASSORTMENT_TYPE\'''');