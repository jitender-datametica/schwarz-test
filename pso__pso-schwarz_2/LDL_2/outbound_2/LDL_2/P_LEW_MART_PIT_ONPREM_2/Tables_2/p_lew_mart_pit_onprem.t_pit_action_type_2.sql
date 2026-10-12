CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_action_type_2 (
action_type_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
action_type_descr STRING(16777216) COLLATE 'und:ci' NOT NULL,
mstr_related_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
action_type_sort_val BIGNUMERIC(38,0) DEFAULT 99 NOT NULL,
PRIMARY KEY (action_type_id) NOT ENFORCED
);