CREATE TABLE IF NOT EXISTS ldl_data_etl.t_wawi_precore_t270_listtype_2 (
ctrcode STRING(3) COLLATE 'und:ci',
c270_listnr INTEGER,
c270_listdescript STRING(50),
c270_eks_link STRING(6),
scn BIGNUMERIC(38,0),
c270_main_type INTEGER,
extraction_tmsp DATETIME,
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_load_id BIGNUMERIC(38,0)
);