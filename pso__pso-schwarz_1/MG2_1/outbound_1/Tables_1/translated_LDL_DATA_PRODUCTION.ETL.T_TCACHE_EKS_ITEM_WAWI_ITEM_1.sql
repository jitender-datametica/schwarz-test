CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_eks_item_wawi_item_1 (
prod_num INTEGER NOT NULL,
itemno INTEGER NOT NULL,
wawi_instanz_kzl STRING(2) NOT NULL,
itemno_wawi INTEGER NOT NULL,
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_load_id INTEGER NOT NULL
);