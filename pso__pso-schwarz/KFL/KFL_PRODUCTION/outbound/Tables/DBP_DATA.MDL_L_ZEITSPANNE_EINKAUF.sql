CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mdl_l_zeitspanne_einkauf (
zeitspanne_einkauf_id BIGNUMERIC(38,0) NOT NULL,
zeitspanne_einkauf_sort_id BIGNUMERIC(38,0) DEFAULT - 1,
td_insert TIMESTAMP,
td_update TIMESTAMP
);