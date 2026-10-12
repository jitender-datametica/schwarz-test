CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_completion_type (
nfpo_market_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''surrogate key market
            CBX: derived from the type of code list'''),
nfpo_completion_type_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO completion types
            CBX:CNT_CODELIST.CODE (code list \'LIDL_OWIMFH\' and \'LIDL_COMPLTYPE_US\')'''),
nfpo_completion_type_name STRING(100) NOT NULL
OPTIONS(description='''NFPO completion type name
            CBX:CNT_CODELIST.NAME (code list \'LIDL_OWIMFH\' and \'LIDL_COMPLTYPE_US\''''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_market_sid, nfpo_completion_type_cd) NOT ENFORCED
)
OPTIONS(description='''NFPO completion type codes, different codes are used for different markets
             CBX: CNT_CODELIST, code lists \'LIDL_OWIMFH\', \'LIDL_COMPLTYPE_US\'
             ''');