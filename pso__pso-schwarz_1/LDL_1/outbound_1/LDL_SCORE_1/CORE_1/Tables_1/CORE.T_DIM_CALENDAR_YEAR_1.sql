--==============================================================
-- Table: t_dim_calendar_year_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_calendar_year_1
   generated from Powerdesigner on Montag, 14. Oktober 2024 18:38:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_calendar_year_1 (
cy BIGNUMERIC NOT NULL OPTIONS(description='The year '),
cy_seq BIGNUMERIC
OPTIONS(description='The current year has the sequence number 0. The next year takes the value 1. Beginning with a negative number from 2012. '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (cy) NOT ENFORCED
) OPTIONS(description='Annual information is listed here. ');