/* --------------------------------------------------------------------------------
   DDL for table: T_LOCATION_KEY_1
   generated from Powerdesigner on Donnerstag, 30. November 2023 09:39:09
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_LOCATION_KEY_1 (
   LOCATION_SID                        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the location.',
   LOCATION_KEY_TYPE_CD                VARCHAR(50)     NOT NULL COMMENT 'The code for the type of natural key which identifies the location.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   LOCATION_NAT_KEY_NR                 VARCHAR(250)    NOT NULL COMMENT 'The natural key which identifies the location.In case the natural key consist of several columns, all components get concatenated.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_LOCATION_KEY PRIMARY KEY (LOCATION_KEY_TYPE_CD, DWH_VALID_FROM_TMSP, LOCATION_NAT_KEY_NR) NOT ENFORCED 
)  COMMENT = 'Metadata - Keytable - Location_1 - Contains the mapping between surrogate keys and natural keys for business objects from the subject area "Location_1".';

