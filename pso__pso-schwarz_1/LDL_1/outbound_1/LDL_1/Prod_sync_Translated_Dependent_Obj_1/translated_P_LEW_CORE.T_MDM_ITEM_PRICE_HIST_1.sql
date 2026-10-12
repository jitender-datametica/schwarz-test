CREATE OR REPLACE TABLE ldl_p_lew_core.t_mdm_item_price_hist_1 (
client_id INTEGER NOT NULL
OPTIONS(description='technical column required by the used ETL framework\n            static 7 for all rows'),
mdm_item_sid INTEGER NOT NULL
OPTIONS(description='foreign key NFPO item_1 instance\n            CBX: CNT_ITEM.id / CNT_ITEM_CUST.item_id'),
mdm_price_scenario_nr INTEGER NOT NULL OPTIONS(description='identifier of the price scenario'),
item_price NUMERIC(29,5) OPTIONS(description='value of the price'),
curr_cd STRING(3) OPTIONS(description='currency code of the price'),
deleted_fg INTEGER NOT NULL
OPTIONS(description='deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to '),
dwh_valid_from DATE NOT NULL
OPTIONS(description='begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='end of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)'),
dwh_load_id INTEGER NOT NULL OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp_ntz(9) of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH'),
PRIMARY KEY (mdm_price_scenario_nr, mdm_item_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='values of the price scenario prices used in the non food product development and ordering process\n             prices which are differenciated by targeted intenal organisation are not included here\n             CBX: CNT_ITEM_CUST_1, CNT_ITEM_1');