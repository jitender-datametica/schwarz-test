CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_package_type (
nfpo_pack_type_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO outer package type codes for items
            CBX:  CNT_CODELIST.CODE, code list \'LIDL_PACKAGETYPE\''''),
nfpo_pack_type_name STRING(100)
OPTIONS(description='''NFPO outer package type names for items (NETZ/TOPF/BOX usw.)
            CBX:  CNT_CODELIST.NAME, code list \'LIDL_PACKAGETYPE\''''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_pack_type_cd) NOT ENFORCED
)
OPTIONS(description='''NFPO outer package type for items (NETZ/TOPF/BOX usw.)
             CBX:  CNT_CODELIST, code list \'LIDL_PACKAGETYPE\'''');