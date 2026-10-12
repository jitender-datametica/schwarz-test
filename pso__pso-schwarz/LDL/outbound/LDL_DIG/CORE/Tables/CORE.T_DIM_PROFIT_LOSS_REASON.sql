/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PROFIT_LOSS_REASON
   GENERATED FROM POWERDESIGNER ON Dienstag, 31. Mai 2022 08:03:25
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_profit_loss_reason (
profit_loss_reason_cd STRING(5) NOT NULL
OPTIONS(description='The code for the reason of profit/loss  ( 001, 327, 326... etc)'),
profit_loss_reason_name STRING(100) NOT NULL
OPTIONS(description='A textual description for the reason of profit or loss (Storno /0-Meldung Lager ,Technisch Probleme Shop, etc)'),
profit_loss_reason_group_cd STRING(5)
OPTIONS(description='The code for the group of reasons for profit or loss (001, 320, 220)'),
profit_loss_reason_group_name STRING(100)
OPTIONS(description='The textual descriottion for the group of reasons for profit or loss (ex Interne Abwicklung)'),
profit_loss_type_name STRING(100)
OPTIONS(description='The textual description of the type of reason for profit or loss (Abschriften, PV)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
PRIMARY KEY (profit_loss_reason_cd) NOT ENFORCED
) OPTIONS(description='The minor dimension that defines the reasons for profit or loss');