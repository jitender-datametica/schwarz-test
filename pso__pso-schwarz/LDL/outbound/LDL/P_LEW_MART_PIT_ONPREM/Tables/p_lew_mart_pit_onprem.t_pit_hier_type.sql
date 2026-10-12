CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_hier_type (
hier_type_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
hier_type_descr STRING(16777216) DEFAULT 'N/A' NOT NULL,
PRIMARY KEY (hier_type_id) NOT ENFORCED
);