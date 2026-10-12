/* --------------------------------------------------------------------------------
   DDL for table: T_ROAMING_IDENTIFICATION_TYPE_1
   generated from Powerdesigner on Mittwoch, 15. November 2023 14:40:09
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_ROAMING_IDENTIFICATION_TYPE_1 (
   ROAMING_IDENTIFICATION_TYPE_CD      VARCHAR(50)     NOT NULL COMMENT 'Natural/Business Key - The unique code of the identification type when roaming is used.',
   ROAMING_IDENTIFICATION_TYPE_DESCR   VARCHAR(250)    NOT NULL COMMENT 'A brief description of the roaming identification type.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOB storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_ROAMING_IDENTIFICATION_TYPE PRIMARY KEY (ROAMING_IDENTIFICATION_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - The type of identification when roaming is used while charging an electical car. - Source - Manual';
