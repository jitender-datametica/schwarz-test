CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_incoterm (
nfpo_market_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''surrogate key market
            CBX: derived from the type of code list'''),
nfpo_incoterm_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO incoterm codes similar to the terms defined by the International Chamber of Commerce
            CBX:CNT_CODELIST.CODE (code list \'INCOTERM\' and \'LIDL_INCOTERM_US\')'''),
nfpo_incoterm_name STRING(100) NOT NULL
OPTIONS(description='''NFPO incoterm names similar to the terms defined by the International Chamber of Commerce
            CBX:CNT_CODELIST.NAME (code list \'INCOTERM\' and \'LIDL_INCOTERM_US\')'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_market_sid, nfpo_incoterm_cd) NOT ENFORCED
)
OPTIONS(description='''NFPO set of codes for commercial terms in the contracts, different codes are used for different markets
             CBX: CNT_CODELIST, code lists \'INCOTERM\', \'LIDL_INCOTERM_US\'''');