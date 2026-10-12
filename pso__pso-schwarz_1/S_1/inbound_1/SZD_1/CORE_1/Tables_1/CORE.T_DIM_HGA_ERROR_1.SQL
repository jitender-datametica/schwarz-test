/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_HGA_ERROR_1
   generated from Powerdesigner on Dienstag, 29. April 2025 16:02:17
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_HGA_ERROR_1 (
   HGA_ERROR_CD                        VARCHAR(50)     NOT NULL COMMENT 'The unique code for the hot beverage machine error',
   HGA_ERROR_GRP_SID                   NUMBER(38, 0)   NOT NULL COMMENT 'The  unique identifier (surrogate key) for an error group of hot beverage machine',
   MANUFACTURER_SID                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a company which produces deposit machines.',
   HGA_ERROR_DESCR                     VARCHAR(250)    COMMENT 'The default textual description for error code',
   HGA_ERROR_DESCR_DE                  VARCHAR(250)    NOT NULL COMMENT 'The textual description for error code in German.',
   HGA_ERROR_DESCR_EN                  VARCHAR(250)    NOT NULL COMMENT 'The textual description for error code in English.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',   
   CONSTRAINT PK_T_DIM_HGA_ERROR PRIMARY KEY (HGA_ERROR_CD) NOT ENFORCED 
)  COMMENT = 'The dimension holds the different error data of hot beverage machines manufactured by Sielaff and Gerhardt';
