/* --------------------------------------------------------------------------------
   DDL for table: t_fact_hga_availability_per_day
   generated from Powerdesigner on Donnerstag, 13. Oktober 2022 15:44:57
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_HGA_AVAILABILITY_PER_DAY (
   hga_sid                             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store',
   avail_dt                            DATE            NOT NULL COMMENT 'The calendar date of the machine availability',
   daily_avail_pct                     NUMBER(38, 5)   NOT NULL COMMENT 'The time duration in seconds during which the machine is functioning',
   no_sale_daily_val                   NUMBER(38, 5)   NOT NULL COMMENT 'The computed daily value where there was no sale for more than 6 hours between consecutive sales',
   last_online_tmsp                    TIMESTAMP_TZ(9) NOT NULL COMMENT 'The report timestamp of the source file',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT PK_T_FACT_HGA_AVAILABILITY_PER_DAY PRIMARY KEY (hga_sid, avail_dt) NOT ENFORCED
 )  COMMENT= 'Transactional fact capturing the uptime in seconds per day of hot beverage machines located in stores';
