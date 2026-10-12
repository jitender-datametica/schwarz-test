CREATE OR REPLACE TABLE szd_production_core_rel.t_transhipment_location_type_2 (
transhipment_location_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the transhipment location_2 type.'),
transhipment_location_type_descr STRING(250)
OPTIONS(description='A brief description of the transhipment location_2 type.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (transhipment_location_type_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - The transhipment location_2 type defines which kind of transport vehicles are supported. For example a port serves ships and an airport serves planes. - Source - Manual');