CREATE TABLE IF NOT EXISTS ldl_data_etl.t_product_group_hierarchy_type (
prod_grp_hierarchy_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the kind of hierarchy for product groups.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
prod_grp_hierarchy_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the kind of hierarchy for product groups.'),
PRIMARY KEY (prod_grp_hierarchy_type_cd, lang_cd) NOT ENFORCED
);