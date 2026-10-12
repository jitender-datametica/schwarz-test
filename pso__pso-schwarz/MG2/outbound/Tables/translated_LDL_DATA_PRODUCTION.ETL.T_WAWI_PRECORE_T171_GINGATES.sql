CREATE OR REPLACE TABLE ldl_data_production_etl.t_wawi_precore_t171_gingates (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c171_gingate INTEGER NOT NULL,
c171_gatetypeid INTEGER NOT NULL,
c171_usecount INTEGER NOT NULL,
c171_status INTEGER,
c171_stplace_from INTEGER,
c171_stplace_until INTEGER,
c171_label_printer INTEGER,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_load_id INTEGER NOT NULL,
PRIMARY KEY (c171_gingate) NOT ENFORCED
);