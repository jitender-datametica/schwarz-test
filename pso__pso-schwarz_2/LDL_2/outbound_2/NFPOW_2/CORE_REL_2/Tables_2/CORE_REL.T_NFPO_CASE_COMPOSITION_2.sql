CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_case_composition_2 (
nfpo_case_composition_cd STRING(100) NOT NULL
OPTIONS(description='''code ofoptions to put items in the case, indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
            CBX:  CNT_CODELIST.CODE, code list \'LIDL_NUMBEROFSET\'
            '''),
nfpo_case_composition_txt STRING(1000) NOT NULL
OPTIONS(description='''text of options to put items in the case, indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
            CBX:  CNT_CODELIST.NAME, code list \'LIDL_NUMBEROFSET\''''),
nfpo_subcase_size_qty BIGNUMERIC(38,5)
OPTIONS(description='''predefined number of items in the text of options to put items in the case when the case will be filled by subcases which contain a predefined number of items.
            CBX:  CNT_CODELIST.NAME, code list \'LIDL_NUMBEROFSET\''''),
nfpo_case_composition_name STRING(100)
OPTIONS(description='''text of options to put items in the case whithout the predefined number of items in  possible sub cases , indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
            CBX:  CNT_CODELIST.NAME, code list \'LIDL_NUMBEROFSET\''''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_case_composition_cd) NOT ENFORCED
)
OPTIONS(description='''list of options to put items in the case, indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
             CBX:  CNT_CODELIST_2, code list \'LIDL_NUMBEROFSET\'''');