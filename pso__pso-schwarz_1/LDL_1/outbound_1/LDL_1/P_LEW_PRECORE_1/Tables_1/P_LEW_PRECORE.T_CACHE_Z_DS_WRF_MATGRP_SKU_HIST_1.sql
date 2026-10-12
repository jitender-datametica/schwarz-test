CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_z_ds_wrf_matgrp_sku_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
bic_zmlila STRING(20),
hier_id STRING(20) NOT NULL,
matnr STRING(20) NOT NULL,
node STRING(20) NOT NULL,
date_from DATE NOT NULL,
date_to DATE NOT NULL,
mainflg STRING(20),
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (client_id, hier_id, matnr, node, date_from, dwh_valid_from) NOT ENFORCED
);