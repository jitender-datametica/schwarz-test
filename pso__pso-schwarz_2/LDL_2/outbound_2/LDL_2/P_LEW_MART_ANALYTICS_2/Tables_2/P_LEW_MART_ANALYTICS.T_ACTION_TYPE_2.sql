CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_action_type_2 (
action_type_id BIGNUMERIC(38,0) NOT NULL,
action_type_descr STRING(100) COLLATE 'und:ci' NOT NULL,
mstr_related_fg BIGNUMERIC(38,0) NOT NULL,
action_type_sort_val BIGNUMERIC(38,0) NOT NULL
);