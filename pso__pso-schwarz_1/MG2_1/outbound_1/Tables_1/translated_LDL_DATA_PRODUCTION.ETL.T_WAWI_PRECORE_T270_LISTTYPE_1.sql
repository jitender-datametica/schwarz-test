CREATE OR REPLACE TABLE ldl_data_production_etl.t_wawi_precore_t270_listtype_1 (
ctrcode STRING(3) COLLATE 'und:ci',
c270_listnr INTEGER,
c270_listdescript STRING(50),
c270_eks_link STRING(6),
scn INTEGER,
c270_main_type INTEGER,
extraction_tmsp DATETIME,
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_load_id INTEGER
);