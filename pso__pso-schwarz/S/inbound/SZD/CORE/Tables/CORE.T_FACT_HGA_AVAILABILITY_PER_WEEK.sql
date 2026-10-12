/* --------------------------------------------------------------------------------
   DDL for table: t_fact_hga_availability_per_week
   generated from Powerdesigner on Donnerstag, 13. Oktober 2022 15:44:08
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_HGA_AVAILABILITY_PER_WEEK (
   hga_sid                             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store',
   cy_week                             NUMBER(38, 0)   NOT NULL COMMENT 'The number to which this week belongs, in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar year. Week 1 is the first week in the calendar year containing at least 4 days.',
   weekly_avail_pct                    NUMBER(38, 5)   NOT NULL COMMENT 'The time duration in seconds during which the machine is functioning',
   no_sale_weekly_val                  NUMBER(38, 5)   NOT NULL COMMENT 'The computed weekly value where there was no sale for more than 6 hours between consecutive sales',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT PK_T_FACT_HGA_AVAILABILITY_PER_WEEK PRIMARY KEY (hga_sid, cy_week) NOT ENFORCED
 )  COMMENT= 'Transactional fact capturing the uptime in seconds per week of hot beverage machines located in stores';
