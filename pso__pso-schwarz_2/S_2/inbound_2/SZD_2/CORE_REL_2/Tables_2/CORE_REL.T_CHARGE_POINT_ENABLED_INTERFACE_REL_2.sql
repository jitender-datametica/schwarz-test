/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_POINT_ENABLED_INTERFACE_REL_2
   generated from Powerdesigner on Mittwoch, 15. November 2023 10:33:17
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CHARGE_POINT_ENABLED_INTERFACE_REL_2 (
   RESOURCE_ITEM_SID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the charge point.',
   ROAMING_INTERFACE_CD                VARCHAR(50)     NOT NULL COMMENT 'The unique code of the roaming interface.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOB storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CHARGE_POINT_ENABLED_INTERFACE_REL PRIMARY KEY (RESOURCE_ITEM_SID, ROAMING_INTERFACE_CD, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Bridge Table - Contains the enabled roaming interfaces of the charge points. - Source IOTCharger';
