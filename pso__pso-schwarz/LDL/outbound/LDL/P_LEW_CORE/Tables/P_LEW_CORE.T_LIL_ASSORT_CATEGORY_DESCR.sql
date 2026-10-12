CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_lil_assort_category_descr (
client_id INTEGER NOT NULL,
assort_cat_sid INTEGER NOT NULL,
lang_cd STRING COLLATE 'und:ci' NOT NULL,
assort_parent_cat_name STRING(100) COLLATE 'und:ci',
assort_cat_name STRING(300) COLLATE 'und:ci',
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (assort_cat_sid) NOT ENFORCED
) CLUSTER BY client_id;