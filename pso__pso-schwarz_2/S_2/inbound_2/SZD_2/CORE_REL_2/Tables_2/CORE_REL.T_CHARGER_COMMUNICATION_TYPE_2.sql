/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGER_COMMUNICATION_TYPE_2
   generated from Powerdesigner on Donnerstag, 9. November 2023 14:50:01
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CHARGER_COMMUNICATION_TYPE_2 (
   CHARGER_COMMUNICATION_TYPE_ID       NUMBER(38, 0)   NOT NULL COMMENT 'The unique code of the communication_2 type of a charger.',
   CHARGER_COMMUNICATION_TYPE_NAME     VARCHAR(100)    NOT NULL COMMENT 'The technical name of the communication_2 type.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOB storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CHARGER_COMMUNICATION_TYPE PRIMARY KEY (CHARGER_COMMUNICATION_TYPE_ID) NOT ENFORCED 
)  COMMENT = 'Minor Entity - Defines the possible types/protocols that are used by the charger to communicate. - Source - Manual';
