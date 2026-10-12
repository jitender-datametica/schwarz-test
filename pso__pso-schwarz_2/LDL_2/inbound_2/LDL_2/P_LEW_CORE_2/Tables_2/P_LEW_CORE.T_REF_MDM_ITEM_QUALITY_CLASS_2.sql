/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_item_quality_class_2
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:40:27
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_ITEM_QUALITY_CLASS_2 (
   item_quality_class_cd               VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'NFPO code for item_2 quality classification
            CBX:  CNT_CODELIST.code (code list ''LDL_Article_Class'')',
   item_quality_class_descr            VARCHAR(100)     NOT NULL COMMENT 'NFPO description for item_2 quality classification
            CBX:  CNT_CODELIST.name (code list ''LDL_Article_Class'')',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_ITEM_QUALITY_CLASS PRIMARY KEY (item_quality_class_cd) NOT ENFORCED 
)  COMMENT = 'NFPO item_2 classification related to item_2 quality compared to the overall market
             CBX: CNT_CODELIST_2 (code list "LDL_Article_Class")';
