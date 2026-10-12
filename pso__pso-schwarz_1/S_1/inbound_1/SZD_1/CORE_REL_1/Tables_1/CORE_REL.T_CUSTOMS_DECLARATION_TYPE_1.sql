/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_DECLARATION_TYPE_1
   generated from Powerdesigner on Mittwoch, 26. April 2023 09:52:55
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CUSTOMS_DECLARATION_TYPE_1 (
   CUSTOMS_DECLARATION_TYPE_CD         VARCHAR(50)     NOT NULL COMMENT 'The unique code of the customs declaration type.',
   CUSTOMS_DECLARATION_TYPE_DESCR      VARCHAR(250)    COMMENT 'A brief description of the customs declaration type.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CUSTOMS_DECLARATION_TYPE PRIMARY KEY (CUSTOMS_DECLARATION_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity  - The type of the declaration being made, for example a frontier declaration or a supplementary declaration. - Source - Manual';
