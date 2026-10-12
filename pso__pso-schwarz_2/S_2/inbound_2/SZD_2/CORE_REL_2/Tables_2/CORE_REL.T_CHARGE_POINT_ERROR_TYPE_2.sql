/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_POINT_ERROR_TYPE_2
   generated from Powerdesigner on Donnerstag, 9. November 2023 13:27:21
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CHARGE_POINT_ERROR_TYPE_2 (
   CHARGE_POINT_ERROR_TYPE_CD          VARCHAR(250)    NOT NULL COMMENT 'The unique code of a possible charge point/charger error type',
   CHARGE_POINT_ERROR_TYPE_DESCR       VARCHAR(250)    NOT NULL COMMENT 'A brief description of this error type.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CHARGE_POINT_ERROR_TYPE PRIMARY KEY (CHARGE_POINT_ERROR_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - Defines the possible error type codes that can occur on a charge point or charger. - Source - Manual';
