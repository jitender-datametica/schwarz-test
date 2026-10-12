CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_transport_charge_type_2 (
transport_charge_type_cd STRING(20) NOT NULL
OPTIONS(description='This is a code, which defines the services for which, a fee is charged.'),
transport_charge_type_name STRING(100) NOT NULL
OPTIONS(description='This is a name, for the services for which, a fee is charged.'),
transport_charge_type_name_de STRING(100)
OPTIONS(description='This is a name, for the services for which, a fee is charged (in German).'),
transport_charge_type_name_en STRING(100)
OPTIONS(description='This is a name, for the services for which, a fee is charged (in English)'),
transport_charge_type_descr STRING(100)
OPTIONS(description='This is a description, for the services for which, a fee is charged. Can be empty.'),
transport_charge_type_descr_de STRING(100)
OPTIONS(description='This is a description, for the services for which, a fee is charged. Can be empty (in German).'),
transport_charge_type_descr_en STRING(100)
OPTIONS(description='This is a description, for the services for which, a fee is charged. Can be empty (in English)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (transport_charge_type_cd) NOT ENFORCED
) OPTIONS(description='This dimension defines the services for which, a Transport fee is charged');