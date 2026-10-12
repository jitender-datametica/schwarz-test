/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_POINT_ERROR_STATUS_1
   generated from Powerdesigner on Montag, 4. Dezember 2023 13:39:43
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CHARGE_POINT_ERROR_STATUS_1 (
   ERROR_NR                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique ID of the occured error.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The date when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The date when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   CHARGE_POINT_ERROR_STATUS_TYPE_CD   VARCHAR(50)     NOT NULL COMMENT 'The unique code of the charge point status_1 error type.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CHARGE_POINT_ERROR_STATUS PRIMARY KEY (ERROR_NR, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Entity - Transactional - Transaction - Contains the timeline of the status_1 of the the charge point error. - Source - IOTCharger';
