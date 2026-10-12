CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_z_ds_wrf_matgrp_struc_hist (
client_id BIGNUMERIC(38,0) NOT NULL,
bic_zmlila STRING(20),
hier_id STRING(20) NOT NULL,
tree_level BIGNUMERIC(38,0) NOT NULL,
node STRING(20) NOT NULL,
parent_node STRING(20),
date_from DATE NOT NULL,
date_to DATE NOT NULL,
catflg STRING(20),
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (client_id, hier_id, node, date_from, dwh_valid_from) NOT ENFORCED
);