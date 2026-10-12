/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PROFIT_LOSS_REASON_GROUP_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 31. Mai 2022 08:02:16
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_profit_loss_reason_group_1 (
profit_loss_reason_group_cd STRING(5) NOT NULL
OPTIONS(description='The code for the group of reasons for profit or loss ( 011, 320, 220)'),
profit_loss_reason_group_name STRING(100)
OPTIONS(description='The textual descriottion for the group of reasons for profit or loss (ex Interne Abwicklung)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
PRIMARY KEY (profit_loss_reason_group_cd) NOT ENFORCED
) OPTIONS(description='The minor dimension that defines the groups of  reason for profit or loss ');