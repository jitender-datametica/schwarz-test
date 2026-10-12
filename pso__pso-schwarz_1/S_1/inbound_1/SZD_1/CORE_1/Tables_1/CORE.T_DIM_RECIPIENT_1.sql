CREATE TABLE CORE.T_DIM_RECIPIENT_1 (
   PARTY_SID            NUMBER(38, 0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the recipient.',
   DWH_VALID_FROM_TMSP  TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG         BOOLEAN          NOT NULL COMMENT 'An indicator showing the current record in history.',
   RECIPIENT_NR         VARCHAR(50)      NOT NULL COMMENT 'Natural/Business Key - The business identifier of the recipient.',
   RECIPIENT_NAME       VARCHAR(100)     NOT NULL COMMENT 'Descriptive Attribute - The name of the recipient.',
   COUNTRY_LOCATION_SID NUMBER(38, 0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the country_1 location_1 of the recipient.',
   COUNTRY_ISO_CD       VARCHAR(50)      NOT NULL COMMENT 'Descriptive Attribute - The ISO country_1 code of the country_1 of the recipient.',
   DWH_CREATED_TMSP     TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP     TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME    VARCHAR(500)              COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_DIM_RECIPIENT PRIMARY KEY (PARTY_SID, DWH_VALID_FROM_TMSP)
)  COMMENT = 'Major Dimension - The receipient is the party that receives the ordered goods that was ordered by a client. - Source - LExIS';

