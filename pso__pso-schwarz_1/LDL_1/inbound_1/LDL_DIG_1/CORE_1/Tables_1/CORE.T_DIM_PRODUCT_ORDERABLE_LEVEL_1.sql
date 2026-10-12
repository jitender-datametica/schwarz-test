/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PRODUCT_ORDERABLE_LEVEL_1
   GENERATED FROM POWERDESIGNER ON Mittwoch, 21. September 2022 15:15:40
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_PRODUCT_ORDERABLE_LEVEL_1 (
   PROD_ORDERABLE_LVL_CD               VARCHAR(5)      NOT NULL COMMENT 'Indicator code. It shows if a product is orderable, soon orderable, or not orderable. It is derived from multiple indicators, like stock_indicator, display_indicator, online_indicator',
   PROD_ORDERABLE_LVL_DESCR            VARCHAR(50)     COMMENT 'Text description of the orderable code. . It shows if a product is orderable, soon orderable, or not orderable. It is derived from multiple indicators, like stock_indicator, display_indicator, online_indicator',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PRODUCT_ORDERABLE_LEVEL PRIMARY KEY (PROD_ORDERABLE_LVL_CD) NOT ENFORCED
 )  COMMENT= 'Indicator code. It shows if a product is orderable, soon orderable, or not orderable. It is derived from multiple indicators, like stock_indicator, display_indicator, online_indicator';
