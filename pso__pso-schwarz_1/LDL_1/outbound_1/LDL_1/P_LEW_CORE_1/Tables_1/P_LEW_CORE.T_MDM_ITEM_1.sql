CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
mdm_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key NFPO item_1 instance            CBX: CNT_ITEM.REF_NO'),
src_item_doc_ref STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='NFPO item_1 instance reference            CBX: CNT_ITEM.REF_NO'),
mdm_item_name STRING(100) NOT NULL OPTIONS(description='NFPO item_1 name            CBX: CNT_ITEM.ITEM_DESC, SHORT_DESC'),
item_ian BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lidl International Item_1 Number (not necessarily unique in this table - numbers can be reused if an item_1 is cancelled, or multiple item_1 instances will be created for catalog items);            CBX: CNT_ITEM.ITEM_NO'),
range_plan_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='Range selection number (Ausmusterungsnummer), initially assigned to the item_1 instance            CBX: CNT_ITEM.LDL_LOT_NO'),
item_selection_nr STRING(20) COLLATE 'und:ci'
OPTIONS(description='NFPO source system internal identifier of an article            CBX: CNT_ITEM.LDL_SELECTION_NO'),
step_item_nr STRING(20) COLLATE 'und:ci'
OPTIONS(description='STEP internal identifier of an article, only available if an item_1 can be ordered by Kaufland countries            STEP:STEP_ID            '),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_item_sid) NOT ENFORCED
)
OPTIONS(description='instances of NFPO items in the quarterly item_1 planning and ordering process. For catalog items there might be several instances in this table, all sharing the same international article number             CBX: CNT_ITEM_1');