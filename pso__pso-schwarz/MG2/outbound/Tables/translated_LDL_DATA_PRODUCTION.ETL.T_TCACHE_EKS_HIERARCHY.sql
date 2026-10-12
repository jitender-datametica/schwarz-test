CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_eks_hierarchy (
itemno_ea INTEGER NOT NULL,
itemno_sk INTEGER NOT NULL,
itemno_ba INTEGER NOT NULL,
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_load_id INTEGER NOT NULL
);