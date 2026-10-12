/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_case_composition_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:23:20
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_CASE_COMPOSITION_1 (
   mdm_case_composition_cd             VARCHAR(100)     NOT NULL COMMENT 'code ofoptions to put items in the case, indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
            CBX:  CNT_CODELIST.CODE (code list ''LIDL_NUMBEROFSET'')',
   mdm_case_composition_txt            VARCHAR(100)     NOT NULL COMMENT 'text of options to put items in the case, indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
            CBX:  CNT_CODELIST.NAME (code list ''LIDL_NUMBEROFSET'')',
   subcase_size_qty                    NUMBER(38,5)     COMMENT 'predefined number of items in the text of options to put items in the case when the case will be filled by subcases which contain a predefined number of items.
            CBX:  CNT_CODELIST.NAME (code list ''LIDL_NUMBEROFSET'')',
   mdm_case_composition_name           VARCHAR(100)     COMMENT 'text of options to put items in the case whithout the predefined number of items in  possible sub cases , indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
            CBX:  CNT_CODELIST.NAME (code list ''LIDL_NUMBEROFSET'')',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_CASE_COMPOSITION PRIMARY KEY (mdm_case_composition_cd) NOT ENFORCED 
)  COMMENT = 'list of options to put items in the case, indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
             CBX: CNT_CODELIST_1 (code list "LIDL_NUMBEROFSET")';
