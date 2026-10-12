CREATE TABLE IF NOT EXISTS ldl_data_etl.t_wawi_precore_t171_gingates_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr BIGNUMERIC(38,0) NOT NULL,
c171_gingate INTEGER NOT NULL,
c171_gatetypeid INTEGER NOT NULL,
c171_usecount INTEGER NOT NULL,
c171_status INTEGER,
c171_stplace_from INTEGER,
c171_stplace_until INTEGER,
c171_label_printer INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
PRIMARY KEY (c171_gingate) NOT ENFORCED
);