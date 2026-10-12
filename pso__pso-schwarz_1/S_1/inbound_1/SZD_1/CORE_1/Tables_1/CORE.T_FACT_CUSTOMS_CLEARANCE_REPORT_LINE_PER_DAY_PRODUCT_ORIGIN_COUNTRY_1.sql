/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_CUSTOMS_CLEARANCE_REPORT_LINE_PER_DAY_PRODUCT_ORIGIN_COUNTRY_1
   generated from Powerdesigner on Dienstag, 1. August 2023 12:14:33
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_CUSTOMS_CLEARANCE_REPORT_LINE_PER_DAY_PRODUCT_ORIGIN_COUNTRY_1 (
   CLEARANCE_DT                        DATE            NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
   AUTHORITY_COUNTRY_LOCATION_SID      NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the political country.',
   CONSIGNOR_PARTY_SID                 NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the consignor.',
   ORIGIN_COUNTRY_LOCATION_SID         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the political country.',
   CUSTOMS_PRODUCT_SID                 NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the customs product.',
   CUSTOMS_PREFERENCE_CD               VARCHAR(50)     NOT NULL COMMENT 'The unique code of the customs procedure code.',
   AGREEMENT_SID                       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the free trade agreement.',
   CUSTOMS_DECLARATION_TYPE_CD         VARCHAR(50)     NOT NULL COMMENT 'The unique code of the type of the customs declaration',
   CURR_CD                             VARCHAR(3)      COLLATE 'en-ci' NOT NULL COMMENT 'The currency code for the duty paid amount.',
   DECLARATION_CNT                     NUMBER(38, 0)   NOT NULL COMMENT 'Fact - additive - The count of declatations.',
   DUTY_PAID_VAL                       NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The amount of duty that was paid.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    NOT NULL COMMENT 'Contains the fully qualified names of the source tables from the relational model.',   
   CONSTRAINT PK_FACT_CUSTOMS_CLEARANCE_RE PRIMARY KEY (CLEARANCE_DT, AUTHORITY_COUNTRY_LOCATION_SID, CONSIGNOR_PARTY_SID, ORIGIN_COUNTRY_LOCATION_SID, CUSTOMS_PRODUCT_SID, CUSTOMS_PREFERENCE_CD, AGREEMENT_SID, CUSTOMS_DECLARATION_TYPE_CD, CURR_CD) NOT ENFORCED 
)  COMMENT = 'Fact table - Analytical - Granularity - by day & customs product & origin country_1 & preference code - Aggregate - Special fact table with the count of declarations and sum of total duty paid dependent on the customs product, the origin country_1 and preference code of the items of a declaration. - Source - CDS Item_1 Report';
