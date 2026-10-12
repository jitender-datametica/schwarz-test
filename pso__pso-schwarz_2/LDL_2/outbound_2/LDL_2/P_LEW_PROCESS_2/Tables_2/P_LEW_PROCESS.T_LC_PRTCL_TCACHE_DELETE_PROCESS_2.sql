CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_lc_prtcl_tcache_delete_process_2 (
tcache_tablename STRING(100) COLLATE 'und:ci' NOT NULL,
tcache_database STRING(100) COLLATE 'und:ci' NOT NULL,
context_area_type STRING(50) COLLATE 'und:ci' NOT NULL,
context_area STRING(50) COLLATE 'und:ci' NOT NULL,
context_load_id BIGNUMERIC(38,0) NOT NULL,
delete_ts DATETIME NOT NULL,
PRIMARY KEY (context_load_id) NOT ENFORCED
);