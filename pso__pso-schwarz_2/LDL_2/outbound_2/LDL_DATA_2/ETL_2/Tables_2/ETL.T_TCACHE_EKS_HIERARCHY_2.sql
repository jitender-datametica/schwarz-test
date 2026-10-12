CREATE TABLE IF NOT EXISTS ldl_data_etl.t_tcache_eks_hierarchy_2 (
itemno_ea INTEGER NOT NULL,
itemno_sk INTEGER NOT NULL,
itemno_ba INTEGER NOT NULL,
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_load_id BIGNUMERIC(38,0) NOT NULL
);