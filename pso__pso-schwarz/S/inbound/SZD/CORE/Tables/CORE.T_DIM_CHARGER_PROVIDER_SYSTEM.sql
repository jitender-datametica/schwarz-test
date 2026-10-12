/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CHARGER_PROVIDER_SYSTEM
   generated from Powerdesigner on Dienstag, 16. Januar 2024 10:18:03
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CHARGER_PROVIDER_SYSTEM (
   CHARGER_PROVIDER_SYSTEM_CD          VARCHAR(50)     NOT NULL COMMENT 'Natural/Business Key - The unique code of the charger provider system.',
   CHARGER_PROVIDER_SYSTEM_NAME        VARCHAR(100)    NOT NULL COMMENT 'Descriptive Attribute - The displayable name of the charger provider system.',
   CHARGER_PROVIDER_SYSTEM_DESCR       VARCHAR(250)    NOT NULL COMMENT 'Descriptive Attribute - A brief description of the charger provider system.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_CHARGER_PROVIDER_SYSTEM PRIMARY KEY (CHARGER_PROVIDER_SYSTEM_CD) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - The charger provider system describes the source system where the charging information came from. - Source - Manual ';
