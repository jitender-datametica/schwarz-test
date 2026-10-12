-- Table: t_dim_business_year_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_business_year_2
   generated from Powerdesigner on Mittwoch, 29. November 2023 20:12:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_business_year_2 (
bus_year BIGNUMERIC NOT NULL OPTIONS(description='Business Year'),
prev_1y_bus_year BIGNUMERIC NOT NULL OPTIONS(description='Previous Business Year'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (bus_year) NOT ENFORCED
) OPTIONS(description='Annual information is listed here. ');