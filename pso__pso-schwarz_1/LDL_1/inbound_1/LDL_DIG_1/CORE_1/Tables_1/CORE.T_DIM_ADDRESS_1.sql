/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_ADDRESS_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 30. November 2023 16:49:41
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_ADDRESS_1 (
   ADDR_SID                            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the addresses',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   ADDR_NR                             VARCHAR(100)    COMMENT 'Original addresses numbers in source system',
   ADDR_TYPE_CD                        VARCHAR(5)      COMMENT 'The code for the address_1 type. Possible values: OS (=OnlineShop) & TR (=Travel).',
   ORG_REGION_CD                       VARCHAR(5)      COMMENT 'A two-letter code describing a sales_1 region_1 within a country. The regions are defined by Lidl Stiftung, and represent an organizational hierarchy_1 level within a country_1, from a sales_1 perspective.',
   ZIP_CD                              VARCHAR(100)    COMMENT 'A zip code is a sequence of numbers or a combination of characters and numbers.',
   COUNTRY_NAME                        VARCHAR(100)    COMMENT 'A country_1 name',
   CITY_NAME                           VARCHAR(100)    COMMENT 'The city name',
   STREET_NAME                         VARCHAR(100)    COMMENT 'The name of a street, so that it can be distinguished from other streets. ',
   HOUSE_NR                            VARCHAR(100)    COMMENT 'A house number is a designation of a specific building in a street or a village.',
   DISTRICT_NAME                       VARCHAR(100)    COMMENT 'A district name',
   POST_BOX_NR                         VARCHAR(100)    COMMENT 'A number of a box in a post office to which mail is delivered for the receipient to collect.',
   ADDR_SUFFIX                         VARCHAR(100)    COMMENT 'Additional information for address_1 -  a floor , door number , etc',
   COMPANY_NAME                        VARCHAR(100)    COMMENT 'A company name used for delivery',
   ADDR_LON                            NUMBER(9, 6)    COMMENT 'A geo longitude ',
   ADDR_LAT                            NUMBER(9, 6)    COMMENT 'A geo latitude',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_DIM_ADDRESS PRIMARY KEY (ADDR_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'All possible street addresses,';
