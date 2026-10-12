/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_ACCOUNTING_COST_TYPE_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 10. Mai 2022 10:30:19
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_accounting_cost_type_1 (
acct_cost_type_cd STRING(20) NOT NULL OPTIONS(description='Unique identifier of the cost type'),
acct_cost_type_name_en STRING(100) OPTIONS(description='Name (description) of the cost type in English'),
acct_cost_type_name_de STRING(100) OPTIONS(description='Name (description) of the cost type in German'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (acct_cost_type_cd) NOT ENFORCED
)
OPTIONS(description='A minor dimension with cost type values (in accounting) - "Direct Cost"/ "Indirect Cost" / "Credit". Values are populated manually without source table');