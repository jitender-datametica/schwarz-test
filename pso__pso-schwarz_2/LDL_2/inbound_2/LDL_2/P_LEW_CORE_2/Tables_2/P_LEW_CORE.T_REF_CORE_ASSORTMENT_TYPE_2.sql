/* --------------------------------------------------------------------------------
   DDL for table: t_ref_core_assortment_type_2
   generated from Powerdesigner on Mittwoch, 5. März 2025 10:24:35
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_CORE_ASSORTMENT_TYPE_2 (
   core_assort_type_cd                 VARCHAR(100)     NOT NULL COMMENT 'Code  of the type how items can be regarded to be part of the Lidl core assortment.
            CBX: CNT_CODELIST.CODE (code list "lidl_Core_Article")',
   core_assort_type_name               VARCHAR(100)     COMMENT 'Name of the type how items can be regarded to be part of the Lidl core assortment.
            CBX: CNT_CODELIST.NAME (code list "lidl_Core_Article")',
   retail_core_assort_fg               NUMBER(38,0)     COMMENT 'Indicator whether the code classifies the item_2 to be part of the Lidl retail core assortment
            CBX: CNT_CODELIST.CODE (code list "lidl_Core_Article")',
   online_core_assort_fg               NUMBER(38,0)     COMMENT 'Indicator whether the code classifies the item_2 to be part of the Lidl online core assortment
            CBX: CNT_CODELIST.CODE (code list "lidl_Core_Article")',
   online_core_assort_week_cnt         NUMBER(38,0)     COMMENT 'number of weeks the classified item_2 is regarded to be part of the online core assortment
            CBX: CNT_CODELIST.CODE (code list "lidl_Core_Article")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_CORE_ASSORTMENT_TYPE PRIMARY KEY (core_assort_type_cd) NOT ENFORCED 
)  COMMENT = 'This table containes the types of how items can be regarded to be part of the Lidl core assortment.
             CBX: CNT_CODELIST_2 (code list "lidl_Core_Article")';
