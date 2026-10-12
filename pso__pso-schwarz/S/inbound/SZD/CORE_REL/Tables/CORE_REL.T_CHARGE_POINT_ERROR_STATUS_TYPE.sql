/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_POINT_ERROR_STATUS_TYPE
   generated from Powerdesigner on Freitag, 17. November 2023 13:30:05
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CHARGE_POINT_ERROR_STATUS_TYPE (
   CHARGE_POINT_ERROR_STATUS_TYPE_CD   VARCHAR(50)     NOT NULL COMMENT 'The unique code of the charge point status error type.',
   CHARGE_POINT_ERROR_STATUS_TYPE_DESCR VARCHAR(250)    NOT NULL COMMENT 'A brief description of the charge point error status type.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_T_CHARGE_POINT_ERROR_STATUS_TYPE PRIMARY KEY (CHARGE_POINT_ERROR_STATUS_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - Defines the possible states a charge point error can have. - Source - Manual';
