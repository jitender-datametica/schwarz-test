--==============================================================
-- Table: t_dim_calendar_month_of_year
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_calendar_month_of_year
   generated from Powerdesigner on Montag, 14. Oktober 2024 18:29:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_calendar_month_of_year (
month_of_year BIGNUMERIC NOT NULL OPTIONS(description='Month 1-12 (January = 1, ..., December = 12)'),
month_of_year_descr STRING(100) OPTIONS(description='The month in the year (written out)'),
month_of_year_short_descr STRING(100) OPTIONS(description='The month in the year (abbreviated)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (month_of_year) NOT ENFORCED
)
OPTIONS(description='Represents the twelve months of the year. Contains the german description and an abbreviated field. ');