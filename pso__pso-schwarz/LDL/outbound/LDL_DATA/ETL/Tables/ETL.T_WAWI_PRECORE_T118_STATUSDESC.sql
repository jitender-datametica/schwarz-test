CREATE TABLE IF NOT EXISTS ldl_data_etl.t_wawi_precore_t118_statusdesc (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
extraction_tmsp DATETIME,
status INTEGER NOT NULL,
statusdesc STRING(50),
hq INTEGER,
wh INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL
);