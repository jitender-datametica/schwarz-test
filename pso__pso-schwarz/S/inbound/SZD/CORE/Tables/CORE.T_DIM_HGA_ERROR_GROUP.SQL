/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_HGA_ERROR_GROUP
   generated from Powerdesigner on Dienstag, 29. April 2025 16:03:42
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_HGA_ERROR_GROUP (
   HGA_ERROR_GRP_SID                   NUMBER(38, 0)   NOT NULL COMMENT 'The numerical identifier for an error group of hot beverage machine',
   MANUFACTURER_SID                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a company which produces deposit machines.',
   HGA_ERROR_GRP_NAME                  VARCHAR(100)    NOT NULL COMMENT 'The default descriptive name for an error group',
   HGA_ERROR_GRP_NAME_DE               VARCHAR(100)    NOT NULL COMMENT 'The descriptive name for an error group in German.',
   HGA_ERROR_GRP_NAME_EN               VARCHAR(100)    NOT NULL COMMENT 'The descriptive name for an error group in English.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',   
   CONSTRAINT PK_T_DIM_HGA_ERROR_GROUP PRIMARY KEY (HGA_ERROR_GRP_SID) NOT ENFORCED 
)  COMMENT = 'The dimension holds the different error categories of hot beverage machines manufactured by Sielaff and Gerhardt';
