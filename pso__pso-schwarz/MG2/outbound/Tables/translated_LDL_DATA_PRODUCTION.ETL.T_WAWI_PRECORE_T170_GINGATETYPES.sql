CREATE OR REPLACE TABLE ldl_data_production_etl.t_wawi_precore_t170_gingatetypes (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c170_gatetypeid INTEGER NOT NULL,
c170_gatetype STRING(33) NOT NULL,
c170_show_pallets INTEGER,
c170_check_temp INTEGER,
c170_mult_bb_date INTEGER,
c170_mult_pal_fact INTEGER,
c170_def_task_type INTEGER,
c170_rcv_lane INTEGER NOT NULL,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_load_id INTEGER NOT NULL,
PRIMARY KEY (c170_gatetypeid) NOT ENFORCED
);