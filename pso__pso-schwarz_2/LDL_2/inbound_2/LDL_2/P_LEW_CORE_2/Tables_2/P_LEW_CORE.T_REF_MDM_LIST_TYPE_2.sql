/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_list_type_2
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:44:39
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_LIST_TYPE_2 (
   mdm_list_type_cd                    VARCHAR(100)     NOT NULL COMMENT 'NFPO codes for list types of items
            CBX:  CNT_CODELIST.CODE  (code list ''LIDL_ASSORTMENT_TYPE'')',
   mdm_list_type_name                  VARCHAR(100)     COMMENT 'NFPO names for list types of items
            CBX:  CNT_CODELIST.NAME  (code list ''LIDL_ASSORTMENT_TYPE'')',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_LIST_TYPE PRIMARY KEY (mdm_list_type_cd) NOT ENFORCED 
)  COMMENT = 'NFPO codes for list types of items
             CBX: CNT_CODELIST_2 (code list "LIDL_ASSORTMENT_TYPE")';
