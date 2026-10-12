CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_supplier_map_key_1 (
client_id INTEGER NOT NULL,
sup_sid INTEGER NOT NULL,
sup_sid_map INTEGER NOT NULL,
dwh_sup_id STRING(20) COLLATE 'und:ci',
dwh_orig_supplier_nr INTEGER,
elwis_dwh_ec_cd INTEGER,
elwis_dwh_sup_sid INTEGER,
elwis_dwh_sup_id STRING(20) COLLATE 'und:ci',
wawi_dwh_client_id INTEGER,
wawi_dwh_supplier_id INTEGER,
wawi_dwh_orig_supplier_nr INTEGER,
active_fg INTEGER,
source_cd STRING(100) COLLATE 'und:ci',
dwh_create DATETIME,
dwh_upd DATETIME,
dwh_load_id INTEGER NOT NULL,
PRIMARY KEY (sup_sid) NOT ENFORCED
);