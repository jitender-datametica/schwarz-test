CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_lc_conf_tcache_recipients (
tcache_tablename STRING(100) COLLATE 'und:ci' NOT NULL,
tcache_database STRING(100) COLLATE 'und:ci' NOT NULL,
tcache_recipient_processname STRING(300) COLLATE 'und:ci' NOT NULL,
tcache_processcontainer STRING(300) COLLATE 'und:ci' NOT NULL,
active_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
refreshed_ts DATETIME NOT NULL,
created_ts DATETIME NOT NULL
);