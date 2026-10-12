/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_logistics_class_2
   generated from Powerdesigner on Dienstag, 25. November 2025 15:29:28
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_LOGISTICS_CLASS_2 (
   mdm_logistics_class_cd              VARCHAR(100)     NOT NULL COMMENT 'Code to classify the way the items will be transported from the central warehouse of OWIM into the countries.
            CBX: CNT_CODELIST.CODE (code list "LIDL_DELIVERYTYPE")',
   mdm_logistics_class_name            VARCHAR(100)     COMMENT 'Name to classify the way the items will be transported from the central warehouse of OWIM into the countries.
            CBX: CNT_CODELIST.NAME (code list "LIDL_DELIVERYTYPE")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_LOGISTICS_CLASS PRIMARY KEY (mdm_logistics_class_cd) NOT ENFORCED 
)  COMMENT = 'NFPO classification of the way the items will be transported from the central warehouse of OWIM into the countries.
             CBX: CNT_CODELIST_2 (code list "LIDL_DELIVERYTYPE")';
