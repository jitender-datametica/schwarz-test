CREATE OR REPLACE TABLE szd_production_core_rel.t_transport_type (
transport_type_cd STRING(50) NOT NULL OPTIONS(description='The unique identifier of the transport mode.'),
transport_route_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the transport route type.'),
transport_type_descr STRING(250) OPTIONS(description='A brief description of the transport mode.'),
wholesale_cd STRING(50)
OPTIONS(description='The code of the transport mode and transport route typ used in the\"Wholesale\" solution.'),
wholesale_label_descr STRING(250)
OPTIONS(description='A brief description of the transport mode and transport route typ used in the\"Wholesale\" solution.'),
foreigntrade_id STRING(50)
OPTIONS(description='The code of the transport mode and transport route typ used in the\"Foreign Trade\" solution.'),
foreigntrade_label_descr STRING(250)
OPTIONS(description='A brief description of the transport mode and transport route typ used in the\"Foreign Trade\" solution.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (transport_type_cd, transport_route_type_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - Indicates the way in which means of transport are used to transport goods.\n             Wholesale uses route types BEFORE_IMPORT for its international transportation and AFTER_IMPORT for domestic transport at importing country.\n             Foreign trade uses route type BEFORE_IMPORT only for transportation to the importing country. - Source - Manual');