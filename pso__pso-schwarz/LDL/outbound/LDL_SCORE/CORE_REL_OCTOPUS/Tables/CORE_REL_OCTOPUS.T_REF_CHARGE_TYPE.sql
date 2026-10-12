CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_ref_charge_type (
charge_type_cd STRING(20) NOT NULL
OPTIONS(description='This is a code, which defines the services for which, a fee is charged.'),
charge_categ_cd STRING(20)
OPTIONS(description='This is a code, which defines the charge categories. Charge Category group a charge type.'),
charge_type_name STRING(100) NOT NULL
OPTIONS(description='This is a name, for the services for which, a fee is charged.'),
charge_type_name_de STRING(100)
OPTIONS(description='This is a name, for the services for which, a fee is charged (in German).'),
charge_type_name_en STRING(100)
OPTIONS(description='This is a name, for the services for which, a fee is charged (in English)'),
charge_type_descr STRING(100)
OPTIONS(description='This is a description, for the services for which, a fee is charged. Can be empty.'),
charge_type_descr_de STRING(100)
OPTIONS(description='This is a description, for the services for which, a fee is charged. Can be empty (in German).'),
charge_type_descr_en STRING(100)
OPTIONS(description='This is a description, for the services for which, a fee is charged. Can be empty (in English)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (charge_type_cd) NOT ENFORCED
) OPTIONS(description='This table defines the services for which, a fee is charged');