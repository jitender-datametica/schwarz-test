CREATE TABLE IF NOT EXISTS ldl_data_etl.t_wawi_precore_eks_item_wawi_item_1 (
prod_num INTEGER NOT NULL,
itemno INTEGER NOT NULL,
ctrcode STRING(2) NOT NULL,
itemno_wawi INTEGER NOT NULL,
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_load_id BIGNUMERIC(38,0) NOT NULL
);