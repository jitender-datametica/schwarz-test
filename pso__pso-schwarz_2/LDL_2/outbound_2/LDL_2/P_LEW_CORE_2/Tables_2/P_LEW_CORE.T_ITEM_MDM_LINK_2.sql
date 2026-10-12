CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_mdm_link_2 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key of the ERP client of the item_2 related to the NFPO item_2 instance'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key of the ERP system based item_2 variant (overarching unique, not just within a certain client)'),
client_item_role_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='role of the ERP system based item_2 variant in the relation to the cbx based item_2'),
mdm_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='foreign key NFPO item_2 instance'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_item_sid, item_sid) NOT ENFORCED
)
OPTIONS(description='relation between NFPO items and local ERP system based items             populated by algorithm using t_item_2 and t_mdm_item_2 and the IAN of the NFPO item_2');