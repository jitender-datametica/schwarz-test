/* --------------------------------------------------------------------------------
   DDL for table: T_DOCUMENT_TYPE
   generated from Powerdesigner on Mittwoch, 26. April 2023 09:58:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_DOCUMENT_TYPE (
   DOCUMENT_TYPE_CD                    VARCHAR(50)     NOT NULL COMMENT 'The unique code of the document type.',
   DOCUMENT_TYPE_DESCR                 VARCHAR(250)    COMMENT 'A brief description of the document type.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DOCUMENT_TYPE PRIMARY KEY (DOCUMENT_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - Defines the possible types of documents. - Source - Manual';
