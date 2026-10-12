/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_PREFERENCE_CODE
   generated from Powerdesigner on Mittwoch, 26. April 2023 09:54:08
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CUSTOMS_PREFERENCE_CODE (
   CUSTOMS_PREFERENCE_CD               VARCHAR(50)     NOT NULL COMMENT 'The unique code of the customs procedure code.',
   CUSTOMS_PREFERENCE_DESCR            VARCHAR(250)    COMMENT 'A brief description of the customs procedure code.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CUSTOMS_PREFERENCE_CODE PRIMARY KEY (CUSTOMS_PREFERENCE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - The 3-digit code indicating whether a reduction in or relief from import duty applies. - Source - Manual';
