/* --------------------------------------------------------------------------------
   DDL for table: T_POWER_TYPE_1
   generated from Powerdesigner on Mittwoch, 15. November 2023 09:12:28
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_POWER_TYPE_1 (
   POWER_TYPE_CD                       VARCHAR(50)     NOT NULL COMMENT 'The code for the type of power.',
   POWER_TYPE_DESCR                    VARCHAR(250)    NOT NULL COMMENT 'The description for the type of power (AC = Alternating current, DC = Direct current)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_POWER_TYPE PRIMARY KEY (POWER_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - This minor entity describes the type of power (AC = Alternating Current, DC = Direct Current). - Source - IoT Charger';
