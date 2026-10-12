/* --------------------------------------------------------------------------------
   DDL for table: T_CONSIGNOR_STREAM
   generated from Powerdesigner on Dienstag, 9. Mai 2023 10:20:07
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CONSIGNOR_STREAM (
   CONSIGNOR_STREAM_CD                 VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - The unique code of the of the consignor stream.',
   CONSIGNOR_STREAM_NAME               VARCHAR(100)    NOT NULL COMMENT 'The name of the consignor stream.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CONSIGNOR_STREAM PRIMARY KEY (CONSIGNOR_STREAM_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - Defines the consignor streams like LExI, OWIM and Lidl Stiftung. Consignors a attached to a stream. - Source - Manual';
