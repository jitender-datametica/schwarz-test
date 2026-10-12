CREATE OR REPLACE TABLE ldl_data_production_etl.t_wawi_precore_t038_itemfamily_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
extraction_tmsp DATETIME,
family_id INTEGER NOT NULL,
itemgrpnr INTEGER NOT NULL,
prodgrpnr INTEGER NOT NULL,
family_code INTEGER NOT NULL,
desc_long STRING(480) NOT NULL,
desc_short STRING(60),
mod_date DATETIME,
mod_user STRING(32),
mmo_calculation_flag INTEGER NOT NULL,
pst_print_flag INTEGER NOT NULL,
mmo_modify_flag INTEGER NOT NULL,
scn INTEGER DEFAULT 0,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
dwh_load_id INTEGER NOT NULL
);