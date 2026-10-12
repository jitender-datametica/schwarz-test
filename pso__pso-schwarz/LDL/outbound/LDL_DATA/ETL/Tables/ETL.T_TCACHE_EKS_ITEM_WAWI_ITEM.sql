CREATE TABLE IF NOT EXISTS ldl_data_etl.t_tcache_eks_item_wawi_item (
prod_num INTEGER NOT NULL,
itemno INTEGER NOT NULL,
wawi_instanz_kzl STRING(2) NOT NULL,
itemno_wawi INTEGER NOT NULL,
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_load_id BIGNUMERIC(38,0) NOT NULL
);