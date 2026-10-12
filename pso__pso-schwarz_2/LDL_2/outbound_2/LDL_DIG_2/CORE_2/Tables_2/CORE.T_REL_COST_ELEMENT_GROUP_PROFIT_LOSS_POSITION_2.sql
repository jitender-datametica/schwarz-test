/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_COST_ELEMENT_GROUP_PROFIT_LOSS_POSITION_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 22. Februar 2023 10:45:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_rel_cost_element_group_profit_loss_position_2 (
fiscal_year BIGNUMERIC NOT NULL
OPTIONS(description='A number that represents the fiscal year for which the accounting document is posted'),
ce_group_lvl3_nr STRING(20) NOT NULL
OPTIONS(description='Identifier of the Cost Element Group (a.k.a. KER Position) to which this Cost Element belongs according to the Standard  Hierarchy_2'),
profit_loss_position_nr STRING(20) NOT NULL
OPTIONS(description='Identifier of the Profit/Loss position (KER Position) according to the associated fiscal year hierarchy_2'),
ce_group_lvl3_name_de STRING(100) OPTIONS(description='Short description of the  level 3 Cost Element Group in German'),
profit_loss_position_name STRING(100)
OPTIONS(description='Description of the profit/loss position (KER Position) according to the associated fiscal year hierarchy_2'),
ce_group_lvl2_nr STRING(20)
OPTIONS(description='Identifier of the Cost Element Group (a.k.a. KER Position) to which the CE Group lvl3 belongs according to the Standard  Hierarchy_2'),
profit_loss_position_display_order_nr BIGNUMERIC
OPTIONS(description='The number indicates in which order the Ker Position will appear in front end '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (fiscal_year, ce_group_lvl3_nr, profit_loss_position_nr) NOT ENFORCED
)
OPTIONS(description='Table that describes and historizes the Profit and Loss Positions (KER Positions) and their relationships with the Cost Element Groups');