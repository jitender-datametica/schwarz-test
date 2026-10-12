/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_WEBSHOP_PROFIT_LOSS_REASON_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 9. Juni 2022 10:48:59
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_rel_webshop_profit_loss_reason_1 (
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1'),
profit_loss_reason_cd STRING(5) NOT NULL
OPTIONS(description='The code for the reason of profit/loss  ( 327, 326... etc)'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
fin_acct_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the Financial Account_1'),
reconcil_fin_acct_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the Financial Account_1'),
correction_fin_acct_sid BIGNUMERIC
OPTIONS(description='The unique identifier (surrogate key) for the Financial Account_1'),
depart_name STRING(100) OPTIONS(description='Department taken into account_1 for the loss'),
profit_loss_reason_pos_group_cd STRING(50)
OPTIONS(description='Label used by controlling department in reports for grouping different reason codes in same P&L position'),
profit_loss_reason_mgmt_group_cd STRING(50)
OPTIONS(description='Label used by controlling department in reports for grouping different reason codes in same management view position'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (wshop_cd, profit_loss_reason_cd, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='Table that contains mapping between webshops and profit/loss reason code.');