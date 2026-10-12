/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PRODUCT_VARIANT_UNIT_CONVERSION_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 13. November 2024 15:06:07
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_PRODUCT_VARIANT_UNIT_CONVERSION_2 (
   PROD_VARIANT_SID                    NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant',
   UNIT_CONVERSION_TYPE_CD             VARCHAR(10)     NOT NULL COMMENT 'The code for the unit_2 conversion type (e.g. PAL - palette, ST - piece, MBO - container, KOL - package_2, etc.)',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   UNIT_CONVERSION_NUM_MEAS            NUMBER(38, 0)   COMMENT 'The numerator for the given unit_2 conversion type',
   UNIT_CONVERSION_DENOM_MEAS          NUMBER(38, 0)   COMMENT 'The denominator for the given unit_2 conversion type',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_DIM_PRODUCT_VARIANT_UNIT_CONVERSION PRIMARY KEY (PROD_VARIANT_SID, UNIT_CONVERSION_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'This dimensional table contains conversion metrics at product variant level to pieces, boxes, pallets, etc. which are necessary for warehouse outbound and inbound reporting. E.g. a pallet can store 14 TVs so the corresponding product variant is going to have 14 as numerator and 1 as denominator for the unit_2 conversion type "PAL".';
