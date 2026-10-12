/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_FISCAL_PERIOD_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 5. Mai 2022 07:15:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_fiscal_period_2 (
fiscal_period_nr BIGNUMERIC NOT NULL OPTIONS(description='Unique identifier of the fiscal period'),
fiscal_period_name STRING(100) OPTIONS(description='Name (description) of the fiscal period'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (fiscal_period_nr) NOT ENFORCED
) OPTIONS(description='A minor dimension fiscal periods used in accounting for a financial year');