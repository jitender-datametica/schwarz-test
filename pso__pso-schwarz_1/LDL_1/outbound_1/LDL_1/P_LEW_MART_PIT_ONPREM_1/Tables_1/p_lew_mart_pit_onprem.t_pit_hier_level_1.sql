CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_hier_level_1 (
hier_level_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
hier_type_id BIGNUMERIC(38,0) NOT NULL,
hier_level_descr STRING(16777216) NOT NULL,
PRIMARY KEY (hier_level_id) NOT ENFORCED
);