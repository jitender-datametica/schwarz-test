/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_DOCUMENT_1
   generated from Powerdesigner on Mittwoch, 26. April 2023 09:53:23
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CUSTOMS_DOCUMENT_1 (
   RESOURCE_ITEM_SID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the resource item..',
   DOCUMENT_TYPE_CD                    VARCHAR(50)     NOT NULL COMMENT 'The unique code of the document type.',
   COUNTRY_LOCATION_SID                NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the political country.',
   USAGE_CD                            VARCHAR(250)    NOT NULL COMMENT 'The usage of this document (Import / Export / Both)',
   CUSTOMS_DOCUMENT_CD                 VARCHAR(50)     NOT NULL COMMENT 'Natural/Business Key - The code of the customs document. This is usually a 4 digit alphanumeric code.',
   CUSTOMS_DOCUMENT_DESCR              VARCHAR(1000)   COMMENT 'A brief description of what is this document about.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CUSTOMS_DOCUMENT PRIMARY KEY (RESOURCE_ITEM_SID) NOT ENFORCED 
)  COMMENT = 'Major Entity - A customs document is used when handling with customs declarations and customs products. A customs document is usually attached to one or more products and also to a customs report line. - Source - Manual';
