CREATE OR REPLACE TABLE ldl_data_production_etl.t_wawi_precore_eks_item_wawi_item_2 (
prod_num INTEGER NOT NULL,
itemno INTEGER NOT NULL,
ctrcode STRING(2) NOT NULL,
itemno_wawi INTEGER NOT NULL,
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_load_id INTEGER NOT NULL
);