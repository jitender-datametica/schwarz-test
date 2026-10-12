--==============================================================
-- Table: t_oracle_v_fk_storecalculation
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_fk_storecalculation
   generated from Powerdesigner on Dienstag, 28. Mai 2024 10:05:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_storecalculation (
country STRING(2) NOT NULL OPTIONS(description='Country; sourcefield: country'),
storecalculation_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Order Identificator - ID is equal to ord_storecalculation_id but not unique, same number can come up in different countries. Sourcefield: cal_storecalculation_id.'),
order_type STRING(100) NOT NULL
OPTIONS(description='Type of the calculation of an order (for example standard-calc. or Precalc.); Sourcefield: cal_order_type'),
generation_date TIMESTAMP NOT NULL
OPTIONS(description='Date of the creation of an order; Sourcefield; CAL_GENERATION_DATE'),
mod_date TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of altering entries inside the table, is usually null. Sourcefield: mod_date'),
source_extraction_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.'),
snflk_insert_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake loading process'),
snflk_update_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake table update process.'),
PRIMARY KEY (country, storecalculation_id) NOT ENFORCED
)
OPTIONS(description='Table created to have storeclaclulation on order type level to increase CROSS JOIN performance in frontend; Sourcetable fk_storecalculation');