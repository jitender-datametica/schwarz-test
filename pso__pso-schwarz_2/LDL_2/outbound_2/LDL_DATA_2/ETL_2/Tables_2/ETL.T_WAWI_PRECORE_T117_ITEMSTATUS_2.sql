CREATE TABLE IF NOT EXISTS ldl_data_etl.t_wawi_precore_t117_itemstatus_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
extraction_tmsp DATETIME,
wh_nr BIGNUMERIC(38,0) NOT NULL,
itemno STRING(18) NOT NULL,
warehouseno INTEGER NOT NULL,
status_2 INTEGER NOT NULL,
updatedby STRING(8) NOT NULL,
updatedon DATETIME,
reason STRING(254),
first_sale_date DATETIME,
scn BIGNUMERIC(38,0) DEFAULT 0,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL
);