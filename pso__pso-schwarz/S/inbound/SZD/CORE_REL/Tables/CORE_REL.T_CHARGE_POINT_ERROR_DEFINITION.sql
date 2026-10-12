/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_POINT_ERROR_DEFINITION
   generated from Powerdesigner on Freitag, 17. November 2023 11:04:54
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CHARGE_POINT_ERROR_DEFINITION (
   ERROR_DEFINITION_SID                NUMBER(38, 0)   NOT NULL COMMENT 'The unique surrogate key of the error definition.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   CHARGE_POINT_ERROR_TYPE_CD          VARCHAR(250)    NOT NULL COMMENT 'The unique code of a possible charge point/charger error',
   MANUFACTURER_PARTY_SID              NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party.',
   MANUFACTURER_ERROR_CODE_TXT         VARCHAR(1000)   NOT NULL COMMENT 'Descriptive Attribute - A arbitrary error code defined by the manufacturer of the charger model.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_T_CHARGE_POINT_ERROR_DEFINITION PRIMARY KEY (ERROR_DEFINITION_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - This error definition describes an error that can occur on a charge point. The charge point is part of a charger where you can charge your electric car. - Source - IOTCharger';
