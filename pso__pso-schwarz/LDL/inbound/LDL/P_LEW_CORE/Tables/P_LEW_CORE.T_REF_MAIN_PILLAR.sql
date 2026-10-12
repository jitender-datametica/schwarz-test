CREATE TABLE P_LEW_CORE.T_REF_MAIN_PILLAR (
   main_pillar_cd                      VARCHAR(100)    NOT NULL COMMENT 'code of the main pillar
            CBX: CNT_CODELIST.CODE (code list ''PRODUCT_CATEGORY'')',
   main_pillar_name                    VARCHAR(100)    COMMENT 'name  of the main pillar
            CBX: CNT_CODELIST.NAME (code list ''PRODUCT_CATEGORY'')',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_REF_MAIN_PILLAR PRIMARY KEY (main_pillar_cd) NOT ENFORCED 
)  COMMENT = 'main pillar (HG/TX) directly assigned to the item instance in the NFPO source system. 
             CBX:  CNT_CODELIST, code list ''PRODUCT CATEGORY''';