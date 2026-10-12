CREATE TABLE P_LEW_CORE.T_KFL_BRAND_1 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   kfl_brand_sid                       NUMBER(38,0)    NOT NULL COMMENT 'surrogate key Kaufland brand_1
            CBX: CNT_ITEM.LDL_BRAND_KL',
   kfl_brand_name                      VARCHAR(100)    COMMENT 'identifying name of the Kaufland Brand_1
            CBX: CNT_ITEM.LDL_BRAND_KL',
   brand_type_cd                       VARCHAR(20)     COLLATE 'en-ci' COMMENT 'FK Brand_1 Type; constant value EM (only Eigenmarken from Kaufland will be used here)
            
            ',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_KFL_BRAND PRIMARY KEY (kfl_brand_sid) NOT ENFORCED 
)  COMMENT = 'store brands of the division Kaufland related to items created and ordered by the Lidl NFPO in the common process for non food items
             CBX: CNT_ITEM.LDL_BRAND_KL';

