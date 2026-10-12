CREATE TABLE IF NOT EXISTS ldl_data_etl.t_wawi_precore_t711_wgi (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
extraction_tmsp DATETIME,
wgi_id INTEGER NOT NULL,
nat_wgi_id INTEGER NOT NULL,
item_group INTEGER NOT NULL,
date_from DATETIME NOT NULL,
date_to DATETIME,
version INTEGER NOT NULL,
int_desc STRING(140) NOT NULL,
nat_desc STRING(140),
remarks STRING(240),
moduser STRING(32),
moddate DATETIME,
scn BIGNUMERIC(38,0) DEFAULT 0,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL
);