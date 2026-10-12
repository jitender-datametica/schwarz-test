/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_BROKER_REPORT_ERROR_2
   generated from Powerdesigner on Mittwoch, 9. August 2023 10:02:35
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_BROKER_REPORT_ERROR_2 (
   MOVEMENT_REF_NUMBER                 VARCHAR(250)    NOT NULL COMMENT 'The movement reference number that identifies a declaration.',
   ITEM_POSITION                       NUMBER(38, 0)   NOT NULL COMMENT 'The position number within the shipment/declaration.',
   DECLARANT_PARTY_SID                 NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the declarant.',
   CDS_ACCEPTANCE_DT                   DATE            NOT NULL COMMENT 'This is the date when the goods have arrived at the import location.',
   ATTRIBUTE_NAME                      VARCHAR(100)    NOT NULL COMMENT 'The name of the attribute containing the invalid value.',
   ATTRIBUTE_VALUE_TXT                 VARCHAR(1000)   NOT NULL COMMENT 'The invalid value of the attribute as text.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    NOT NULL COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_FACT_BROKER_REPORT_ERROR PRIMARY KEY (MOVEMENT_REF_NUMBER, ITEM_POSITION, DECLARANT_PARTY_SID, CDS_ACCEPTANCE_DT) NOT ENFORCED 
)  COMMENT = 'Fact table - Transactional Events - Transactional - Contains invalid records from the broker report to be shown in a dashboard. - Source - Broker Report';
