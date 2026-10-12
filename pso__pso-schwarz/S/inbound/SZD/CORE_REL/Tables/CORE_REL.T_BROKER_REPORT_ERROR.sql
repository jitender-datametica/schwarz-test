/* --------------------------------------------------------------------------------
   DDL for table: T_BROKER_REPORT_ERROR
   generated from Powerdesigner on Dienstag, 8. August 2023 14:52:13
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_BROKER_REPORT_ERROR (
   MOVEMENT_REF_NUMBER                 VARCHAR(250)    NOT NULL COMMENT 'This is a customs identification number that’s created each time a declaration is submitted
            The movement reference number for importing or exporting goods. The number generated is bespoke, allowing your goods to be uniquely linked to you. As such, it forms an important part of the audit process for your declarations.',
   ITEM_POSITION                       NUMBER(38, 0)   NOT NULL COMMENT 'The number of the Item to which the report line refers. It''s "Item Number" in CDS item.',
   BROKER_DECLARANT_PARTY_SID          NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the broker.',
   CDS_ACCEPTANCE_DT                   DATE            NOT NULL COMMENT 'This is the date when the goods have arrived at the import location.',
   ATTRIBUTE_NAME                      VARCHAR(100)    NOT NULL COMMENT 'The name of the attribute with the invalid value.',
   ATTRIBUTE_VALUE_TXT                 VARCHAR(1000)   NOT NULL COMMENT 'The invalid value as text.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_BROKER_REPORT_ERROR PRIMARY KEY (MOVEMENT_REF_NUMBER, ITEM_POSITION, BROKER_DECLARANT_PARTY_SID, CDS_ACCEPTANCE_DT) NOT ENFORCED 
)  COMMENT = 'Entity - Transactional Events - Transaction - Contains lines from the broker report that contains attributes with invalid content and needs to be reviewed by the business department. - Source - Broker Report';
