/* --------------------------------------------------------------------------------
   DDL for table: T_ROAMING_INTERFACE_2
   generated from Powerdesigner on Dienstag, 14. November 2023 11:15:00
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_ROAMING_INTERFACE_2 (
   ROAMING_INTERFACE_CD                VARCHAR(50)     NOT NULL COMMENT 'The unique code of the roaming interface.',
   ROAMING_INTERFACE_DESCR             VARCHAR(250)    NOT NULL COMMENT 'A brief description of the roaming interface.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_ROAMING_INTERFACE PRIMARY KEY (ROAMING_INTERFACE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - The roaming interface determines the type of billing between two different providers (e.g. Lidl and Kaufland). - Source - Manual';
