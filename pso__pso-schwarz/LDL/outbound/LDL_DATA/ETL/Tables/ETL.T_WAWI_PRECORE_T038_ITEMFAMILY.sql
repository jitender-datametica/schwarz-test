CREATE TABLE IF NOT EXISTS ldl_data_etl.t_wawi_precore_t038_itemfamily (
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
scn BIGNUMERIC(38,0) DEFAULT 0,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL
);