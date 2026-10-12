--==============================================================
-- Table: t_dim_calendar_week
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_calendar_week
   generated from Powerdesigner on Montag, 14. Oktober 2024 18:39:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_calendar_week (
cy_week BIGNUMERIC NOT NULL
OPTIONS(description='A composition of (calendar year + week) e.g. 201.132 = year 2011 week 32'),
cy_week_descr STRING(100) OPTIONS(description='KW 01 - KW 52'),
cy_week_prev_1w BIGNUMERIC
OPTIONS(description='A composition of (calendar year + week) e.g. 201.131 = year 2011 week 31 one week previously '),
cy_week_prev_1y BIGNUMERIC
OPTIONS(description='A composition of (calendar year + week) e.g. 201.032 = year 2010 week 32 one year previously'),
cy_week_seq BIGNUMERIC OPTIONS(description='A sequence of calendar year week. 0 equals to the current week and year. '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (cy_week) NOT ENFORCED
)
OPTIONS(description='Contains information about the year and the according week of year. A composition of (calendar year + week) e.g. 201.132 = year 2011 week 32. ');