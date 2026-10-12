CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_surcharge_type_1 (
surcharge_type_cd STRING(20) NOT NULL
OPTIONS(description='This is a code, which defines the services for which, a fee is charged.'),
surcharge_categ_cd STRING(20)
OPTIONS(description='This is a code, which defines the charge categories. Charge Category group a charge type.'),
surcharge_type_name STRING(100) NOT NULL
OPTIONS(description='This is a name, for the services for which, a fee is charged.'),
surcharge_type_name_de STRING(100)
OPTIONS(description='This is a name, for the services for which, a fee is charged (in German).'),
surcharge_type_name_en STRING(100)
OPTIONS(description='This is a name, for the services for which, a fee is charged (in English)'),
surcharge_type_descr STRING(100)
OPTIONS(description='This is a description, for the services for which, a fee is charged. Can be empty.'),
surcharge_type_descr_de STRING(100)
OPTIONS(description='This is a description, for the services for which, a fee is charged. Can be empty (in German).'),
surcharge_type_descr_en STRING(100)
OPTIONS(description='This is a description, for the services for which, a fee is charged. Can be empty (in English)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (surcharge_type_cd) NOT ENFORCED
) OPTIONS(description='This dimension defines the services for which, a surcharge fee is charged.');