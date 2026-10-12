/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_CUSTOMS_CLEARANCE_REPORT_LINE_PER_DAY_PROCEDURE_1
   generated from Powerdesigner on Mittwoch, 14. Juni 2023 13:18:33
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_CUSTOMS_CLEARANCE_REPORT_LINE_PER_DAY_PROCEDURE_1 (
   CLEARANCE_DT                        DATE            NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
   AUTHORITY_COUNTRY_LOCATION_SID      NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the political country.',
   CONSIGNOR_PARTY_SID                 NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the consignor.',
   CUSTOMS_DECLARATION_TYPE_CD         VARCHAR(50)     NOT NULL COMMENT 'The unique code of the type of the customs declaration',
   CUSTOMS_PROCEDURE_CD                VARCHAR(50)     NOT NULL COMMENT 'The unique code of the customs procedure of the item.',
   DECLARATION_CNT                     NUMBER(38, 0)   NOT NULL COMMENT 'Fact - additive - The count of declarations.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    NOT NULL COMMENT 'Contains the fully qualified names of the source tables from the relational model.',   
   CONSTRAINT PK_FACT_CUSTOMS_CLEARANCE_REPORT_LINE_PER_DAY_PROCEDURE PRIMARY KEY (CLEARANCE_DT, AUTHORITY_COUNTRY_LOCATION_SID, CONSIGNOR_PARTY_SID, CUSTOMS_PROCEDURE_CD, CUSTOMS_DECLARATION_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Fact table - Analytical - Granulatity - by day & customs procedure - Aggregate - Special fact table with the count of declarations dependent on the customs procedure code of the items of a declaration. - Source - CDS Item_1 Report';
