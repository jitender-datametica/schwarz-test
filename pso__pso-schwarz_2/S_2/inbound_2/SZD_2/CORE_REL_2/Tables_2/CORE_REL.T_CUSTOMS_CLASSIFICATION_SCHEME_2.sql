/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_CLASSIFICATION_SCHEME_2
   generated from Powerdesigner on Mittwoch, 26. April 2023 09:50:29
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CUSTOMS_CLASSIFICATION_SCHEME_2 (
   CUSTOMS_CLASSIFICATION_SCHEME_CD    VARCHAR(50)     NOT NULL COMMENT 'The unique code of the customs classification scheme.',
   CUSTOMS_CLASSIFICATION_SCHEME_DESCR VARCHAR(250)    COMMENT 'A brief description of the customs classification scheme.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CUSTOMS_CLASSIFICATION_SCHEME PRIMARY KEY (CUSTOMS_CLASSIFICATION_SCHEME_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - The customs classification schema summarizes the customs tariff numbers of a specific community, one or more countries or regions. - Source - Manual';
