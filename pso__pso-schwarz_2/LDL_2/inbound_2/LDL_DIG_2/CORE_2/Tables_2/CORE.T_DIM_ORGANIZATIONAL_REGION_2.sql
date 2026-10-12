/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_ORGANIZATIONAL_REGION_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 30. November 2023 16:50:11
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_ORGANIZATIONAL_REGION_2 (
   ORG_REGION_CD                       VARCHAR(5)      NOT NULL COMMENT 'A two-letter code describing a sales_2 region_2 within a country. The regions are defined by Lidl Stiftung, and represent an organizational hierarchy_2 level within a country_2, from a sales_2 perspective.',
   ORG_REGION_DESCR                    VARCHAR(250)    COMMENT 'A sales_2 region_2 within a country. The regions are defined by Lidl Stiftung, and represent an organizational hierarchy_2 level within a country_2, from a sales_2 perspective.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_DIM_ORGANIZATIONAL_REGION PRIMARY KEY (ORG_REGION_CD) NOT ENFORCED 
)  COMMENT = 'This dimensional table contains the codes and descriptions of all regions defined by Lidl Stiftung which represent an organizational hierarchy_2 level within a country_2, from a sales_2 perspective.';
