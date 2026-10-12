/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CHARGER_AUTHENTICATION_METHOD_2
   generated from Powerdesigner on Dienstag, 16. Januar 2024 10:21:43
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CHARGER_AUTHENTICATION_METHOD_2 (
   AUTHENTICATION_METHOD_CD            VARCHAR(50)     NOT NULL COMMENT 'The unique code of the authentication method.',
   AUTHENTICATION_METHOD_NAME          VARCHAR(100)    NOT NULL COMMENT 'The displayable name of the authentication method.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_CHARGER_AUTHENTICATION_METHOD PRIMARY KEY (AUTHENTICATION_METHOD_CD) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - The method used for authenticating on a charging station by a customer. - Source - Manual';
