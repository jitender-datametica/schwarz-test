/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_ORGANIZATIONAL_REGION_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 30. November 2023 16:51:09
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_ORGANIZATIONAL_REGION_2 (
   COUNTRY_CD                          VARCHAR(5)      NOT NULL COMMENT 'The unique code for a country_2 according to ISO-3166 Alpha-2. E.g. DE for Germany or FR for France',
   ZIP_CD                              VARCHAR(100)    NOT NULL COMMENT 'A zip code is a sequence of numbers or a combination of characters and numbers. It is part of a postal address_2 and designates the destination area.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   ORG_REGION_CD                       VARCHAR(5)      NOT NULL COMMENT 'A two-letter code describing a sales_2 region_2 within a country. The regions are defined by Lidl Stiftung, and represent an organizational hierarchy_2 level within a country_2, from a sales_2 perspective.',
   ORG_REGION_DESCR                    VARCHAR(250)    COMMENT 'A sales_2 region_2 within a country. The regions are defined by Lidl Stiftung, and represent an organizational hierarchy_2 level within a country_2, from a sales_2 perspective.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_ETL_ORGANIZATIONAL_REGION PRIMARY KEY (DWH_VALID_FROM_TMSP, COUNTRY_CD, ZIP_CD) NOT ENFORCED 
)  COMMENT = 'ETL table to support the loading of t_dim_organizational_region_2';
