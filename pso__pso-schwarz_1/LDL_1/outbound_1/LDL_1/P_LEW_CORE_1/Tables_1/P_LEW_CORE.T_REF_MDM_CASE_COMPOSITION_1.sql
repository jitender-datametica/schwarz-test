/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_case_composition_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:23:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_case_composition_1 (
mdm_case_composition_cd STRING(100) NOT NULL
OPTIONS(description='''code ofoptions to put items in the case, indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
            CBX:  CNT_CODELIST.CODE (code list \'LIDL_NUMBEROFSET\')'''),
mdm_case_composition_txt STRING(100) NOT NULL
OPTIONS(description='''text of options to put items in the case, indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
            CBX:  CNT_CODELIST.NAME (code list \'LIDL_NUMBEROFSET\')'''),
subcase_size_qty BIGNUMERIC(38,5)
OPTIONS(description='''predefined number of items in the text of options to put items in the case when the case will be filled by subcases which contain a predefined number of items.
            CBX:  CNT_CODELIST.NAME (code list \'LIDL_NUMBEROFSET\')'''),
mdm_case_composition_name STRING(100)
OPTIONS(description='''text of options to put items in the case whithout the predefined number of items in  possible sub cases , indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
            CBX:  CNT_CODELIST.NAME (code list \'LIDL_NUMBEROFSET\')'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_case_composition_cd) NOT ENFORCED
)
OPTIONS(description='''list of options to put items in the case, indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
             CBX: CNT_CODELIST_1 (code list "LIDL_NUMBEROFSET")''');