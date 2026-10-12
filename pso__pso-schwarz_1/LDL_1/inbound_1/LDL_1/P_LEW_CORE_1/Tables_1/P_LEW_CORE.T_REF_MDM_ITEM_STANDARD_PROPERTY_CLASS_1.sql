/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_item_standard_property_class_1
   generated from Powerdesigner on Dienstag, 25. November 2025 15:35:04
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY_CLASS_1 (
   mdm_item_standard_property_class_cd VARCHAR(100)     NOT NULL COMMENT 'Class of the standardized item_1 properties: So far "TX" for textile item_1 properties and "HG" for hard goods item_1 properties.',
   mdm_item_standard_property_class_descr VARCHAR(250)     COMMENT 'Description of the class of standardized item_1 properties.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_ITEM_STANDARD_PROPERTY_CLASS PRIMARY KEY (mdm_item_standard_property_class_cd) NOT ENFORCED 
)  COMMENT = 'Classes of item_1 standard properties. So far "TX" for textile item_1 properties and "HG" for hard goods item_1 properties.
             Manually filled values derived from:
             CBX: LDL_ITEM_CERTIFICATION column names LDL_CERTIFICATION_PROPERTY_TX and LDL_CERTIFICATION_PROPERTY_HG
             or from the CNT_CODELIST_BOOK.CODELISTNAME entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX"';
