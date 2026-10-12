/* --------------------------------------------------------------------------------
   DDL for table: t_fact_hga_total_availability_1
   generated from Powerdesigner on Donnerstag, 13. Oktober 2022 15:42:09
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_HGA_TOTAL_AVAILABILITY_1 (
   hga_sid                             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store',
   start_dt                            DATE            NOT NULL COMMENT 'The start date of the source file',
   end_dt                              DATE            NOT NULL COMMENT 'The latest date of the source file',
   total_avail_pct                     NUMBER(38, 5)   NOT NULL COMMENT 'The total availability measure of machine between the start date and end date of source file',
   last_online_tmsp                    TIMESTAMP_TZ(9) COMMENT 'The latest timestamp of the report source file for respective machine',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT PK_T_FACT_HGA_TOTAL_AVAILABILITY PRIMARY KEY (hga_sid) NOT ENFORCED
 )  COMMENT= 'Aggregate fact capturing the total availability of machine for a given start and end date';
