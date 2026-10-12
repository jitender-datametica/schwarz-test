CREATE OR REPLACE TABLE szd_production_core.t_dim_transport_type_2 (
transport_type_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - Type of transport that is used deliver the goods from harbor EU to OWIM warehouse'),
transport_route_type_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - Type of transport that is used deliver the goods from harbor EU to OWIM warehouse'),
wholesale_cd STRING(50)
OPTIONS(description='The code of the transport mode and transport route typ used in the\"Wholesale\" solution.'),
wholesale_label_descr STRING(250)
OPTIONS(description='A brief description of the transport mode and transport route typ used in the\"Wholesale\" solution.'),
foreigntrade_id INTEGER
OPTIONS(description='The code of the transport mode and transport route typ used in the\"Foreign Trade\" solution.'),
foreigntrade_label_descr STRING(250)
OPTIONS(description='A brief description of the transport mode and transport route typ used in the\"Foreign Trade\" solution.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (transport_type_cd, transport_route_type_cd) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - Type of transport that is used deliver the goods.\n             Wholesale uses route types BEFORE_IMPORT for it\'s international transportation and AFTER_IMPORT for domestic transport at importing country.\n             Foreign trade uses route type BEFORE_IMPORT only for transportation to the importing country. - Source - VMT');