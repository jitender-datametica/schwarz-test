CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_dim_item_status_1 (
country_1 STRING(2) NOT NULL OPTIONS(description='Country_1; sourcefield: country_1'),
dis_wh BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Number of a Warehouse; sourcefield: dis_wh'),
dis_item_nr STRING(20) NOT NULL
OPTIONS(description='Global item_1 number, dis_item_nr is equal to other xx_item_nr from other tables; sourcefield: dis_item_nr.'),
dis_packagecapacity BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Amount of salesitems that can be placed in one case. Sourcefield: DIS_PACKAGECAPACITY'),
dis_status BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Status_1 of an item_1 in system NIS. Status_1 = 5 or 6 item_1 ordered from warehouse; status_1=7 item_1 ordered from warehouse but locked for store delivery; status_1=8 item_1 ordered from warehouse and available for store delivery. Sourcefield DIS_STATUS'),
dis_status_date BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Date when the status_1 for a warehouse item_1 combination got changed. Sourcefield: DIS_STATUS_DATE'),
active_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Status_1 of the combination of dis_item_nr, dis_status and dis_packagecapacity in ADF system. Can differ on that level when an item_1 has promotion- Then another status_1 or packagecapacity is valid. Active=1 inactive=0; sourcefield: DIS_ACTIVE'),
mod_date TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of altering entries inside the table, is usually null. Sourcefield; mod_date'),
source_extraction_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Start date from when a dis_item_nr with a specific dis_status is valid; created in loading process (timestamp of the mod_date when information got changed in source).'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='End date from when a dis_item_nr with a specific dis_status is valid; created in loading process (timestamp of the mod_date when status_1 got changed in source).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake loading process.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake table update process.'),
PRIMARY KEY (country_1, dis_wh, dis_item_nr, dis_packagecapacity, dwh_valid_to_tmsp) NOT ENFORCED
)
OPTIONS(description='The table shows the status_1 of an item_1 assigned to a specific warehouse in ADF system. Combination of item_1, item_1 status_1 and item_1 packagecapacity can be active or inactive wether an item_1 is in promotion or regular assortment.Source: Parin/Parin1 table DIM_ITEM_STATUS.');