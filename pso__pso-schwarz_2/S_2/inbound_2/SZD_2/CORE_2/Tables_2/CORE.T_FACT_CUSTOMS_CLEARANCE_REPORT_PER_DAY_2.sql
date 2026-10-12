/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_CUSTOMS_CLEARANCE_REPORT_PER_DAY_2
   generated from Powerdesigner on Dienstag, 1. August 2023 12:06:21
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_CUSTOMS_CLEARANCE_REPORT_PER_DAY_2 (
   CLEARANCE_DT                        DATE            NOT NULL COMMENT 'The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). ',
   AUTHORITY_COUNTRY_LOCATION_SID      NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the political country_2 of the customs authority.',
   CONSIGNOR_PARTY_SID                 NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the consignor.',
   DECLARANT_PARTY_SID                 NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the declarant.',
   IMPORT_LOCATION_SID                 NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the transhipment location.',
   CUSTOMS_DECLARATION_TYPE_CD         VARCHAR(50)     NOT NULL COMMENT 'The unique code of the type of the customs declaration',
   DISPATCH_COUNTRY_LOCATION_SID       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the country_2 that dispatched the good.',
   TRANSPORT_COUNTRY_LOCATION_SID      NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the political country_2 that has made the transport of the goods.',
   CURR_CD                             VARCHAR(3)      NOT NULL COMMENT 'The currency code for the duty paid amount and the excise value.',
   DECLARATION_CNT                     NUMBER(38, 0)   NOT NULL COMMENT 'Fact - additive - The count of declarations.',
   DUTY_PAID_VAL                       NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The amount of duty that was paid.',
   EXCISE_VAL                          NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The total amount of paid excise per declaration.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    NOT NULL COMMENT 'Contains the fully qualified names of the source tables from the relational model.',   
   CONSTRAINT PK_FACT_CUSTOMS_CLEARANCE_RE PRIMARY KEY (CLEARANCE_DT, AUTHORITY_COUNTRY_LOCATION_SID, CONSIGNOR_PARTY_SID, DECLARANT_PARTY_SID, IMPORT_LOCATION_SID, CUSTOMS_DECLARATION_TYPE_CD, DISPATCH_COUNTRY_LOCATION_SID, TRANSPORT_COUNTRY_LOCATION_SID, CURR_CD) NOT ENFORCED 
)  COMMENT = 'Fact table - Analytical - Granularity - by day & authority country_2 & consignor stream & declarant & procedure - Aggregate - Containts declaration related facts from the item_2 report from the customs authority. - Source - CDS Header Report, CDS Item_2 Report';
