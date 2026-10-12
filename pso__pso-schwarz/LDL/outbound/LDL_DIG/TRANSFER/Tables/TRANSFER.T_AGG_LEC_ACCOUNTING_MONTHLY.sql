CREATE TABLE IF NOT EXISTS ldl_dig_transfer.t_agg_lec_accounting_monthly (
bus_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The business year (starting in March, ending in February of the following calendar year)'),
month_of_bus_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The month of business year, indicated by a number (1 = March, 2 = April, ... 12 = February)'),
cc_group_lvl4_nr STRING(20) NOT NULL OPTIONS(description='Identifier of the level 4 Cost Center Group'),
cc_group_lvl4_name STRING(100) OPTIONS(description='Name of the level 4 Cost Center Group'),
profit_loss_position_nr STRING(20) NOT NULL
OPTIONS(description='Identifier of the Profit/Loss position (KER Position) according to the associated fiscal year hierarchy'),
profit_loss_position_name STRING(100) NOT NULL OPTIONS(description='Description of the profit/loss accounting position'),
profit_loss_position_eur_value BIGNUMERIC(38,5)
OPTIONS(description='Accounting position value, in group currency (EUR)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded'),
PRIMARY KEY (bus_year, month_of_bus_year, cc_group_lvl4_nr, profit_loss_position_name) NOT ENFORCED
) OPTIONS(description='This table is used for the monthly reporting of aggregated accounting KPIs for Lidl E-Commerce');