/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_VALUATION_METHOD
   generated from Powerdesigner on Mittwoch, 26. April 2023 09:58:07
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CUSTOMS_VALUATION_METHOD (
   CUSTOMS_VALUATION_METHOD_ID         NUMBER(38, 0)   NOT NULL COMMENT 'The unique code of the customs valuation method.',
   CUSTOMS_VALUATION_METHOD_DESCR      VARCHAR(1000)   COMMENT 'A brief description of the customs valuation method.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CUSTOMS_VALUATION_METHOD PRIMARY KEY (CUSTOMS_VALUATION_METHOD_ID) NOT ENFORCED 
)  COMMENT = 'Minor Entity - There are 6 valuation methods that you can use to work out the customs value of your imported goods. - Source - Manual';
