/* --------------------------------------------------------------------------------
   DDL for table: T_CURRENCY
   generated from Powerdesigner on Mittwoch, 26. April 2023 09:49:04
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CURRENCY (
   CURR_CD                             VARCHAR(50)     NOT NULL COMMENT 'The code identifying the currency, according to ISO 4217.',
   CURR_NAME                           VARCHAR(100)    NOT NULL COMMENT 'The name of the currency.',
   USED_IN_STORE_FG                    BOOLEAN         NOT NULL COMMENT 'An indicator showing, if this currency is used in a country where the Schwarz Group operates any stores.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CURRENCY PRIMARY KEY (CURR_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - A system of money that is in use in a country. - Source - Manual';
